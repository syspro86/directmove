
#pragma once

#include <windows.h>

// zsoo app data
struct ZAPPDATA
{
	HWND hWnd;
	HINSTANCE hInst;
	LPSTR szClassName;
	BOOL bFullscreen;
	BOOL bHasFocus;
	INT iFPS;
};

typedef void* (*CREATEPROC)();
