
#pragma once

class CEvent;

class CEvent
{
public:
	virtual bool Initialize(const char* name,...) = 0;
	virtual bool IsOccured() = 0;
	virtual bool IsExpired() = 0;
	virtual void OnDelete() = 0;
	virtual const char* GetName() = 0;
	virtual long GetValue() = 0;
	virtual LRESULT WndProc(HWND, UINT, WPARAM, LPARAM) = 0;
};
