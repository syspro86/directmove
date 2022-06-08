/*
#include <zsoo.h>

#ifdef NDEBUG
#pragma comment(lib, "zsoo")
#else
#pragma comment(lib, "zsood")
#endif

// 게임 클래스
class CExample : public CGameApp
{
public:
	CExample();
	LRESULT WndProc(HWND, UINT, WPARAM, LPARAM);

protected:
	bool Init();
	bool CleanUp();
	void UpdateFrame();
};

// 키 이벤트
class CKeyEvent : public CEvent
{
public:
	struct key
	{
		int vk;
		string name;
	};

	bool Initialize(const char* name,...)
	{
		Name = name;
		va_list va;
		va_start(va, name);

		int vk;
		while (vk = va_arg(va, int))
		{
			char* n = va_arg(va, char*);
			key k = {vk, string(n)};
			vKey.push_back(k);
		}
		va_end(va);
		return true;
	}

	bool IsOccured()
	{
		return !vGet.empty();
	}

	bool IsExpired()
	{
		return false;
	}

	void OnDelete()
	{
		vKey.clear();
		vGet.clear();
		delete this;
	}

	const char* GetName()
	{
		return Name.c_str();
	}

	long GetValue()
	{
		if (!vGet.size())
			return 0;

		static char c[1024];
		strcpy(c, vKey[vGet.front()].name.c_str());
		vGet.erase(vGet.begin());
		return (long)c;
	}

	LRESULT WndProc(HWND, UINT msg, WPARAM wParam, LPARAM)
	{
		switch (msg)
		{
			case WM_KEYDOWN:
			{
				for (int i=0; i<(int)vKey.size(); ++i)
				{
					if (vKey[i].vk == wParam)
					{
						vGet.push_back(i);
						return 0;
					}
				}
			}
		}
		return 1;
	}

	string Name;
	vector<key> vKey;
	vector<int> vGet;
};

// 스테이트
class CSttExam : public CGameState
{
public:
	CIme Ime;
	DWORD CaretChangeTime;
	string PressName;

	static void* createState()
	{
		return (void*)new CSttExam();
	}
	void OnEnter()
	{
		CKeyEvent* pKeyEvent = new CKeyEvent();
		pKeyEvent->Initialize("KEY",
			VK_ESCAPE, "Return",
			VK_RETURN, "OK",
			0);
		AddEvent(pKeyEvent);

		CaretChangeTime = timeGetTime();
	}
	void OnExit()
	{
		delete this;
	}
	void OnUpdate()
	{
	}
	void Render()
	{
		zg_mSpr[""]->Draw(&IRECT(0, 0, 640, 480), NULL, 0xff808080, BLSTYLE_SRC);

		static int const CARET_BLINK_TIME = 500;
		static int PrevCaretPos = 0;
		RECT r = { Ime.GetCaretPos(), 0, 0, 0 };
		if (PrevCaretPos != r.left)
		{
			PrevCaretPos = r.left;
			CaretChangeTime = timeGetTime();
		}
		CFont::draw_option dop;
		dop.flag = CFont::DS_GET_CARET_RECT | CFont::DS_SET_GAP;
		dop.params["DS_GET_CARET_RECT"] = (DWORD)&r;
		dop.params["DS_SET_GAP"] = (DWORD)-1;
		zg_mFont[""]->DrawString(0, 0, ~0, &dop, "%s", Ime.GetDisplayString());
		if (((timeGetTime()-CaretChangeTime) % (CARET_BLINK_TIME*2)) <= CARET_BLINK_TIME)
			zg_mSpr[""]->Draw(&r, NULL, 0xff000000, BLSTYLE_SRC);

		zg_mFont[""]->DrawString(0, 20, ~0, &dop, "%s", PressName.c_str());
	}
	void OnEvent(CEvent* pEvent)
	{
		string name = pEvent->GetName();
		if (name == "KEY")
		{
			string key = (const char*)pEvent->GetValue();
			PressName = key;
		}
	}
	LRESULT WndProc(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam)
	{
		if (Ime.WndProc(hWnd, msg, wParam, lParam)==0)
			return 0;

		return 1;
	}
};


INT WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, INT)
{
//	CMusic m;
	CIme ime;
	CInput i;

	if (0) strlen(NULL);
	if (0) sprintf(NULL, NULL);

	CExample game;
	return game.Run();
};

CExample::CExample()
{
	m_bUse3D = FALSE;
}

bool CExample::Init()
{
	if (!CGameApp::Init())
	{
		return false;
	}

	SPRLOCKEDRECT slr;
	zg_mSpr[""] = new CSprite();
	zg_mSpr[""]->Initialize(1, 1);
	zg_mSpr[""]->Lock(&slr);
	FillMemory(slr.pData, slr.Pitch, 0xff);
	zg_mSpr[""]->Unlock();

	zg_mFont[""] = new CFont("돋움체", 12, 128, CFont::FT_OUTLINE);

	AddGameState("Exam", CSttExam::createState);
	ChangeGameState("Exam");

	return true;
}

bool CExample::CleanUp()
{
	return CGameApp::CleanUp();
}

void CExample::UpdateFrame()
{
	zg_pInput->Update();
	m_sttMngr.UpdateFrame();
	zg_pRen->PreRender();
	m_sttMngr.Render();

	CFont::draw_option dop;
	dop.flag = CFont::DS_SET_GAP;
	dop.params["DS_SET_GAP"] = (DWORD)-1;
	zg_mFont[""]->DrawString(540, 460, ~0, &dop, "FPS : %04d", s_AppData.iFPS);

	zg_pRen->PostRender();
}

LRESULT CExample::WndProc(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
	return CGameApp::WndProc(hWnd, msg, wParam, lParam);
}
*/
#pragma comment(linker, "/entry:main")
void main(){}