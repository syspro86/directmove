
#include <zsoo.h>
#include "files.h"
#include <zlib.h>
#include "crc.h"

CJukebox::CJukebox(const char* path, CFileManager* man)
:	m_pManager(man),
	m_strPath(path),
	m_bEvenActived(false)
{
}

bool CJukebox::Activate()
{
	if (m_bEvenActived)
		return true;

	SetCurrentDirectory(m_strPath.c_str());
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
		CFolder* pFolder = new CFolder(FindData.cFileName, this);;
		if ( pFolder->Active() )
		{
			AddFolder(pFolder);
		}
		else
		{
			delete pFolder;
		}
		SetCurrentDirectory("..");
	}
	SetCurrentDirectory("..");
	m_bEvenActived = true;
	return true;
}

void CJukebox::Unload()
{
	while (m_vpFolders.size())
	{
		m_vpFolders.back()->Unload();
		delete m_vpFolders.back();
		m_vpFolders.pop_back();
	}
}

void CJukebox::AddFolder(CFolder* pFolder)
{
	m_vpFolders.push_back(pFolder);
}

DWORD CJukebox::GetFolderCount()
{
	return m_vpFolders.size();
}

const char* CJukebox::GetPath()
{
	static char path[MAX_PATH];
	strcpy(path, m_strPath.c_str());
	return path;
}

CFolder* CJukebox::GetFolder(int iNum)
{
	while (iNum < 0)
		iNum += m_vpFolders.size();
	while (iNum >= (int)m_vpFolders.size())
		iNum -= m_vpFolders.size();

	return m_vpFolders[iNum];
}

CFolder::CFolder(const char* path, CJukebox* juke)
:	m_pParentJuke(juke),
	m_strPath(path)
{
	FILE* fp;
	if (fp = fopen("disc.bmp", "rb"))
	{	m_mssPath["Disc"] = "disc.bmp"; fclose(fp); }
	else if (fp = fopen("disc.png", "rb"))
	{	m_mssPath["Disc"] = "disc.png"; fclose(fp); }
	if (fp = fopen("title.bmp", "rb"))
	{	m_mssPath["Title"] = "title.bmp"; fclose(fp); }
	else if (fp = fopen("title.png", "rb"))
	{	m_mssPath["Title"] = "title.png"; fclose(fp); }
	if (fp = fopen("intro.mp3", "rb"))
	{	m_mssPath["Intro"] = "intro.mp3"; fclose(fp); }
	else if (fp = fopen("intro.wav", "rb"))
	{	m_mssPath["Intro"] = "intro.wav"; fclose(fp); }
	if (fp = fopen("song.mp3", "rb"))
	{	m_mssPath["Song"] = "song.mp3"; fclose(fp); }
	else if (fp = fopen("song.wav", "rb"))
	{	m_mssPath["Song"] = "song.wav"; fclose(fp); }
}

bool CFolder::Active()
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

		if (hFile == INVALID_HANDLE_VALUE)
			return false;

		++search_count;
		if (FindData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
			continue;
		if (FindData.cFileName[0] == '.')
			continue;

		FILE* fp = fopen(FindData.cFileName, "rb");
		if (fp)
		{
			CFile* pFile = new CFile(FindData.cFileName, this);;
			AddFile(pFile);
			fclose(fp);
		}
	}
	return true;
}

void CFolder::Unload()
{
	while (m_vpFiles.size())
	{
		m_vpFiles.back()->Unload();
		delete m_vpFiles.back();
		m_vpFiles.pop_back();
	}
	while (m_mstDisc.size())
	{
		m_mstDisc.begin()->second->Release();
		delete m_mstDisc.begin()->second;
		m_mstDisc.erase( m_mstDisc.begin() );
	}
}

void CFolder::AddFile(CFile* pFile)
{
	m_vpFiles.push_back(pFile);
}

DWORD CFolder::GetFileCount()
{
	return m_vpFiles.size();
}

CFile* CFolder::GetFile(int iNum)
{
	while (iNum < 0)
		iNum += m_vpFiles.size();
	while (iNum >= (int)m_vpFiles.size())
		iNum -= m_vpFiles.size();

	return m_vpFiles[iNum];
}

const char* CFolder::GetPath()
{
	static char path[MAX_PATH];
	strcpy(path, m_strPath.c_str());
	return path;
}

CJukebox* CFolder::GetJukebox()
{
	return m_pParentJuke;
}

const char* CFolder::GetDefaultElementFileName(const char* p)
{
	static char path[MAX_PATH];
	string str(p);
	strcpy(path, m_mssPath[str].c_str());
	return path;
}

CSprite* CFolder::AddDiscFile(const char* p)
{
	if (!strlen(p))
		return NULL;

	string str(p);
	strlwr(const_cast<char*>(str.c_str()));

	FILE* fp = fopen(p, "rb");
	if (!fp)
		return NULL;

	fclose(fp);
	fp = NULL;

	CSprite*& pTex = m_mstDisc[str];
	if (!pTex)
	{
		pTex = new CSprite;
		LoadSpriteFromFile(p, pTex, DelColorkey);
	}
	return pTex;
}

void CFolder::DelColorkey(DWORD* pColor, bool start)
{
	static DWORD Colorkey = 0;
	if (start)
		Colorkey = (*pColor) & 0x00ffffff;

	if (Colorkey == ((*pColor)&0x00ffffff))
		*pColor = 0;
}

CFile::CFile(const char* path, CFolder* fold)
:	m_pParentFolder(fold),
	m_strPath(path),
	m_pTexDisc(NULL)
{
	ZeroMemory(&m_Info, sizeof(m_Info));
	m_Info.Player = 1;

	if (stricmp(path, "double.ksf")==0)
		m_Info.Player = 2;

	char* FileNames[] = {"Disc", "Title", "Intro", "Song"};
	for (int i=0; i<(sizeof FileNames / sizeof (char*)); ++i)
	{
		string str = FileNames[i];
		m_mssPath[str] = fold->GetDefaultElementFileName(FileNames[i]);
	}

	ifstream ifs;
	ifs.open(path, ios_base::in);
	if (!ifs.is_open())
		return;

	string lline(1024, '\0');
	while (ifs.getline( &lline[0], 1023 ))
	{
		string line = &lline[0];
		if (line[0] != '#')
			continue;

		size_t pos = line.find_first_of(":");
		if (pos < line.length())
		{
			if (line.find("#STEP:") < line.length())
				break;

			string tag( &line[1], &line[pos] );
			string value( &line[pos+1] );
			pos = value.find_last_of(';');
			if (pos < value.length())
				value.erase( &value[pos], value.end() );

			if (tag == "TITLE")
				strcpy(m_Info.Title, value.c_str());
			else if (tag == "BPM")
				m_Info.BPM = (float)atof(value.c_str());
			else if (tag == "PLAYER")
			{
				if (value == "SINGLE")
					m_Info.Player = 1;
				else if (value == "DOUBLE")
					m_Info.Player = 2;
			}
			else if (tag == "DISCFILE")
				m_mssPath["Disc"] = value;
			else if (tag == "TITLEFILE")
				m_mssPath["Title"] = value;
			else if (tag == "INTROFILE")
				m_mssPath["Intro"] = value;
			else if (tag == "SONGFILE")
				m_mssPath["Song"] = value;
		}
	}
	BOOL Long[10] = {FALSE};
	while (ifs.getline( &lline[0], 1023 ))
	{
		string line = &lline[0];
		if (line[0] == '|' && line[line.length()-1] == '|');
		else if (line[0] == '#');
		else if (line.length() == 13)
		{
			for (int i=0; i<m_Info.Player*5; ++i)
			{
				int a = line[i]-'0';
				if (a == 1)
				{
					++m_Info.StepCount;
					Long[i] = FALSE;
				}
				else if (a == 4)
				{
#ifdef PENIL
					++m_Info.StepCount;
#else
					if (!Long[i])
					{
						++m_Info.StepCount;
						Long[i] = TRUE;
					}
#endif
				}
				else
					Long[i] = FALSE;
			}
		}
	}
	ifs.close();
	ifs.clear();

	m_CRC = GetFileCRC(path);

	string name = path;
	name.erase(name.length()-3, 3);
	name += "dmscore";

	ifs.open(name.c_str(), ios_base::in | ios_base::binary);
	if (ifs.is_open())
	{
		DWORD filesize, uncompsize;
		ifs.clear();
		ifs.seekg(0, ios_base::end);
		filesize = ifs.tellg();
		ifs.seekg(0, ios_base::beg);

		BYTE* pSrc = new BYTE[filesize];
		ifs.read((char*)pSrc, filesize);
		ifs.close();

		uncompsize = 512 * 1024;
		BYTE* pDest = new BYTE[uncompsize];
		uncompress(pDest, &uncompsize, pSrc, filesize);

		DWORD count = ((DWORD*)pDest)[0];
		DWORD offset = 4 + sizeof(RANK) * count;

		DWORD ksfsize = uncompsize - offset;
		ifs.open(path, ios_base::in | ios_base::binary);
		ifs.clear();
		ifs.seekg(0, ios_base::end);
		filesize = ifs.tellg();
		ifs.seekg(0, ios_base::beg);

		if (ksfsize == filesize)
		{
			bool fail = false;
			BYTE* pKSF = new BYTE[ksfsize];
			ifs.read((char*)pKSF, ksfsize);

			BYTE *comp1 = pDest+offset, *comp2 = pKSF;
			while (ksfsize--)
			{
				if (*comp1++ != *comp2++)
				{
					fail = true;
					break;
				}
			}
			delete []pKSF;
			if (fail==false)
			{
				m_vRank.insert(m_vRank.end(), (RANK*)(pDest+4), (RANK*)(pDest+offset));
			}
		}

		delete []pSrc;
		delete []pDest;
	}

	m_pTexDisc = m_pParentFolder->AddDiscFile(m_mssPath["Disc"].c_str());
}

void CFile::Unload()
{
	m_mssPath.clear();
}

const char* CFile::GetPath()
{
	static char path[MAX_PATH];
	strcpy(path, m_strPath.c_str());
	return path;
}

CFolder* CFile::GetFolder()
{
	return m_pParentFolder;
}

bool CFile::GetInformation(INFORMATION* p)
{
	CopyMemory(p, &m_Info, sizeof(m_Info));
	return true;
}

bool CFile::IsDouble()
{
	return m_Info.Player==2;
}

CSprite* CFile::GetDiscSprite()
{
	if (m_pTexDisc)
		return m_pTexDisc;
	else
		return zg_mSpr["Nodisc"];
}

const char* CFile::GetTitlePath()
{
	static char path[MAX_PATH];
	strcpy(path, m_mssPath["Title"].c_str());
	return path;
}

CMusic* CFile::GetIntroMusic(CMusic* pMusic)
{
	if (!pMusic)
		pMusic = new CMusic;

	pMusic->Create();
	if ( FAILED(pMusic->Open(m_mssPath["Intro"].c_str())) )
	{
		pMusic->Release();
		return NULL;
	}
	return pMusic;
}

CMusic* CFile::GetBackGroundMusic(CMusic* pMusic)
{
	if (!pMusic)
		pMusic = new CMusic;

	pMusic->Create();
	if ( FAILED(pMusic->Open(m_mssPath["Song"].c_str())) )
	{
		pMusic->Release();
		return NULL;
	}
	return pMusic;
}

void CFile::AddRank(RANK* r)
{
	if (m_vRank.size() < 10)
	{
		m_vRank.push_back(*r);
	}
	else
	{
		if (m_vRank.back().TOTAL < r->TOTAL)
		{
			m_vRank.pop_back();
			m_vRank.push_back(*r);
		}
		else
			return;
	}

	sort(m_vRank.begin(), m_vRank.end());

	SetCurrentDirectory( GetFolder()->GetJukebox()->GetPath() );
	SetCurrentDirectory( GetFolder()->GetPath() );
	string name = GetPath();

	DWORD ksfsize, ranksize;
	ifstream ifs;
	ifs.open(name.c_str(), ios_base::in | ios_base::binary);
	ifs.seekg(0, ios_base::end);
	ksfsize = ifs.tellg();
	ifs.seekg(0, ios_base::beg);
	ranksize = sizeof(RANK) * m_vRank.size() + 4;

	BYTE* pSrc = new BYTE[ksfsize+ranksize];
	((DWORD*)pSrc)[0] = m_vRank.size();
	CopyMemory(pSrc+4, &m_vRank[0], ranksize);
	ifs.read((char*)pSrc+ranksize, ksfsize);
	ifs.close();

	name.erase(name.length()-3, 3);
	name += "dmscore";

	ofstream ofs;
	ofs.open(name.c_str(), ios_base::out | ios_base::binary);

	DWORD filesize = (ksfsize+ranksize)*2;
	BYTE* pDest = new BYTE[filesize];
	compress(pDest, &filesize, pSrc, ksfsize+ranksize);
	ofs.write((char*)pDest, filesize);
	ofs.close();

	delete []pSrc;
	delete []pDest;
	SetCurrentDirectory("..\\..");
}

const vector<CFile::RANK>* CFile::GetRankData()
{
	return &m_vRank;
}

DWORD CFile::GetCRC()
{
	return m_CRC;
}
