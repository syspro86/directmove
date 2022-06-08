
#include "zsoo.h"
#include "gameapp.h"
#include <mmsystem.h>

#pragma comment(lib, "winmm")
#pragma comment(lib, "dxguid")

namespace NS_CGAMEAPP
{
	CGameApp* g_pApp = NULL;
};
using namespace NS_CGAMEAPP;

LRESULT CALLBACK WndProc(HWND, UINT, WPARAM, LPARAM);

ZAPPDATA CGameApp::s_AppData;
CRenderer* CGameApp::s_pRenderer = NULL;
map<string, CSprite*> CGameApp::s_mstSprite;
map<string, CFont*> CGameApp::s_msfFont;

LRESULT CALLBACK WndProc(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
	return g_pApp->WndProc(hWnd, msg, wParam, lParam);
}

CGameApp::CGameApp()
:	m_sttMngr(), m_bUse3D(TRUE), m_iWndWidth(640), m_iWndHeight(480)
{
	ZeroMemory(&s_AppData, sizeof(s_AppData));
	s_AppData.hInst = GetModuleHandle(NULL);
	s_AppData.szClassName = "zsoo";
	g_pApp = this;
}

// 게임을 초기화 함
bool CGameApp::Init()
{
	// 우선 클래스 등록
	if (!RegisterClass())
		return false;

	s_pRenderer = new CRenderer();

	if ( FAILED(s_pRenderer->Initialize(m_iWndWidth, m_iWndHeight)) )
	{
		AddLogString("렌더러를 초기화하는데 실패했습니다.\n");
		return false;
	}
	AddLogString("렌더러를 초기화했습니다. 텍스쳐 포맷은 (ARGB)%d입니다.\n", s_pRenderer->GetTextureQuality());

//	CoInitializeEx(NULL, COINIT_MULTITHREADED);

	return true;
}

// 사용된 모든 리소스를 해제한다.
bool CGameApp::CleanUp()
{
	bool failed = false;

	CoUninitialize();

	while (s_mstSprite.size())
	{
		s_mstSprite.begin()->second->Release();
		delete s_mstSprite.begin()->second;
		s_mstSprite.erase( s_mstSprite.begin() );
	}

	while (s_msfFont.size())
	{
		s_msfFont.begin()->second->Release();
		delete s_msfFont.begin()->second;
		s_msfFont.erase( s_msfFont.begin() );
	}

	// 렌더러 릴리즈
	if (s_pRenderer)
		s_pRenderer->Release();

	// 윈도우 클래스 등록해제 :>
	if (!UnregisterClass(s_AppData.szClassName, s_AppData.hInst))
		failed = true;

	return failed;
}

void CGameApp::UpdateFrame()
{
	m_sttMngr.UpdateFrame();
	s_pRenderer->PreRender();
	m_sttMngr.Render();
	s_pRenderer->PostRender();
}

// 클래스를 등록함
bool CGameApp::RegisterClass()
{
	WNDCLASS wc = {CS_DBLCLKS, ::WndProc, 0, 0, s_AppData.hInst, 
		LoadIcon(s_AppData.hInst, IDI_WINLOGO), LoadCursor(s_AppData.hInst, IDC_ARROW),
		NULL, NULL, s_AppData.szClassName};

	return !!::RegisterClass(&wc);
}

int CGameApp::Run()
{
	static bool bRunning = false;
	if (bRunning) // 단 한번만 호출됨..
		return -1;
	bRunning = true;

	StartLog();
	if (!Init())
	{
		MessageBox(NULL, "초기화에 실패했습니다. log.txt파일을 확인해주세요.", "에러", MB_OK);
		CleanUp();
		return -1;
	}

	DWORD fpstime, incfps=0;
	MSG msg;
	ZeroMemory(&msg, sizeof(msg));
	fpstime = timeGetTime();

	while (msg.message != WM_QUIT)
	{
		if (timeGetTime() - fpstime >= 1000)
		{
			s_AppData.iFPS = incfps;
			fpstime += 1000;
			incfps = 0;
		}
		if (PeekMessage(&msg, NULL, 0U, 0U, PM_REMOVE))
		{
			TranslateMessage(&msg);
			DispatchMessage(&msg);
		}
		else
		{
			++incfps;
			if (!s_AppData.bHasFocus) // 포커스를 잃었을 때 CPU점유율를 줄이기 위해 :)
				Sleep(0);

			UpdateFrame();
		}
	}

	if (!CleanUp())
		return -1;

	EndLog();
	return 0;
}

LRESULT CGameApp::WndProc(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
	switch (msg)
	{
		case WM_DESTROY:
		{
			m_sttMngr.WndProc(hWnd, WM_CHANGESTATE, (WPARAM)"Exit", 0);
			PostQuitMessage(0);
			return 0;
		}

		case WM_SYSCOMMAND:
		{
			switch (wParam)
			{
				case SC_SCREENSAVE:
				case SC_MONITORPOWER:
					return 0;
				case SC_KEYMENU:
					if (lParam == VK_RETURN)
						s_pRenderer->ToggleFullScreen();
					return 0;
			}
			break;
		}

		case WM_COMMAND:
			return 0;

		case WM_SETFOCUS:
			s_AppData.bHasFocus = TRUE;
			return 0;

		case WM_KILLFOCUS:
			s_AppData.bHasFocus = FALSE;
			return 0;
	}

	if (m_sttMngr.WndProc(hWnd, msg, wParam, lParam) == 0)
		return 0;

	return DefWindowProc(hWnd, msg, wParam, lParam);
}
