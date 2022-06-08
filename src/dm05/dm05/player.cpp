
#include <zsoo.h>
#include "directmove.h"
#include "player.h"

long CPlayer::s_ZONE_EXORBITANT;
long CPlayer::s_ZONE_PERFECT;
long CPlayer::s_ZONE_GREAT;
long CPlayer::s_ZONE_GOOD;
long CPlayer::s_ZONE_BAD;

CSprite* CPlayer::s_pSprArrow;
CSprite* CPlayer::s_pSprFlare;
CSprite* CPlayer::s_pSprJudge;
CSprite* CPlayer::s_pSprJudgeExor;
CSprite* CPlayer::s_pSprGauge;
CSprite* CPlayer::s_pSprScore;

RECT CPlayer::s_trcArrow[5][8];
RECT CPlayer::s_trcArrowLong[5][8];
RECT CPlayer::s_trcFlare[6][6];
RECT CPlayer::s_trcNumber[10];

void CPlayer::InitCommonInfo()
{
	for (int x=0; x<5; ++x)
	{
		for (int y=0; y<8; ++y)
		{
			s_trcArrow[x][y].left = y * 60;
			s_trcArrow[x][y].top = x * 60;
			s_trcArrow[x][y].right = s_trcArrow[x][y].left + 60;
			s_trcArrow[x][y].bottom = s_trcArrow[x][y].top + 60;
			s_trcArrowLong[x][y].left = y * 60;
			s_trcArrowLong[x][y].top = x * 60 + 30;
			s_trcArrowLong[x][y].right = s_trcArrowLong[x][y].left + 60;
			s_trcArrowLong[x][y].bottom = s_trcArrowLong[x][y].top;
		}
	}
	for (int x=0; x<6; ++x)
	{
		for (int y=0; y<6; ++y)
		{
			s_trcFlare[x][y].left = y * 80;
			s_trcFlare[x][y].top = x * 80;
			s_trcFlare[x][y].right = s_trcFlare[x][y].left + 80;
			s_trcFlare[x][y].bottom = s_trcFlare[x][y].top + 80;
		}
	}
	for (int x=0; x<2; ++x)
	{
		for (int y=0; y<5; ++y)
		{
			s_trcNumber[x+y*2].left = x*50 + 256;
			s_trcNumber[x+y*2].top = y * 64;
			s_trcNumber[x+y*2].right = x*50 + 306;
			s_trcNumber[x+y*2].bottom = (y+1) * 64;
		}
	}

	s_ZONE_EXORBITANT = 20;
	s_ZONE_PERFECT = 50;
	s_ZONE_GREAT = 80;
	s_ZONE_GOOD = 100;
	s_ZONE_BAD = 130;

	s_pSprArrow = zg_mSpr["Arrow"];
	s_pSprFlare = zg_mSpr["Flare"];
	s_pSprJudge = zg_mSpr["Judge"];
	s_pSprJudgeExor = zg_mSpr["JudgeExor"];
	s_pSprGauge = zg_mSpr["Gauge"];
	s_pSprScore = zg_mSpr["Score"];
}

CPlayer::CPlayer()
{
	m_iCurPtnNum = 0,
	m_fGauge = 1.0f;
	ZeroMemory(&m_Judge, sizeof m_Judge);
	ZeroMemory(&m_Flare[0], sizeof m_Flare);
	ZeroMemory(&m_Score, sizeof m_Score);
	m_iCurCombo = 0;
	m_bFade = dg_cfg.Fade;

	SetPlayer(KSF_SINGLE1P);
	SetSpeed(SSPD_SET, 1.0f);
}

CPlayer::~CPlayer()
{

}

void CPlayer::Release()
{
}

void CPlayer::UpdateStepData(long time)
{

}

void CPlayer::Render(long time)
{
	DWORD time_com = timeGetTime();
	BOOL bDrawLong[10] = {FALSE};
	BOOL bDrawLongPress[10] = {FALSE};
	LONG iLongTop[10] = {0};
	int iPtnNo, iPtnNowNo;
	int iLineNo, iStepNo;

	m_iArrowFrame = (time_com % 1000) / 200;

	PATTERN *pPtnFirst, *pPtnLast;
	pPtnFirst = m_KSF.m_vPtns.front();
	pPtnLast = m_KSF.m_vPtns.back();

	// 현재 bpm 찾기..
	if (time < pPtnFirst->timePos)
	{
		m_fCurBPM = pPtnFirst->fBPM;
		iPtnNowNo = 0;
	}
	else if (time > pPtnLast->timePos)
	{
		m_fCurBPM = pPtnLast->fBPM;
		iPtnNowNo = m_KSF.m_vPtns.size() - 1;
	}
	else
	{
		bool bBpmFound = false;
		for (iPtnNo=m_iCurPtnNum; iPtnNo<(int)m_KSF.m_vPtns.size(); ++iPtnNo)
		{	// 그 패턴의 음악 범위에 속하는지 체크
			PATTERN *pPtnCur = m_KSF.m_vPtns[iPtnNo];
			if (time >= pPtnCur->timePos && time < pPtnCur->timePos + pPtnCur->timeLen)
			{
				while (pPtnCur->fBPM==0)
					pPtnCur = m_KSF.m_vPtns[--iPtnNo];
				m_fCurBPM = pPtnCur->fBPM;
				iPtnNowNo = iPtnNo;
				bBpmFound = true;
				break;
			}
		}
		if (bBpmFound == false)
		{
			for (iPtnNo=0; iPtnNo<(int)m_KSF.m_vPtns.size()-1; ++iPtnNo)
			{	// 그 패턴과 다음패턴 사이에 있는지 체크
				PATTERN *pPtnCur = m_KSF.m_vPtns[iPtnNo];
				PATTERN *pPtnNext = m_KSF.m_vPtns[iPtnNo+1];
				if (time >= pPtnCur->timePos && time < pPtnNext->timePos)
				{
					while (pPtnCur->fBPM==0)
						pPtnCur = m_KSF.m_vPtns[--iPtnNo];
					m_fCurBPM = pPtnCur->fBPM;
					iPtnNowNo = iPtnNo;
					break;
				}
			}
		}
	}
	m_iCurPtnNum = iPtnNowNo;

	iLineNo = m_iArrowFrame;
	for (iStepNo=0; iStepNo<m_iStepWidth; ++iStepNo)	// 스퀀시 존
	{
		m_iArrowFrame = 5 + (m_bBtnPress[iStepNo]==TRUE);
		BOOL bFadeSave = m_bFade;
		m_bFade = FALSE;
		DrawNote(iStepNo, 60);
		m_bFade =bFadeSave;
	}
	m_iArrowFrame = iLineNo;

	float fGapPerStep = (STEPSIZE * m_fSpeed);
	int iPtnTop, iPtnBottom; // 패턴의 첫스텝과 마지막스텝의 실제 출력 좌표

	if (m_KSF.m_vPtns[iPtnNowNo]->timeDelay)
		time = m_KSF.m_vPtns[iPtnNowNo]->timePos;
	iPtnTop = (long)((float)(m_KSF.m_vPtns[iPtnNowNo]->timePos-time) * m_fCurBPM * m_fSpeed * 0.001f);

	for (iPtnNo = iPtnNowNo -1; iPtnNo >= 0; --iPtnNo)
	{
		if (iPtnTop < -STEPSIZE)
			break;
		PATTERN* pPtnCur = m_KSF.m_vPtns[iPtnNo];
		float fPtnTick = (float)pPtnCur->iTick;
		int iLineCnt = (int)pPtnCur->vLine.size();
		iPtnBottom = iPtnTop;
		iPtnTop = iPtnBottom - (long)((float)iLineCnt * fGapPerStep / fPtnTick);
		for (iLineNo=0; iLineNo<iLineCnt; ++iLineNo)
		{
			int iNoteTop = iPtnTop + (int)((float)iLineNo * fGapPerStep / fPtnTick) + STEPSIZE;
			if (iNoteTop >-STEPSIZE && iNoteTop < 480)
			{
				for (iStepNo=0; iStepNo<m_iStepWidth; ++iStepNo)
				{
					BYTE nowstep = pPtnCur->vLine[iLineNo].step[iStepNo];
					if (nowstep & NOTE_NOTE_CHK)
						DrawNote(iStepNo, iNoteTop);
					else if (nowstep & NOTE_LONG_CHK)
					{
						if (nowstep & NOTE_START_CHK)
						{
							if (nowstep & NOTE_PRESS_CHK)
							{
								bDrawLong[iStepNo] = TRUE;
								iLongTop[iStepNo] = STEPSIZE;
								bDrawLongPress[iStepNo] = TRUE;
							}
							else
							{
								bDrawLong[iStepNo] = TRUE;
								iLongTop[iStepNo] = iNoteTop;
							}
							DrawNote(iStepNo, iLongTop[iStepNo]);
						}
						else if (nowstep & NOTE_END_CHK)
						{
							if (nowstep & NOTE_PRESS_CHK)
							{
								DrawNote(iStepNo, STEPSIZE);
								DrawNote(iStepNo, iNoteTop);
								DrawLongNote(iStepNo, STEPSIZE, iNoteTop);
								bDrawLongPress[iStepNo] = TRUE;
							}
							else
							{
								if (bDrawLong[iStepNo]==TRUE)
								{
									bDrawLong[iStepNo] = FALSE;
								}
								DrawNote(iStepNo, iNoteTop);
								DrawLongNote(iStepNo, iLongTop[iStepNo], iNoteTop);
							}
						}
						else
						{
							if (bDrawLong[iStepNo]==FALSE)
							{
								bDrawLong[iStepNo] = TRUE;
								iLongTop[iStepNo] = -STEPSIZE;
							}
						}
					}
				}
			}
			else if (iNoteTop >= 480)
				break;
		} 
	}

	iPtnBottom = (long)((float)(m_KSF.m_vPtns[iPtnNowNo]->timePos-time) * m_fCurBPM * m_fSpeed * 0.001f);
	for (iPtnNo = iPtnNowNo; iPtnNo < (int)m_KSF.m_vPtns.size(); ++iPtnNo)
	{
		if (iPtnBottom > 480)
			break;
		PATTERN* pPtnCur = m_KSF.m_vPtns[iPtnNo];
		float fPtnTick = (float)pPtnCur->iTick;
		int iLineCnt = (int)pPtnCur->vLine.size();
		iPtnTop = iPtnBottom;
		iPtnBottom = iPtnTop + (long)((float)iLineCnt * fGapPerStep / fPtnTick);
		for (iLineNo=0; iLineNo<iLineCnt; ++iLineNo)
		{
			int iNoteTop = iPtnTop + (int)((float)iLineNo * fGapPerStep / fPtnTick) + STEPSIZE;
			if (iNoteTop >-STEPSIZE && iNoteTop < 480)
			{
				for (iStepNo=0; iStepNo<m_iStepWidth; ++iStepNo)
				{
					BYTE nowstep = pPtnCur->vLine[iLineNo].step[iStepNo];
					if (nowstep & NOTE_NOTE_CHK)
						DrawNote(iStepNo, iNoteTop);
					else if (nowstep & NOTE_LONG_CHK)
					{
						if (nowstep & NOTE_START_CHK)
						{
							if (nowstep & NOTE_PRESS_CHK)
							{
								bDrawLong[iStepNo] = TRUE;
								iLongTop[iStepNo] = STEPSIZE;
								bDrawLongPress[iStepNo] = TRUE;
							}
							else
							{
								bDrawLong[iStepNo] = TRUE;
								iLongTop[iStepNo] = iNoteTop;
							}
							DrawNote(iStepNo, iLongTop[iStepNo]);
						}
						else if (nowstep & NOTE_END_CHK)
						{
							if (nowstep & NOTE_PRESS_CHK)
							{
								DrawNote(iStepNo, STEPSIZE);
								DrawNote(iStepNo, iNoteTop);
								DrawLongNote(iStepNo, STEPSIZE, iNoteTop);
								bDrawLongPress[iStepNo] = TRUE;
							}
							else
							{
								if (bDrawLong[iStepNo]==TRUE)
								{
									bDrawLong[iStepNo] = FALSE;
								}
								DrawNote(iStepNo, iNoteTop);
								DrawLongNote(iStepNo, iLongTop[iStepNo], iNoteTop);
							}
						}
						else
						{
							if (bDrawLong[iStepNo]==FALSE)
							{
								bDrawLong[iStepNo] = TRUE;
								iLongTop[iStepNo] = -STEPSIZE;
							}
						}
					}
				}
			}
			else if (iNoteTop >= 480)
				break;
		} 
	}

	for (iStepNo=0; iStepNo<m_iStepWidth; ++iStepNo)
	{
		if (bDrawLong[iStepNo])
			DrawLongNote(iStepNo, iLongTop[iStepNo], 480);
	}

	if (m_fGauge > 1.0f)
		m_fGauge = 1.0f;
	if (m_fGauge < 0.0f)
		m_fGauge = 0.0f;

	float gauge_find;

	gauge_find = (60000 / m_fCurBPM);
	iPtnNo = abs(m_KSF.m_vPtns[iPtnNowNo]->timePos - time); // iPtnNo 임시사용
	while (iPtnNo >= gauge_find)
		iPtnNo = int((float)iPtnNo - gauge_find);
	if (time < pPtnFirst->timePos)
		iPtnNo = int(gauge_find - (float)iPtnNo);
	gauge_find = iPtnNo/gauge_find*0.1f;

	if (m_fGauge == 1.0f)
	{
		gauge_find *= 3.0f;
		gauge_find += 0.7f;
		DrawGauge(2.0f + gauge_find);
	}
	else
	{
		gauge_find += m_fGauge;
		if (gauge_find > 1.0f)
			gauge_find = 1.0f;
		DrawGauge(gauge_find);
	}

	for (iStepNo=0; iStepNo<m_iStepWidth; ++iStepNo)
	{
		if (bDrawLongPress[iStepNo])
			DrawLongNotePress(iStepNo);

		if (m_Flare[iStepNo].startTime==0)
			continue;
		iLongTop[iStepNo] = time_com - m_Flare[iStepNo].startTime; // iLongTop 임시사용..
		iLongTop[iStepNo] = iLongTop[iStepNo] >> 6;
		if (iLongTop[iStepNo] >= 6)
		{
			m_Flare[iStepNo].startTime = 0;
			continue;
		}
		DrawFlare(iStepNo, iLongTop[iStepNo]);
	}

	DrawScore();

	if (m_Judge.startTime==0)
		return;
	if (m_Judge.startTime+800 < (long)time_com)
	{
		m_Judge.startTime = 0;
		return;
	}
	DrawJudge(time_com-m_Judge.startTime);
}

void CPlayer::Load(LPCSTR filename)
{
	m_KSF.Load(filename);
}

void CPlayer::SetPlayer(KSF_PLAYER_TYPE player)
{
	m_iPlayer = player;
	if (player==KSF_SINGLE1P)
	{
		m_StepPos.x = 20;
		m_StepPos.y = 60;
		m_GaugePos.x = 22;
		m_GaugePos.y = 10;
		m_JudgePos.x = 150;
		m_JudgePos.y = 224;
		m_ScorePos.x = 22;
		m_ScorePos.y = 400;
		m_iStepWidth = 5;
	}
	else if (player==KSF_SINGLE2P)
	{
		m_StepPos.x = 360;
		m_StepPos.y = 60;
		m_GaugePos.x = 362;
		m_GaugePos.y = 10;
		m_JudgePos.x = 490;
		m_JudgePos.y = 224;
		m_ScorePos.x = 362;
		m_ScorePos.y = 400;
		m_iStepWidth = 5;
	}
	else if (player==KSF_DOUBLE)
	{
		m_StepPos.x = 65;
		m_StepPos.y = 60;
		m_GaugePos.x = 67;
		m_GaugePos.y = 10;
		m_JudgePos.x = 320;
		m_JudgePos.y = 224;
		m_ScorePos.x = 67;
		m_ScorePos.y = 400;
		m_iStepWidth = 10;
	}
}

void CPlayer::SetSpeed(SETSPEED_TYPE sst, float spd)
{
	switch (sst)
	{
		case SSPD_SET:
			m_fSpeed = spd;
			break;
		case SSPD_ADD:
			m_fSpeed += spd;
			break;
		case SSPD_SUB:
			m_fSpeed -= spd;
			break;
	}
	if (m_fSpeed < 1.0f)
		m_fSpeed = 1.0f;
	if (m_fSpeed > 8.0f)
		m_fSpeed = 8.0f;
}

void CPlayer::GetScore(PLAYER_SCORE* p)
{
	CopyMemory(p, &m_Score, sizeof m_Score);
}

void CPlayer::MakeRandom()
{
	m_KSF.MakeRandom();
}

void CPlayer::NewFlare(int x, long time)
{
	m_Flare[x].startTime = time;
}

void CPlayer::NewJudge(int judge, long time)
{
	m_Judge.judge = judge;
	m_Judge.startTime = time;
}

void CPlayer::NewScore(int judge, long time)
{
	switch (judge)
	{//1 3 5 점 / 200점 500점 800점 1000점
		case JUDGE_EXORBITANT:
			m_Score.TOTAL += 1000;
			m_Score.TOTAL += m_iCurCombo * 5;
			++m_Score.EXORBITANT;
			++m_iCurCombo;
			break;
		case JUDGE_PERFECT:
			m_Score.TOTAL += 800;
			m_Score.TOTAL += m_iCurCombo * 3;
			++m_Score.PERFECT;
			++m_iCurCombo;
			break;
		case JUDGE_GREAT:
			m_Score.TOTAL += 500;
			m_Score.TOTAL += m_iCurCombo * 1;
			++m_Score.GREAT;
			++m_iCurCombo;
			break;
		case JUDGE_GOOD:
			m_Score.TOTAL += 200;
			++m_Score.GOOD;
			break;
		case JUDGE_BAD:
			m_iCurCombo = 0;
			++m_Score.BAD;
			break;
		case JUDGE_MISS:
			m_iCurCombo = 0;
			++m_Score.MISS;
			break;
	}
	if (m_Score.MAXCOMBO < m_iCurCombo)
		m_Score.MAXCOMBO = m_iCurCombo;
}

void CPlayer::DrawNote(int x, int y)
{
	DWORD color = 0xffffffff;
	int left, top;
	left = m_StepPos.x + x * 50;
	top = y;
	if (m_bFade)
	{
		BYTE& alpha = *((BYTE*)&color + 3);
		if (y < 150)
			alpha = 0;
		else if (y < 390)
			alpha = (BYTE)((float)(y-150) / 240.0f * 255.0f);
	}
	s_pSprArrow->Draw( &IRECT(left, top, left+60, top+60), &s_trcArrow[x%5][m_iArrowFrame], color );
}

void CPlayer::DrawLongNote(int x, int y, int y2)
{
	RECT rcDest;
	CSprite::COLOR4 color(0xffffffff);
	rcDest.left = m_StepPos.x + x * 50;
	rcDest.right = rcDest.left + 60;
	if (y2 - y < 60)
	{
		if (y > -60)
		{
			rcDest.top = y;
			rcDest.bottom = y + (y2 - y + 60) / 2;
			color.Color[0] = color.Color[1] = 0x00ffffff;
			color.Color[2] = color.Color[3] = 0xffffffff;
			if (m_bFade)
			{
				BYTE& alpha = *((BYTE*)&color.Color[2] + 3);
				if (y < 150)
					alpha = 0;
				else if (y < 390)
					alpha = (BYTE)((float)(y-150) / 240.0f * 255.0f);
				color.Color[3] = color.Color[2];
			}
			s_pSprArrow->Draw( &rcDest, &s_trcArrowLong[x%5][m_iArrowFrame], color );
		}
		if (y2 < 480)
		{
			rcDest.top = y + (y2 - y + 60) / 2;
			rcDest.bottom = y2 + 60;
			color.Color[0] = color.Color[1] = 0xffffffff;
			color.Color[2] = color.Color[3] = 0x00ffffff;
			if (m_bFade)
			{
				BYTE& alpha = *((BYTE*)&color.Color[0] + 3);
				if (y2 < 150)
					alpha = 0;
				else if (y2 < 390)
					alpha = (BYTE)((float)(y2-150) / 240.0f * 255.0f);
				color.Color[1] = color.Color[0];
			}
			s_pSprArrow->Draw( &rcDest, &s_trcArrowLong[x%5][m_iArrowFrame], color );
		}
	}
	else
	{
		if (y > -60)
		{
			rcDest.top = y;
			rcDest.bottom = rcDest.top + 60;
			color.Color[0] = color.Color[1] = 0x00ffffff;
			color.Color[2] = color.Color[3] = 0xffffffff;
			if (m_bFade)
			{
				BYTE& alpha = *((BYTE*)&color.Color[2] + 3);
				if (y < 150)
					alpha = 0;
				else if (y < 390)
					alpha = (BYTE)((float)(y-150) / 240.0f * 255.0f);
				color.Color[3] = color.Color[2];
			}
			s_pSprArrow->Draw( &rcDest, &s_trcArrowLong[x%5][m_iArrowFrame], color );
		}
		if (y2 < 480)
		{
			rcDest.top = y2;
			rcDest.bottom = rcDest.top + 60;
			color.Color[0] = color.Color[1] = 0xffffffff;
			color.Color[2] = color.Color[3] = 0x00ffffff;
			if (m_bFade)
			{
				BYTE& alpha = *((BYTE*)&color.Color[0] + 3);
				if (y2 < 150)
					alpha = 0;
				else if (y2 < 390)
					alpha = (BYTE)((float)(y2-150) / 240.0f * 255.0f);
				color.Color[1] = color.Color[0];
			}
			s_pSprArrow->Draw( &rcDest, &s_trcArrowLong[x%5][m_iArrowFrame], color );
		}
		if (m_bFade)
		{
			if (y < 150)
				y = 150;
			if (y2 >= 390 && y < 330)
			{
				rcDest.top = 390;
				rcDest.bottom = y2;
				s_pSprArrow->Draw( &rcDest, &s_trcArrowLong[x%5][m_iArrowFrame] );
				y2 = 390;
			}
			rcDest.top = y + 60;
			rcDest.bottom = y2;
			BYTE& alpha = *((BYTE*)&color.Color[0] + 3);
			if (y < 150)
				alpha = 0;
			else if (y < 390)
				alpha = (BYTE)((float)(y-150) / 240.0f * 255.0f);
			else
				alpha = 255;
			color.Color[1] = color.Color[0];
			BYTE& alpha2 = *((BYTE*)&color.Color[2] + 3);
			if (y2 < 150)
				alpha2 = 0;
			else if (y2 < 390)
				alpha2 = (BYTE)((float)(y2-150) / 240.0f * 255.0f);
			else
				alpha2 = 255;
			color.Color[3] = color.Color[2];
			s_pSprArrow->Draw( &rcDest, &s_trcArrowLong[x%5][m_iArrowFrame], color );
		}
		else
		{
			rcDest.top = y + 60;
			rcDest.bottom = y2;
			s_pSprArrow->Draw( &rcDest, &s_trcArrowLong[x%5][m_iArrowFrame] );
		}
	}
}

void CPlayer::DrawLongNotePress(int x)
{
	int left, right;
	left = m_StepPos.x + x * 50 - 10;
	right = left + 80;
	int frame = (timeGetTime() % 299) * 6 / 300;

	s_pSprFlare->Draw( &IRECT(left, 50, right, 130), &s_trcFlare[5][frame], ~0, BLSTYLE_COLOR );
}

void CPlayer::DrawFlare(int x, int frame)
{
	int left, right;
	left = m_StepPos.x + x * 50 - 10;
	right = left + 80;

	s_pSprFlare->Draw( &IRECT(left, 50, right, 130), &s_trcFlare[x%5][frame], ~0, BLSTYLE_COLOR );
}

void CPlayer::DrawJudge(long time)
{
	byte alpha;
	DWORD color;
	float ft;
	if (time < 100)
	{
		ft = (float)time;
		ft /= 300;
		ft += 1.0f;
		alpha = (byte)(255.0f * ((float)time/200.0f + 0.5f));
	}
	else if (time > 600)
	{
		ft = (float)time;
		ft -= 600;
		ft /= 400;
		ft += 1;
		alpha = (byte)(255.0f * (1.5f-ft));
	}
	else
	{
		ft = 1.0f;
		alpha = 255;
	}
	color = (alpha << 24) | 0x00ffffff;
	if (m_Judge.judge == JUDGE_EXORBITANT)
	{
		int frame = (((time) / 50) % 8);
		s_pSprJudgeExor->Draw( &IRECT(m_JudgePos.x - (long)(128*ft), m_JudgePos.y - (long)(32*ft), m_JudgePos.x + (long)(128*ft), m_JudgePos.y + (long)(32*ft)),
									&IRECT(0, frame*64, 256, (frame+1)*64),
									color);
	}
	else
	{
		s_pSprJudge->Draw( &IRECT(m_JudgePos.x - (long)(128*ft), m_JudgePos.y - (long)(32*ft), m_JudgePos.x + (long)(128*ft), m_JudgePos.y + (long)(32*ft)),
								&IRECT(0, (m_Judge.judge-1)*64, 256, m_Judge.judge*64),
								color);
	}

	if (m_iCurCombo > 1)
	{
		char combo[5];
		char number;
		sprintf(combo, "%d", m_iCurCombo);
		int len = strlen(combo);
		float xc = (float)m_JudgePos.x;
		float xc2 = xc;
		xc2 -= len*25;
		xc2 += 25;
		float yc = (float)m_JudgePos.y + 50;
		float x1, y1, x2, y2;
		for (time = 0; time < len; ++time)
		{
			x1 = xc - (xc-xc2+25)*ft;
			x2 = xc - (xc-xc2-25)*ft;
			y1 = yc - 32*ft;
			y2 = yc + 32*ft;
			xc2 += 50;
			number = combo[time] - '0';

			s_pSprJudge->Draw( &IRECT((int)x1, (int)y1, (int)x2, (int)y2), &s_trcNumber[number], color );
		}
	}
}

void CPlayer::DrawScore()
{
	s_pSprGauge->Draw(&IRECT(m_ScorePos.x, m_ScorePos.y, m_ScorePos.x+256, m_ScorePos.y+64), &IRECT(0, 64, 256, 128));
	char Score[16];
	sprintf(Score, "%08d", m_Score.TOTAL);
	for (int i=0; i<8; ++i)
	{
		if (Score[i] == '0')
			Score[i] = 9;
		else
			Score[i] -= '1';

		RECT rect, rect2;
		rect.left = m_ScorePos.x + 3 + 30 * i;
		rect.right = rect.left + 40;
		rect.top = m_ScorePos.y + 25;
		rect.bottom = rect.top + 30;

		rect2.left = (Score[i] % 3) * 40;
		rect2.top = (Score[i] / 3) * 30;
		rect2.right = rect2.left + 40;
		rect2.bottom = rect2.top + 30;

		s_pSprScore->Draw(&rect, &rect2);
	}
}

void CPlayer::DrawGauge(float gauge)
{
	RECT rcDest, rcImg;

	rcDest.left = m_GaugePos.x;
	rcDest.top = m_GaugePos.y;
	rcDest.right = m_GaugePos.x+256;
	rcDest.bottom = m_GaugePos.y+32;
	rcImg.left = 0;
	rcImg.top = 0;
	rcImg.right = 256;
	rcImg.bottom = 32;

	s_pSprGauge->Draw(&rcDest, &rcImg);

	rcImg.top = 32;
	rcImg.bottom = 64;

	if (gauge >= 2.0f)
	{
		gauge -= 2.0f;
		s_pSprGauge->Draw(&rcDest, &rcImg, 0x00ffffff | (int(gauge*255.0f)<<24));
	}
	else
	{
		gauge = gauge*256.0f;
		rcDest.right = m_GaugePos.x + (int)gauge;
		rcImg.right = (int)gauge;
		s_pSprGauge->Draw(&rcDest, &rcImg);
	}
}
