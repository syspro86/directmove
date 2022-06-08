
#include <zsoo.h>
#include "player_auto.h"
#include "directmove.h"

namespace NS_CAUTOPLAYER
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
using namespace NS_CAUTOPLAYER;

CAutoPlayer::CAutoPlayer()
{
	for (int x=0; x<10; ++x)
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

CAutoPlayer::~CAutoPlayer()
{

}

void CAutoPlayer::UpdateStepData(long time)
{
	int x;				// 키 번호
	int iptn;			// 패턴 번호
	int iptnc = m_KSF.m_vPtns.size();	// 패턴 개수
	int step_num_s;		// 해당 패턴에서 시작 스텝번호
	int step_num_c;		// 해당 패턴의 스텝수
	int judge_time;		// 지금 시간과 해당 스텝의 시간차
	int step_mpos;		// 해당 스텝의 시간적 위치
	int step_num;		// 해당 스텝의 패턴에서의 번호
	int judge;			// 판정
	int FPS = zg_App.iFPS;
	BYTE key[10];		// 키 정보
	PATTERN* ptn_now;

	for (x=0; x<m_iStepWidth; ++x)
	{
		m_bBtnPress[x] = false;
		key[x] = KEY_DOWN;
		for(iptn=m_chkptn_num[x]; iptn < iptnc; ++iptn)
		{
			ptn_now = m_KSF.m_vPtns[iptn];
			if (time < ptn_now->timePos)
				break;
//			if (time > (ptn_now->timePos + ptn_now->timeLen + s_ZONE_BAD))
//				continue;
			if (ptn_now->fBPM==0)
				continue;
			if (iptn == m_chkptn_num[x])
				step_num_s = m_chkline_num[x];
			else
				step_num_s = 0;
//			step_num_s = int(float(time - ptn_now->timePos) / 60000 * ptn_now->fBPM * (float)ptn_now->iTick);
			step_num_c = ptn_now->vLine.size();
			if (step_num_s < 0)
				step_num_s = 0;
			m_chkptn_num[x];
			for (step_num=step_num_s; step_num<step_num_c; ++step_num)
			{
				step_mpos = long((60000 / ptn_now->fBPM) * ((float)step_num / (float)ptn_now->iTick)) + ptn_now->timePos;
				if (step_mpos > time)
				{
					key[x] = KEY_NONE;
					break;
				}
				judge_time = abs(step_mpos - time);
				byte &nnote = ptn_now->vLine[step_num].step[x];
				if (nnote & NOTE_MISS_CHK)
					continue;
				if (nnote == NOTE_NOTE)
				{
					m_bBtnPress[x] = true;
					nnote = NOTE_NONE;
					judge = JUDGE_EXORBITANT;
					NewScore(judge, s_ZONE_BAD);
					m_fGauge += GaugeInc[judge];
					NewJudge(judge, timeGetTime());
					NewFlare(x, timeGetTime());
					key[x] = KEY_NONE;	//빠져나가기
				}
				else if (nnote == NOTE_LSTART)
				{
					m_bBtnPress[x] = true;
					byte *step_to_change;
					nnote = NOTE_NONE;
					if (step_num+1 == step_num_c)
					{
						int next_long_ptn = iptn+1;
						while (!m_KSF.m_vPtns[next_long_ptn]->vLine.size())
							++next_long_ptn;
						step_to_change = &(m_KSF.m_vPtns[next_long_ptn]->vLine.front().step[x]);
						LONGNOTE[x].ptn = next_long_ptn;
						LONGNOTE[x].step = 0;
					}
					else
					{
						step_to_change = &(ptn_now->vLine[step_num+1].step[x]);
						LONGNOTE[x].ptn = iptn;
						LONGNOTE[x].step = step_num+1;
					}
					if (*step_to_change==NOTE_LNOTE)
						*step_to_change = NOTE_LSTART_PRESS;
					else if (*step_to_change==NOTE_LEND)
						*step_to_change = NOTE_LEND_PRESS;
					LONGNOTE[x].pressed = TRUE;
					key[x] = KEY_NONE;	//빠져나가기
#ifdef PENIL
					NewScore(JUDGE_EXORBITANT, s_ZONE_BAD);
					m_fGauge += GaugeInc[JUDGE_EXORBITANT];
					NewJudge(JUDGE_EXORBITANT, timeGetTime());
					NewFlare(x, timeGetTime());
#endif
				}
				m_chkline_num[x] = step_num;
			}
			if (key[x] == KEY_NONE)
				break;
		}
		if (LONGNOTE[x].pressed==TRUE)
		{
			m_bBtnPress[x] = true;
			step_num = LONGNOTE[x].step;
			iptn = LONGNOTE[x].ptn;
			ptn_now = m_KSF.m_vPtns[iptn];
			step_mpos = long(60000 / ptn_now->fBPM * (float)step_num / (float)ptn_now->iTick) + ptn_now->timePos;
			if (step_mpos <= time)
			{
				ptn_now->vLine[step_num].step[x] = NOTE_NONE;
				if (step_num+1 == (int)ptn_now->vLine.size())
				{
					int next_long_ptn = LONGNOTE[x].ptn+1;
					while (!m_KSF.m_vPtns[next_long_ptn]->vLine.size())
						++next_long_ptn;
					LONGNOTE[x].ptn = next_long_ptn;
					LONGNOTE[x].step = 0;
				}
				else
					++LONGNOTE[x].step;
				step_num = LONGNOTE[x].step;
				iptn = LONGNOTE[x].ptn;
				ptn_now = m_KSF.m_vPtns[iptn];
				if (ptn_now->vLine[step_num].step[x] == NOTE_LEND)
					ptn_now->vLine[step_num].step[x] = NOTE_LEND_PRESS;
				else if (ptn_now->vLine[step_num].step[x] == NOTE_LNOTE)
					ptn_now->vLine[step_num].step[x] = NOTE_LSTART_PRESS;
#ifdef PENIL
				else
					LONGNOTE[x].pressed = FALSE;
				NewScore(JUDGE_EXORBITANT, s_ZONE_BAD);
				m_fGauge += GaugeInc[JUDGE_EXORBITANT];
				NewJudge(JUDGE_EXORBITANT, timeGetTime());
				NewFlare(x, timeGetTime());
#else
				else
				{// 터진다..
					NewScore(JUDGE_EXORBITANT, s_ZONE_BAD);
					m_fGauge += GaugeInc[JUDGE_EXORBITANT];
					NewJudge(JUDGE_EXORBITANT, timeGetTime());
					NewFlare(x, timeGetTime());
					LONGNOTE[x].pressed = FALSE;
				}
#endif
			}
		}
	}
	if (m_fGauge > 1.0f)
		m_fGauge = 1.0f;
	else if (m_fGauge < 0.0f)
		m_fGauge = 0.0f;
}

void CAutoPlayer::Render(long time)
{
	CPlayer::Render(time);
	zg_mFont["Normal"]->DrawString(m_StepPos.x+60, m_StepPos.y+80, ~0, NULL, "This is auto play");
}

void CAutoPlayer::Load(LPCSTR filename)
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
