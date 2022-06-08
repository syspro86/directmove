
#pragma once

class CPlayer;

#include "ksf.h"

#define STEPSIZE 60
#define FLARESIZE 80

class CPlayer
{
public:
	typedef CKsf::LINE LINE;
	typedef CKsf::PATTERN PATTERN;

	struct PLAYER_FLARE
	{
		long startTime;
	};
	struct PLAYER_JUDGE
	{
		long startTime;
		long judge;
	};
	struct PLAYER_SCORE
	{
		int EXORBITANT;
		int PERFECT;
		int GREAT;
		int GOOD;
		int BAD;
		int MISS;
		int MAXCOMBO;
		int TOTAL;
	};
	enum SETSPEED_TYPE
	{
		SSPD_SET = 0,
		SSPD_ADD,
		SSPD_SUB,
		SSPD_FORCE_DWORD = 0x7fffffff
	};
	enum JUDGE_TYPE
	{
		JUDGE_EXORBITANT = 0,
		JUDGE_PERFECT,
		JUDGE_GREAT,
		JUDGE_GOOD,
		JUDGE_BAD,
		JUDGE_MISS,
		JUDGE_NONE,
		JUDGE_FORCE_DWORD = 0x7fffffff
	};

	CPlayer();
	virtual ~CPlayer();

	static void InitCommonInfo();

	virtual void Load(LPCSTR filename);
	virtual void Release();

	virtual void UpdateStepData(long time);
	virtual void Render(long time);

	virtual void SetPlayer(KSF_PLAYER_TYPE player);
	virtual void SetSpeed(SETSPEED_TYPE sst, float spd);

	void GetScore(PLAYER_SCORE*);
	void MakeRandom();

protected:
	virtual void NewFlare(int x, long time); // 출력할 플레어를 추가
	virtual void NewJudge(int judge, long time); // 출력할 판정을 추가
	virtual void NewScore(int judge, long time);
	virtual void DrawNote(int x, int y);
	virtual void DrawLongNote(int x, int y, int y2);
	virtual void DrawLongNotePress(int x);
	virtual void DrawFlare(int x, int frame);
	virtual void DrawJudge(long time);
	virtual void DrawScore();
	virtual void DrawGauge(float gauge);

protected:
	CKsf m_KSF;
	POINT m_GaugePos;
	POINT m_StepPos;
	POINT m_JudgePos;
	POINT m_ScorePos;
	float m_fSpeed;
	float m_fGauge;
	float m_fCurBPM;
	int m_iArrowFrame;
	int m_iCurPtnNum;
	int m_iStepWidth;
	int m_iCurCombo;
	bool m_bBtnPress[10];
	PLAYER_JUDGE m_Judge;
	PLAYER_FLARE m_Flare[10];
	PLAYER_SCORE m_Score;
	KSF_PLAYER_TYPE m_iPlayer;
	BOOL m_bFade;

	static long s_ZONE_EXORBITANT;
	static long s_ZONE_PERFECT;
	static long s_ZONE_GREAT;
	static long s_ZONE_GOOD;
	static long s_ZONE_BAD;

	static CSprite* s_pSprArrow;
	static CSprite* s_pSprFlare;
	static CSprite* s_pSprJudge;
	static CSprite* s_pSprJudgeExor;
	static CSprite* s_pSprGauge;
	static CSprite* s_pSprScore;

	static RECT s_trcArrow[5][8];
	static RECT s_trcArrowLong[5][8];
	static RECT s_trcFlare[6][6];
	static RECT s_trcNumber[10];
};
