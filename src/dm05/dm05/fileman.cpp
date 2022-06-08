
#include <zsoo.h>
#include "fileman.h"

CFileManager::CFileManager()
{
	m_vpJukes.clear();
}

// 모든 쥬크박스를 검색하여 목록을 만든다
bool CFileManager::ListEveryJukebox()
{
	HANDLE hFile;
	WIN32_FIND_DATA FindData;
	UINT search_count = 0;
	while (1)
	{
		if (search_count==0)
		{
			hFile = (HANDLE)FindFirstFile("*.*", &FindData);
		}
		else if (FindNextFile(hFile, &FindData)==FALSE)
		{
			FindClose(hFile);
			break;
		}

		++search_count;
		if (!(FindData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY))
			continue;
		if (FindData.cFileName[0] == '.')
			continue;

		CJukebox* pJuke = new CJukebox(FindData.cFileName, this);

		SetCurrentDirectory(FindData.cFileName);
		if ( CheckFolders(pJuke) )
		{
			m_vpJukes.push_back(pJuke);
			AddLogString("새 쥬크박스 \"%s\"를 찾았습니다.\n", FindData.cFileName);
		}
		else
		{
			delete pJuke;
		}
		SetCurrentDirectory("..");
	}

	return !!m_vpJukes.size();
}

void CFileManager::UnloadAllJukebox()
{
	while (m_vpJukes.size())
	{
		m_vpJukes.back()->Unload();
		delete m_vpJukes.back();
		m_vpJukes.pop_back();
	}
}

DWORD CFileManager::GetJukeboxCount()
{
	return m_vpJukes.size();
}

CJukebox* CFileManager::GetJukebox(int i)
{
	while (i < 0)
		i += m_vpJukes.size();
	while (i >= (int)m_vpJukes.size())
		i -= m_vpJukes.size();

	return m_vpJukes[i];
}

bool CFileManager::CheckFolders(CJukebox* pJuke)
{
	HANDLE hFile;
	WIN32_FIND_DATA FindData;
	UINT search_count = 0;
	while (1)
	{
		if (search_count==0)
		{
			hFile = (HANDLE)FindFirstFile("*.*", &FindData);
		}
		else if (FindNextFile(hFile, &FindData)==FALSE)
		{
			FindClose(hFile);
			break;
		}

		++search_count;
		if (!(FindData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY))
			continue;
		if (FindData.cFileName[0] == '.')
			continue;

		SetCurrentDirectory(FindData.cFileName);
		CFolder folder(FindData.cFileName, NULL);
		if ( CheckFiles( &folder ) )
		{
			SetCurrentDirectory("..");
			FindClose(hFile);
			return true;
		}
		SetCurrentDirectory("..");
	}
	return false;
}

bool CFileManager::CheckFiles(CFolder* pFolder)
{
	HANDLE hFile;
	WIN32_FIND_DATA FindData;
	UINT search_count = 0;
	while (1)
	{
		if (search_count==0)
		{
			hFile = (HANDLE)FindFirstFile("*.ksf", &FindData);
		}
		else if (FindNextFile(hFile, &FindData)==FALSE)
		{
			FindClose(hFile);
			break;
		}

		++search_count;
		if (FindData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
			continue;
		if (FindData.cFileName[0] == '.')
			continue;

		FILE* fp = fopen(FindData.cFileName, "rb");
		if (fp)
		{
			fclose(fp);
			FindClose(hFile);
			return true;
		}
	}
	return false;
}
