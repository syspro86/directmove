
#include <cstdio>
#include <windows.h>
#include <string>
using namespace std;
#include "log.h"

#ifdef _DEBUG

void StartLog()
{
	AddLogString("Start Logging\n");
}

void AddLogString(const char* fmt, ...)
{
	va_list va;
	va_start(va, fmt);

	char buff[512];
	vsprintf(buff, fmt, va);
	OutputDebugString(buff);

	va_end(va);
}

void EndLog()
{
	AddLogString("End Logging\n");
}

#else

FILE * pLogFile;

void StartLog()
{
	pLogFile = fopen("log.txt", "wt");
}

void AddLogString(const char* fmt, ...)
{
	if (!pLogFile)
		return;

	va_list va;
	va_start(va, fmt);

	char buff[512];
	vsprintf(buff, fmt, va);
	fprintf(pLogFile, "%s", buff);

	va_end(va);
}

void EndLog()
{
	fclose(pLogFile);
	pLogFile = 0;
}

#endif
