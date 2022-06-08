
#pragma once

class CIme;

#include <windows.h>

class CIme
{
public:
	CIme();

	void Clear();

	const char* GetCompleteString() const;
	const char* GetDisplayString() const;
	const char* GetCandidateList(int x) const;

	int GetCaretPos();

	LRESULT WndProc(HWND, UINT, WPARAM, LPARAM);

private:
	void GetCandidateList(HWND hWnd, WPARAM wParam, LPARAM lParam);

private:
	string m_strCompleteBuffer;
	string m_strInputBuffer;
	string m_strCandidateBuffer[9];
	int m_iCaret;
};
