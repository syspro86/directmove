
#include <zsoo.h>
#include "directmove.h"
#include "resource.h"
#include "player.h"
#include "player_single.h"
#include "player_auto.h"
#include <internet.h>
#include <stack>
#include <zlib.h>

#ifdef NDEBUG
#pragma comment(lib, "zsoo")
#else
#pragma comment(lib, "zsood")
#endif

namespace NS_DIRECTMOVE
{
	DIRECT_MOVE_CONFIG dg_cfg;
	CInternet dg_Internet;
}
using namespace NS_DIRECTMOVE;

stack<void*> s_DataStack;
#include "events.h"
#include "stt_main.h"
#include "stt_select.h"
#include "stt_play.h"
#include "stt_result.h"
#include "stt_option.h"

CFileManager CDirectMove::s_fileMngr;

INT WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, INT)
{
	CDirectMove game;
	if (DialogBox(zg_App.hInst, MAKEINTRESOURCE(IDD_START), NULL, CDirectMove::DlgProc) == IDOK)
		return game.Run();
	else
		return 0;
};

CDirectMove::CDirectMove()
{
	m_bUse3D = FALSE;
	FILE* pf = fopen("dm.cfg", "rb");
	if (pf)
	{
		fread(&dg_cfg, sizeof(dg_cfg) - sizeof(string)*3, 1, pf);
		fclose(pf);
	}
	zg_App.bFullscreen = dg_cfg.Fullscreen;
}

bool CDirectMove::Init()
{
	if (!CGameApp::Init())
	{
		return false;
	}

	SetWindowText(zg_App.hWnd, "Direct Move 0.5");
	HICON hIcon = LoadIcon(zg_App.hInst, MAKEINTRESOURCE(IDI_DM));
	SendMessage(zg_App.hWnd, WM_SETICON, (WPARAM)ICON_BIG, (LPARAM)hIcon);
	SendMessage(zg_App.hWnd, WM_SETICON, (WPARAM)ICON_SMALL, (LPARAM)hIcon);

	s_msfFont["Normal"] = new CFont("돋움", 10, 256, CFont::FT_OUTLINE);

	SPRLOCKEDRECT slr;
	zg_mSpr[""] = new CSprite();
	zg_mSpr[""]->Initialize(1, 1);
	zg_mSpr[""]->Lock(&slr);
	FillMemory(slr.pData, slr.Pitch, 0xff);
	zg_mSpr[""]->Unlock();

	if (s_fileMngr.ListEveryJukebox() == false)
	{
		AddLogString("쥬크박스를 찾을 수 없습니다..\n");
		return false;
	}

	AddSprite("Title", "title.png");
	AddSprite("TitleMenu", "titlemenu.png");
	AddSprite("Arrow", "arrow.png");
	AddSprite("Flare", "flare.png");
	AddSprite("Judge", "judge.png");
	AddSprite("JudgeExor", "judgeexor.png");
	AddSprite("Gauge", "gauge.png");
	AddSprite("Score", "score.png");
	AddSprite("SelectSingle", "selectsingle.png");
	AddSprite("Result", "result.png");
	AddSprite("Mode", "mode.png");
	AddSprite("Nodisc", "nodisc.png");
	AddSprite("Bonus", "bonus.png");

	CPlayer::InitCommonInfo();

	AddGameState("Main", CSttMain::createState);
	AddGameState("Select", CSttSelect::createState);
	AddGameState("Play", CSttPlay::createState);
	AddGameState("Result", CSttResult::createState);
	AddGameState("Option", CSttOption::createState);

	ChangeGameState("Main");
	dg_Internet.Connect();

	return true;
}

bool CDirectMove::CleanUp()
{
	dg_Internet.Disconnect();

	s_fileMngr.UnloadAllJukebox();

	FILE* pf = fopen("dm.cfg", "wb");
	fwrite(&dg_cfg, sizeof(dg_cfg) - sizeof(string)*3, 1, pf);
	fclose(pf);
	int i = fcloseall();

	return CGameApp::CleanUp();
}

void CDirectMove::UpdateFrame()
{
	zg_pInput->Update();
	m_sttMngr.UpdateFrame();
	zg_pRen->PreRender();
	m_sttMngr.Render();

	zg_mFont["Normal"]->DrawString(540, 460, ~0, NULL, "FPS : %04d", s_AppData.iFPS);

	zg_pRen->PostRender();
}

LRESULT CDirectMove::WndProc(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
/*	switch (msg)
	{
		case WM_NULL:
			return 0;
	} // 의미없는 코드..
*/
	return CGameApp::WndProc(hWnd, msg, wParam, lParam);
}

INT_PTR CALLBACK CDirectMove::DlgProc(HWND hDlg, UINT msg, WPARAM wParam, LPARAM lParam)
{
	switch (msg)
	{
		case WM_INITDIALOG:
			if (SUCCEEDED(dg_Internet.Connect()))
			{
				char buff[1024];
				char* p;
				DWORD len;

				len = 1024;
				dg_Internet.Query("http://zsoo.net/dm/notice", buff, &len);
				SetWindowText(GetDlgItem(hDlg, IDC_NOTICE), buff);

				len = 1024;
				dg_Internet.Query("http://zsoo.net/dm/servers", buff, &len);
				p = strtok(buff, "\n");
				while (p)
				{
					SendMessage(GetDlgItem(hDlg, IDC_SERVER), CB_ADDSTRING, 0, (LPARAM)p);
					p = strtok(NULL, "\n");
				}
				SendMessage(GetDlgItem(hDlg, IDC_SERVER), CB_SETCURSEL, 0, 0);
				dg_Internet.Disconnect();
			}
			return TRUE;
			break;

		case WM_COMMAND:
			if (wParam == IDOK)
			{
				char id[1024];
				SendMessage(GetDlgItem(hDlg, IDC_NICK), WM_GETTEXT, 1024, (WPARAM)id);
				if (id[0] == '\0' && MessageBox(NULL, "닉네임이 없으면 점수를 저장하거나 랭킹등록할수 없습니다. 비워두시겠습니까?", NULL, MB_YESNO) == IDNO)
				{
					return TRUE;
				}
				if (strlen(id) > 8)
				{
					MessageBox(NULL, "닉네임이 너무 깁니다.", NULL, MB_OK);
					return TRUE;
				}
				dg_cfg.RankID = id;
				EndDialog(hDlg, IDOK);
				return TRUE;
			}
			else if (wParam == IDCANCEL)
			{
				EndDialog(hDlg, IDCANCEL);
				return TRUE;
			}
			else if (wParam == IDC_LOGIN)
			{
				if (dg_cfg.LoginID == "")
				{
					char id[1024], pw[1024], server[1024];
					int sel = SendMessage(GetDlgItem(hDlg, IDC_SERVER), CB_GETCURSEL, 0, 0);
					SendMessage(GetDlgItem(hDlg, IDC_SERVER), CB_GETLBTEXT, sel, (WPARAM)server);
					SendMessage(GetDlgItem(hDlg, IDC_ID), WM_GETTEXT, 1024, (WPARAM)id);
					SendMessage(GetDlgItem(hDlg, IDC_PW), WM_GETTEXT, 1024, (WPARAM)pw);

					if (server[0] == '\0') // strlen(server) == 0
					{
						MessageBox(NULL, "서버를 선택해주세요", NULL, MB_OK);
						return TRUE;
					}
					if (id[0] == '\0')
					{
						MessageBox(NULL, "아이디를 적어주세요", NULL, MB_OK);
						return TRUE;
					}
					if (pw[0] == '\0')
					{
						MessageBox(NULL, "비밀번호를 적어주세요", NULL, MB_OK);
						return TRUE;
					}

					if (SUCCEEDED(dg_Internet.Connect()))
					{
						char msg[1024];
						DWORD len = 1024;
						sprintf(msg, "%s/dm/login.php?user_id=%s&password=%s", server, id, pw);
						dg_Internet.Query(msg, msg, &len);
						if (strcmp(msg, "success") == 0)
						{
							SetWindowText(GetDlgItem(hDlg, IDC_LOGIN), "로그아웃");
							EnableWindow(GetDlgItem(hDlg, IDC_ID), FALSE);
							EnableWindow(GetDlgItem(hDlg, IDC_PW), FALSE);
							EnableWindow(GetDlgItem(hDlg, IDC_SERVER), FALSE);
							dg_cfg.Server = server;
							dg_cfg.LoginID = id;
						}
						dg_Internet.Disconnect();
					}
				}
				else
				{
					SetWindowText(GetDlgItem(hDlg, IDC_LOGIN), "로그인");
					EnableWindow(GetDlgItem(hDlg, IDC_ID), TRUE);
					EnableWindow(GetDlgItem(hDlg, IDC_PW), TRUE);
					EnableWindow(GetDlgItem(hDlg, IDC_SERVER), TRUE);
					dg_cfg.Server = "";
					dg_cfg.LoginID = "";
				}
			}
			break;
	}
	return FALSE;
}
