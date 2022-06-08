
#include "zsoo.h"
#include "stateman.h"

namespace NS_STATEMAN {
	void* postquitmessage()
	{
		PostQuitMessage(0);
		return NULL;
	}
}

CStateManager::CStateManager()
:	m_pCurState()
{
	WndProc(NULL, WM_ADDSTATE, (WPARAM)"Exit", (LPARAM)NS_STATEMAN::postquitmessage);
}

void CStateManager::UpdateFrame()
{
	if (m_pCurState)
	{
		for (int i=0; i<(int)m_pCurState->m_vpEvent.size(); ++i)
		{
			CEvent* pEvent = m_pCurState->m_vpEvent[i];
			while (pEvent->IsOccured())
				m_pCurState->OnEvent(pEvent);

			if (pEvent->IsExpired())
			{
				pEvent->OnDelete();
				m_pCurState->m_vpEvent.erase(m_pCurState->m_vpEvent.begin()+i);
				--i;
			}
		}

		m_pCurState->OnUpdate();
	}
}

void CStateManager::Render()
{
	if (m_pCurState)
		m_pCurState->Render();
}

LRESULT CStateManager::WndProc(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
	switch (msg)
	{
		case WM_ADDSTATE:
		{
			if (wParam == 0 || lParam == 0)
				return 0;

			STATE stt;
			stt.Name = (char*)wParam;
			stt.Func = (CREATEPROC)lParam;
			m_vStates.push_back(stt);
		}
		return 0;

		case WM_CHANGESTATE:
		{
			if (m_pCurState) // 현재 스테이트
			{
				while (m_pCurState->m_vpEvent.size())
				{
					m_pCurState->m_vpEvent.back()->OnDelete();
					m_pCurState->m_vpEvent.pop_back();
				}
				m_pCurState->OnExit(); // 끝냄
			}
			m_pCurState = NULL;

			if (wParam)
			{
				string str( (char*)wParam );
				vector<STATE>::iterator itor;
				for (itor=m_vStates.begin(); itor<m_vStates.end(); ++itor)
				{
					if (str == itor->Name) // 이름이 같으면 찾은거다..
					{
						CGameState* pState = NULL;
						if (pState = (CGameState*)itor->Func()) // 게임스테이트 생성;
						{
							m_pCurState = pState;
						}
						break;
					}
				}
			}

			if (m_pCurState) // 새로운 스테이트
				m_pCurState->OnEnter(); // 시작함.
		}
		return 0;
	}

	if (m_pCurState)
	{
		vector<CEvent*>::iterator cur = m_pCurState->m_vpEvent.begin(),
								 end = m_pCurState->m_vpEvent.end();

		for (; cur != end; ++cur)
		{
			if (!(*cur)->WndProc(hWnd, msg, wParam, lParam))
				return 0;
		}

		if (!m_pCurState->WndProc(hWnd, msg, wParam, lParam)) // 처리된 경우 0
			return 0;
	}

	return 1;
}
