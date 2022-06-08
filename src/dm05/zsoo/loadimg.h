
#pragma once

typedef void (*TRANSPIXELPROC)(DWORD*, bool);

HRESULT LoadSpriteFromFile(LPCSTR Filename, CSprite* pSpr, TRANSPIXELPROC Proc=NULL);
HRESULT LoadSpriteDataFromFile(LPCSTR Filename, SPRLOCKEDRECT* pSpr, TRANSPIXELPROC Proc=NULL);
