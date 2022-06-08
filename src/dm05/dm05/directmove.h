
#pragma once

class CDirectMove;

#include <stateman.h>
#include "files.h"
#include "fileman.h"
#include <input.h>
#include "ksf.h"

class CDirectMove : public CGameApp
{
public:
	CDirectMove();

	virtual LRESULT WndProc(HWND, UINT, WPARAM, LPARAM);
	static INT_PTR CALLBACK DlgProc(HWND, UINT, WPARAM, LPARAM);

protected:
	virtual bool Init();
	virtual bool CleanUp();
	virtual void UpdateFrame();

public:
	static CFileManager s_fileMngr;
};

#define dg_fileMngr CDirectMove::s_fileMngr

struct DIRECT_MOVE_CONFIG
{
	DIRECT_MOVE_CONFIG()
	{
		Speed = 1.0f;
		Fade = FALSE;
		Rush = FALSE;
		Random = FALSE;
		Unknown = FALSE;
		Auto = FALSE;
		Player = KSF_SINGLE1P;
		Jukebox = Folder = File = 0;
		Fullscreen = FALSE;
		GaugeLevel = 1;
		StageBreak = FALSE;
		RankID = "";
		LoginID = "";
		Server = "";
	}
	float Speed;
	BOOL Fade;
	BOOL Rush;
	BOOL Random;
	BOOL Unknown;
	BOOL Auto;
	KSF_PLAYER_TYPE Player;
	int Jukebox;
	int Folder;
	int File;
	BOOL Fullscreen;
	int GaugeLevel;
	BOOL StageBreak;
	string RankID;
	string LoginID;
	string Server;
};

namespace NS_DIRECTMOVE
{
	extern DIRECT_MOVE_CONFIG dg_cfg;
}
using namespace NS_DIRECTMOVE;

#define WM_STAGEBREAK		(WM_ZSOO_USER+100) /*
	폭사함..
	전송타입 : PostMessage
	wParam :
	lParam :
*/
