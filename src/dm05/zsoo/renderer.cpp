
#include "zsoo.h"
#include "renderer.h"

#pragma comment(lib, "d3d8")
#pragma comment(lib, "d3dx8")

#define pDevice zg_pRen->m_pD3DDevice

CRenderer::CImmDrawer::CImmDrawer(D3DPRIMITIVETYPE pt)
{
	_Vertices.clear();
	_PrimitiveType = pt;
	_Diffuse = 0xffffffff;
}

void CRenderer::CImmDrawer::Vertex(long x,long y,long z)
{
	zVertex v1;
	v1.x = (float)x - 0.5f;
	v1.y = (float)y - 0.5f;
	v1.z = (float)z;
	v1.diff = _Diffuse;
	v1.tx = _TexCoord[0];
	v1.ty = _TexCoord[1];
	_Vertices.push_back(v1);
}

void CRenderer::CImmDrawer::Vertex(float x,float y,float z)
{
	zVertex v1;
	v1.x = x - 0.5f;
	v1.y = y - 0.5f;
	v1.z = z;
	v1.diff = _Diffuse;
	v1.tx = _TexCoord[0];
	v1.ty = _TexCoord[1];
	_Vertices.push_back(v1);
}

void CRenderer::CImmDrawer::Vertex(D3DXVECTOR3 v)
{
	zVertex v1;
	v1.x = v.x - 0.5f;
	v1.y = v.y - 0.5f;
	v1.z = 1.0f;
	v1.diff = _Diffuse;
	v1.tx = _TexCoord[0];
	v1.ty = _TexCoord[1];
	_Vertices.push_back(v1);
}

void CRenderer::CImmDrawer::Color(float a,float r,float g,float b)
{
	_Diffuse = (BYTE(a*255) << 24) | (BYTE(r*255) << 16) | (BYTE(g*255) << 8) | (BYTE(b*255));
}

void CRenderer::CImmDrawer::Color(byte a,byte r,byte g,byte b)
{
	_Diffuse = (a << 24) | (r << 16) | (g << 8) | (b);
}

void CRenderer::CImmDrawer::Color(DWORD c)
{
	_Diffuse = c;
}

void CRenderer::CImmDrawer::TexCoord(float u,float v)
{
	_TexCoord[0] = u;
	_TexCoord[1] = v;
}

CRenderer::CImmDrawer::~CImmDrawer()
{
	long PrimitiveCount;
	switch (_PrimitiveType)
	{
		case D3DPT_POINTLIST:
			PrimitiveCount = _Vertices.size();
			break;
		case D3DPT_LINELIST:
			PrimitiveCount = _Vertices.size() / 2;
			break;
		case D3DPT_LINESTRIP:
			PrimitiveCount = _Vertices.size() - 1;
			break;
		case D3DPT_TRIANGLELIST:
			PrimitiveCount = _Vertices.size() / 3;
			break;
		case D3DPT_TRIANGLESTRIP:
		case D3DPT_TRIANGLEFAN:
			PrimitiveCount = _Vertices.size() - 2;
			break;
		default:
			PrimitiveCount = 0;
	}
	if (PrimitiveCount>0)
		pDevice->DrawPrimitiveUP(_PrimitiveType, PrimitiveCount, &_Vertices[0], sizeof zVertex);
}

CRenderer::CRenderer()
: m_pD3D(0), m_pD3DDevice(0)
{
}

HRESULT CRenderer::Initialize(int Width, int Height)
{
	if (zg_App.hWnd == NULL)
	{
		DWORD dwExStyle;
		DWORD dwStyle;

		RECT WindowRect;
		WindowRect.left = 0;
		WindowRect.right = Width;
		WindowRect.top = 0;
		WindowRect.bottom = Height;

		if (zg_App.bFullscreen)
		{
			dwExStyle = WS_EX_APPWINDOW;
			dwStyle = WS_POPUP;
		}
		else
		{
			dwExStyle = WS_EX_APPWINDOW | WS_EX_WINDOWEDGE;
			dwStyle = WS_SYSMENU|WS_CAPTION|WS_MINIMIZEBOX;
		}

		AdjustWindowRectEx(&WindowRect, dwStyle, FALSE, dwExStyle);
		WindowRect.right -= WindowRect.left;
		WindowRect.bottom -= WindowRect.top;

		zg_App.hWnd = CreateWindowEx(dwExStyle, zg_App.szClassName, "zsoo", dwStyle, CW_USEDEFAULT, CW_USEDEFAULT,
								WindowRect.right, WindowRect.bottom, NULL, NULL, zg_App.hInst, NULL);

		ShowWindow(zg_App.hWnd, SW_SHOW);
		UpdateWindow(zg_App.hWnd);
	}

	HRESULT hr;
	// 이미 있으면 제거
	if (m_pD3D || m_pD3DDevice)
		Release();

	m_pD3D = Direct3DCreate8(D3D_SDK_VERSION);
//	m_pD3D = Direct3DCreate9(D3D_SDK_VERSION);

//	if (!m_pD3D)
//		m_pD3D = Direct3DCreate9(D3D9b_SDK_VERSION);

	if (!m_pD3D)
	{
		AddLogString("Direct3D 생성에 실패했습니다.\n");
		goto fail;
	}

	// 디스플레이모드 얻어옴
	D3DDISPLAYMODE d3ddm;
	if( FAILED(hr = m_pD3D->GetAdapterDisplayMode(D3DADAPTER_DEFAULT, &d3ddm)) )
	{
		AddLogString("디스플레이모드를 얻어 오는데 실패했습니다.\n");
		goto fail;
	}

	ZeroMemory(&m_d3dpp, sizeof(m_d3dpp));
	m_d3dpp.SwapEffect = D3DSWAPEFFECT_DISCARD;
	m_d3dpp.BackBufferWidth = Width;
	m_d3dpp.BackBufferHeight = Height;
	m_d3dpp.hDeviceWindow = zg_App.hWnd;
	m_d3dpp.EnableAutoDepthStencil = FALSE;
	m_d3dpp.AutoDepthStencilFormat = D3DFMT_D16;
	m_d3dpp.BackBufferFormat = d3ddm.Format;
//	m_d3dpp.PresentationInterval = D3DPRESENT_INTERVAL_IMMEDIATE;
	m_d3dpp.Windowed = !zg_App.bFullscreen;

	if ( FAILED(hr = m_pD3D->CreateDevice(D3DADAPTER_DEFAULT, D3DDEVTYPE_HAL, zg_App.hWnd,
		D3DCREATE_SOFTWARE_VERTEXPROCESSING, &m_d3dpp, &m_pD3DDevice)) )
	{
		AddLogString("Direct3D 디바이스 생성에 실패했습니다.\n");
		goto fail;
	}

/*	D3DCAPS9 ddc;
	m_pD3DDevice->GetDeviceCaps(&ddc);
	if (!(ddc.TextureCaps & D3DPTEXTURECAPS_ALPHA))
	{
		AddLogString("그래픽카드가 알파채널 텍스쳐를 지원하지 않습니다.\n");
		goto fail;
	}
	if (ddc.TextureCaps & D3DPTEXTURECAPS_SQUAREONLY)
	{
		AddLogString("그래픽카드가 정사각형만을 지원합니다.\n");
		goto fail;
	}
	if (ddc.MaxTextureWidth < 1024 || ddc.MaxTextureHeight < 1024)
	{
		AddLogString("그래픽카드의 최대 텍스쳐 크기가 1024보다 작습니다.\n");
		goto fail;
	}*/

	LPDIRECT3DTEXTURE8 pTemp;
	m_iTexQuality = 0;
	if (1)
	{
		if (SUCCEEDED(m_pD3DDevice->CreateTexture(256, 256, 1, 0, D3DFMT_A8R8G8B8, D3DPOOL_MANAGED, &pTemp)))
		{
			m_iTexQuality = 4;
			pTemp->Release();
		}
	}
	if (!m_iTexQuality)
	{
		if (SUCCEEDED(m_pD3DDevice->CreateTexture(256, 256, 1, 0, D3DFMT_A4R4G4B4, D3DPOOL_MANAGED, &pTemp)))
		{
			m_iTexQuality = 2;
			pTemp->Release();
		}
	}
	if (!m_iTexQuality)
	{
		AddLogString("그래픽카드에 zsoo에서 지원하는 텍스쳐 포맷이 없습니다.\n");
		goto fail;
	}

	// 2D출력을 위한 세팅
	D3DXMatrixIdentity(&m_matIden);
	D3DXMatrixOrthoOffCenterLH(&m_matOrtho, 0, (float)Width, (float)Height, 0, 0, 300);

	SetRenderingOption();

	return S_OK;

fail:
	if (m_pD3DDevice)
		m_pD3DDevice->Release();
	if (m_pD3D)
		m_pD3D->Release();
	m_pD3DDevice = NULL;
	m_pD3D = NULL;
	return E_FAIL;
}

// 여기서 모든 요소들을 해제한다.
void CRenderer::Release()
{
	HRESULT hr = S_OK;

	hr |= m_pD3DDevice->Release();
	hr |= m_pD3D->Release();
	delete this;
}

// 그리기 준비
void CRenderer::PreRender()
{
	m_pD3DDevice->Clear(0, 0, D3DCLEAR_TARGET, 0, 1, 0);
	m_pD3DDevice->BeginScene();
}

// 화면에 출력
void CRenderer::PostRender()
{
	m_pD3DDevice->EndScene();
	if ( FAILED(m_pD3DDevice->Present(0, 0, 0, 0)) )
	{
		HRESULT hr = m_pD3DDevice->TestCooperativeLevel(); 

		while(hr == D3DERR_DEVICELOST)
		{ 
			while(hr != D3DERR_DEVICENOTRESET)
			{
				MSG msg;
				Sleep(500);
				PeekMessage(&msg, 0, 0, 0, PM_REMOVE);
				TranslateMessage(&msg);
				DispatchMessage(&msg);
				hr = m_pD3DDevice->TestCooperativeLevel();
			}
			if(FAILED(m_pD3DDevice->Reset(&m_d3dpp)))
				hr = D3DERR_DEVICELOST;
		}
		SetRenderingOption();
	}
}

HRESULT CRenderer::ToggleFullScreen()
{
	HRESULT hr;
	m_d3dpp.Windowed ^= 1;
	if (FAILED(hr = m_pD3DDevice->Reset(&m_d3dpp)))
	{
//		Release();
//		CreateDevice(m_RenderOption.hDeviceWindow, m_RenderOption.BackBufferWidth, m_RenderOption.BackBufferHeight, !m_RenderOption.Windowed);
	}

	SetRenderingOption();

	RECT WindowRect;
	zg_App.bFullscreen ^= 1;
	if (zg_App.bFullscreen)
	{
		GetWindowRect(zg_App.hWnd, &WindowRect);
//		m_ptPosition.x = WindowRect.left;
//		m_ptPosition.y = WindowRect.top;
		GetClientRect(zg_App.hWnd, &WindowRect);
		SetWindowLong(zg_App.hWnd, GWL_EXSTYLE, WS_EX_APPWINDOW);
		SetWindowLong(zg_App.hWnd, GWL_STYLE, WS_POPUP);
		SetWindowPos(zg_App.hWnd, NULL, 0, 0, WindowRect.right, WindowRect.bottom, 0);
	}
	else
	{
		GetClientRect(zg_App.hWnd, &WindowRect);
		SetWindowLong(zg_App.hWnd, GWL_EXSTYLE, WS_EX_APPWINDOW | WS_EX_WINDOWEDGE);
		SetWindowLong(zg_App.hWnd, GWL_STYLE, WS_SYSMENU|WS_CAPTION|WS_MINIMIZEBOX);
		AdjustWindowRectEx(&WindowRect, WS_SYSMENU|WS_CAPTION|WS_MINIMIZEBOX, FALSE, WS_EX_APPWINDOW | WS_EX_WINDOWEDGE);
		WindowRect.right -= WindowRect.left;
		WindowRect.bottom -= WindowRect.top;
		SetWindowPos(zg_App.hWnd, NULL, 0, 0/*_ptPosition.x, m_ptPosition.y*/, WindowRect.right, WindowRect.bottom, 0);
	}

	SetForegroundWindow(zg_App.hWnd);
	SetFocus(zg_App.hWnd);
	ShowWindow(zg_App.hWnd, SW_SHOW);

	return S_OK;
}

HRESULT CRenderer::SetBackBufferSize(int Width, int Height, BOOL bSetWndSize)
{
	m_d3dpp.BackBufferWidth = Width;
	m_d3dpp.BackBufferHeight = Height;

	HRESULT hr = m_pD3DDevice->Reset(&m_d3dpp);
	if (FAILED(hr))
	{
		AddLogString("백버퍼 크기 변경 실패.\n");
		return hr;
	}
	SetRenderingOption();

	// 2D출력을 위한 세팅
	D3DXMatrixIdentity(&m_matIden);
	D3DXMatrixOrthoOffCenterLH(&m_matOrtho, 0, (float)Width, (float)Height, 0, 0, 300);
	return S_OK;
}

int CRenderer::GetTextureQuality() const
{
	return m_iTexQuality;
}

void CRenderer::SetRenderingOption()
{
	m_pD3DDevice->SetRenderState(D3DRS_STENCILENABLE, FALSE);
	m_pD3DDevice->SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_MODULATE);
	m_pD3DDevice->SetTextureStageState(0, D3DTSS_ALPHAARG1, D3DTA_TEXTURE);
	m_pD3DDevice->SetTextureStageState(0, D3DTSS_ALPHAARG2, D3DTA_DIFFUSE);
	m_pD3DDevice->SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_MODULATE);
	m_pD3DDevice->SetTextureStageState(0, D3DTSS_COLORARG1, D3DTA_TEXTURE);
	m_pD3DDevice->SetTextureStageState(0, D3DTSS_COLORARG2, D3DTA_DIFFUSE);

	m_pD3DDevice->SetTransform(D3DTS_WORLD, &m_matIden);
	m_pD3DDevice->SetTransform(D3DTS_VIEW, &m_matIden);
	m_pD3DDevice->SetTransform(D3DTS_PROJECTION, &m_matOrtho);
//	m_pD3DDevice->SetSamplerState(0, D3DSAMP_MAGFILTER, D3DTEXF_LINEAR);
//	m_pD3DDevice->SetSamplerState(0, D3DSAMP_MINFILTER, D3DTEXF_LINEAR);
	m_pD3DDevice->SetRenderState(D3DRS_LIGHTING, FALSE);
	m_pD3DDevice->SetRenderState(D3DRS_ZENABLE, FALSE);
	m_pD3DDevice->SetRenderState(D3DRS_ZWRITEENABLE, FALSE);
	m_pD3DDevice->SetRenderState(D3DRS_CULLMODE, D3DCULL_NONE);
	m_pD3DDevice->SetVertexShader(D3DFVF_XYZ|D3DFVF_DIFFUSE|D3DFVF_TEX1);
//	m_pD3DDevice->SetFVF(D3DFVF_XYZ|D3DFVF_DIFFUSE|D3DFVF_TEX1);
}

CSprite::COLOR4::COLOR4()
{
}

CSprite::COLOR4::COLOR4(DWORD d)
{
	Color[0] = Color[1] = Color[2] = Color[3] = d;
}

CSprite::CSprite() : m_pTexture(0), m_bLocked(false), m_Size()
{
}

HRESULT CSprite::Initialize(int w, int h)
{
	Release();

	D3DFORMAT Fmt;
	if (zg_pRen->GetTextureQuality() == 4)
		Fmt = D3DFMT_A8R8G8B8;
	else if (zg_pRen->GetTextureQuality() == 2)
		Fmt = D3DFMT_A4R4G4B4;
	else
		return E_FAIL;

	if (SUCCEEDED(pDevice->CreateTexture(w, h, 1, 0, Fmt, D3DPOOL_MANAGED, &m_pTexture)))
	{
		m_Size.cx = w;
		m_Size.cy = h;
		return S_OK;
	}
	else
		return E_FAIL;
}

void CSprite::Release()
{
	Unlock();
	m_Size.cx = m_Size.cy = 0;
	if (m_pTexture)
	{
		m_pTexture->Release();
		m_pTexture = NULL;
	}
}

void CSprite::SetTexture()
{
	pDevice->SetTexture(0, m_pTexture);
}

void CSprite::Draw(RECT* pDest, RECT* pSrc, DWORD Color, DWORD bs)
{
	float tx[2], ty[2];
	float x[2] = {(float)pDest->left-0.5f, (float)pDest->right-0.5f}, y[2] = {(float)pDest->top-0.5f, (float)pDest->bottom-0.5f};
	if (pSrc)
	{
		tx[0] = (float)pSrc->left / (float)m_Size.cx;
		tx[1] = (float)pSrc->right / (float)m_Size.cx;
		ty[0] = (float)pSrc->top  / (float)m_Size.cy;
		ty[1] = (float)pSrc->bottom / (float)m_Size.cy;
	}
	else
	{
		tx[0] = ty[0] = 0.0f;
		tx[1] = ty[1] = 1.0f;
	}
	zVertex v[4] = {
		{x[0], y[0], 1, Color, tx[0], ty[0]},
		{x[1], y[0], 1, Color, tx[1], ty[0]},
		{x[1], y[1], 1, Color, tx[1], ty[1]},
		{x[0], y[1], 1, Color, tx[0], ty[1]}
	};

	if (bs & BLSTYLE_SRC)
	{
		pDevice->SetRenderState(D3DRS_ALPHABLENDENABLE, FALSE);
	}
	else if (bs & BLSTYLE_ALPHA)
	{
		pDevice->SetRenderState(D3DRS_ALPHABLENDENABLE, TRUE);
		pDevice->SetRenderState(D3DRS_SRCBLEND, D3DBLEND_SRCALPHA);
		pDevice->SetRenderState(D3DRS_DESTBLEND, D3DBLEND_INVSRCALPHA);
	}
	else if (bs & BLSTYLE_COLOR)
	{
		pDevice->SetRenderState(D3DRS_ALPHABLENDENABLE, TRUE);
		pDevice->SetRenderState(D3DRS_SRCBLEND, D3DBLEND_SRCCOLOR);
		pDevice->SetRenderState(D3DRS_DESTBLEND, D3DBLEND_ONE);
	}

	if (bs & BLSTYLE_TESTCHK)
	{
		int func = (bs >> 24) & 0xff;
		int value = (bs >> 16) & 0xff;
		pDevice->SetRenderState(D3DRS_ALPHATESTENABLE, TRUE);
		pDevice->SetRenderState(D3DRS_ALPHAFUNC, func);
		pDevice->SetRenderState(D3DRS_ALPHAREF, value);
	}
	else
	{
		pDevice->SetRenderState(D3DRS_ALPHATESTENABLE, FALSE);
	}

	pDevice->SetTexture(0, m_pTexture);
	pDevice->DrawPrimitiveUP(D3DPT_TRIANGLEFAN, 2, v, sizeof zVertex);
}

void CSprite::Draw(RECT* pDest, RECT* pSrc, COLOR4 Color, DWORD bs)
{
	float tx[2], ty[2];
	float x[2] = {(float)pDest->left-0.5f, (float)pDest->right-0.5f}, y[2] = {(float)pDest->top-0.5f, (float)pDest->bottom-0.5f};
	if (pSrc)
	{
		tx[0] = (float)pSrc->left / (float)m_Size.cx;
		tx[1] = (float)pSrc->right / (float)m_Size.cx;
		ty[0] = (float)pSrc->top  / (float)m_Size.cy;
		ty[1] = (float)pSrc->bottom / (float)m_Size.cy;
	}
	else
	{
		tx[0] = ty[0] = 0.0f;
		tx[1] = ty[1] = 1.0f;
	}
	zVertex v[4] = {
		{x[0], y[0], 1, Color.Color[0], tx[0], ty[0]},
		{x[1], y[0], 1, Color.Color[1], tx[1], ty[0]},
		{x[1], y[1], 1, Color.Color[3], tx[1], ty[1]},
		{x[0], y[1], 1, Color.Color[2], tx[0], ty[1]}
	};

	if (bs & BLSTYLE_SRC)
	{
		pDevice->SetRenderState(D3DRS_ALPHABLENDENABLE, FALSE);
	}
	else if (bs & BLSTYLE_ALPHA)
	{
		pDevice->SetRenderState(D3DRS_ALPHABLENDENABLE, TRUE);
		pDevice->SetRenderState(D3DRS_SRCBLEND, D3DBLEND_SRCALPHA);
		pDevice->SetRenderState(D3DRS_DESTBLEND, D3DBLEND_INVSRCALPHA);
	}
	else if (bs & BLSTYLE_COLOR)
	{
		pDevice->SetRenderState(D3DRS_ALPHABLENDENABLE, TRUE);
		pDevice->SetRenderState(D3DRS_SRCBLEND, D3DBLEND_SRCCOLOR);
		pDevice->SetRenderState(D3DRS_DESTBLEND, D3DBLEND_ONE);
	}

	if (bs & BLSTYLE_TESTCHK)
	{
		int func = (bs >> 24) & 0xff;
		int value = (bs >> 16) & 0xff;
		pDevice->SetRenderState(D3DRS_ALPHATESTENABLE, TRUE);
		pDevice->SetRenderState(D3DRS_ALPHAFUNC, func);
		pDevice->SetRenderState(D3DRS_ALPHAREF, value);
	}
	else
	{
		pDevice->SetRenderState(D3DRS_ALPHATESTENABLE, FALSE);
	}

	pDevice->SetTexture(0, m_pTexture);
	pDevice->DrawPrimitiveUP(D3DPT_TRIANGLEFAN, 2, v, sizeof zVertex);
}

void CSprite::Lock(SPRLOCKEDRECT* slr)
{
	if (m_bLocked)
		return;

	slr->pData = NULL;
	slr->Pitch = 0;
	slr->Size.cx = 0;
	slr->Size.cy = 0;

	if (!m_pTexture)
		return;

	D3DSURFACE_DESC desc;

	if ( FAILED(m_pTexture->GetLevelDesc(0, &desc)) )
		return;
	if ( FAILED(m_pTexture->LockRect(0, &m_LockedRect, NULL, 0)) )
		return;

	slr->pData = (BYTE*)m_LockedRect.pBits;
	slr->Pitch = m_LockedRect.Pitch;
	slr->Size.cx = desc.Width;
	slr->Size.cy = desc.Height;
	m_bLocked = true;
}

void CSprite::Unlock()
{
	if (m_bLocked)
		m_pTexture->UnlockRect(0);

	m_bLocked = false;
}

CFont::CFont()
{
	m_iSize = 0;
	m_iHeight = 0;
}

CFont::CFont(const char* lpFont, int size, int texsize, DWORD flags)
{
	if ( FAILED(Initialize(lpFont, size, texsize, flags)) )
		Release();
}

HRESULT CFont::Initialize(const char* lpFont, int size, int texsize, DWORD flags)
{
	Release();
	m_strFontname = lpFont;
	m_iSize = size;
	m_iTexSize = texsize;
	m_bBold = flags & FT_BOLD ? FW_BOLD : 0;
	m_bOutline = flags & FT_OUTLINE ? TRUE : FALSE;

	HDC hDC = CreateCompatibleDC(NULL);
	m_iHeight = MulDiv(m_iSize, (INT)GetDeviceCaps(hDC, LOGPIXELSY), 72);
	DeleteDC(hDC);

	return S_OK;
}

void CFont::DrawString(int sx, int sy, DWORD color, draw_option* option, const char* fmt, ...)
{
	WCHAR wbuffer[1024];
	// fmt을 이용하여 buffer에 출력내용을 저장
	{
		char buffer[1024];
		va_list List;
		va_start(List, fmt);
		vsprintf(buffer, fmt, List);
		va_end(List);
		MultiByteToWideChar(CP_ACP, 0, buffer, -1, wbuffer, MAX_PATH);
	}

	typedef vector<draw_int> vDInt;
	vector<vDInt> vDInts(m_vCharsets.size());
	int x = sx, y = sy;
	int char_no = 0;
	bool pos_found = false;
	int gap = 1;

	if (option)
	{
		if (option->flag & DS_SET_GAP)
		{
			gap = (int)option->params["DS_SET_GAP"];
		}
	}

	// 한 글자씩
	for (int nbuff=0; wbuffer[nbuff]; ++nbuff)
	{
		BOOL bFound = FALSE;
		if (option)
		{
			if ((option->flag & DS_GET_CARET_RECT) && !pos_found)
			{
				RECT* r = (RECT*)option->params["DS_GET_CARET_RECT"];
				if (r->left == char_no)
				{
					r->left = x;
					r->top = y;
					r->right = x+1;
					r->bottom = y+m_iHeight;
					pos_found = true;
				}
			}
		}
		// 문자세트로 루프
		for (int nset=0; nset<(int)m_vCharsets.size(); ++nset)
		{
			// 해당 텍스쳐의 출력문자
			vDInt &vDI = vDInts[nset];
			// 해당 문자셋
			charset &cset = *m_vCharsets[nset];
			// 문자셋에서 검색
			for (int nchar=0; nchar<(int)cset.vChars.size(); ++nchar)
			{
				character &cchar = *cset.vChars[nchar];
				// 찾았으면
				if (cchar.word == wbuffer[nbuff])
				{
					draw_int di;
					di.nchar = nchar;
recompute_0:
					di.x = (float)x; di.y = (float)y;
					di.x2 = float(x + cchar.x2 - cchar.x);
					di.y2 = float(y + cchar.y2 - cchar.y);
					if (option)
					{
						if ((option->flag & DS_LIMIT_WIDTH) == DS_LIMIT_WIDTH)
						{
							if (sx + (int)option->params["DS_LIMIT_WIDTH"] < x + cchar.x2 - cchar.x)
							{
								if ((option->flag & DS_AUTO_LINE) == DS_AUTO_LINE)
								{
									x = sx;
									y += cchar.y2 - cchar.y + 1;
									if ((option->flag & DS_LIMIT_HEIGHT) == DS_LIMIT_HEIGHT)
									{
										if (sy + (int)option->params["DS_LIMIT_HEIGHT"] < y + cchar.y2 - cchar.y)
											goto draw_string;
									}
									goto recompute_0;
								}
								else
								{
									goto draw_string;
								}
							}
						}
					}
					x += cchar.x2 - cchar.x + gap;
					vDI.push_back(di);
					bFound = TRUE;
					break;
				}
			}
		}
		if (bFound==FALSE) // 검색실패
		{
			SIZE wcSize;
			{
				char buffer[4];
				WCHAR wc[] = {wbuffer[nbuff], 0x0000};
				WideCharToMultiByte(CP_ACP, 0, wc, -1, buffer, 4, NULL, NULL);
				HDC hDC = CreateCompatibleDC(NULL);
//				int nHeight = MulDiv(m_iSize, (INT)GetDeviceCaps(hDC, LOGPIXELSY), 72);
				HFONT hFont = CreateFont(m_iHeight/*nHeight*/, 0, 0, 0, m_bBold, FALSE,
										FALSE, FALSE, DEFAULT_CHARSET, OUT_DEFAULT_PRECIS,
										CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY,
										VARIABLE_PITCH, m_strFontname.c_str());
				HFONT oldFont = (HFONT)SelectObject(hDC, hFont);
				GetTextExtentPoint32(hDC, buffer, strlen(buffer), &wcSize);
				if (m_bOutline)
				{
					wcSize.cx += 2;
					wcSize.cy += 2;
				}
				SelectObject(hDC, oldFont);
				DeleteObject(hFont);
				DeleteDC(hDC);
			}

			charset* pcset;
			character* pchar;

			if (nset==0)
			{
				pchar = new character;
				pchar->x2 = m_iTexSize; pchar->y2 = m_iTexSize;
			}
			else
			{
				pcset = m_vCharsets.back();
				pchar = pcset->vChars.back();
			}
			if (pchar->x2+1 + wcSize.cx >= m_iTexSize)
			{// 가로줄의 끝에 왔다면
				if (pchar->y2+1 + wcSize.cy >= m_iTexSize)
				{// 새로운 텍스쳐필요
					charset* pnset = new charset;
					pnset->pSprite = new CSprite();
					pnset->pSprite->Initialize(m_iTexSize, m_iTexSize);
					m_vCharsets.push_back(pnset);
					// 개수를 만추기 위함
					vDInt nvdi;
					vDInts.push_back(nvdi);

					AddChar(0, 0, wcSize.cx, wcSize.cy, m_vCharsets.size()-1, wbuffer[nbuff]);

					if (nset==0)
						delete pchar;

					pcset = pnset;
				}
				else
				{// 다음줄로..
					AddChar(0, pchar->y2+1, wcSize.cx, wcSize.cy, m_vCharsets.size()-1, wbuffer[nbuff]);
				}
			}
			else
			{// 가로에 여유가 있는 경우
				AddChar(pchar->x2+1, pchar->y, wcSize.cx, wcSize.cy, m_vCharsets.size()-1, wbuffer[nbuff]);
			}

			pchar = pcset->vChars.back();
			draw_int di;
			di.nchar = pcset->vChars.size()-1;
recompute_1:
			di.x = (float)x; di.y = (float)y;
			di.x2 = float(x + pchar->x2 - pchar->x);
			di.y2 = float(y + pchar->y2 - pchar->y);
			if (option)
			{
				if ((option->flag & DS_LIMIT_WIDTH) == DS_LIMIT_WIDTH)
				{
					if (sx + (int)option->params["DS_LIMIT_WIDTH"] < x + pchar->x2 - pchar->x)
					{
						if ((option->flag & DS_AUTO_LINE) == DS_AUTO_LINE)
						{
							x = sx;
							y += pchar->y2 - pchar->y + 1;
							if ((option->flag & DS_LIMIT_HEIGHT) == DS_LIMIT_HEIGHT)
							{
								if (sy + (int)option->params["DS_LIMIT_HEIGHT"] < y + pchar->y2 - pchar->y)
									goto draw_string;
							}
							goto recompute_1;
						}
						else
						{
							goto draw_string;
						}
					}
				}
			}
			x += pchar->x2 - pchar->x + gap;
			vDInts.back().push_back(di);
		}
		if (wbuffer[nbuff] >= 0x80)
			char_no += 2;
		else
			++char_no;
	}
	if (option)
	{
		if ((option->flag & DS_GET_CARET_RECT) && !pos_found)
		{
			RECT* r = (RECT*)option->params["DS_GET_CARET_RECT"];
			if (r->left == char_no)
			{
				r->left = x;
				r->top = y;
				r->right = x+1;
				r->bottom = y+m_iHeight;
				pos_found = true;
			}
		}
	}
draw_string:

	pDevice->SetRenderState(D3DRS_ALPHABLENDENABLE, TRUE);
	pDevice->SetRenderState(D3DRS_SRCBLEND, D3DBLEND_SRCALPHA);
	pDevice->SetRenderState(D3DRS_DESTBLEND, D3DBLEND_INVSRCALPHA);
	for (int nTex=0; nTex<(int)vDInts.size(); ++nTex)
	{
		CRenderer::CImmDrawer imm(D3DPT_TRIANGLELIST);
		vDInt& vDI = vDInts[nTex];
		pDevice->SetTexture(0, (m_vCharsets[nTex]->pSprite)->m_pTexture);
		imm.Color(color);
		for(int nDInt=0; nDInt<(int)vDI.size(); ++nDInt)
		{
			draw_int di = vDI[nDInt];
			character* pchar = m_vCharsets[nTex]->vChars[ di.nchar ];
			imm.TexCoord(pchar->u, pchar->v);
			imm.Vertex(di.x, di.y, 1);

			imm.TexCoord(pchar->u2, pchar->v);
			imm.Vertex(di.x2, di.y, 1);

			imm.TexCoord(pchar->u, pchar->v2);
			imm.Vertex(di.x, di.y2, 1);

			imm.TexCoord(pchar->u, pchar->v2);
			imm.Vertex(di.x, di.y2, 1);

			imm.TexCoord(pchar->u2, pchar->v);
			imm.Vertex(di.x2, di.y, 1);

			imm.TexCoord(pchar->u2, pchar->v2);
			imm.Vertex(di.x2, di.y2, 1);
		}
		vDI.clear();
	}
	vDInts.clear();
	pDevice->SetTexture(0, NULL);
}

void CFont::Release()
{
	while (m_vCharsets.size())
	{
		charset* pset = m_vCharsets.front();
		pset->pSprite->Release();
		delete pset->pSprite;

		while (pset->vChars.size())
		{
			delete pset->vChars.back();
			pset->vChars.pop_back();
		}
		delete m_vCharsets.front();
		m_vCharsets.erase(m_vCharsets.begin());
	}
	m_vCharsets.clear();
}

void CFont::AddChar(int x, int y, int cx, int cy, int to, WCHAR w)
{
	character* pnc = new character;
	pnc->word = w; pnc->x = x; pnc->y = y;
	pnc->x2 = x + cx; pnc->y2 = y + cy;
	pnc->u = (float)pnc->x / (float)m_iTexSize;
	pnc->v = (float)pnc->y / (float)m_iTexSize;
	pnc->u2 = (float)pnc->x2 / (float)m_iTexSize;
	pnc->v2 = (float)pnc->y2 / (float)m_iTexSize;
	m_vCharsets[to]->vChars.push_back(pnc);

	char buffer[4];
	WCHAR wc[] = {w, 0x0000};
	WideCharToMultiByte(CP_ACP, 0, wc, -1, buffer, 4, NULL, NULL);

	LPDWORD pBitmapBits;
	BITMAPINFO bmi;
	HBITMAP oldBitmap;
	HFONT oldFont;
	ZeroMemory(&bmi.bmiHeader, sizeof(BITMAPINFOHEADER));
	bmi.bmiHeader.biSize = sizeof(BITMAPINFOHEADER);
	bmi.bmiHeader.biWidth = cx;
	bmi.bmiHeader.biHeight = -cy;
	bmi.bmiHeader.biPlanes = 1;
	bmi.bmiHeader.biCompression = BI_RGB;
	bmi.bmiHeader.biBitCount = 32;

	HDC hDC = CreateCompatibleDC(NULL);
	HBITMAP hbmBitmap = CreateDIBSection(hDC, &bmi, DIB_RGB_COLORS,
										(VOID**)&pBitmapBits, NULL, 0);
	SetMapMode(hDC, MM_TEXT);

//	INT nHeight = MulDiv( m_iSize, (INT)GetDeviceCaps(hDC, LOGPIXELSY), 72 );
	HFONT hFont = CreateFont(m_iHeight/*nHeight*/, 0, 0, 0, m_bBold, FALSE,
							FALSE, FALSE, DEFAULT_CHARSET, OUT_DEFAULT_PRECIS,
							CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY,
							VARIABLE_PITCH, m_strFontname.c_str());
	if(NULL==hFont)
		return;

	oldBitmap = (HBITMAP)SelectObject(hDC, hbmBitmap);
	oldFont = (HFONT)SelectObject(hDC, hFont);

	SetBkMode(hDC, OPAQUE);
	SetBkColor(hDC, 0x00000000);
	SetTextAlign(hDC, TA_TOP);

	memset(pBitmapBits, 0, cx*cy*4);

	SetTextColor(hDC, RGB(255, 255, 255));
	if (m_bOutline)
		ExtTextOut(hDC, 1, 1, ETO_OPAQUE, NULL, buffer, strlen(buffer), NULL);
	else
		ExtTextOut(hDC, 0, 0, ETO_OPAQUE, NULL, buffer, strlen(buffer), NULL);

	SPRLOCKEDRECT lockedRect;
	CSprite* pSprite = m_vCharsets[to]->pSprite;
	pSprite->Lock(&lockedRect);

	BYTE** apLine = new BYTE*[cy];
	for (int coy=0; coy<cy; ++coy)
	{
		apLine[coy] = new BYTE[cx];
		for (int cox=0; cox<cx; ++cox)
		{
			apLine[coy][cox] = ((BYTE*)pBitmapBits)[1];
			++pBitmapBits;
		}
	}

	if (zg_pRen->GetTextureQuality() == 4)
	{
		LPDWORD pDest = (LPDWORD)lockedRect.pData, pDest2;
		int nPitch = lockedRect.Pitch / 4;
		pDest += nPitch * y;

		int cox, coy;
		for(coy=0; coy<cy; coy++)
		{
			pDest2 = pDest + x;
			for (cox=0; cox<cx; cox++)
			{
				if (apLine[coy][cox])
					*pDest2++ = 0x00ffffff | (apLine[coy][cox] << 24);
				else if (m_bOutline)
				{
					*pDest2 = 0;
					int sidex, sidey, cox2, coy2;
					for (sidex=-1; sidex<=1; ++sidex)
					{
						for (sidey=-1; sidey<=1; ++sidey)
						{
							cox2 = cox + sidex;
							coy2 = coy + sidey;
							if (cox2 >= 0 && cox2 < cx && coy2 >= 0 && coy2 < cy)
							{
								if (apLine[coy2][cox2] == 0xff)
								{
									*pDest2 = 0xc0101010;
									goto next0;
								}
							}
						}
					}
next0:
					++pDest2;
				}
				else
					*pDest2++ = 0;
			}
			pDest += nPitch;
		}
	}
	else if (zg_pRen->GetTextureQuality() == 2)
	{
		LPWORD pDest = (LPWORD)lockedRect.pData, pDest2;
		int nPitch = lockedRect.Pitch / 2;
		pDest += nPitch * y;

		int cox, coy;
		for(coy=0; coy<cy; coy++)
		{
			pDest2 = pDest + x;
			for (cox=0; cox<cx; cox++)
			{
				if (apLine[coy][cox])
					*pDest2++ = 0x0fff | (apLine[coy][cox] << 8);
				else if (m_bOutline)
				{
					*pDest2 = 0;
					int sidex, sidey, cox2, coy2;
					for (sidex=-1; sidex<=1; ++sidex)
					{
						for (sidey=-1; sidey<=1; ++sidey)
						{
							cox2 = cox + sidex;
							coy2 = coy + sidey;
							if (cox2 >= 0 && cox2 < cx && coy2 >= 0 && coy2 < cy)
							{
								if (apLine[coy2][cox2] == 0xff)
								{
									*pDest2 = 0xc111;
									goto next1;
								}
							}
						}
					}
next1:
					++pDest2;
				}
				else
					*pDest2++ = 0;
			}
			pDest += nPitch;
		}
	}

	for (int coy=0; coy<cy; ++coy)
		delete []apLine[coy];
	delete []apLine;

	pSprite->Unlock();
	SelectObject(hDC, oldBitmap);
	SelectObject(hDC, oldFont);
	DeleteObject(hbmBitmap);
	DeleteObject(hFont);
	DeleteDC(hDC);
}
