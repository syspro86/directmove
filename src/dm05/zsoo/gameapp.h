
#pragma once

class CGameApp;

#include "stateman.h"
#include "sound.h"

class CGameApp
{
public:
	CGameApp();

	virtual int Run();
	virtual LRESULT WndProc(HWND, UINT, WPARAM, LPARAM);

protected:
	virtual bool Init();
	virtual bool CleanUp();
	virtual void UpdateFrame();

private:
	bool RegisterClass();

public:
	static ZAPPDATA s_AppData;
	static CRenderer* s_pRenderer;
	static map<string, CSprite*> s_mstSprite;
	static map<string, CFont*> s_msfFont;
	static map<string, CSound*> s_msfSnd;

protected:
	CStateManager m_sttMngr;
	BOOL m_bUse3D;
	int m_iWndWidth;
	int m_iWndHeight;
};

#define zg_App CGameApp::s_AppData
#define zg_pRen CGameApp::s_pRenderer
#define zg_mSpr CGameApp::s_mstSprite
#define zg_mFont CGameApp::s_msfFont
