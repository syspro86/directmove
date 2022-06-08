
#pragma once

class CRenderer;
class CSprite;
class CFont;

#include "appdata.h"
#include <d3dx8.h>

struct zVertex
{
	float x,y,z;
	DWORD diff;
	float tx,ty;
};

class CRenderer
{
public:
	friend class CSprite;
	friend class CFont;

	CRenderer();
	HRESULT Initialize(int Width=640, int Height=480);
	void Release();
	void PreRender();
	void PostRender();

	HRESULT ToggleFullScreen();
	HRESULT SetBackBufferSize(int Width, int Height, BOOL bSetWndSize=FALSE);
	int GetTextureQuality() const;

private:
	void SetRenderingOption();

public:
	class CImmDrawer
	{
	public:
		CImmDrawer(D3DPRIMITIVETYPE pt);
		~CImmDrawer();
		void Vertex(long x,long y,long z);
		void Vertex(float x,float y,float z);
		void Vertex(D3DXVECTOR3 v);
		void Color(float a,float r,float g,float b);
		void Color(byte a,byte r,byte g,byte b);
		void Color(DWORD c);
		void TexCoord(float u,float v);

	private:
		vector<zVertex> _Vertices;
		D3DPRIMITIVETYPE _PrimitiveType;
		DWORD _Diffuse;
		float _TexCoord[2];
	};

private:
	LPDIRECT3D8 m_pD3D;
	LPDIRECT3DDEVICE8 m_pD3DDevice;
	D3DPRESENT_PARAMETERS m_d3dpp;
	D3DXMATRIX m_matIden, m_matOrtho;
	int m_iTexQuality;
};


struct SPRLOCKEDRECT
{
	SIZE Size;
	LONG Pitch;
	BYTE*pData;
};

enum BLENDSTYLE
{
	BLSTYLE_SRC     = 0x00000001,
	BLSTYLE_ALPHA   = 0x00000002,
	BLSTYLE_COLOR   = 0x00000004,
	BLSTYLE_TESTCHK = 0x00000008,
	BLSTYLE_FORCE_DWORD = 0x7fffffff
};

enum ALPHATESTFUNC
{
	ATFUNC_NEVER = D3DCMP_NEVER,
	ATFUNC_LESS = D3DCMP_LESS,
	ATFUNC_EQUAL = D3DCMP_EQUAL,
	ATFUNC_LESSEQUAL = D3DCMP_LESSEQUAL,
	ATFUNC_GREATER = D3DCMP_GREATER,
	ATFUNC_NOTEQUAL = D3DCMP_NOTEQUAL,
	ATFUNC_GREATEREQUAL = D3DCMP_GREATEREQUAL,
	ATFUNC_ALWAYS = D3DCMP_ALWAYS,
	ATFUNC_FORCE_DWORD = 0x7fffffff
};

#define BLSTYLE_ALPHATEST(func, value)  ((((int)func)<<24) | ((value&&0xff)<<16) | BLSTYLE_TESTCHK)

class CSprite
{
public:
	friend class CFont;
	struct COLOR4
	{
		COLOR4();
		COLOR4(DWORD);
		DWORD Color[4];
	};
	CSprite();
	HRESULT Initialize(int, int);
	void Release();
	void SetTexture();
	void Draw(RECT* pDest, RECT* pSrc, DWORD Color = 0xffffffff, DWORD bs = BLSTYLE_ALPHA);
	void Draw(RECT* pDest, RECT* pSrc, COLOR4 Color, DWORD bs = BLSTYLE_ALPHA);
	void Lock(SPRLOCKEDRECT*);
	void Unlock();

private:
	LPDIRECT3DTEXTURE8 m_pTexture;
	bool m_bLocked;
	D3DLOCKED_RECT m_LockedRect;
	SIZE m_Size;

};

class CFont
{
public:
	enum DRAWSTRING_OPTION
	{
		DS_NO_OPTION = 0,
		DS_LIMIT_WIDTH		= 0x0001, // 00001
		DS_LIMIT_HEIGHT		= 0x0007, // 00111
		DS_AUTO_LINE		= 0x0003, // 00011
		DS_GET_CARET_RECT	= 0x0008, // 01000
		DS_SET_GAP			= 0x0010, // 10000
	};
	enum FONT_OPTION
	{
		FT_NORMAL = 0,
		FT_BOLD = 1,
		FT_OUTLINE = 2,
	};
	struct draw_option
	{
		DWORD flag;
		map<string, DWORD> params;
	};
	struct draw_int
	{
		float x, y, x2, y2;
		int nchar;
	};
	struct character
	{
		WCHAR word;
		int x, y, x2, y2;
		float u, v, u2, v2;
	};
	struct charset
	{
		vector<character*> vChars;
		CSprite* pSprite;
	};

	CFont();
	CFont(const char* lpFont, int size, int texsize, DWORD flags);
	HRESULT Initialize(const char* lpFont, int size, int texsize, DWORD flags);
	void DrawString(int x, int y, DWORD color, draw_option* option, const char* fmt, ...);
	void Release();

private:
	void AddChar(int x, int y, int cx, int cy, int to, WCHAR w);
	vector<charset*> m_vCharsets;
	string m_strFontname;
	int m_iSize;
	int m_iHeight;
	int m_iTexSize;
	BOOL m_bBold;
	BOOL m_bOutline;
};
