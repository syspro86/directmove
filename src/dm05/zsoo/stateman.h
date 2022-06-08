
#pragma once

class CStateManager
{
public:
	struct STATE
	{
		string Name;
		CREATEPROC Func;
	};

	CStateManager();

	void UpdateFrame();
	void Render();
	LRESULT WndProc(HWND, UINT, WPARAM, LPARAM);

private:
	vector<STATE> m_vStates;
	CGameState* m_pCurState;
};
