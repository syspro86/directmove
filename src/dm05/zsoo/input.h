
#pragma once

class CInput;

#define DIRECTINPUT_VERSION 0x0800
#include <dinput.h>

#define INPUT_INIT_KEYBOARD	0x00000001
#define INPUT_INIT_MOUSE	0x00000002
#define INPUT_INIT_BOTH		0x00000003

class CInput
{
public:
	CInput();
	~CInput();
	HRESULT Initialize(HWND hWnd, DWORD flags);
	HRESULT Release();
	void Update();

	const KEYBOARD_BUFFER& GetKeyboardBuffer() const;
	const MOUSE_BUFFER& GetMouseBuffer() const;

private:
	LPDIRECTINPUT8			m_pDI;
	LPDIRECTINPUTDEVICE8	m_pKeyboard;
	LPDIRECTINPUTDEVICE8	m_pMouse;
	KEYBOARD_BUFFER			m_Keyboard;
	MOUSE_BUFFER			m_Mouse;
};
