
#include "zsoo.h"
#include "input.h"

#pragma comment(lib, "dinput8")

CInput::CInput()
{
	ZeroMemory(&m_Keyboard, sizeof(m_Keyboard));
	ZeroMemory(&m_Mouse, sizeof(m_Mouse));
	m_pDI = NULL;
	m_pKeyboard = NULL;
	m_pMouse = NULL;
}

CInput::~CInput()
{

}

HRESULT CInput::Initialize(HWND hWnd, DWORD flags)
{
	HRESULT hr;

	if( FAILED(hr = DirectInput8Create(GetModuleHandle(NULL), DIRECTINPUT_VERSION, IID_IDirectInput8, (void**)&m_pDI, NULL)) )
		return hr;

	if (flags & INPUT_INIT_KEYBOARD)
	{
		if ( SUCCEEDED(hr = m_pDI->CreateDevice(GUID_SysKeyboard, &m_pKeyboard, NULL)) )
		{
			m_pKeyboard->SetDataFormat(&c_dfDIKeyboard);
			m_pKeyboard->SetCooperativeLevel(hWnd, DISCL_NONEXCLUSIVE | DISCL_FOREGROUND /*| DISCL_NOWINKEY*/);

			if ( FAILED(hr = m_pKeyboard->Acquire()) )
			{
				for (int i=0;i<50;i++)
				{
					if ( SUCCEEDED(hr = m_pKeyboard->Acquire()) )
						break;
				}
			}
			if( FAILED(hr) && hr != DIERR_OTHERAPPHASPRIO ) 
				return hr;
		}
		ZeroMemory(&m_Keyboard, sizeof(m_Keyboard));
	}

	if (flags & INPUT_INIT_MOUSE)
	{
		if ( FAILED(hr = m_pDI->CreateDevice(GUID_SysMouse, &m_pMouse, NULL)) )
			return hr;

		if ( FAILED(hr = m_pMouse->SetDataFormat(&c_dfDIMouse)) )
			return hr;

		if ( FAILED(hr = m_pMouse->SetCooperativeLevel(hWnd, DISCL_EXCLUSIVE|DISCL_FOREGROUND)) )
			return hr;

		if ( FAILED(hr = m_pMouse->Acquire()) )
		{
			if (hr != DIERR_OTHERAPPHASPRIO)
				return hr;
		}
		ZeroMemory(&m_Mouse, sizeof(m_Mouse));
	}
	return S_OK;
}

HRESULT CInput::Release()
{
	if (!m_pDI)
		return E_FAIL;

	if (m_pKeyboard)
	{
		m_pKeyboard->Unacquire();
		m_pKeyboard->Release();
		m_pKeyboard = NULL;
	}
	if (m_pMouse)
	{
		m_pMouse->Unacquire();
		m_pMouse->Release();
		m_pMouse = NULL;
	}
	m_pDI->Release();
	m_pDI = NULL;
	return S_OK;
}

void CInput::Update()
{
	HRESULT hr;
	int i;
	if (m_pKeyboard)
	{
		hr = m_pKeyboard->Acquire();
		while(hr == DIERR_INPUTLOST)
			hr = m_pKeyboard->Acquire();

		if (SUCCEEDED(hr))
			hr = m_pKeyboard->GetDeviceState(256, &m_Keyboard.keyRaw);
		else
			ZeroMemory(&m_Keyboard.keyRaw, 256);
		for(i=0; i<256; ++i)
		{
			if (m_Keyboard.keyRaw[i] & 0x80)
			{
				if (m_Keyboard.keyStates[i] & KEY_PRESS)
					m_Keyboard.keyStates[i] = KEY_PRESS;
				else
					m_Keyboard.keyStates[i] = KEY_DOWN;
			}
			else
			{
				if (m_Keyboard.keyStates[i] & KEY_PRESS)
					m_Keyboard.keyStates[i] = KEY_UP;
				else
					m_Keyboard.keyStates[i] = KEY_NONE;
			}
		}
	}

	if (m_pMouse)
	{
		DIMOUSESTATE dims;
		hr = m_pMouse->Acquire();
		while(hr == DIERR_INPUTLOST)
			hr = m_pMouse->Acquire();

		ZeroMemory(&dims, sizeof(DIMOUSESTATE));
		if (SUCCEEDED(hr))
			hr = m_pMouse->GetDeviceState(sizeof(DIMOUSESTATE), (void*)&dims);
		m_Mouse.pos.x = dims.lX;
		m_Mouse.pos.y = dims.lY;
		memcpy(m_Mouse.btnRaw, dims.rgbButtons, sizeof(dims.rgbButtons));
		for(int i=0; i<4; ++i)
		{
			if (m_Mouse.btnRaw[i] & 0x80)
			{
				if (m_Mouse.btnStates[i] & KEY_PRESS)
					m_Mouse.btnStates[i] = KEY_PRESS;
				else
					m_Mouse.btnStates[i] = KEY_DOWN;
			}
			else
			{
				if (m_Mouse.btnStates[i] & KEY_PRESS)
					m_Mouse.btnStates[i] = KEY_UP;
				else
					m_Mouse.btnStates[i] = KEY_NONE;
			}
		}
	}
}

const KEYBOARD_BUFFER& CInput::GetKeyboardBuffer() const
{
	return m_Keyboard;
}

const MOUSE_BUFFER& CInput::GetMouseBuffer() const
{
	return m_Mouse;
}
