
// 0~20
// disc		20~220
// folder	220~250
// file		250~280
// p1		280~310
// p2		310~340

class CSttSelect : public CGameState
{
public:
	struct MENU
	{
		RECT rcSel;
	};

	CJukebox* pCurJuke;
	CFolder* pCurFolder;
	CFile* pCurFile;
	int iSelectingJukeNo;
	int iDiscAnimation;
	DWORD dwDiscAniTime;
	CFile::INFORMATION ksfInfo;

	CMusic* pMusic;
	BOOL bPlayIntro;
	BOOL bHasIntro;

	static void* createState()
	{
		return (void*)new CSttSelect();
	}
	void OnEnter()
	{
		CKeyEvent* pKeyEvent = new CKeyEvent();
		pKeyEvent->Initialize("KEY",
			VK_NUMPAD7, "PrevFolder",
			VK_NUMPAD1, "NextFolder",
			VK_NUMPAD9, "PrevFile",
			VK_NUMPAD3, "NextFile",
			'Q', "PrevFolder",
			'Z', "NextFolder",
			'E', "PrevFile",
			'C', "NextFile",
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
			VK_F2, "ModeFade",
			VK_F3, "ModeRush",
			VK_F4, "ModeRandom",
			VK_F5, "ModeUnknown",
			VK_F6, "ModeAuto",
			VK_F7, "PrevJukebox",
			VK_F8, "NextJukebox",
			VK_RETURN, "EnterJukebox",
			'S', "OK",
			VK_NUMPAD5, "OK",
			VK_ESCAPE, "Return",
			VK_TAB, "SwapSide",
			0);
		AddEvent(pKeyEvent);

		pCurJuke = dg_fileMngr.GetJukebox(dg_cfg.Jukebox);
		pCurJuke->Activate();
		pCurFolder = pCurJuke->GetFolder(dg_cfg.Folder);
		pCurFile = pCurFolder->GetFile(dg_cfg.File);
		pCurFile->GetInformation(&ksfInfo);

		if (pCurFile->IsDouble())
			dg_cfg.Player = KSF_DOUBLE;
		else if (dg_cfg.Player == KSF_DOUBLE)
			dg_cfg.Player = KSF_SINGLE1P;

		pMusic = new CMusic;
		pMusic->Create();

		iSelectingJukeNo = dg_cfg.Jukebox;
		iDiscAnimation = 0;
		bPlayIntro = FALSE;
	}
	void OnExit()
	{
		pMusic->Stop();
		pMusic->Release();
		delete pMusic;
		delete this;
	}
	void OnUpdate()
	{
		if (bPlayIntro)
		{
			if (bHasIntro)
			{
				if (pMusic->GetPosition() == pMusic->GetLength())
				{
					pMusic->Stop();
					pMusic->Create();
				}
			}
			else
			{
				double pos = pMusic->GetPosition();
				double fade = pMusic->GetLength() / 2 + 5;
				double end = pMusic->GetLength() / 2 + 10;
				if (pos > end)
				{
					pMusic->Stop();
					pMusic->Create();
				}
				else if (pos > fade)
				{
					pMusic->SetVolume((long)((end - pos) * 20));
				}
			}
		}
	}
	void Render()
	{
		CFont* pFont = NULL;

		zg_mSpr["SelectSingle"]->Draw(&IRECT(0, 0, 640, 480), &IRECT(0, 0, 640, 480), -1, BLSTYLE_SRC);

		// 디스크 출력
		if (iDiscAnimation)
		{
			float frame = (float)(timeGetTime() - dwDiscAniTime) / 500.0f;
			if (frame >= 1.0f)
				frame = 1.0f;

			DWORD color;;
			RECT rect;
			if (iDiscAnimation == -1) // prev folder
			{
				// right top
				color = ((BYTE)(128-128*frame) << 24) | 0x00ffffff;
				pCurJuke->GetFolder(dg_cfg.Folder+2)->GetFile(0)->GetDiscSprite()->Draw(&IRECT(340,  60, 520, 180), &IRECT(0, 0, 300, 200), color);

				// center -> right top
				rect.left = (long)(170 * (1-frame) + 340 * frame);
				rect.top = (long)(110 * (1-frame) + 60 * frame);
				rect.right = (long)(470 * (1-frame) + 520 * frame);
				rect.bottom = (long)(310 * (1-frame) + 180 * frame);
				color = ((BYTE)(255-128*frame) << 24) | 0x00ffffff;
				pCurJuke->GetFolder(dg_cfg.Folder+1)->GetFile(0)->GetDiscSprite()->Draw(&rect, &IRECT(0, 0, 300, 200), color);

				// left bottom -> center
				rect.left = (long)(120 * (1-frame) + 170 * frame);
				rect.top = (long)(240 * (1-frame) + 110 * frame);
				rect.right = (long)(300 * (1-frame) + 470 * frame);
				rect.bottom = (long)(360 * (1-frame) + 310 * frame);
				color = ((BYTE)(127+128*frame) << 24) | 0x00ffffff;
				pCurFile->GetDiscSprite()->Draw(&rect, &IRECT(0, 0, 300, 200), color);

				// left bottom
				color = ((BYTE)(128*frame) << 24) | 0x00ffffff;
				pCurJuke->GetFolder(dg_cfg.Folder-1)->GetFile(0)->GetDiscSprite()->Draw(&IRECT(120, 240, 300, 360), &IRECT(0, 0, 300, 200), color);
			}
			else if (iDiscAnimation == 1) // next folder
			{
				// left bottom
				color = ((BYTE)(128-128*frame) << 24) | 0x00ffffff;
				pCurJuke->GetFolder(dg_cfg.Folder-2)->GetFile(0)->GetDiscSprite()->Draw(&IRECT(120, 240, 300, 360), &IRECT(0, 0, 300, 200), color);

				// center -> left bottom
				rect.left = (long)(170 * (1-frame) + 120 * frame);
				rect.top = (long)(110 * (1-frame) + 240 * frame);
				rect.right = (long)(470 * (1-frame) + 300 * frame);
				rect.bottom = (long)(310 * (1-frame) + 360 * frame);
				color = ((BYTE)(255-128*frame) << 24) | 0x00ffffff;
				pCurJuke->GetFolder(dg_cfg.Folder-1)->GetFile(0)->GetDiscSprite()->Draw(&rect, &IRECT(0, 0, 300, 200), color);

				// right top -> center
				rect.left = (long)(340 * (1-frame) + 170 * frame);
				rect.top = (long)(60 * (1-frame) + 110 * frame);
				rect.right = (long)(520 * (1-frame) + 470 * frame);
				rect.bottom = (long)(180 * (1-frame) + 310 * frame);
				color = ((BYTE)(127+128*frame) << 24) | 0x00ffffff;
				pCurFile->GetDiscSprite()->Draw(&rect, &IRECT(0, 0, 300, 200), color);

				// right top
				color = ((BYTE)(128*frame) << 24) | 0x00ffffff;
				pCurJuke->GetFolder(dg_cfg.Folder+1)->GetFile(0)->GetDiscSprite()->Draw(&IRECT(340,  60, 520, 180), &IRECT(0, 0, 300, 200), color);
			}
			if (frame == 1.0f)
				iDiscAnimation = 0;
		}
		else
		{
			pCurJuke->GetFolder(dg_cfg.Folder-1)->GetFile(0)->GetDiscSprite()->Draw(&IRECT(120, 240, 300, 360), &IRECT(0, 0, 300, 200), 0x80ffffff);
			pCurJuke->GetFolder(dg_cfg.Folder+1)->GetFile(0)->GetDiscSprite()->Draw(&IRECT(340,  60, 520, 180), &IRECT(0, 0, 300, 200), 0x80ffffff);
			pCurFile->GetDiscSprite()->Draw(&IRECT(170, 110, 470, 310), &IRECT(0, 0, 300, 200));
			if (bPlayIntro)
			{
				float frame = (float)(timeGetTime() % 999) / 1000.0f;
				int width = int(frame*36);
				int height = int(frame*24);
				pCurFile->GetDiscSprite()->Draw(&IRECT(170-width, 110-height, 470+width, 310+height), &IRECT(0, 0, 300, 200), ((BYTE)((1-frame)*255)<<24) | 0x00ffffff);
			}
		}

		pFont = zg_mFont["Normal"];

		// 주크박스
		pFont->DrawString(70,  3, ~0, NULL, "%s", pCurJuke->GetPath());
		pFont->DrawString(70, 23, ~0, NULL, "%s", dg_fileMngr.GetJukebox(iSelectingJukeNo)->GetPath());
		if (dg_cfg.Player==KSF_SINGLE1P)
			pFont->DrawString(70, 43, ~0, NULL, "Left");
		else if (dg_cfg.Player==KSF_SINGLE2P)
			pFont->DrawString(70, 43, ~0, NULL, "Right");
		else if (dg_cfg.Player==KSF_DOUBLE)
			pFont->DrawString(70, 43, ~0, NULL, "Double");

		// 폴더 목록
		for (int i=0; i<20; ++i)
		{
			CFont::draw_option dop;
			dop.flag = CFont::DS_LIMIT_WIDTH;
			dop.params["DS_LIMIT_WIDTH"] = 110;
			pFont->DrawString(5, 60 + i*15 + 1, ~0, &dop, "%s", pCurJuke->GetFolder(dg_cfg.Folder-6+i)->GetPath());
		}
		// 파일 목록
		for (int i=0; i<(int)pCurFolder->GetFileCount(); ++i)
		{
			if (i == 4) break;
			CFont::draw_option dop;
			dop.flag = CFont::DS_LIMIT_WIDTH;
			dop.params["DS_LIMIT_WIDTH"] = 110;
			pFont->DrawString(125, 400 + i*20 + 1, ~0, &dop, "%s", pCurFolder->GetFile(dg_cfg.File+i)->GetPath());
		}

		// KSF 정보
		{
			CFile::INFORMATION info;
			pCurFile->GetInformation(&info);

			CFont::draw_option dop;
			dop.flag = CFont::DS_LIMIT_WIDTH;

			dop.params["DS_LIMIT_WIDTH"] = 110;
			pFont->DrawString(170, 370, ~0, &dop, "%s", info.Title);

			dop.params["DS_LIMIT_WIDTH"] = 50;
			pFont->DrawString(330, 370, ~0, &dop, "%3.2f", info.BPM);

			dop.params["DS_LIMIT_WIDTH"] = 70;
			pFont->DrawString(440, 370, ~0, &dop, "%d", info.StepCount);

//			dop.params["DS_LIMIT_WIDTH"] = 70;
//			pFont->DrawString(330, 390, ~0, &dop, "%08x", pCurFile->GetCRC());
		}

		// RANKING
		{
			int display = (timeGetTime() % 8000) / 2000;

			const vector<CFile::RANK>& vRank = *pCurFile->GetRankData();
			for (int i=0; i<(int)vRank.size(); ++i)
			{
				CFile::RANK rank = vRank[i];
				if (display==0)
				{
					char ID[9] = {0};
					CopyMemory(ID, rank.ID, 8);
					pFont->DrawString(550, 100 + i * 20, ~0, NULL, "%s", ID);
				}
				else if (display==1)
				{
					pFont->DrawString(550, 100 + i * 20, ~0, NULL, "%08d", rank.TOTAL);
				}
				else if (display==2)
				{
					float TOTAL = (float)(rank.EXORBITANT+rank.PERFECT+rank.GREAT+rank.GOOD+rank.BAD+rank.MISS);
					float Percentage = 0.0f;
					Percentage += float(rank.EXORBITANT);
					Percentage += float(rank.PERFECT) * 0.9f;
					Percentage += float(rank.GREAT) * 0.8f;
					Percentage += float(rank.GOOD) * 0.6f;
					Percentage += float(rank.BAD) * 0.4f;
					Percentage /= TOTAL;
					pFont->DrawString(550, 100 + i * 20, ~0, NULL, "%.0f", Percentage*100);
				}
				else if (display==3)
				{
					pFont->DrawString(550, 100 + i * 20, ~0, NULL, "%c%c%c%c", rank.Fade?'O':'X', rank.Rush?'O':'X', rank.Random?'O':'X', rank.XXX?'O':'X');
				}
			}
		}

		// 모드 정보
		zg_mSpr["Mode"]->Draw(&IRECT(261, 429, 291, 459), &IRECT((int)(dg_cfg.Speed-1)*30, 0, (int)dg_cfg.Speed*30, 30), ~0, BLSTYLE_SRC);
		zg_mSpr["Mode"]->Draw(&IRECT(301, 429, 331, 459), &IRECT(dg_cfg.Fade*30, 30, 30+dg_cfg.Fade*30, 60), ~0, BLSTYLE_SRC);
		zg_mSpr["Mode"]->Draw(&IRECT(341, 429, 371, 459), &IRECT(60+dg_cfg.Rush*30, 30, 90+dg_cfg.Rush*30, 60), ~0, BLSTYLE_SRC);
		zg_mSpr["Mode"]->Draw(&IRECT(382, 429, 412, 459), &IRECT(120+dg_cfg.Random*30, 30, 150+dg_cfg.Random*30, 60), ~0, BLSTYLE_SRC);
		if (dg_cfg.Unknown)
			zg_mSpr["Mode"]->Draw(&IRECT(423, 429, 453, 459), &IRECT(180, 30, 210, 60));
		if (dg_cfg.Auto)
			zg_mSpr["Mode"]->Draw(&IRECT(464, 429, 494, 459), &IRECT(210, 30, 240, 60));
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
			if (bPlayIntro)
			{
				pMusic->Stop();
				ChangeGameState("Play");
			}
			else
			{
				SetCurrentDirectory(pCurJuke->GetPath());
				SetCurrentDirectory(pCurFolder->GetPath());
				if (pCurFile->GetIntroMusic(pMusic))
				{
					pMusic->Play();
					bHasIntro = TRUE;
				}
				else
				{
					pMusic = pCurFile->GetBackGroundMusic(pMusic);
					pMusic->SetPosition((pMusic->GetLength() / 2) - 10);
					pMusic->Play();
					bHasIntro = FALSE;
				}
				SetCurrentDirectory("..\\..");
				bPlayIntro = TRUE;
			}
		}
		else if (name == "PrevJukebox")
		{
			--iSelectingJukeNo;
			while (iSelectingJukeNo < 0)
				iSelectingJukeNo += dg_fileMngr.GetJukeboxCount();
			while (iSelectingJukeNo >= (int)dg_fileMngr.GetJukeboxCount())
				iSelectingJukeNo -= dg_fileMngr.GetJukeboxCount();
		}
		else if (name == "NextJukebox")
		{
			++iSelectingJukeNo;
			while (iSelectingJukeNo < 0)
				iSelectingJukeNo += dg_fileMngr.GetJukeboxCount();
			while (iSelectingJukeNo >= (int)dg_fileMngr.GetJukeboxCount())
				iSelectingJukeNo -= dg_fileMngr.GetJukeboxCount();
		}
		else if (name == "EnterJukebox")
		{
			if (iSelectingJukeNo==dg_cfg.Jukebox)
				return;
			bPlayIntro = FALSE;
			pMusic->Stop();
			pMusic->Create();
			dg_cfg.Jukebox = iSelectingJukeNo;
			dg_cfg.Folder = 0;
			dg_cfg.File = 0;
			pCurJuke = dg_fileMngr.GetJukebox(dg_cfg.Jukebox);
			pCurJuke->Activate();
			pCurFolder = pCurJuke->GetFolder(0);
			pCurFile = pCurFolder->GetFile(0);
			pCurFile->GetInformation(&ksfInfo);
			if (dg_cfg.Player == KSF_DOUBLE)
				dg_cfg.Player = pCurFile->IsDouble() ? KSF_DOUBLE : KSF_SINGLE1P;
			else
				dg_cfg.Player = pCurFile->IsDouble() ? KSF_DOUBLE : dg_cfg.Player;
			iDiscAnimation = 0;
			dwDiscAniTime = timeGetTime();
		}
		else if (name == "PrevFolder")
		{
			bPlayIntro = FALSE;
			pMusic->Stop();
			pMusic->Create();
			--dg_cfg.Folder;
			while (dg_cfg.Folder < 0)
				dg_cfg.Folder += pCurJuke->GetFolderCount();
			while (dg_cfg.Folder >= (int)pCurJuke->GetFolderCount())
				dg_cfg.Folder -= pCurJuke->GetFolderCount();
			dg_cfg.File = 0;
			pCurFolder = pCurJuke->GetFolder(dg_cfg.Folder);
			pCurFile = pCurFolder->GetFile(dg_cfg.File);
			pCurFile->GetInformation(&ksfInfo);
			if (dg_cfg.Player == KSF_DOUBLE)
				dg_cfg.Player = pCurFile->IsDouble() ? KSF_DOUBLE : KSF_SINGLE1P;
			else
				dg_cfg.Player = pCurFile->IsDouble() ? KSF_DOUBLE : dg_cfg.Player;
			iDiscAnimation = -1;
			dwDiscAniTime = timeGetTime();
		}
		else if (name == "NextFolder")
		{
			bPlayIntro = FALSE;
			pMusic->Stop();
			pMusic->Create();
			++dg_cfg.Folder;
			while (dg_cfg.Folder < 0)
				dg_cfg.Folder += pCurJuke->GetFolderCount();
			while (dg_cfg.Folder >= (int)pCurJuke->GetFolderCount())
				dg_cfg.Folder -= pCurJuke->GetFolderCount();
			dg_cfg.File = 0;
			pCurFolder = pCurJuke->GetFolder(dg_cfg.Folder);
			pCurFile = pCurFolder->GetFile(dg_cfg.File);
			pCurFile->GetInformation(&ksfInfo);
			if (dg_cfg.Player == KSF_DOUBLE)
				dg_cfg.Player = pCurFile->IsDouble() ? KSF_DOUBLE : KSF_SINGLE1P;
			else
				dg_cfg.Player = pCurFile->IsDouble() ? KSF_DOUBLE : dg_cfg.Player;
			iDiscAnimation = 1;
			dwDiscAniTime = timeGetTime();
		}
		else if (name == "PrevFile")
		{
			bPlayIntro = FALSE;
			pMusic->Stop();
			pMusic->Create();
			--dg_cfg.File;
			while (dg_cfg.File < 0)
				dg_cfg.File += pCurFolder->GetFileCount();
			while (dg_cfg.File >= (int)pCurFolder->GetFileCount())
				dg_cfg.File -= pCurFolder->GetFileCount();
			pCurFile = pCurFolder->GetFile(dg_cfg.File);
			pCurFile->GetInformation(&ksfInfo);
			if (dg_cfg.Player == KSF_DOUBLE)
				dg_cfg.Player = pCurFile->IsDouble() ? KSF_DOUBLE : KSF_SINGLE1P;
			else
				dg_cfg.Player = pCurFile->IsDouble() ? KSF_DOUBLE : dg_cfg.Player;
		}
		else if (name == "NextFile")
		{
			bPlayIntro = FALSE;
			pMusic->Stop();
			pMusic->Create();
			++dg_cfg.File;
			while (dg_cfg.File < 0)
				dg_cfg.File += pCurFolder->GetFileCount();
			while (dg_cfg.File >= (int)pCurFolder->GetFileCount())
				dg_cfg.File -= pCurFolder->GetFileCount();
			pCurFile = pCurFolder->GetFile(dg_cfg.File);
			pCurFile->GetInformation(&ksfInfo);
			if (dg_cfg.Player == KSF_DOUBLE)
				dg_cfg.Player = pCurFile->IsDouble() ? KSF_DOUBLE : KSF_SINGLE1P;
			else
				dg_cfg.Player = pCurFile->IsDouble() ? KSF_DOUBLE : dg_cfg.Player;
		}
		else if (name == "Speed1")
			dg_cfg.Speed = 1;
		else if (name == "Speed2")
			dg_cfg.Speed = 2;
		else if (name == "Speed3")
			dg_cfg.Speed = 3;
		else if (name == "Speed4")
			dg_cfg.Speed = 4;
		else if (name == "Speed5")
			dg_cfg.Speed = 5;
		else if (name == "Speed6")
			dg_cfg.Speed = 6;
		else if (name == "Speed7")
			dg_cfg.Speed = 7;
		else if (name == "Speed8")
			dg_cfg.Speed = 8;
		else if (name == "SpeedUp")
		{
			dg_cfg.Speed += 1;
			if (dg_cfg.Speed == 9.0f)
				dg_cfg.Speed = 8.0f;
		}
		else if (name == "SpeedDown")
		{
			dg_cfg.Speed -= 1;
			if (dg_cfg.Speed == 0.0f)
				dg_cfg.Speed = 1.0f;
		}
		else if (name == "ModeFade")
			dg_cfg.Fade ^= 1;
		else if (name == "ModeRush")
			dg_cfg.Rush ^= 1;
		else if (name == "ModeRandom")
			dg_cfg.Random ^= 1;
		else if (name == "ModeUnknown")
//			dg_cfg.Unknown ^= 1;
			dg_cfg.Unknown = 0;
		else if (name == "ModeAuto")
			dg_cfg.Auto ^= 1;
		else if (name == "Return")
		{
			ChangeGameState("Main");
		}
		else if (name == "SwapSide")
		{
			if (dg_cfg.Player == KSF_SINGLE1P)
				dg_cfg.Player = KSF_SINGLE2P;
			else if (dg_cfg.Player == KSF_SINGLE2P)
				dg_cfg.Player = KSF_SINGLE1P;
		}
	}
	LRESULT WndProc(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam)
	{
		return 1;
	}
};
