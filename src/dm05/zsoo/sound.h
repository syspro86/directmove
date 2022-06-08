
#pragma once

class CSoundManager;
class CSound;

#include <windows.h>
#include <dsound.h>

class CSoundManager
{
public:
	friend class CSound;
	CSoundManager();
	~CSoundManager();

	HRESULT Initialize(HWND hWnd);
	HRESULT Release();

	HRESULT SetPrimaryBufferFormat(DWORD dwPrimaryChannels, DWORD dwPrimaryFreq, DWORD dwPrimaryBitRate);

private:
	LPDIRECTSOUND8 m_pDS;
};


class CSound
{
public:
	CSound();
	~CSound();

	HRESULT CreateFromFile(LPCSTR szFileName, DWORD dwCreationFlags = DSBCAPS_CTRLPAN|DSBCAPS_CTRLVOLUME, DWORD NumBuffer=1, BOOL bStreaming=FALSE);
	HRESULT CreateFromMemory();
	HRESULT Play(DWORD dwPriority = 0, DWORD dwFlags = 0, LONG lVolume = 0, LONG lFrequency = -1, LONG lPan = 0);
	HRESULT Pause();
	HRESULT Stop();
	HRESULT Release();

private:
	LPDIRECTSOUNDBUFFER8*	m_pBuffers;
	DWORD					m_dwNumBuffers;
	DWORD					m_dwBufferSize;
	DWORD					m_dwCreationFlags;
	WAVEFORMATEX			m_wfxFormat;
	BOOL					m_bStreaming;
	HMMIO					m_hMMIO;
};
