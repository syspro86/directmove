 
#include "zsoo.h"
#include "sound.h"

#pragma comment(lib, "dsound")

namespace NS_SOUND
{
	CSoundManager* g_pSndMngr = NULL;
}
using namespace NS_SOUND;

CSoundManager::CSoundManager()
{
	g_pSndMngr = this;
}

CSoundManager::~CSoundManager()
{

}

HRESULT CSoundManager::Initialize(HWND hWnd)
{
	HRESULT hr;

	if( FAILED(hr = DirectSoundCreate8(NULL, &m_pDS, NULL)) )
		return hr;

	if( FAILED(hr = m_pDS->SetCooperativeLevel(hWnd, DSSCL_PRIORITY)) )
		return hr;

	return S_OK;
}

HRESULT CSoundManager::Release()
{
	if (m_pDS)
	{
		m_pDS->Release();
		m_pDS = NULL;
	}
	else
		return E_FAIL;

	return S_OK;
}

HRESULT CSoundManager::SetPrimaryBufferFormat(DWORD dwPrimaryChannels, DWORD dwPrimaryFreq, DWORD dwPrimaryBitRate)
{
	HRESULT hr;
	LPDIRECTSOUNDBUFFER pDSBPrimary = NULL;
	
	if(m_pDS == NULL)
		return CO_E_NOTINITIALIZED;

	// Get the primary buffer
	DSBUFFERDESC dsbd;
	ZeroMemory(&dsbd, sizeof(DSBUFFERDESC));
	dsbd.dwSize        = sizeof(DSBUFFERDESC);
	dsbd.dwFlags       = DSBCAPS_PRIMARYBUFFER;
	dsbd.dwBufferBytes = 0;
	dsbd.lpwfxFormat   = NULL;

	if( FAILED(hr = m_pDS->CreateSoundBuffer(&dsbd, &pDSBPrimary, NULL)) )
		return hr;

	WAVEFORMATEX wfx;
	ZeroMemory(&wfx, sizeof(WAVEFORMATEX));
	wfx.wFormatTag      = (WORD) WAVE_FORMAT_PCM;
	wfx.nChannels       = (WORD) dwPrimaryChannels;
	wfx.nSamplesPerSec  = (DWORD) dwPrimaryFreq;
	wfx.wBitsPerSample  = (WORD) dwPrimaryBitRate;
	wfx.nBlockAlign     = (WORD) (wfx.wBitsPerSample / 8 * wfx.nChannels);
	wfx.nAvgBytesPerSec = (DWORD) (wfx.nSamplesPerSec * wfx.nBlockAlign);

	if( FAILED( hr = pDSBPrimary->SetFormat(&wfx) ) )
		return hr;

	pDSBPrimary->Release();
	pDSBPrimary = NULL;

	return S_OK;
}

CSound::CSound()
{

}

CSound::~CSound()
{

}

HRESULT CSound::CreateFromFile(LPCSTR szFileName, DWORD dwCreationFlags, DWORD NumBuffer, BOOL bStreaming)
{
	m_dwNumBuffers = NumBuffer;
	m_pBuffers = new LPDIRECTSOUNDBUFFER8[m_dwNumBuffers];
	ZeroMemory(m_pBuffers, sizeof(LPDIRECTSOUNDBUFFER8) * m_dwNumBuffers);
	m_bStreaming = FALSE/*bStreaming*/;

	m_hMMIO = mmioOpen(const_cast<char*>(szFileName), NULL, MMIO_ALLOCBUF|MMIO_READ);
	if (!m_hMMIO)
		return E_FAIL;

	MMCKINFO      ck;
	MMCKINFO      ckRiff;
	WAVEFORMATEX* pwfx;
	try
	{
		MMCKINFO      ckIn;
		PCMWAVEFORMAT pcmWaveFormat;

		pwfx = NULL;

		if ( (0 != mmioDescend(m_hMMIO, &ckRiff, NULL, 0)) )
			throw;

		if ( (ckRiff.ckid != FOURCC_RIFF) || (ckRiff.fccType != mmioFOURCC('W', 'A', 'V', 'E') ) )
			throw;

		ckIn.ckid = mmioFOURCC('f', 'm', 't', ' ');
		if (0 != mmioDescend(m_hMMIO, &ckIn, &ckRiff, MMIO_FINDCHUNK))
			throw;

		if (ckIn.cksize < (LONG) sizeof(PCMWAVEFORMAT))
			throw;

		if (mmioRead(m_hMMIO, (HPSTR) &pcmWaveFormat, sizeof(pcmWaveFormat)) != sizeof(pcmWaveFormat))
			throw;

		if (pcmWaveFormat.wf.wFormatTag == WAVE_FORMAT_PCM)
		{
			pwfx = (WAVEFORMATEX*)new CHAR[sizeof(WAVEFORMATEX)];
			if(NULL == pwfx)
				throw;

			memcpy(pwfx, &pcmWaveFormat, sizeof(pcmWaveFormat));
			pwfx->cbSize = 0;
		}
		else
		{
			WORD cbExtraBytes = 0L;
			if (mmioRead(m_hMMIO, (CHAR*)&cbExtraBytes, sizeof(WORD)) != sizeof(WORD))
				throw;

			pwfx = (WAVEFORMATEX*)new CHAR[sizeof(WAVEFORMATEX) + cbExtraBytes];
			if (NULL == pwfx)
				throw;

			memcpy(pwfx, &pcmWaveFormat, sizeof(pcmWaveFormat));
			pwfx->cbSize = cbExtraBytes;

			if (mmioRead(m_hMMIO, (CHAR*)(((BYTE*)&(pwfx->cbSize))+sizeof(WORD)),
				cbExtraBytes ) != cbExtraBytes)
			{
				if (pwfx)
				{
					delete pwfx;
					pwfx = NULL;
				}
				throw;
			}
		}

		if (0 != mmioAscend(m_hMMIO, &ckIn, 0))
		{
			if (pwfx)
			{
				delete pwfx;
				pwfx = NULL;
			}
			throw;
		}

		if (-1 == mmioSeek(m_hMMIO, ckRiff.dwDataOffset + sizeof(FOURCC), SEEK_SET))
			throw;

		ck.ckid = mmioFOURCC('d', 'a', 't', 'a');
		if (0 != mmioDescend(m_hMMIO, &ck, &ckRiff, MMIO_FINDCHUNK))
			throw;
	}
	catch (void*)
	{
		mmioClose(m_hMMIO, 0);
		m_hMMIO = NULL;
		return E_FAIL;
	}

	HRESULT hr;
	DSBUFFERDESC dsbd;
	LPDIRECTSOUNDBUFFER pDSBuffer;
	ZeroMemory(&dsbd, sizeof(DSBUFFERDESC));
	dsbd.dwSize          = sizeof(DSBUFFERDESC);
	dsbd.dwFlags         = dwCreationFlags;
	dsbd.dwBufferBytes   = ck.cksize;
	dsbd.guid3DAlgorithm = GUID_NULL;
	dsbd.lpwfxFormat     = pwfx;

	if ( FAILED(hr = g_pSndMngr->m_pDS->CreateSoundBuffer(&dsbd, &pDSBuffer, NULL)) )
		return hr;
	delete []pwfx;

	if ( FAILED(hr = pDSBuffer->QueryInterface(IID_IDirectSoundBuffer8, (void**)&m_pBuffers[0])) )
		return hr;

	m_dwBufferSize = ck.cksize;
	VOID* pDSLockedBuffer      = NULL;
	DWORD dwDSLockedBufferSize = 0;
	if ( FAILED(hr = m_pBuffers[0]->Lock(0, m_dwBufferSize, &pDSLockedBuffer, &dwDSLockedBufferSize, NULL, NULL, 0)) )
		return hr;

	if (m_dwBufferSize != dwDSLockedBufferSize)
		return E_FAIL;

	BYTE* pBuffer = (BYTE*)pDSLockedBuffer;
	MMIOINFO mmioinfoIn;
	if (0 != mmioGetInfo(m_hMMIO, &mmioinfoIn, 0))
		return E_FAIL;
	for (DWORD cT = 0; cT < m_dwBufferSize; cT++)
	{
		if (mmioinfoIn.pchNext == mmioinfoIn.pchEndRead)
		{
			if (0 != mmioAdvance(m_hMMIO, &mmioinfoIn, MMIO_READ))
				return E_FAIL;

			if (mmioinfoIn.pchNext == mmioinfoIn.pchEndRead)
				return E_FAIL;
		}
		*((BYTE*)pBuffer+cT) = *((BYTE*)mmioinfoIn.pchNext);
		mmioinfoIn.pchNext++;
	}

	if (0 != mmioSetInfo(m_hMMIO, &mmioinfoIn, 0))
		return E_FAIL;

	m_pBuffers[0]->Unlock(pDSLockedBuffer, dwDSLockedBufferSize, NULL, 0);
	return S_OK;
}

HRESULT CSound::CreateFromMemory()
{
	return E_FAIL;
}

HRESULT CSound::Play(DWORD dwPriority, DWORD dwFlags, LONG lVolume, LONG lFrequency, LONG lPan)
{
	if (m_pBuffers)
	{
		for (DWORD dwNum = 0; dwNum < m_dwNumBuffers; ++dwNum)
		{
			if (m_pBuffers[dwNum])
			{
				if (m_dwCreationFlags & DSBCAPS_CTRLVOLUME)
					m_pBuffers[dwNum]->SetVolume(lVolume);

				if (lFrequency != -1 && (m_dwCreationFlags & DSBCAPS_CTRLFREQUENCY))
					m_pBuffers[dwNum]->SetFrequency(lFrequency);

				if (m_dwCreationFlags & DSBCAPS_CTRLPAN)
					m_pBuffers[dwNum]->SetPan(lPan);

				if (SUCCEEDED(m_pBuffers[dwNum]->Play(0, dwPriority, dwFlags)))
					return S_OK;
			}
		}
	}
	return E_FAIL;
}

HRESULT CSound::Pause()
{
	HRESULT hr = 0;

	for (DWORD i=0; i<m_dwNumBuffers; ++i)
	{
		if (m_pBuffers[i])
		{
			hr |= m_pBuffers[i]->Stop();
		}
	}

	return hr;
}

HRESULT CSound::Stop()
{
	HRESULT hr = 0;

	for (DWORD i=0; i<m_dwNumBuffers; ++i)
	{
		if (m_pBuffers[i])
		{
			hr |= m_pBuffers[i]->Stop();
			hr |= m_pBuffers[i]->SetCurrentPosition(0);
		}
	}

	return hr;
}

HRESULT CSound::Release()
{
	Stop();
	HRESULT hr = 0;

	for (DWORD i=0; i<m_dwNumBuffers; ++i)
	{
		if (m_pBuffers[i])
		{
			hr |= m_pBuffers[i]->Release();
			m_pBuffers[i] = NULL;
		}
	}
	delete []m_pBuffers;
	m_pBuffers = NULL;

	return hr;
}
