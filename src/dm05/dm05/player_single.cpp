
#include <zsoo.h>
#include "player_single.h"
#include "directmove.h"

namespace NS_CSINGLEPLAYER
{
	const float GaugeIncEasy[] = 
	{
		0.06f,
		0.03f,
		0.02f,
		0.015f,
		-0.015f,
		-0.08f
	};
	const float GaugeIncNormal[] = 
	{
		0.04f,
		0.02f,
		0.015f,
		0.01f,
		-0.02f,
		-0.1f
	};
	const float GaugeIncHard[] = 
	{
		0.02f,
		0.01f,
		0.007f,
		0.005f,
		-0.04f,
		-0.2f
	};
	float GaugeInc[6];
}
using namespace NS_CSINGLEPLAYER;

CSinglePlayer::CSinglePlayer()
{
	for (int x=0; x<10; ++x)
	{
		KEY[0] = 0;
	}
	for (x=0; x<10; ++x)
	{
		LONGNOTE[x].pressed = FALSE;
		m_chkptn_num[x] = 0;
		m_chkline_num[x] = 0;
	}

	if (dg_cfg.GaugeLevel==0)
		CopyMemory(GaugeInc, GaugeIncEasy, sizeof GaugeInc);
	if (dg_cfg.GaugeLevel==1)
		CopyMemory(GaugeInc, GaugeIncNormal, sizeof GaugeInc);
	if (dg_cfg.GaugeLevel==2)
		CopyMemory(GaugeInc, GaugeIncHard, sizeof GaugeInc);
}

CSinglePlayer::~CSinglePlayer()
{

}

void CSinglePlayer::UpdateStepData(long time)
{
	int x;				// 키 번호
	int iptn;			// 패턴 번호
	int iptnc = (int)m_KSF.m_vPtns.size();	// 패턴 개수
	int line_num_s;		// 해당 패턴에서 시작 라인번호
	int line_num_c;		// 해당 패턴의 라인수
	int judge_time;		// 지금 시간과 해당 스텝의 시간차
	int line_mpos;		// 해당 라인의 시간적 위치
	int line_num;		// 해당 라인의 패턴에서의 번호
	int judge;			// 판정
	int FPS = zg_App.iFPS;
	BYTE key[10];		// 키 정보
	PATTERN* ptn_now;

	const KEYBOARD_BUFFER& keyboard = zg_pInput->GetKeyboardBuffer();
	for (x=0; x<m_iStepWidth; ++x)
		key[x] = keyboard.keyStates[KEY[x]];

	for (x=0; x<m_iStepWidth; ++x)
	{
		if (key[x] == KEY_DOWN)			// 체크..
		{
			m_bBtnPress[x] = true;
			for(iptn=0; iptn < iptnc; ++iptn)
			{
				ptn_now = m_KSF.m_vPtns[iptn];
				if (time < ptn_now->timePos - s_ZONE_BAD)
					break;
				if (time > (ptn_now->timePos + ptn_now->timeLen + s_ZONE_BAD))
					continue;
				if (ptn_now->fBPM==0)
					continue;
				line_num_s = int(float(time - ptn_now->timePos - s_ZONE_BAD) / 60000 * ptn_now->fBPM * (float)ptn_now->iTick);
				line_num_c = (int)ptn_now->vLine.size();
				if (line_num_s < 0)
					line_num_s = 0;
				for (line_num=line_num_s; line_num<line_num_c; ++line_num)
				{
					line_mpos = long(60000 / ptn_now->fBPM * (float)line_num / (float)ptn_now->iTick) + ptn_now->timePos;
					judge_time = abs(line_mpos - time);
					if (judge_time < s_ZONE_BAD)
					{
						BYTE &nnote = ptn_now->vLine[line_num].step[x];
						if (nnote & NOTE_MISS_CHK)
							continue;
						if (nnote == NOTE_NOTE)
						{
							nnote = NOTE_NONE;
							OnStepChange(iptn, line_num, x, NOTE_NONE);
							if (judge_time <= s_ZONE_EXORBITANT)
								judge = JUDGE_EXORBITANT;
							else if (judge_time <= s_ZONE_PERFECT)
								judge = JUDGE_PERFECT;
							else if (judge_time <= s_ZONE_GREAT)
								judge = JUDGE_GREAT;
							else if (judge_time <= s_ZONE_GOOD)
								judge = JUDGE_GOOD;
							else
								judge = JUDGE_BAD;
							NewScore(judge, s_ZONE_BAD - judge_time);
							m_fGauge += GaugeInc[judge];
							NewJudge(judge, timeGetTime());
							NewFlare(x, timeGetTime());
							key[x] = KEY_NONE;	//빠져나가기
						}
						else if (nnote == NOTE_LSTART)
						{
							BYTE *step_to_change;
							nnote = NOTE_NONE;
							OnStepChange(iptn, line_num, x, NOTE_NONE);
							if (line_num+1 == line_num_c)
							{
								int next_long_ptn = iptn+1;
								while (!m_KSF.m_vPtns[next_long_ptn]->vLine.size())
									++next_long_ptn;
								step_to_change = &(m_KSF.m_vPtns[next_long_ptn]->vLine.front().step[x]);
								LONGNOTE[x].ptn = next_long_ptn;
								LONGNOTE[x].line = 0;
							}
							else
							{
								step_to_change = &(ptn_now->vLine[line_num+1].step[x]);
								LONGNOTE[x].ptn = iptn;
								LONGNOTE[x].line = line_num+1;
							}
							if (*step_to_change==NOTE_LNOTE)
							{
								*step_to_change = NOTE_LSTART_PRESS;
								OnStepChange(LONGNOTE[x].ptn, LONGNOTE[x].line, x, NOTE_LSTART_PRESS);
							}
							else if (*step_to_change==NOTE_LEND)
							{
								*step_to_change = NOTE_LEND_PRESS;
								OnStepChange(LONGNOTE[x].ptn, LONGNOTE[x].line, x, NOTE_LEND_PRESS);
							}
							LONGNOTE[x].pressed = TRUE;
							LONGNOTE[x].time = judge_time;
							key[x] = KEY_NONE;	//빠져나가기
#ifdef PENIL
							judge_time = LONGNOTE[x].time >> 1;
							if (judge_time <= s_ZONE_EXORBITANT)
								judge = JUDGE_EXORBITANT;
							else if (judge_time <= s_ZONE_PERFECT)
								judge = JUDGE_PERFECT;
							else if (judge_time <= s_ZONE_GREAT)
								judge = JUDGE_GREAT;
							else if (judge_time <= s_ZONE_GOOD)
								judge = JUDGE_GOOD;
							else
								judge = JUDGE_BAD;
							NewScore(judge, s_ZONE_BAD - judge_time);
							m_fGauge += GaugeInc[judge];
							NewJudge(judge, timeGetTime());
							NewFlare(x, timeGetTime());
#endif
						}
					}
					else if (line_mpos > time)
					{
						key[x] = KEY_NONE;
					}
					if (key[x] == KEY_NONE)
						break;
				}
				if (key[x] == KEY_NONE)
					break;
			}
		}
		else if (key[x] == KEY_PRESS)	// 롱노트~
		{
			m_bBtnPress[x] = true;
			if (LONGNOTE[x].pressed==TRUE)
			{
				line_num = LONGNOTE[x].line;
				iptn = LONGNOTE[x].ptn;
				ptn_now = m_KSF.m_vPtns[iptn];
				line_mpos = long(60000 / ptn_now->fBPM * (float)line_num / (float)ptn_now->iTick) + ptn_now->timePos;
				if (line_mpos <= time)
				{
					ptn_now->vLine[line_num].step[x] = NOTE_NONE;
					OnStepChange(iptn, line_num, x, NOTE_NONE);
					if (line_num+1 == (int)ptn_now->vLine.size())
					{
						int next_long_ptn = LONGNOTE[x].ptn+1;
						while (!m_KSF.m_vPtns[next_long_ptn]->vLine.size())
							++next_long_ptn;
						LONGNOTE[x].ptn = next_long_ptn;
						LONGNOTE[x].line = 0;
					}
					else
						++LONGNOTE[x].line;
					line_num = LONGNOTE[x].line;
					iptn = LONGNOTE[x].ptn;
					ptn_now = m_KSF.m_vPtns[iptn];
					if (ptn_now->vLine[line_num].step[x] == NOTE_LEND)
					{
						ptn_now->vLine[line_num].step[x] = NOTE_LEND_PRESS;
						OnStepChange(LONGNOTE[x].ptn, LONGNOTE[x].line, x, NOTE_LEND_PRESS);
					}
					else if (ptn_now->vLine[line_num].step[x] == NOTE_LNOTE)
					{
						ptn_now->vLine[line_num].step[x] = NOTE_LSTART_PRESS;
						OnStepChange(LONGNOTE[x].ptn, LONGNOTE[x].line, x, NOTE_LSTART_PRESS);
					}
#ifdef PENIL
					else
						LONGNOTE[x].pressed = FALSE;
					judge_time = LONGNOTE[x].time >> 1;
					if (judge_time <= s_ZONE_EXORBITANT)
						judge = JUDGE_EXORBITANT;
					else if (judge_time <= s_ZONE_PERFECT)
						judge = JUDGE_PERFECT;
					else if (judge_time <= s_ZONE_GREAT)
						judge = JUDGE_GREAT;
					else if (judge_time <= s_ZONE_GOOD)
						judge = JUDGE_GOOD;
					else
						judge = JUDGE_BAD;
					NewScore(judge, s_ZONE_BAD - judge_time);
					m_fGauge += GaugeInc[judge];
					NewJudge(judge, timeGetTime());
					NewFlare(x, timeGetTime());
#else
					else
					{// 터진다..
						judge_time = LONGNOTE[x].time >> 1;
						if (judge_time <= s_ZONE_EXORBITANT)
							judge = JUDGE_EXORBITANT;
						else if (judge_time <= s_ZONE_PERFECT)
							judge = JUDGE_PERFECT;
						else if (judge_time <= s_ZONE_GREAT)
							judge = JUDGE_GREAT;
						else if (judge_time <= s_ZONE_GOOD)
							judge = JUDGE_GOOD;
						else
							judge = JUDGE_BAD;
						NewScore(judge, s_ZONE_BAD - judge_time);
						m_fGauge += GaugeInc[judge];
						NewJudge(judge, timeGetTime());
						NewFlare(x, timeGetTime());
						LONGNOTE[x].pressed = FALSE;
					}
#endif
				}
			}
		}
		else if (key[x] == KEY_UP)		// 롱노트에서 떼면 미스!
		{
			m_bBtnPress[x] = false;
			if (LONGNOTE[x].pressed==TRUE)
			{
				LONGNOTE[x].pressed = FALSE;
				judge_time = GetLongNoteEndTime(x) - time;
				if (judge_time < s_ZONE_BAD)
				{
					judge_time = abs(judge_time);
					judge_time += LONGNOTE[x].time;
					judge_time >>= 1;
					if (judge_time <= s_ZONE_EXORBITANT)
						judge = JUDGE_EXORBITANT;
					else if (judge_time <= s_ZONE_PERFECT)
						judge = JUDGE_PERFECT;
					else if (judge_time <= s_ZONE_GREAT)
						judge = JUDGE_GREAT;
					else if (judge_time <= s_ZONE_GOOD)
						judge = JUDGE_GOOD;
					else
						judge = JUDGE_BAD;
					NewScore(judge, s_ZONE_BAD - judge_time);
					m_fGauge += GaugeInc[judge];
					NewJudge(judge, timeGetTime());
					NewFlare(x, timeGetTime());
					ClearLongNote(x);
				}
				else
				{
					line_num = LONGNOTE[x].line;
					iptn = LONGNOTE[x].ptn;
					ptn_now = m_KSF.m_vPtns[iptn];
					if (ptn_now->vLine[line_num].step[x] == NOTE_LEND_PRESS)
					{
						ptn_now->vLine[line_num].step[x] = NOTE_LEND_MISS;
						OnStepChange(iptn, line_num, x, NOTE_LEND_MISS);
					}
					else
					{
						ptn_now->vLine[line_num].step[x] = NOTE_LSTART_MISS;
						OnStepChange(iptn, line_num, x, NOTE_LSTART_MISS);
					}
					NewScore(JUDGE_MISS, -s_ZONE_BAD);
					m_fGauge += GaugeInc[JUDGE_MISS];
					NewJudge(JUDGE_MISS, timeGetTime());
				}
			}
		}
		else
			m_bBtnPress[x] = false;
		key[x] = KEY_DOWN;
		for(iptn=m_chkptn_num[x]; iptn < iptnc; ++iptn)
		{
			ptn_now = m_KSF.m_vPtns[iptn];
			if (time < ptn_now->timePos + s_ZONE_BAD)
				break;
			line_num_c = (int)ptn_now->vLine.size();
			int line_start = iptn==m_chkptn_num[x] ? m_chkline_num[x] : 0;
			for (line_num=line_start; line_num<line_num_c; ++line_num)
			{
				line_mpos = long(60000 / ptn_now->fBPM * (float)line_num / (float)ptn_now->iTick) + ptn_now->timePos;
				line_mpos += s_ZONE_BAD;
				if (line_mpos < time)
				{
					BYTE &nnote = ptn_now->vLine[line_num].step[x];
					if (nnote & NOTE_MISS_CHK)
						continue;
					if (nnote & NOTE_PRESS_CHK)
						continue;
					if (nnote == NOTE_NOTE)
					{
						nnote = NOTE_NOTE_MISS;
						OnStepChange(iptn, line_num, x, NOTE_NOTE_MISS);
						NewScore(JUDGE_MISS, -s_ZONE_BAD);
						m_fGauge += GaugeInc[JUDGE_MISS];
						NewJudge(JUDGE_MISS, timeGetTime());
					}
					else if (nnote == NOTE_LSTART)
					{
						nnote = NOTE_LSTART_MISS;
						OnStepChange(iptn, line_num, x, NOTE_LSTART_MISS);
						NewScore(JUDGE_MISS, -s_ZONE_BAD);
						m_fGauge += GaugeInc[JUDGE_MISS];
						NewJudge(JUDGE_MISS, timeGetTime());
					}
					else if (nnote == NOTE_LEND)
					{
						nnote = NOTE_LEND_MISS;
						OnStepChange(iptn, line_num, x, NOTE_LEND_MISS);
					}
					m_chkptn_num[x] = iptn;
					m_chkline_num[x] = line_num;
				}
				else
				{
					key[x] = KEY_NONE;
					break;
				}
			}
			if (key[x] == KEY_NONE)
				break;
		}
	}
	if (m_fGauge > 1.0f)
		m_fGauge = 1.0f;
	else if (m_fGauge < 0.0f)
	{
		if (dg_cfg.StageBreak)
			PostMessage(zg_App.hWnd, WM_STAGEBREAK, 0, 0);
		m_fGauge = 0.0f;
	}
}

void CSinglePlayer::Load(LPCSTR filename)
{
	int x;
	m_KSF.Load(filename, m_iPlayer);
	m_iCurPtnNum = 0;
	for (x=0; x<10; ++x)
	{
		m_Flare[x].startTime = 0;
		m_bBtnPress[x] = false;
	}
}

void CSinglePlayer::SetPlayer(KSF_PLAYER_TYPE player)
{
	CPlayer::SetPlayer(player);
	if (player==KSF_SINGLE1P)
	{
		KEY[0] = DIK_Z;
		KEY[1] = DIK_Q;
		KEY[2] = DIK_S;
		KEY[3] = DIK_E;
		KEY[4] = DIK_C;
		KEY[5] = 0;
		KEY[6] = 0;
		KEY[7] = 0;
		KEY[8] = 0;
		KEY[9] = 0;
	}
	else if (player==KSF_SINGLE2P)
	{
		KEY[0] = DIK_NUMPAD1;
		KEY[1] = DIK_NUMPAD7;
		KEY[2] = DIK_NUMPAD5;
		KEY[3] = DIK_NUMPAD9;
		KEY[4] = DIK_NUMPAD3;
		KEY[5] = 0;
		KEY[6] = 0;
		KEY[7] = 0;
		KEY[8] = 0;
		KEY[9] = 0;
	}
	else if (player==KSF_DOUBLE)
	{
		KEY[0] = DIK_Z;
		KEY[1] = DIK_Q;
		KEY[2] = DIK_S;
		KEY[3] = DIK_E;
		KEY[4] = DIK_C;
		KEY[5] = DIK_NUMPAD1;
		KEY[6] = DIK_NUMPAD7;
		KEY[7] = DIK_NUMPAD5;
		KEY[8] = DIK_NUMPAD9;
		KEY[9] = DIK_NUMPAD3;
	}
}

long CSinglePlayer::GetLongNoteEndTime(int x)
{
	LONGNOTE_PRESS ln = LONGNOTE[x];

	int iptnc = m_KSF.m_vPtns.size();
	for(int iptn=ln.ptn; iptn < iptnc; ++iptn)
	{
		PATTERN* ptn_now = m_KSF.m_vPtns[iptn];
		int line_num_c = (int)ptn_now->vLine.size();
		int line_start = iptn==ln.ptn ? ln.line : 0;
		for (int line_num=line_start; line_num<line_num_c; ++line_num)
		{
			BYTE nnote = ptn_now->vLine[line_num].step[x];
			if (nnote == NOTE_LEND || nnote == NOTE_LEND_PRESS)
			{
				long line_mpos = long(60000 / ptn_now->fBPM * (float)line_num / (float)ptn_now->iTick) + ptn_now->timePos;
				return line_mpos;
			}
		}
	}
	return 0;
}

void CSinglePlayer::ClearLongNote(int x)
{
	LONGNOTE_PRESS ln = LONGNOTE[x];

	int iptnc = m_KSF.m_vPtns.size();
	for(int iptn=ln.ptn; iptn < iptnc; ++iptn)
	{
		PATTERN* ptn_now = m_KSF.m_vPtns[iptn];
		int line_num_c = (int)ptn_now->vLine.size();
		int line_start = iptn==ln.ptn ? ln.line : 0;
		for (int line_num=line_start; line_num<line_num_c; ++line_num)
		{
			BYTE &nnote = ptn_now->vLine[line_num].step[x];
			if (nnote == NOTE_LEND || nnote == NOTE_LEND_PRESS)
			{
				nnote = NOTE_NONE;
				OnStepChange(iptn, line_num, x, NOTE_NONE);
				return;
			}
			else if (nnote == NOTE_LNOTE || nnote == NOTE_LSTART_PRESS)
			{
				nnote = NOTE_NONE;
				OnStepChange(iptn, line_num, x, NOTE_NONE);
			}
		}
	}
}
