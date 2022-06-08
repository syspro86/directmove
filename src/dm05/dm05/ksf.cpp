
#include <zsoo.h>
#include "ksf.h"
#include <time.h>

namespace KSF
{
	struct LOADINGINFO
	{
		string tag;
		string value;
	};

	struct STEPINFO
	{
		string step;
		int type;
	};

	struct LONGNOTEINFO
	{
		BOOL bUsed;
		INT iPrevPtn;
		INT iPrevPos;
	};
};

using namespace KSF;

CKsf::~CKsf()
{
	while (m_vPtns.size())
	{
		delete m_vPtns.back();
		m_vPtns.pop_back();
	}
}

HRESULT CKsf::Load(LPCSTR filename, KSF_PLAYER_TYPE player)
{
	vector<LOADINGINFO> vLoadInfo;
	vector<STEPINFO> vStepInfo;

	ifstream ifs;
	ifs.open(filename, ios_base::in);
	if (!ifs.is_open())
		return E_FAIL;

	string lline(1024, '\0');
	while (ifs.getline( &lline[0], 1023 ))
	{
		string line = &lline[0];
		if (line[0] != '#')
			continue;

		size_t pos = line.find_first_of(":");
		if (pos < line.length())
		{
			if (line.find("#STEP:") < line.length())
				break;

			string tag( &line[1], &line[pos] );
			string value( &line[pos+1], line.end()-1 );
			pos = value.find_last_of(';');
			if (pos < value.length())
				value.erase( &value[pos], value.end() );

			LOADINGINFO li = {tag, value};
			vLoadInfo.push_back(li);
		}
	}

	while (ifs.getline( &lline[0], 1023 ))
	{
		string line = &lline[0];
		STEPINFO si;
		si.type = STEPINFO_UNKNOWN;

		if (line[0] == '|' && line[line.length()-1] == '|')
		{
			switch (line[1])
			{
				case 'B':
					si.type = STEPINFO_BPM;
					break;
				case 'T':
					si.type = STEPINFO_TICK;
					break;
				case 'D':
					si.type = STEPINFO_DELAY;
					break;
				case 'E':
					si.type = STEPINFO_DELAYBEAT;
					break;
			}
			si.step = string( &line[2], line.end()-1 );
		}
		else if (line[0] == '#')
		{
			size_t pos = line.find_first_of(':');
			if (pos >= line.length())
				break;

			string tag( &line[1], &line[pos] );
			string value( &line[pos+1], line.end()-1 );
			pos = value.find_last_of(';');
			if (pos < value.length())
				value.erase( &value[pos], value.end() );

			if (tag == "BPM")
				si.type = STEPINFO_BPM;
			else if (tag == "TICKCOUNT")
				si.type = STEPINFO_TICK;
			else if (tag == "DELAY")
				si.type = STEPINFO_DELAY;
			else if (tag == "DELAYBEAT")
				si.type = STEPINFO_DELAYBEAT;

			si.step = value;
		}
		else if (line.length() == 13)
		{
			si.type = STEPINFO_STEP;
			si.step = line;
		}
		vStepInfo.push_back(si);
	}
	ifs.close();

	int TickCount = 4;
	float BPM = 0, BPM2 = 0, BPM3 = 0;
	int Bunki = 0, Bunki2 = 0, StartTime = 0, StartTime2 = 0, StartTime3 = 0;
	BOOL bUseOldBPM = FALSE;

	while (vLoadInfo.size())
	{
		LOADINGINFO li;
		li = vLoadInfo.back();

		if (li.tag == "TICKCOUNT")
			TickCount = atoi( li.value.c_str() );
		else if(li.tag == "BPM")
			BPM = (float)atof( li.value.c_str() );
		else if(li.tag == "BPM2")
			BPM2 = (float)atof( li.value.c_str() );
		else if(li.tag == "BPM3")
			BPM3 = (float)atof( li.value.c_str() );
		else if(li.tag == "BUNKI")
			Bunki = atoi( li.value.c_str() ) * 10;
		else if(li.tag == "BUNKI2")
			Bunki2 = atoi( li.value.c_str() ) * 10;
		else if(li.tag == "STARTTIME")
			StartTime = atoi( li.value.c_str() ) * 10;
		else if(li.tag == "STARTTIME2")
			StartTime2 = atoi( li.value.c_str() ) * 10;
		else if(li.tag == "STARTTIME3")
			StartTime3 = atoi( li.value.c_str() ) * 10;

		vLoadInfo.pop_back();
	}

	if (BPM < 0) BPM = 0.0f;
	if (BPM2 < 0) BPM2 = 0.0f;
	if (BPM3 < 0) BPM3 = 0.0f;
	if (StartTime < 0) StartTime = 0;
	if (StartTime2 < 0) StartTime2 = 0;
	if (StartTime3 < 0) StartTime3 = 0;
	if (Bunki < 0) Bunki = 0;
	if (Bunki2 < 0) Bunki2 = 0;

	if (BPM2!=0)
	{
		bUseOldBPM = TRUE;
		if (Bunki == 0)
		{
			BPM = BPM2;
			BPM2 = BPM3;
			BPM3 = 0;
			Bunki = Bunki2;
			Bunki2 = 0;
			StartTime = StartTime2;
			StartTime2 = StartTime3;
			StartTime3 = 0;
		}
		if (Bunki == Bunki2)
		{
			BPM2 = BPM3;
			BPM3 = 0;
			Bunki2 = 0;
			StartTime2 = StartTime3;
			StartTime3 = 0;
		}
		if (BPM2 == 0)
			bUseOldBPM = FALSE;
	}

	LONGNOTEINFO CurLongNote[10] = {0};
	int CurTick = TickCount;
	float CurBPM = BPM;
	int ButtonCount = 5;

	m_PLAYER_TYPE = player;
	switch(m_PLAYER_TYPE)
	{
		case KSF_SINGLE1P:
		case KSF_SINGLE2P:
			ButtonCount = 5;
			break;
		case KSF_DOUBLE:
			ButtonCount = 10;
			break;
	}

	PATTERN* CurPtn = new PATTERN;
	m_vPtns.push_back(CurPtn);
	CurPtn->fBPM = BPM;
	CurPtn->iTick = TickCount;
	while (vStepInfo.size())
	{
		if (vStepInfo.front().type == STEPINFO_STEP)
		{
			LINE line;
			for (int iStep=0; iStep<ButtonCount; ++iStep)
			{
				switch (vStepInfo.front().step[iStep])
				{
					case '1':
						line.step[iStep] = NOTE_NOTE;
						if (CurLongNote[iStep].bUsed)
						{
							BYTE &step = m_vPtns[CurLongNote[iStep].iPrevPtn]->vLine[CurLongNote[iStep].iPrevPos].step[iStep];
							CurLongNote[iStep].bUsed = FALSE;
							step |= NOTE_END_CHK;
							if ((step & (NOTE_START_CHK|NOTE_END_CHK)) == (NOTE_START_CHK|NOTE_END_CHK))
								step = NOTE_NOTE;
						}
						break;
					case '4':
						line.step[iStep] = NOTE_LNOTE;
						if (CurLongNote[iStep].bUsed == FALSE)
							line.step[iStep] |= NOTE_START_CHK;
						CurLongNote[iStep].bUsed = TRUE;
						CurLongNote[iStep].iPrevPtn = m_vPtns.size() - 1;
						CurLongNote[iStep].iPrevPos = m_vPtns.back()->vLine.size();
						break;
					case '0':
					case '2':
					default:
						if (CurLongNote[iStep].bUsed)
						{
							BYTE &step = m_vPtns[CurLongNote[iStep].iPrevPtn]->vLine[CurLongNote[iStep].iPrevPos].step[iStep];
							CurLongNote[iStep].bUsed = FALSE;
							step |= NOTE_END_CHK;
							if ((step & (NOTE_START_CHK|NOTE_END_CHK)) == (NOTE_START_CHK|NOTE_END_CHK))
								step = NOTE_NOTE;
						}
						line.step[iStep] = NOTE_NONE;
				}
			}
			m_vPtns.back()->vLine.push_back(line);
		}
		else if (vStepInfo.front().type == STEPINFO_BPM)
		{
			if ( m_vPtns.back()->vLine.size() > 0 )
			{
				CurPtn = new PATTERN;
				CurPtn->fBPM = (float)atof( vStepInfo.front().step.c_str() );
				CurPtn->iTick = CurTick;
				CurBPM = CurPtn->fBPM;
				m_vPtns.push_back(CurPtn);
			}
			else
			{
				CurPtn->fBPM = (float)atof( vStepInfo.front().step.c_str() );
				CurBPM = CurPtn->fBPM;
			}
		}
		else if (vStepInfo.front().type == STEPINFO_TICK)
		{
			if ( m_vPtns.back()->vLine.size() > 0 )
			{
				CurPtn = new PATTERN;
				CurPtn->fBPM = CurBPM;
				CurPtn->iTick = (int)atoi( vStepInfo.front().step.c_str() );
				CurTick = CurPtn->iTick;
				m_vPtns.push_back(CurPtn);
			}
			else
			{
				CurPtn->iTick = (int)atoi( vStepInfo.front().step.c_str() );
				CurTick = CurPtn->iTick;
			}
		}
		else if (vStepInfo.front().type == STEPINFO_DELAY)
		{
			PATTERN *DelayPtn = new PATTERN;
			if ( m_vPtns.back()->vLine.size() > 0 )
			{
				CurPtn = new PATTERN;
				CurPtn->fBPM = CurBPM;
				CurPtn->iTick = CurTick;
			}
			else
			{
				m_vPtns.pop_back();
			}
			DelayPtn->fBPM = CurBPM;
			DelayPtn->iTick = CurTick;
			DelayPtn->timeDelay = (long)atoi( vStepInfo.front().step.c_str() );
			m_vPtns.push_back(DelayPtn);
			m_vPtns.push_back(CurPtn);
		}
		else if (vStepInfo.front().type == STEPINFO_DELAYBEAT)
		{
			PATTERN *DelayPtn = new PATTERN;
			if ( m_vPtns.back()->vLine.size() > 0 )
			{
				CurPtn = new PATTERN;
				CurPtn->fBPM = CurBPM;
				CurPtn->iTick = CurTick;
			}
			else
			{
				m_vPtns.pop_back();
			}
			DelayPtn->fBPM = CurBPM;
			DelayPtn->iTick = CurTick;
			DelayPtn->timeDelay = long(60000 / CurBPM * (float)atoi( vStepInfo.front().step.c_str() ) / (float)CurTick);
			m_vPtns.push_back(DelayPtn);
			m_vPtns.push_back(CurPtn);
		}
		vStepInfo.erase(vStepInfo.begin());
	}

	if (bUseOldBPM)
	{
		PATTERN *ptn0 = m_vPtns.front(), *ptn1 = NULL, *ptn2 = NULL;
		ptn0->timePos = StartTime;
		if (Bunki!=0)
		{
			int cutting_pos;
			cutting_pos = GetCuttingPos(BPM, StartTime, Bunki, ptn0->vLine.size(), TickCount);
			if (cutting_pos >= 0)
			{
				ptn1 = new PATTERN;
				ptn1->fBPM = BPM2;
				ptn1->timePos = StartTime2;
				ptn1->iTick = ptn0->iTick;
				m_vPtns.push_back(ptn1);
				while ((int)ptn0->vLine.size() > cutting_pos)
				{
					LINE new_line;
					new_line = ptn0->vLine[cutting_pos];
					ptn1->vLine.push_back(new_line);
					ptn0->vLine.erase(ptn0->vLine.begin() + cutting_pos);
				}
				if (Bunki2!=0)
				{
					int cutting_pos2;
					cutting_pos2 = GetCuttingPos(BPM2, StartTime2, Bunki2, ptn0->vLine.size()+ptn1->vLine.size(), TickCount);
					if (cutting_pos < cutting_pos2)
					{
						ptn2 = new PATTERN;
						ptn2->fBPM = BPM3;
						ptn2->timePos = StartTime3;
						ptn2->iTick = ptn1->iTick;
						m_vPtns.push_back(ptn2);
						cutting_pos = cutting_pos2 - cutting_pos;
						while ((int)ptn1->vLine.size() > cutting_pos)
						{
							LINE new_line;
							new_line = ptn1->vLine[cutting_pos];
							ptn2->vLine.push_back(new_line);
							ptn1->vLine.erase(ptn1->vLine.begin() + cutting_pos);
						}
					}
					else if (cutting_pos == cutting_pos2)
					{
						ptn1->fBPM = BPM3;
					}
					else
					{
						ptn2 = new PATTERN;
						ptn2->fBPM = BPM3;
						ptn2->timePos = StartTime3;
						ptn2->iTick = ptn1->iTick;
						m_vPtns.push_back(ptn2);
						cutting_pos -= cutting_pos2;
						cutting_pos = ptn0->vLine.size() - cutting_pos;
						while ((int)ptn0->vLine.size() > cutting_pos)
						{
							LINE new_line;
							new_line = ptn0->vLine[cutting_pos];
							ptn2->vLine.push_back(new_line);
							ptn0->vLine.erase(ptn0->vLine.begin() + cutting_pos);
						}
						while (ptn1->vLine.size() > 0)
						{
							LINE new_line;
							new_line = ptn0->vLine[cutting_pos];
							ptn2->vLine.push_back(new_line);
							ptn1->vLine.erase(ptn1->vLine.begin());
						}
						ptn1->vLine.clear();
						delete ptn1;
						m_vPtns.erase(m_vPtns.begin() + 1);
					}
				}
				ptn1->timePos = GetPtnTimePos(BPM2, StartTime2, Bunki, TickCount);
				cutting_pos = GetCuttingPos(BPM, StartTime, Bunki, 0x7fffffff, TickCount);
				int tcutting_pos = GetCuttingPos(BPM2, StartTime2, Bunki, 0x7fffffff, TickCount);
				while (cutting_pos < tcutting_pos) // bpm이 변하면서.. 중간부분은 그냥 지나가는 경우 아예 지운다
				{
					--tcutting_pos;
					ptn1->vLine.erase(ptn1->vLine.begin());
				}
				if (cutting_pos > tcutting_pos)
				{
					vector<LINE> temp;
					while (cutting_pos > tcutting_pos) // bpm이 변하면서.. 공백이 생기면.. 추가해 준다.
					{
						LINE newline;
						memset(&newline, 0, sizeof(LINE));
						++tcutting_pos;
						temp.push_back(newline);
					}
					ptn1->vLine.insert(ptn1->vLine.begin(), temp.begin(), temp.end());
					temp.clear();
				}
				if (m_vPtns.size()==3)
				{
					ptn2->timePos = GetPtnTimePos(BPM3, StartTime3, Bunki2, TickCount);
					int cutting_pos2 = GetCuttingPos(BPM2, StartTime2, Bunki2, 0x7fffffff, TickCount);
					int tcutting_pos2 = GetCuttingPos(BPM3, StartTime3, Bunki2, 0x7fffffff, TickCount);
					while (cutting_pos2 < tcutting_pos2)
					{
						--tcutting_pos2;
						ptn2->vLine.erase(ptn2->vLine.begin());
					}
					if (cutting_pos2 > tcutting_pos2)
					{
						vector<LINE> temp;
						while (cutting_pos2 > tcutting_pos2) // bpm이 변하면서.. 공백이 생기면.. 추가해 준다.
						{
							LINE newline;
							memset(&newline, 0, sizeof(LINE));
							++tcutting_pos2;
							temp.push_back(newline);
						}
						ptn2->vLine.insert(ptn2->vLine.begin(), temp.begin(), temp.end());
						temp.clear();
					}
				}
			}
		}
	}
	else
	{
		PATTERN* nowptn;
		float lasttick = float(StartTime);
		for (int i=0; i<(int)m_vPtns.size(); ++i)
		{
			nowptn = m_vPtns[i];
			nowptn->timePos = (LONG)lasttick;
			if (nowptn->timeDelay)
				lasttick += nowptn->timeDelay;
			else
			{
				if (nowptn->fBPM != 0)
					lasttick += (60000 / nowptn->fBPM * (float)nowptn->vLine.size() / (float)nowptn->iTick);
			}
		}
	}

	for (int i=0; i<(int)m_vPtns.size(); ++i)
	{
		PATTERN *nowptn = m_vPtns[i];
		if (nowptn->timeDelay)
			nowptn->timeLen = nowptn->timeDelay;
		else
		{
			if (nowptn->fBPM != 0)
				nowptn->timeLen = LONG(60000 / nowptn->fBPM * (float)nowptn->vLine.size() / (float)nowptn->iTick);
			else
				nowptn->timeLen = 0;
		}
	}
	for (int i=0; i<(int)m_vPtns.size() - 1; ++i)
	{
		long mpos = m_vPtns[i]->timePos;
		long mlen = m_vPtns[i]->timeLen;
		long npos = m_vPtns[i+1]->timePos;
		if (mpos + mlen < npos)
			m_vPtns[i]->timeLen = npos - mpos;
		if (bUseOldBPM)
			m_vPtns[i]->timeLen = npos - mpos;
//		if ((m_vPtns[i]->timePos + m_vPtns[i]->timeLen < m_vPtns[i+1]->timePos) || m_bUseDM==FALSE)
//			m_vPtns[i]->timeLen = m_vPtns[i+1]->timePos - m_vPtns[i]->timePos;
	}
	return S_OK;
}

long CKsf::GetPtnTimePos(float BPM, long start, long bunki, int tick)
{
	float lasttick = (float)(start);
	float ticks = 60000 / BPM;
	float dest = (float)(bunki);

	int num = 0;
	while(1)
	{
		float now = lasttick + (ticks * num / tick);
		if (now >= dest)
			return (long)now;
		++num;
	}
	return 0;
}

int CKsf::GetCuttingPos(float BPM, long start, long bunki, long max, int tick)
{
	float lasttick = (float)(start);
	float ticks = 60000 / BPM;
	float dest = (float)(bunki);

	for (int num=0; num<(int)max; ++num)
	{
		float now = lasttick + (ticks * num / tick);
		if (now >= dest)
			return num;
	}
	return -1;
}

CKsf& CKsf::operator = (const CKsf& ksf)
{
	m_PLAYER_TYPE = ksf.m_PLAYER_TYPE;
	for (int i=0; i<(int)ksf.m_vPtns.size(); ++i)
	{
		PATTERN* ptn = ksf.m_vPtns[i];
		PATTERN* nptn = new PATTERN;
		nptn->timePos = ptn->timePos;
		nptn->timeLen = ptn->timeLen;
		nptn->timeDelay = ptn->timeDelay;
		nptn->iTick = ptn->iTick;
		nptn->iLastMissCheck = ptn->iLastMissCheck;
		nptn->fBPM = ptn->fBPM;
		nptn->vLine.insert(nptn->vLine.begin(), ptn->vLine.begin(), ptn->vLine.end());
		m_vPtns.push_back(nptn);
	}
	return *this;
}

void CKsf::MakeRandom()
{
	BYTE newline[10];
	BYTE nowlong[10];
	BYTE nonote[10];
	for (int i=0; i<10; ++i)
	{
		newline[i] = 0;
		nowlong[i] = 255;
		nonote[i] = 0;
	}
	int stepwidth = m_PLAYER_TYPE == KSF_DOUBLE ? 10 : 5;
	for (int p=0; p<(int)m_vPtns.size(); ++p)
	{
		PATTERN* ptn = m_vPtns[p];
		srand(time(NULL));
		for (int l=0; l<(int)ptn->vLine.size(); ++l)
		{
			BYTE* line = &ptn->vLine[l].step[0];

			for (int a=0; a<stepwidth; ++a)
			{
				newline[a] = 0;
				if (nonote[a] == 2)
					nonote[a] = 3;
				else if (nonote[a] == 3)
					nonote[a] = 0;
			}

			for (int a=0; a<stepwidth; ++a)
			{
				if (line[a] == NOTE_LSTART)
				{
					while (1)
					{
						int r = rand() % stepwidth;
						if (!newline[r] && nowlong[a] == 255 && nonote[r]==0)
						{
							nowlong[a] = r;
							newline[r] = line[a];
							line[a] = NOTE_NONE;
							nonote[r] = 1;
							break;
						}
					}
				}
				else if (line[a] == NOTE_LNOTE)
				{
					newline[ nowlong[a] ] = line[a];
					line[a] = NOTE_NONE;
				}
				else if (line[a] == NOTE_LEND)
				{
					newline[ nowlong[a] ] = line[a];
					nonote[ nowlong[a] ] = 2;
					nowlong[a] = stepwidth;
					line[a] = NOTE_NONE;
				}
			}

			for (int a=0; a<stepwidth; ++a)
			{
				if (line[a] == NOTE_NOTE)
				{
					while (1)
					{
						int r = rand() % stepwidth;
						if (!newline[r] && nowlong[a] == 255 && nonote[r]==0)
						{
							newline[r] = line[a];
							break;
						}
					}
				}
			}

			for (int a=0; a<stepwidth; ++a)
				line[a] = newline[a];

			for (int a=0; a<stepwidth; ++a)
			{
				if (nowlong[a] == stepwidth)
					nowlong[a] = 255;
			}
		}
	}
}
