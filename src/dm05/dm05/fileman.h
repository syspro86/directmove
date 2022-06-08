
#pragma once

class CFileMangager;

#include "files.h"

class CFileManager
{
public:
	CFileManager();
	bool ListEveryJukebox();
	void UnloadAllJukebox();

	DWORD GetJukeboxCount();
	CJukebox* GetJukebox(int);

private:
	bool CheckFolders(CJukebox*);
	bool CheckFiles(CFolder*);

private:
	vector<CJukebox*> m_vpJukes;
};
