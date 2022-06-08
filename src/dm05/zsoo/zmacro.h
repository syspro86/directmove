
#pragma once

#define AddGameState(p, func) SendMessage(zg_App.hWnd, WM_ADDSTATE, (WPARAM)p, (LPARAM)func);
#define ChangeGameState(p) PostMessage(zg_App.hWnd, WM_CHANGESTATE, (WPARAM)p, 0);

#define AddSprite(name, file)	zg_mSpr[name] = new CSprite();\
								LoadSpriteFromFile(file, zg_mSpr[name]);

#define AddFont(name, font, size, tex, flag)	zg_mFont[name] = new CFont(font, size, tex, flag);

#define AddSound(name, file, flag, cnt, stream)	zg_mSnd[name] = new CSound();\
										zg_mSnd[name]->CreateFromFile(file, flag, cnt, stream);
