
#pragma once

class CJukebox;
class CFolder;
class CFile;

class CFileManager;

#include <windows.h>
#include <renderer.h>
#include <music.h>

class CJukebox
{
public:
	CJukebox(const char*, CFileManager*);
	bool	Activate();
	void	Unload();
	void	AddFolder(CFolder*);
	DWORD	GetFolderCount();
	CFolder*GetFolder(int);
	const char* GetPath();

private:
	CFileManager* m_pManager;
	vector<CFolder*> m_vpFolders;
	string m_strPath;
	bool m_bEvenActived;
};

class CFolder
{
public:
	CFolder(const char*, CJukebox*);
	bool	Active();
	void	Unload();
	void	AddFile(CFile*);
	DWORD	GetFileCount();
	CFile*	GetFile(int);
	const char*	GetPath();
	CJukebox* GetJukebox();
	const char*	GetDefaultElementFileName(const char*);
	CSprite*	AddDiscFile(const char*);

	static void DelColorkey(DWORD*, bool);

private:
	CJukebox* m_pParentJuke;
	vector<CFile*> m_vpFiles;
	map<string, CSprite*> m_mstDisc;
	string m_strPath;
	map<string, string> m_mssPath;
};

class CFile
{
public:
	struct INFORMATION
	{
		char Title[256];
		char Artist[64];
		float BPM;
		int StepCount;
		int Player;
	};
	struct RANK
	{
		DWORD KSFCode;
		DWORD ScoreCode;
		char ID[8];
		int EXORBITANT;
		int PERFECT;
		int GREAT;
		int GOOD;
		int BAD;
		int MISS;
		int MAXCOMBO;
		int TOTAL;
		BOOL Fade;
		BOOL Rush;
		BOOL Random;
		BOOL XXX;

		bool operator < (const RANK& r)
		{
			return TOTAL > r.TOTAL;
		}
	};

	CFile(const char*, CFolder*);
	void Unload();
	const char* GetPath();
	CFolder* GetFolder();
	bool GetInformation(INFORMATION*);
	bool IsDouble();
	CSprite* GetDiscSprite();
	const char* GetTitlePath();
	CMusic* GetIntroMusic(CMusic*);
	CMusic* GetBackGroundMusic(CMusic*);
	void AddRank(RANK*);
	const vector<RANK>* GetRankData();
	DWORD GetCRC();

private:
	CFolder* m_pParentFolder;
	string m_strPath;
	map<string, string> m_mssPath;
	CSprite* m_pTexDisc;
	INFORMATION m_Info;
	vector<RANK> m_vRank;
	DWORD m_CRC;
};
