
class CSttResult : public CGameState
{
public:
	enum BONUS
	{
		BONUS_NO = 0,
		BONUS_ALLCOMBO,
		BONUS_ALLPERFECT,
		BONUS_ALLGREAT,
		BONUS_ALLGOOD,
		BONUS_FORCE_DWORD = 0x7fffffff
	};

	CIme Ime;
	CPlayer::PLAYER_SCORE* pScore;
	BOOL Cleared;
	DWORD StartTime;
	DWORD Interval;
	BONUS Bonus;
	float Percentage;
	vector<BONUS> Bonuses;

	int LastWavPlay;

	static void* createState()
	{
		return (void*)new CSttResult();
	}
	void OnEnter()
	{
		CKeyEvent* pKeyEvent = new CKeyEvent();
		pKeyEvent->Initialize("KEY",
			VK_ESCAPE, "Return",
			VK_RETURN, "Save",
			0);
		AddEvent(pKeyEvent);

		pScore = (CPlayer::PLAYER_SCORE*)s_DataStack.top();
		s_DataStack.pop();
		Cleared = (BOOL)s_DataStack.top();
		s_DataStack.pop();
		Ime.Clear();

		LastWavPlay = -1;
		BonusCheck();
		ComputePercentage();

		StartTime = timeGetTime();
		Interval = 100;
	}
	void OnExit()
	{
		delete pScore;
		delete this;
	}
	void OnUpdate()
	{
	}
	void Render()
	{
		zg_mSpr["Result"]->Draw(&IRECT(0, 0, 640, 480), &IRECT(0, 0, 640, 480), -1, BLSTYLE_SRC);

		CSprite *pTex;
		pTex = zg_mSpr["Score"];

		DWORD Time = timeGetTime() - StartTime, Now, No = -1;
		Now = Time / Interval;
		Time -= Interval * Now;
		float Ani = 1.0f - ((float)Time / (float)Interval);

		for (int i=0; i<8; ++i)
		{
			char count[16] = {0};
			sprintf(count, "%d", ((LONG*)pScore)[i]);
			for (int x=0; x<16; ++x)
			{
				if (!count[x])
					break;
				count[x] -= '0';
				if (count[x] == 0)
					count[x] = 9;
				else
					count[x] -= 1;

				RECT rect, rect2;
				rect2.left = (count[x] % 3) * 40;
				rect2.top = (count[x] / 3) * 30;
				rect2.right = rect2.left + 40;
				rect2.bottom = rect2.top + 30;

				if (i==7 || (i!=7 && x==0))
					++No;

				if (Now > No)
				{
					rect.left = 300 + x*40;
					rect.right = rect.left + 40;
					rect.top = 100 + i * 40;
					rect.bottom = rect.top + 30;
					pTex->Draw(&rect, &rect2);
				}
				else if (Now == No)
				{
					if (LastWavPlay < (int)Now)
					{
						LastWavPlay = Now;
//						dg_muzResultScore->Stop();
//						dg_muzResultScore->Play();
					}
					rect.left = 300 + x*40 - (long)(20*Ani);
					rect.right = 300 + x*40 + 40 + (long)(20*Ani);
					rect.top = 100 + i * 40 - (long)(15*Ani);
					rect.bottom = 100 + i * 40 + 30 - (long)(15*Ani);
					pTex->Draw(&rect, &rect2, ((BYTE)((1.0f - Ani*2.0f)*255.0f) << 24) | 0x00ffffff);
				}
			}
		}
		if (LastWavPlay < (int)Now)
		{
			LastWavPlay = Now;
//			dg_muzResultFinish->Stop();
//			dg_muzResultFinish->Play();
		}
		if (Now > No)
		{ // 보너스 출력
			pTex = zg_mSpr["Bonus"];
			RECT rect, rect2;
			DWORD color = 0xffffffff;
			Time += (Now-No)*Interval;
			for (int i=0; i<(int)Bonuses.size(); ++i)
			{
				int b = (int)Bonuses[i] - 1;
				BYTE& a = *((BYTE*)&color + 3);
				rect2.left = (b%2) * 128;
				rect2.right = rect2.left + 128;
				rect2.top = (b/2) * 128;
				rect2.bottom = rect2.top + 128;
				if (Time < 500)
				{
					a = (BYTE)(float(Time)/500.0f * 255.0f);
					rect.left = 430 - (long)(float(500-Time)/500.0f * 64.0f);
					rect.right = 430 + 128 + (long)(float(500-Time)/500.0f * 64.0f);
					rect.top = 176 - (long)(float(500-Time)/500.0f * 64.0f);
					rect.bottom = 176 + 128 + (long)(float(500-Time)/500.0f * 64.0f);
				}
				else
				{
					a = 255;
					rect.left = 430;
					rect.right = rect.left + 128;
					rect.top = 176;
					rect.bottom = rect.top + 128;
				}
				rect.left += i * 32;
				rect.right += i * 32;
				rect.top += i * 32;
				rect.bottom += i * 32;
				pTex->Draw(&rect, &rect2, color);
			}
		}
		char Percent[16];
		sprintf(Percent, "%02d", (int)(Percentage*100));
		for (int i=0; i<16; ++i)
		{
			if (Percent[i] == '\0')
				break;
			else
				Percent[i] -= '0';

			RECT rect, rect2;
			rect.left = 10 + 50 * i;
			rect.right = 60 + 50 * i;
			rect.top = 400;
			rect.bottom = 464;

			rect2.left = (Percent[i] % 2) * 50 + 256;
			rect2.top = (Percent[i] / 2) * 64;
			rect2.right = rect2.left + 50;
			rect2.bottom = rect2.top + 64;

			zg_mSpr["Judge"]->Draw( &rect, &rect2 );
		}
		if (i==i) // 그냥..
		{
			RECT rect, rect2;
			rect.left = 10 + 50 * i;
			rect.right = 50 + 50 * i;
			rect.top = 424;
			rect.bottom = 454;

			rect2.left = 40;
			rect2.top = 90;
			rect2.right = 80;
			rect2.bottom = 120;

			zg_mSpr["Score"]->Draw( &rect, &rect2 );
		}
		CFont::draw_option dop;
		dop.flag = CFont::DS_LIMIT_WIDTH;
		dop.params["DS_LIMIT_WIDTH"] = 360;
		zg_mFont["Normal"]->DrawString(220, 440, -1, &dop, "%s", Ime.GetDisplayString());
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
		if (name == "Save")
		{
			if (dg_cfg.RankID.length() && Cleared)
			{
				CFile* pFile = dg_fileMngr.GetJukebox(dg_cfg.Jukebox)->GetFolder(dg_cfg.Folder)->GetFile(dg_cfg.File);
				CFile::RANK r;
				CopyMemory(r.ID, dg_cfg.RankID.c_str(), 8);
				r.EXORBITANT = pScore->EXORBITANT;
				r.PERFECT = pScore->PERFECT;
				r.GREAT = pScore->GREAT;
				r.GOOD = pScore->GOOD;
				r.BAD = pScore->BAD;
				r.MISS = pScore->MISS;
				r.MAXCOMBO = pScore->MAXCOMBO;
				r.TOTAL = pScore->TOTAL;
				r.Fade = dg_cfg.Fade;
				r.Rush = dg_cfg.Rush;
				r.Random = dg_cfg.Random;
				r.XXX = dg_cfg.Unknown;
				pFile->AddRank(&r);
				if (dg_cfg.LoginID.length())
				{
					char comment[32];
					char rankbuff[1024];
					BYTE compbuff[1024];
					DWORD len = 1024;
					DWORD crc = pFile->GetCRC();

					sprintf(rankbuff, "%s/dm/searchksf.php?crc=%u", dg_cfg.Server.c_str(), crc);
					dg_Internet.Query(rankbuff, rankbuff, &len);
					if (atoi(rankbuff) == -1)
					{
						char ksfbuff[1024];
						CFile::INFORMATION info;
						pFile->GetInformation(&info);

						sprintf(rankbuff, "%s\n%s\n%u\n%d", strlen(info.Title) ? info.Title : "blank", pFile->GetPath(), crc, info.StepCount);
						len = 1024;
						compress(compbuff, &len, (BYTE*)rankbuff, strlen(rankbuff));
						HexString(ksfbuff, compbuff, len);
						sprintf(rankbuff, "%s/dm/registerksf.php?code=%s", dg_cfg.Server.c_str(), ksfbuff);
						len = 1024;
						dg_Internet.Query(rankbuff, rankbuff, &len);
					}

					strcpy(comment, Ime.GetDisplayString());
					sprintf(rankbuff, "%u\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%s\n%s\n%s", crc, r.TOTAL,
						r.EXORBITANT, r.PERFECT, r.GREAT, r.GOOD, r.BAD, r.MISS,
						r.MAXCOMBO, (int)(Percentage*100), r.Fade, r.Rush, r.Random, r.XXX, dg_cfg.LoginID.c_str(), dg_cfg.RankID.c_str(), comment);

					len = 1024;
					compress(compbuff, &len, (BYTE*)rankbuff, strlen(rankbuff));
					HexString(rankbuff, compbuff, len);
					sprintf((char*)compbuff, "%s/dm/register.php?code=%s", dg_cfg.Server.c_str(), rankbuff);
					len = 1024;
					dg_Internet.Query((char*)compbuff, rankbuff, &len);
				}
				ChangeGameState("Select");
			}
		}
		else if (name == "Return")
		{
			ChangeGameState("Select");
		}
	}
	LRESULT WndProc(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam)
	{
		if (dg_cfg.LoginID != "" && Cleared && Ime.WndProc(hWnd, msg, wParam, lParam)==0)
		{
			if (strlen(Ime.GetDisplayString()) > 30)
				Ime.WndProc(hWnd, WM_CHAR, VK_BACK, 0);
			return 0;
		}

		return 1;
	}
	void BonusCheck()
	{
		Bonus = BONUS_NO;
		if (!Cleared)
			return;
		long TOTAL = pScore->EXORBITANT + pScore->PERFECT + pScore->GREAT + pScore->GOOD + pScore->BAD + pScore->MISS;

		if (TOTAL==0)
			return;
		if (pScore->EXORBITANT + pScore->PERFECT + pScore->GREAT + pScore->GOOD == TOTAL)
			Bonuses.push_back(BONUS_ALLCOMBO);
		if (pScore->EXORBITANT + pScore->PERFECT == TOTAL)
			Bonuses.push_back(BONUS_ALLPERFECT);
		if (pScore->GREAT == TOTAL)
			Bonuses.push_back(BONUS_ALLGREAT);
		if (pScore->GOOD == TOTAL)
			Bonuses.push_back(BONUS_ALLGOOD);

		for (int i=0; i<(int)Bonuses.size(); ++i)
		{
			switch (Bonuses[i])
			{
				case BONUS_ALLCOMBO:
					pScore->TOTAL += 15000;
					break;
				case BONUS_ALLPERFECT:
					pScore->TOTAL += 30000;
					break;
				case BONUS_ALLGREAT:
					pScore->TOTAL += 500000;
					break;
				case BONUS_ALLGOOD:
					pScore->TOTAL += 1500000;
					break;
			}
		}
	}
	void ComputePercentage()
	{
		float TOTAL = float(pScore->EXORBITANT + pScore->PERFECT + pScore->GREAT + pScore->GOOD + pScore->BAD + pScore->MISS);
		Percentage = 0.0f;
		if (TOTAL==0.0f)
			return;
		Percentage += float(pScore->EXORBITANT);
		Percentage += float(pScore->PERFECT) * 0.9f;
		Percentage += float(pScore->GREAT) * 0.8f;
		Percentage += float(pScore->GOOD) * 0.6f;
		Percentage += float(pScore->BAD) * 0.4f;
		Percentage /= TOTAL;
	}
	void HexString(char* dest, const BYTE* src, DWORD len)
	{
		for (DWORD i=0; i<len; ++i)
		{
			char a[3];
			sprintf(a, "%02x", src[i]);
			memcpy(&dest[i*2], a, 2);
		}
		dest[len*2] = 0;
	}
};
