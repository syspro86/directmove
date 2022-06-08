
#include "zsoo.h"
#include "loadimg.h"
#include <png.h>
#include <olectl.h>

#pragma comment(lib, "libpng.lib")
#pragma comment(lib, "zlib.lib")

namespace NS_LOADIMG
{
	void CopyBitmapRect4(SPRLOCKEDRECT* pLRDest, SPRLOCKEDRECT* pLRSrc, RECT* pRCSize)
	{
		SPRLOCKEDRECT LRDest = *pLRDest;
		SPRLOCKEDRECT LRSrc  = *pLRSrc;
		RECT RCSize = *pRCSize;
		LONG Width = RCSize.right - RCSize.left;
		BYTE* pDest;
		BYTE* pSrc;

		for (int y=RCSize.top; y<RCSize.bottom; ++y)
		{
			pDest = LRDest.pData + LRDest.Pitch * y + RCSize.left * 4;
			pSrc  = LRSrc.pData  + LRSrc.Pitch  * y + RCSize.left * 4;
			CopyMemory(pDest, pSrc, Width*4);
		}
	}

	void CopyBitmapRect2(SPRLOCKEDRECT* pLRDest, SPRLOCKEDRECT* pLRSrc, RECT* pRCSize)
	{
		SPRLOCKEDRECT LRDest = *pLRDest;
		SPRLOCKEDRECT LRSrc  = *pLRSrc;
		RECT RCSize = *pRCSize;
		LONG Width = RCSize.right - RCSize.left;
		BYTE* pDest;
		BYTE* pSrc;

		for (int y=RCSize.top; y<RCSize.bottom; ++y)
		{
			pDest = LRDest.pData + LRDest.Pitch * y + RCSize.left * 4;
			pSrc  = LRSrc.pData  + LRSrc.Pitch  * y + RCSize.left * 4;
			for (int x=0; x<Width; ++x)
			{
				pDest[0] = (pSrc[0] >> 4);
				pDest[0]|= (pSrc[1] >> 4) << 4;
				pDest[1] = (pSrc[2] >> 4);
				pDest[1]|= (pSrc[3] >> 4) << 4;
				pSrc += 4;
				pDest += 2;
			}
		}
	}

	HRESULT LoadImageDataFromFile(LPCSTR Filename, SPRLOCKEDRECT* pSpr)
	{
		string strFilename(Filename);
		string ext(Filename+strFilename.rfind(".")+1);
		strlwr(const_cast<char*>(ext.c_str()));

		BYTE* pData = NULL;
		LONG Width = 0, Height = 0;

		if (ext == "png")
		{
			png_struct* pPNG;
			png_info* pInfo;

			BYTE** ppLines = NULL;
			BYTE* pImage = NULL;
			int iPitch;

			int bitDepth, colorType;
			DWORD dwWidth, dwHeight;
			int Channel;

			FILE *file;
			if (!(file = fopen(Filename,"rb")))
				return E_FAIL;

			if (!(pPNG = png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL)))
			{
				fclose(file);
				return E_FAIL;
			}

			if (!(pInfo = png_create_info_struct(pPNG)))
			{
				fclose(file);
				png_destroy_read_struct(&pPNG, NULL, NULL);
				return E_FAIL;
			}

			if (setjmp(png_jmpbuf(pPNG)))
			{
				png_destroy_read_struct(&pPNG, &pInfo, NULL);
				fclose(file);
				return E_FAIL;
			}

			png_init_io(pPNG, file);
			png_read_info(pPNG, pInfo);
			png_get_IHDR(pPNG, pInfo, &dwWidth, &dwHeight, &bitDepth, &colorType, NULL, NULL, NULL);

			Channel = png_get_channels(pPNG, pInfo);

			png_read_update_info(pPNG, pInfo);

			iPitch = png_get_rowbytes(pPNG, pInfo);

			if (!(pImage = new png_byte[iPitch*dwHeight]))
			{
				png_destroy_read_struct(&pPNG, &pInfo, NULL);
				return E_FAIL;
			}
			if (!(ppLines = new png_bytep[dwHeight*sizeof(BYTE*)]))
			{
				png_destroy_read_struct(&pPNG, &pInfo, NULL);
				delete []pImage;
				pImage = NULL;
				return E_FAIL;
			}
			for (unsigned int i = 0;  i < dwHeight; ++i)
				ppLines[i] = pImage + i*iPitch;

			png_read_image(pPNG, ppLines);
			delete []ppLines;
			fclose(file);
			png_destroy_info_struct(pPNG, &pInfo);
			png_destroy_read_struct(&pPNG, NULL, NULL);

			Width = dwWidth;
			Height = dwHeight;
			pData = new BYTE[Width*Height*4];

			BYTE* pSrc = pImage;
			BYTE* pDest = pData;

			for (int y=0; y<Height; ++y)
			{
				for (int x=0; x<Width; ++x)
				{
					pDest[0] = pSrc[2];
					pDest[1] = pSrc[1];
					pDest[2] = pSrc[0];
					pDest[3] = Channel==4 ? pSrc[3] : 255;
					pSrc += Channel;
					pDest += 4;
				}
			}
			delete []pImage;
		}
		else
		{
			HDC hDC, hDCg;
			HBITMAP hBMP, hBMPOld;
			IPicture *pPicture;
			OLECHAR wszPath[MAX_PATH+1];
			char szPath[MAX_PATH+1];
			long widthpix, heightpix, width, height, x, y;
			HRESULT hr;
			GetCurrentDirectory(MAX_PATH, szPath);
			strcat(szPath, "\\");
			strcat(szPath, Filename);
			MultiByteToWideChar(CP_ACP, 0, szPath, -1, wszPath, MAX_PATH);

			hr = OleLoadPicturePath(wszPath, 0, 0, 0, IID_IPicture, (void**)&pPicture);
			if ( FAILED(hr) )
				return E_FAIL;

			hDCg = GetDC(NULL);
			hDC = CreateCompatibleDC(hDCg);
			pPicture->get_Width(&width);
			widthpix = MulDiv(width, GetDeviceCaps(hDC, LOGPIXELSX), 2540);
			pPicture->get_Height(&height);
			heightpix = MulDiv(height, GetDeviceCaps(hDC, LOGPIXELSY), 2540);

			BITMAPINFO bi = {0};
			BYTE *pBits = 0;

			bi.bmiHeader.biSize			= sizeof(BITMAPINFOHEADER);
			bi.bmiHeader.biBitCount		= 32;
			bi.bmiHeader.biWidth		= widthpix;
			bi.bmiHeader.biHeight		= heightpix;
			bi.bmiHeader.biCompression	= BI_RGB;
			bi.bmiHeader.biPlanes		= 1;

			hBMP = CreateDIBSection(hDC, &bi, DIB_RGB_COLORS, (void**)&pBits, 0, 0);

			if(!hBMP)
			{
				DeleteDC(hDC);
				pPicture->Release();
				return E_FAIL;
			}

			hBMPOld = (HBITMAP)SelectObject(hDC, hBMP);

			pPicture->Render(hDC, 0, 0, widthpix, heightpix, 0, height, width, -height, 0);

			byte* ppData = new byte[widthpix*heightpix*4];
			BYTE* data = ppData;
			BYTE* data2;

			for (y=0; y<heightpix; ++y)
			{
				data2 = pBits + (heightpix-y-1)*widthpix*4;
				for (x=0; x<widthpix; ++x)
				{
					CopyMemory(data, data2, 3);
					data[3] = 255;
					data += 4;
					data2 += 4;
				}
			}
			SelectObject(hDC, hBMPOld);
			DeleteObject(hBMP);
			DeleteDC(hDC);
			ReleaseDC(NULL, hDCg);
			pPicture->Release();

			pData = ppData;
			Width = widthpix;
			Height = heightpix;
		}

		BYTE *pSrc = pData;

		pSpr->pData = pData;
		pSpr->Pitch = Width * 4;
		pSpr->Size.cx = Width;
		pSpr->Size.cy = Height;
		return S_OK;

		if (Width > pSpr->Size.cx)
			Width = pSpr->Size.cx;
		if (Height > pSpr->Size.cy)
			Height = pSpr->Size.cy;

		delete[] pData;
		return S_OK;
	}
}
using namespace NS_LOADIMG;

HRESULT LoadSpriteFromFile(LPCSTR Filename, CSprite* pSpr, TRANSPIXELPROC Proc)
{
	HRESULT hr;
	SPRLOCKEDRECT RCLoad;
	if (FAILED(hr = LoadImageDataFromFile(Filename, &RCLoad)))
		return hr;

	if (Proc != NULL)
	{
		int Width = RCLoad.Size.cx;
		int Height = RCLoad.Size.cy;
		BYTE* pData = NULL;
		for (int y=0; y<Height; ++y)
		{
			pData = RCLoad.pData + Width * 4 * y;
			for (int x=0; x<Width; ++x)
			{
				Proc((DWORD*)pData, x==0&&y==0);
				pData += 4;
			}
		}
	}

	SPRLOCKEDRECT RCSpr;
	pSpr->Lock(&RCSpr);
	if (!RCSpr.pData)
	{
		int Width = 1;
		int Height = 1;
		while (Width < RCLoad.Size.cx)
			Width <<= 1;
		while (Height < RCLoad.Size.cy)
			Height <<= 1;

		if (FAILED(hr = pSpr->Initialize(Width, Height)))
		{
			delete []RCLoad.pData;
			return hr;
		}

		pSpr->Lock(&RCSpr);
	}
	if (zg_pRen->GetTextureQuality()==4)
		CopyBitmapRect4(&RCSpr, &RCLoad, &IRECT(0, 0, RCLoad.Size.cx, RCLoad.Size.cy));
	else if (zg_pRen->GetTextureQuality()==2)
		CopyBitmapRect2(&RCSpr, &RCLoad, &IRECT(0, 0, RCLoad.Size.cx, RCLoad.Size.cy));

	delete []RCLoad.pData;
	pSpr->Unlock();
	return hr;
}

HRESULT LoadSpriteDataFromFile(LPCSTR Filename, SPRLOCKEDRECT* pSpr, TRANSPIXELPROC Proc)
{
	HRESULT hr;
	SPRLOCKEDRECT RCLoad;
	if (FAILED(hr = LoadImageDataFromFile(Filename, &RCLoad)))
		return hr;

	if (Proc != NULL)
	{
		int Width = RCLoad.Size.cx;
		int Height = RCLoad.Size.cy;
		BYTE* pData = NULL;
		for (int y=0; y<Height; ++y)
		{
			pData = RCLoad.pData + Width * 4 * y;
			for (int x=0; x<Width; ++x)
			{
				Proc((DWORD*)pData, x==0&&y==0);
				pData += 4;
			}
		}
	}

	if (zg_pRen->GetTextureQuality()==4)
		CopyBitmapRect4(pSpr, &RCLoad, &IRECT(0, 0, RCLoad.Size.cx, RCLoad.Size.cy));
	else if (zg_pRen->GetTextureQuality()==2)
		CopyBitmapRect2(pSpr, &RCLoad, &IRECT(0, 0, RCLoad.Size.cx, RCLoad.Size.cy));

	delete []RCLoad.pData;
	return hr;
}
