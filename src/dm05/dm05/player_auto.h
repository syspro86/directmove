
#pragma once

class CAutoPlayer;

#include "player.h"

class CAutoPlayer : public CPlayer
{
public:
	struct LONGNOTE_PRESS
	{
		BOOL pressed;
		long time;
		int ptn;
		int step;
	};
	CAutoPlayer();
	virtual ~CAutoPlayer();

	void UpdateStepData(long time);
	void Render(long time);
	void Load(LPCSTR filename);

private:
	BYTE KEY[10];
	LONGNOTE_PRESS LONGNOTE[10];
	int m_chkptn_num[10];
	int m_chkline_num[10];
};
