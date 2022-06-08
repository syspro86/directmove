
class CSttOption : public CGameState
{
public:
	/*
		전체 모드
		게이지 레벨 (게이지 한줄 됐으므로.. 게이지가 차고 주는 정도로 변경)
		스테이지 브레이크
		스킨 선택 (스킨 검색 안하기때문에 없앰)
		박자 구분선 표시 (보기 안좋으므로 삭제)
		메인 메뉴로
	*/
	enum MENU
	{
		MENU_FULL = 0,
		MENU_GAUGE,
		MENU_STAGEBREAK,
		MENU_RETURN,
		MENU_CNT
	};

	int iMenuIndex;

	static void* createState()
	{
		return (void*)new CSttOption();
	}
	void OnEnter()
	{
		CKeyEvent* pKeyEvent = new CKeyEvent();
		pKeyEvent->Initialize("KEY",
			VK_DOWN, "Down",
			VK_UP, "Up",
			VK_NUMPAD2, "Down",
			VK_NUMPAD8, "Up",
			VK_RETURN, "OK",
			0);
		AddEvent(pKeyEvent);

		iMenuIndex = MENU_RETURN;
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
		char* strLevel[3] = {"쉬움", "보통", "어려움"};
		zg_mSpr[""]->Draw(&IRECT(0, 0, 640, 480), NULL, 0xff808080, BLSTYLE_SRC);
		CFont* pFont = zg_mFont["Normal"];
		pFont->DrawString(100, 150, ~0, NULL, "전체 화면 모드");
		pFont->DrawString(400, 150, ~0, NULL, dg_cfg.Fullscreen?"전체화면":"창모드");
		pFont->DrawString(100, 180, ~0, NULL, "게이지 레벨");
		pFont->DrawString(400, 180, ~0, NULL, strLevel[dg_cfg.GaugeLevel]);
		pFont->DrawString(100, 210, ~0, NULL, "스테이지 브레이크");
		pFont->DrawString(400, 210, ~0, NULL, dg_cfg.StageBreak?"활성":"비활성");
		pFont->DrawString(100, 240, ~0, NULL, "메인 메뉴로..");
		pFont->DrawString( 50, 150 + 30 * (int)iMenuIndex, ~0, NULL, "->");
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
				case MENU_FULL:
					dg_cfg.Fullscreen ^= 1;
					break;
				case MENU_GAUGE:
					++dg_cfg.GaugeLevel;
					if (dg_cfg.GaugeLevel == 3)
						dg_cfg.GaugeLevel = 0;
					break;
				case MENU_STAGEBREAK:
					dg_cfg.StageBreak ^= 1;
					break;
				case MENU_RETURN:
					ChangeGameState("Main");
					break;
			}
		}
		else if (name == "Up")
		{
			--iMenuIndex;
			while (iMenuIndex < 0)
				iMenuIndex += MENU_CNT;
			while (iMenuIndex >= MENU_CNT)
				iMenuIndex -= MENU_CNT;
		}
		else if (name == "Down")
		{
			++iMenuIndex;
			while (iMenuIndex < 0)
				iMenuIndex += MENU_CNT;
			while (iMenuIndex >= MENU_CNT)
				iMenuIndex -= MENU_CNT;
		}
	}
	LRESULT WndProc(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam)
	{
		return 1;
	}
};
