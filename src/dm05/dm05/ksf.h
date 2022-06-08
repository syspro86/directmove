
#pragma once

class CKsf;

namespace KSF
{
	enum STEPINFO_TYPE {
		STEPINFO_STEP = 0,
		STEPINFO_BPM,
		STEPINFO_TICK,
		STEPINFO_DELAY,
		STEPINFO_DELAYBEAT,
		STEPINFO_UNKNOWN,
		STEPINFO_FORCE_DWORD = 0x7fffffff
	};

	enum KSF_PLAYER_TYPE {
		KSF_SINGLE1P = 0,
		KSF_SINGLE2P,
		KSF_DOUBLE,
		KSF_AUTO,
		KSF_FORCE_DWORD = 0x7fffffff
	};

	enum NOTE_TYPE {
		NOTE_NONE = 0,				// 0x00000000 없다
		NOTE_NOTE = 1,				// 0x00000001 일반 노트다
		NOTE_LSTART = 6,			// 0x00000110 롱노트의 시작
		NOTE_LNOTE = 2,				// 0x00000010 롱노트중간
		NOTE_LEND = 10,				// 0x00001010 롱노트 끝
		NOTE_LSTART_PRESS = 22,		// 0x00010110 롱노트 시작인데 눌렸네
		NOTE_LEND_PRESS = 26,		// 0x00011010 롱노트 끝인데 눌렸다
		NOTE_NOTE_MISS = 33,		// 0x00100001 미스난 노트
		NOTE_LSTART_MISS = 38,		// 0x00100110 미스난 롱노트 시작
		NOTE_LEND_MISS = 42,		// 0x00101010 미스난 롱노트 끝

		// 체크 법!
		NOTE_NOTE_CHK = NOTE_NOTE,	// 0x00000001
		NOTE_LONG_CHK = NOTE_LNOTE,	// 0x00000010
		NOTE_START_CHK = 4,			// 0x00000100
		NOTE_END_CHK = 8,			// 0x00001000
		NOTE_PRESS_CHK = 16,		// 0x00010000
		NOTE_MISS_CHK = 32,			// 0x00100000
		NOTE_FORCE_DWORD = 0x7fffffff
	};
};

using namespace KSF;

class CKsf
{
public:
	friend class CPlayer;
	friend class CSinglePlayer;
	friend class CAutoPlayer;

	struct LINE
	{
		BYTE step[10];
	};
	struct PATTERN
	{
		PATTERN()
		{
			timePos = timeLen = timeDelay = 0;
			iTick = iLastMissCheck = 0;
			fBPM = 0;
			vLine.clear();
		}
		long timePos; // 음악상 위치
		long timeLen; // 음악상 길이
		long timeDelay; // 딜레이, (딜레이 패턴은 비어있음..)
		int iTick; // 틱카운트
		int iLastMissCheck;	//마지막으로 미스를체크한 번호
		float fBPM; // BPM
		vector<LINE> vLine; // :)
	};

	~CKsf();
	HRESULT Load(LPCSTR filename, KSF_PLAYER_TYPE player = KSF_AUTO);
	void MakeRandom();

	CKsf& operator = (const CKsf& ksf);

private:
	long GetPtnTimePos(float BPM, long start, long bunki, int tick);
	int GetCuttingPos(float BPM, long start, long bunki, long max, int tick);

private:
	vector<PATTERN*> m_vPtns;
	int m_PLAYER_TYPE;
};
