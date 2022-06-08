
#pragma once

class CSinglePlayer;

#include "player.h"

class CSinglePlayer : public CPlayer
{
public:
	struct LONGNOTE_PRESS
	{
		BOOL pressed;
		long time;
		int ptn;
		int line;
	};
	CSinglePlayer();
	virtual ~CSinglePlayer();

	void UpdateStepData(long time);
	void Load(LPCSTR filename);
	void SetPlayer(KSF_PLAYER_TYPE player);

protected:
	long GetLongNoteEndTime(int x);
	void ClearLongNote(int x);
	virtual void OnStepChange(int ptn, int line, int arrow, int value) {}

	BYTE KEY[10];
	LONGNOTE_PRESS LONGNOTE[10];
	int m_chkptn_num[10];
	int m_chkline_num[10];
};
