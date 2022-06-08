
#pragma once

WORD Crc16(BYTE *Data, DWORD Len);
WORD CrcCcitt(BYTE *Data, DWORD Len);
DWORD Crc32(BYTE *Data, DWORD Len);

DWORD GetFileCRC(const char*);
