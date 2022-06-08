
class CSttPlay : public CGameState
{
public:
	CPlayer* pPlayer;
	CMusic* pMusic;
	CSprite* pTitle;
	long SongLen;
	DWORD ReadyTime;

	static void* createState()
	{
		return (void*)new CSttPlay();
	}
	long GetTime()
	{
		if (ReadyTime)
		{
			long PlayTime = long(timeGetTime() - ReadyTime) - 3000;
			if (PlayTime>=0)
			{
				ReadyTime = 0;
				pMusic->Play();
				return 0;
			}
			return PlayTime;
		}
		else
			return (long)(pMusic->GetPosition()*1000);
	}
	void OnEnter()
	{
		CKeyEvent* pKeyEvent = new CKeyEvent();
		pKeyEvent->Initialize("KEY",
			'1', "Speed1",
			'2', "Speed2",
			'3', "Speed3",
			'4', "Speed4",
			'5', "Speed5",
			'6', "Speed6",
			'7', "Speed7",
			'8', "Speed8",
			'9', "SpeedDown",
			'0', "SpeedUp",
			VK_ESCAPE, "GiveUp",
			VK_BACK, "Pass",
			0);
		AddEvent(pKeyEvent);

		CFile* pCurFile = dg_fileMngr.GetJukebox(dg_cfg.Jukebox)->GetFolder(dg_cfg.Folder)->GetFile(dg_cfg.File);
		SetCurrentDirectory( pCurFile->GetFolder()->GetJukebox()->GetPath() );
		SetCurrentDirectory( pCurFile->GetFolder()->GetPath() );

		pMusic = new CMusic();
		pMusic->Create();
		pCurFile->GetBackGroundMusic(pMusic);
		SongLen = (long)(pMusic->GetLength()*1000);

		pTitle = new CSprite();
		pTitle->Initialize(1024, 512);
		string TitlePath = pCurFile->GetTitlePath();
		if (TitlePath == "")
		{
		}
		else
		{
			LoadSpriteFromFile(TitlePath.c_str(), pTitle);
		}

		if (dg_cfg.Auto)
			pPlayer = new CAutoPlayer();
		else
			pPlayer = new CSinglePlayer();

		pPlayer->SetPlayer(dg_cfg.Player);
		pPlayer->SetSpeed(CPlayer::SSPD_SET, dg_cfg.Speed);
		pPlayer->Load(pCurFile->GetPath());
		if (dg_cfg.Random)
			pPlayer->MakeRandom();

		SetCurrentDirectory("..\\..");

		pMusic->SetVolume(0);
		pMusic->Play();
		pMusic->Pause();
		pMusic->SetPosition(0);
		pMusic->SetVolume(100);

		ReadyTime = timeGetTime();
	}
	void OnExit()
	{
		delete pPlayer;
		pMusic->Stop();
		pMusic->Release();
		delete pMusic;
		pTitle->Release();
		delete pTitle;
		delete this;
	}
	void OnUpdate()
	{
		pPlayer->UpdateStepData( GetTime() );
	}
	void Render()
	{
		long time = GetTime();
		pTitle->Draw(&IRECT(0, 0, 640, 480), &IRECT(0, 0, 640, 480), -1, BLSTYLE_SRC);
		if (time >= -3000 && time <= -2000)
			return;

		pPlayer->Render(time);
		if (time == SongLen)
		{
			CPlayer::PLAYER_SCORE* pScore = new CPlayer::PLAYER_SCORE;
			pPlayer->GetScore(pScore);
			if (dg_cfg.Auto)
				s_DataStack.push((void*)FALSE); // failed
			else
				s_DataStack.push((void*)TRUE); // cleared
			s_DataStack.push((void*)pScore);
			ChangeGameState("Result");
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
		if (name == "Speed1")
			pPlayer->SetSpeed(CPlayer::SSPD_SET, 1.0f);
		else if (name == "Speed2")
			pPlayer->SetSpeed(CPlayer::SSPD_SET, 2.0f);
		else if (name == "Speed3")
			pPlayer->SetSpeed(CPlayer::SSPD_SET, 3.0f);
		else if (name == "Speed4")
			pPlayer->SetSpeed(CPlayer::SSPD_SET, 4.0f);
		else if (name == "Speed5")
			pPlayer->SetSpeed(CPlayer::SSPD_SET, 5.0f);
		else if (name == "Speed6")
			pPlayer->SetSpeed(CPlayer::SSPD_SET, 6.0f);
		else if (name == "Speed7")
			pPlayer->SetSpeed(CPlayer::SSPD_SET, 7.0f);
		else if (name == "Speed8")
			pPlayer->SetSpeed(CPlayer::SSPD_SET, 8.0f);
		else if (name == "SpeedUp")
			pPlayer->SetSpeed(CPlayer::SSPD_ADD, 1.0f);
		else if (name == "SpeedDown")
			pPlayer->SetSpeed(CPlayer::SSPD_SUB, 1.0f);
		else if (name == "GiveUp")
		{
			CPlayer::PLAYER_SCORE* pScore = new CPlayer::PLAYER_SCORE;
			pPlayer->GetScore(pScore);
			s_DataStack.push((void*)FALSE); // cleared
			s_DataStack.push((void*)pScore);
			ChangeGameState("Result");
		}
		else if (name == "Pass")
		{
			long time = GetTime();
			if (time >= -3000 && time <= -2000)
				return;
			if (time < 0)
				pMusic->SetPosition((double)time/1000 + 10.0);
			else
				pMusic->SetPosition(pMusic->GetPosition() + 10.0);
		}
	}
	LRESULT WndProc(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam)
	{
		switch (msg)
		{
			case WM_STAGEBREAK:
			{
				ChangeGameState("Select");
				return 0;
			}
		}
		return 1;
	}
};
