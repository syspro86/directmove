
#pragma once

class CGameState;

class CGameState
{
public:
	friend class CStateManager;

	virtual void OnEnter() = 0;
	virtual void OnExit() = 0;
	virtual void OnUpdate() = 0;
	virtual void Render() = 0;
	void AddEvent(CEvent*);
	virtual void OnEvent(CEvent*) = 0;
	virtual LRESULT WndProc(HWND, UINT, WPARAM, LPARAM) = 0;

private:
	vector<CEvent*> m_vpEvent;
};
