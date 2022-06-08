
class CSttMain : public CGameState
{
public:
	enum MENU
	{
		MENU_SINGLE = 0,
		MENU_MULTI,
		MENU_OPTION,
		MENU_EXIT,
		MENU_CNT
	};

	int iMenuIndex;
	int iPrevMenuIndex;
	DWORD ChangeTime;

	static void* createState()
	{
		return (void*)new CSttMain();
	}
	void OnEnter()
	{
		CKeyEvent* pKeyEvent = new CKeyEvent();
		pKeyEvent->Initialize("KEY",
			VK_LEFT, "Left",
			VK_NUMPAD4, "Left",
			VK_RIGHT, "Right",
			VK_NUMPAD5, "Right",
			VK_UP, "Up",
			VK_NUMPAD8, "Up",
			VK_DOWN, "Down",
			VK_NUMPAD2, "Down",
			VK_RETURN, "OK",
			VK_ESCAPE, "Exit",
			0);
		AddEvent(pKeyEvent);

		iMenuIndex = 0;
		ChangeTime = 0;
	}
	void OnExit()
	{
		delete this;
	}
	void OnUpdate(){}
	void Render()
	{
		CSprite* pTex;

		pTex = zg_mSpr["Title"];
		pTex->Draw(&IRECT(0, 0, 640, 480), &IRECT(0, 0, 640, 480), -1, BLSTYLE_SRC);

		pTex = zg_mSpr["TitleMenu"];
		for (int i=0; i<4; ++i)
		{
			pTex->Draw(&IRECT(70, 180+i*60, 570, 240+i*60), &IRECT(0, i*60, 500, (1+i)*60));
		}

		float fFrame;
		DWORD color;

		fFrame = (float)(timeGetTime() % 800) / 400.0f;
		if (fFrame <= 1.0f)
			color = ((BYTE)((fFrame*0.6f+0.4f)*255) << 24) | 0x00ffffff;
		else
			color = ((BYTE)((1.6f-fFrame*0.6f)*255) << 24) | 0x00ffffff;

		fFrame = (float)(timeGetTime() - ChangeTime) / 350;

		if (fFrame <= 1)
		{
			fFrame = 1.0f - fFrame;
			fFrame = 1.0f - (fFrame*fFrame);
			int y = 180 + (int)(((float)iMenuIndex*fFrame + (float)iPrevMenuIndex*(1-fFrame))*60.0f);
			pTex->Draw(&IRECT(70, y, 570, y+60), &IRECT(0, 240, 500, 300), color);
		}
		else
		{
			pTex->Draw(&IRECT(70, 180+iMenuIndex*60, 570, 240+iMenuIndex*60), &IRECT(0, 240, 500, 300), color);
		}
	}
	void OnEvent(CEvent* pEvent)
	{
		string name = pEvent->GetName();
		if (name == "KEY")
		{
			string key = (const char*)pEvent->GetValue();
			OnKeyDown(key);
		}
	}
	void OnKeyDown(string name)
	{
		if (name == "OK")
		{
			switch (iMenuIndex)
			{
				case MENU_SINGLE:
					ChangeGameState("Select");
					break;
				case MENU_MULTI:
//					ChangeGameState("MultiLogin");
					break;
				case MENU_OPTION:
					ChangeGameState("Option");
					break;
				case MENU_EXIT:
					ChangeGameState("Exit");
					break;
			}
		}
		else if (name == "Up")
		{
			iPrevMenuIndex = iMenuIndex;
			--iMenuIndex;
			while (iMenuIndex < 0)
				iMenuIndex += MENU_CNT;
			while (iMenuIndex >= MENU_CNT)
				iMenuIndex -= MENU_CNT;
			ChangeTime = timeGetTime();
		}
		else if (name == "Down")
		{
			iPrevMenuIndex = iMenuIndex;
			++iMenuIndex;
			while (iMenuIndex < 0)
				iMenuIndex += MENU_CNT;
			while (iMenuIndex >= MENU_CNT)
				iMenuIndex -= MENU_CNT;
			ChangeTime = timeGetTime();
		}
		else if (name == "Exit")
		{
			if (iMenuIndex == MENU_EXIT)
			{
				ChangeGameState("Exit");
			}
			else
			{
				iPrevMenuIndex = iMenuIndex;
				iMenuIndex = MENU_EXIT;
				ChangeTime = timeGetTime();
			}
		}
	}
	LRESULT WndProc(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam)
	{
		return 1;
	}
};
