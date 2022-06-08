
#include "zsoo.h"
#include "imeutil.h"

#pragma comment(lib, "imm32")

CIme::CIme()
{
	m_iCaret = 0;
}

void CIme::Clear()
{
	m_strInputBuffer = "";
	m_strCompleteBuffer = "";
	for (int x=0; x<9; ++x)
		m_strCandidateBuffer[x] = "";
	m_iCaret = 0;
}

const char* CIme::GetCompleteString() const
{
	static char buff[256];
	sprintf(buff, "%s", m_strCompleteBuffer.c_str());
	return buff;
}

const char* CIme::GetDisplayString() const
{
	static char buff[512];
	ZeroMemory(buff, 512);
	strncpy(buff, m_strCompleteBuffer.c_str(), m_iCaret);
	strcpy(buff + strlen(buff), m_strInputBuffer.c_str());
	strcpy(buff + strlen(buff), &m_strCompleteBuffer[m_iCaret]);
	return buff;
}

const char* CIme::GetCandidateList(int x) const
{
	static char buff[256];
	sprintf(buff, "%s", m_strCandidateBuffer[x].c_str());
	return buff;
}

int CIme::GetCaretPos()
{
	return m_iCaret;
}

LRESULT CIme::WndProc(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
	switch (msg)
	{
		case WM_IME_COMPOSITION:
		{
			HIMC hIMC = ImmGetContext(zg_App.hWnd);
			if (lParam & GCS_RESULTSTR)
			{
				int len;
				len = ImmGetCompositionString(hIMC, GCS_RESULTSTR, NULL, 0);
				if (len > 0)
				{
					char Buff[256];
					ImmGetCompositionString(hIMC, GCS_RESULTSTR, Buff, len);
					Buff[len] = 0;
					m_strCompleteBuffer.insert(m_iCaret, Buff);
					m_iCaret += len;
					m_strInputBuffer = "";
				}
			}
			else if (lParam & GCS_COMPSTR)
			{
				int len;
				len = ImmGetCompositionString(hIMC, GCS_COMPSTR, NULL, 0);
				if (len > 0)
				{
					char Buff[256];
					ImmGetCompositionString(hIMC, GCS_COMPSTR, Buff, len);
					Buff[len] = 0;
					m_strInputBuffer = Buff;
				}
				else
				{
					m_strInputBuffer = "";
				}
			}
			ImmReleaseContext(zg_App.hWnd, hIMC);
			return 0;
		}

		case WM_CHAR:
		{
			if (wParam == VK_BACK)
			{
				if (m_iCaret > 0)
				{
					if (m_strCompleteBuffer[m_iCaret-1] < 0)
					{
						m_strCompleteBuffer.erase(m_strCompleteBuffer.begin() + m_iCaret-1);
						--m_iCaret;
					}
					m_strCompleteBuffer.erase(m_strCompleteBuffer.begin() + m_iCaret-1);
					--m_iCaret;
					m_strInputBuffer = "";
				}
			}
			else if (wParam == VK_RETURN || wParam == VK_TAB || wParam == VK_ESCAPE)
			{
			}
			else
			{
				m_strCompleteBuffer.insert(m_iCaret, 1, (char)(wParam & 0xff));
				++m_iCaret;
				m_strInputBuffer = "";
			}
			return 0;
		}

		case WM_KEYDOWN:
		{
			if (wParam == VK_DELETE)
			{
				if (m_iCaret < (int)m_strCompleteBuffer.length())
				{
					if (m_strCompleteBuffer[m_iCaret] < 0)
					{
						m_strCompleteBuffer.erase(m_strCompleteBuffer.begin() + m_iCaret);
					}
					m_strCompleteBuffer.erase(m_strCompleteBuffer.begin() + m_iCaret);
					m_strInputBuffer = "";
				}
			}
			else if (wParam == VK_LEFT)
			{
				if (m_iCaret > 0)
				{
					--m_iCaret;
					if (m_strCompleteBuffer[m_iCaret] < 0)
						--m_iCaret;
				}
			}
			else if (wParam == VK_RIGHT)
			{
				if (m_iCaret < (int)m_strCompleteBuffer.length())
				{
					if (m_strCompleteBuffer[m_iCaret] < 0)
						++m_iCaret;
					++m_iCaret;
				}
			}
			else
				break;
			return 0;
		}

		case WM_IME_NOTIFY:
			GetCandidateList(zg_App.hWnd, wParam, lParam);
			return 0;
	}
	return 1;
}

void CIme::GetCandidateList(HWND hWnd, WPARAM wParam, LPARAM lParam)
{
	DWORD dwBufLen;
	LPCANDIDATELIST lpCandList = NULL;

	HIMC hIMC = ImmGetContext(hWnd);

	switch (wParam)
	{
		case IMN_OPENCANDIDATE:
		{
			for (int x=0; x<9; ++x)
				m_strCandidateBuffer[x] = "";

			dwBufLen = ImmGetCandidateList(hIMC, 0, lpCandList, 0);

			if (!dwBufLen)
				break;

			lpCandList = (LPCANDIDATELIST)new char[dwBufLen];

			ImmGetCandidateList(hIMC, 0, lpCandList, dwBufLen);

			int iMaxCandidate = lpCandList->dwCount;

			for(int i=0; i<9; ++i)
			{
				if (i >= iMaxCandidate)
					break;

				LPSTR lpStr = (LPSTR)lpCandList + lpCandList->dwOffset[i];
				m_strCandidateBuffer[i] = lpStr;
			}

			delete lpCandList;
			lpCandList=NULL;
			break;
		}

		case IMN_CHANGECANDIDATE:
		{
			for (int x=0; x<9; ++x)
				m_strCandidateBuffer[x] = "";

			dwBufLen = ImmGetCandidateList(hIMC, 0, lpCandList, 0);

			if (!dwBufLen)
				break;

			lpCandList = (LPCANDIDATELIST)new char[dwBufLen];

			ImmGetCandidateList(hIMC, 0, lpCandList, dwBufLen);

			int iMaxCandidate = lpCandList->dwCount;

			for(int i=lpCandList->dwSelection; i<(int)lpCandList->dwSelection+9; ++i)
			{
				if (i >= iMaxCandidate)
					break;

				LPSTR lpStr = (LPSTR)lpCandList + lpCandList->dwOffset[i];
				m_strCandidateBuffer[i-lpCandList->dwSelection] = lpStr;
			}

			delete lpCandList;
			lpCandList=NULL;
			break;
		}

		case IMN_CLOSECANDIDATE:
		{
			for (int x=0; x<9; ++x)
				m_strCandidateBuffer[x] = "";
			break;
		}
	}
	ImmReleaseContext(hWnd, hIMC);
}
