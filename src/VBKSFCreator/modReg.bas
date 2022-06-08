Attribute VB_Name = "modReg"
Option Explicit

' REG_QWORD 를 위한 정의
Public Type LARGE_INTEGER
    LowPart As Long
    HighPart As Long
End Type

' 레지스트리 API 함수.

' 값 형 상수
Public Const REG_NONE = 0                        ' No value type
Public Const REG_SZ = 1                          ' NULL 로 끝나는 유니코드 문자열
Public Const REG_EXPAND_SZ = 2                   ' NULL 로 끝나는 유니코드 문자열
Public Const REG_BINARY = 3                      ' 2진 형식
Public Const REG_DWORD = 4                       ' 32-bit 숫자
Public Const REG_DWORD_LITTLE_ENDIAN = 5         ' 32-bit 숫자 (REG_DWORD)
'Public Const REG_DWORD_LITTLE_ENDIAN = 4         ' 32-bit 숫자 (REG_DWORD)
'Public Const REG_DWORD_BIG_ENDIAN = 5            ' 32-bit 숫자 (만들어 봤는데. 실제 Big_Endian 형식은 없었음.(대신 QWORD 를 발견)
Public Const REG_LINK = 6                        ' Symbolic Link (unicode)
Public Const REG_MULTI_SZ = 7                    ' 다중라인 유니코드 문자열
Public Const REG_RESOURCE_LIST = 8               ' Resource list in the resource map
Public Const REG_FULL_RESOURCE_DESCRIPTOR = 9    ' Resource list in the hardware description
Public Const REG_RESOURCE_REQUIREMENTS_LIST = 10 ' Resource

Public Const REG_QWORD = 11                      ' QWORD ' 우연히 발견한 형식

Public Enum rType
   [R_NONE] = REG_NONE                                             ' No value type
   [R_SZ] = REG_SZ                                                 ' Unicode nul terminated string
   [R_EXPAND_SZ] = REG_EXPAND_SZ                                   ' Unicode nul terminated string
   [R_BINARY] = REG_BINARY                                         ' Free form binary
   [R_DWORD] = REG_DWORD                                           ' 32-bit number
   [R_DWORD_LITTLE_ENDIAN] = REG_DWORD_LITTLE_ENDIAN               ' 32-bit number (same as REG_DWORD)
'   [R_DWORD_BIG_ENDIAN] = REG_DWORD_BIG_ENDIAN                     ' 32-bit number
   [R_LINK] = REG_LINK                                             ' Symbolic Link (unicode)
   [R_MULTI_SZ] = REG_MULTI_SZ                                     ' Multiple Unicode strings
   [R_RESOURCE_LIST] = REG_RESOURCE_LIST                           ' Resource list in the resource map
   [R_FULL_RESOURCE_DESCRIPTOR] = REG_FULL_RESOURCE_DESCRIPTOR     ' Resource list in the hardware description
   [R_RESOURCE_REQUIREMENTS_LIST] = REG_RESOURCE_REQUIREMENTS_LIST
   [R_QWORD] = REG_QWORD
End Enum

' 루트키 정의
Public Const HKEY_CLASSES_ROOT = &H80000000
Public Const HKEY_CURRENT_USER = &H80000001
Public Const HKEY_LOCAL_MACHINE = &H80000002
Public Const HKEY_USERS = &H80000003
Public Const HKEY_PERFORMANCE_DATA = &H80000004
Public Const HKEY_CURRENT_CONFIG = &H80000005
Public Const HKEY_DYN_DATA = &H80000006

Public Enum rRootKey
   [HK_CLASSES_ROOT] = HKEY_CLASSES_ROOT         'stores OLE class information and file associations
   [HK_CURRENT_USER] = HKEY_CURRENT_USER         'stores program information for the current user.
   [HK_LOCAL_MACHINE] = HKEY_LOCAL_MACHINE       'stores program information for all users
   [HK_CURRENT_CONFIG] = HKEY_CURRENT_CONFIG     'stores computer configuration information
   [HK_USERS] = HKEY_USERS                       'has all the information for any user (not just the one provided by HKEY_CURRENT_USER)
   [HK_PERFORMANCE_DATA] = HKEY_PERFORMANCE_DATA 'Windows NT / 2000: HKEY_PERFORMANCE_DATA
   [HK_DYN_DATA] = HKEY_DYN_DATA                 'Windows 95 / 98: HKEY_DYN_DATA
End Enum

Private Const REG_OPTION_BACKUP_RESTORE = 4      ' open for backup or restore
Private Const REG_OPTION_VOLATILE = 1            ' Key is not preserved when system is rebooted
Private Const REG_OPTION_NON_VOLATILE = 0        ' Key is preserved when system is rebooted

Private Const REG_NOTIFY_CHANGE_NAME = &H1       ' Create or delete (child)
Private Const REG_NOTIFY_CHANGE_ATTRIBUTES = &H2
Private Const REG_NOTIFY_CHANGE_LAST_SET = &H4   ' time stamp
Private Const REG_NOTIFY_CHANGE_SECURITY = &H8
Private Const REG_NOTIFY_ALL = (REG_NOTIFY_CHANGE_NAME Or REG_NOTIFY_CHANGE_ATTRIBUTES Or REG_NOTIFY_CHANGE_LAST_SET Or REG_NOTIFY_CHANGE_SECURITY)

' No rhyme or reason for making some private and some public. Use your own discretion...
Private Const TOKEN_QUERY As Long = &H8&
Private Const TOKEN_ADJUST_PRIVILEGES As Long = &H20&
Private Const SE_PRIVILEGE_ENABLED As Long = &H2
Private Const SE_RESTORE_NAME = "SeRestorePrivilege" 'Important for what we're trying to accomplish
Private Const SE_BACKUP_NAME = "SeBackupPrivilege"

Private Const REG_FORCE_RESTORE As Long = 8&         ' Almost as import, will allow you to restore over a key while it's open!
Private Const SYNCHRONIZE = &H100000

Private Const READ_CONTROL = &H20000
Private Const STANDARD_RIGHTS_READ = (READ_CONTROL)
Private Const STANDARD_RIGHTS_WRITE = (READ_CONTROL)
Private Const STANDARD_RIGHTS_ALL = &H1F0000
Private Const SPECIFIC_RIGHTS_ALL = &HFFFF

Private Const KEY_QUERY_VALUE = &H1
Private Const KEY_SET_VALUE = &H2
Private Const KEY_CREATE_SUB_KEY = &H4
Private Const KEY_ENUMERATE_SUB_KEYS = &H8
Private Const KEY_NOTIFY = &H10
Private Const KEY_CREATE_LINK = &H20

Private Const KEY_READ = ((STANDARD_RIGHTS_READ Or KEY_QUERY_VALUE Or KEY_ENUMERATE_SUB_KEYS Or KEY_NOTIFY) And (Not SYNCHRONIZE))
Private Const KEY_WRITE = ((STANDARD_RIGHTS_WRITE Or KEY_SET_VALUE Or KEY_CREATE_SUB_KEY) And (Not SYNCHRONIZE))
Private Const KEY_EXECUTE = (KEY_READ)
Private Const KEY_ALL_ACCESS = ((STANDARD_RIGHTS_ALL Or KEY_QUERY_VALUE Or KEY_SET_VALUE Or KEY_CREATE_SUB_KEY Or KEY_ENUMERATE_SUB_KEYS Or KEY_NOTIFY Or KEY_CREATE_LINK) And (Not SYNCHRONIZE))

' 레지스트리 오류 리턴값 상수
'#If Win16 Then
Private Const ERROR_SUCCESS = 0&
Private Const ERROR_NONE = 0
Private Const ERROR_BADDB = 1
Private Const ERROR_BADKEY = 2
Private Const ERROR_CANTOPEN = 3
Private Const ERROR_CANTREAD = 4
Private Const ERROR_CANTWRITE = 5
Private Const ERROR_OUTOFMEMORY = 6
Private Const ERROR_ARENA_TRASHED = 7
Private Const ERROR_ACCESS_DENIED = 8
Private Const ERROR_INVALID_PARAMETERS = 87
Private Const ERROR_NO_MORE_ITEMS = 259
'
'#ElseIf Win32 Then
'' NO_ERROR
'Private Const NO_ERROR = 0 '  dderror
'' 환경 설정 레지스트리 데이터베이스 작업을 성공적으로 완료하였습니다.
'Private Const ERROR_SUCCESS = 0&
''   존재하지 않는 토큰을 참조하려 합니다.
'Private Const ERROR_NO_TOKEN = 1008&
''   환경 설정 레지스트리 데이터베이스가 손상됩니다.
'Private Const ERROR_BADDB = 1009&
''   환경 설정 레지스트리 키가 잘못되었습니다.
'Private Const ERROR_BADKEY = 1010&
''   환경 설정 레지스트리 키를 열 수 없습니다.
'Private Const ERROR_CANTOPEN = 1011&
''   환경 설정 레지스트리 키를 읽을 수 없습니다.
'Private Const ERROR_CANTREAD = 1012&
''   환경 설정 레지스트리 키를 쓸 수 없습니다.
'Private Const ERROR_CANTWRITE = 1013&
''   사용할 수 있는 저장 장소가 충분하지 않아 이 작업을 완료할 수 없습니다.
'Private Const ERROR_OUTOFMEMORY = 14&
''   로그나 대체 복사를 사용하여 레지스트리 데이터베이스의 파일 중
''   하나를 복구해야 합니다. 성공적으로 복구되었습니다.
'Private Const ERROR_REGISTRY_RECOVERED = 1014&
''   액세스할 수 없습니다.
'Private Const ERROR_ACCESS_DENIED = 5&
''   핸들이 잘못되었습니다.
'Private Const ERROR_INVALID_HANDLE = 6&
''   저장 컨트롤 블럭이 손상되었습니다.
'Private Const ERROR_ARENA_TRASHED = 7&
''   레지스트리가 손상되었습니다. 레지스트리 데이터를 갖고 있는
''   파일 중 한 파일의 구조가 손상되었거나 메모리에 있는 파일의
''   시스템 이미지가 손상된 경우 또는 대체 복사나 로그가 없다거나
''   손상되어 파일을 복구할 수 없습니다.
'Private Const ERROR_REGISTRY_CORRUPT = 1015&
''   매개 변수가 잘못되었습니다.
'Private Const ERROR_INVALID_PARAMETER = 87 '  dderror
''   더 이상 사용할 수 있는 데이터가 없습니다.
'Private Const ERROR_NO_MORE_ITEMS = 259&
''   레지스트리에서 초기화한 I/O 작업은 실패하여 복구할 수 없습니다.
''   레지스트리는 레지스트리의 시스템 이미지를 갖는 파일 중 하나를
''   읽어 들이거나 쓰거나 또는 지울 수 없습니다.
'Private Const ERROR_REGISTRY_IO_FAILED = 1016&
''   시스템에서 레지스트리 안으로 파일을 불러오거나 복원하려 했지만
''   지정된 파일이 레지스트리 파일 유형에 없습니다.
'Private Const ERROR_NOT_REGISTRY_FILE = 1017&
''   삭제할 것으로 표시한 레지스트리 키에 시도한 작업이 잘못되었습니다.
'Private Const ERROR_KEY_DELETED = 1018&
''   시스템에서 레지스트리 로그에 필요한 공간을 할당할 수 없습니다.
'Private Const ERROR_NO_LOG_SPACE = 1019&
''   이미 하위 키 또는 값을 가진 레지스트리에서 기호화 연결을 작성할 수 없습니다.
'Private Const ERROR_KEY_HAS_CHILDREN = 1020&
''   휘발성의 상위 키에서 안정적인 하위 키를 작성할 수 없습니다.
'Private Const ERROR_CHILD_MUST_BE_VOLATILE = 1021&
'
'#End If

'This program needs 3 buttons
'example by Scott Watters (scottw@racewaves.com)
Private Type LUID
   LowPart As Long
   HighPart As Long
End Type
Private Type LUID_AND_ATTRIBUTES
   pLuid As LUID
   Attributes As Long
End Type
Private Type TOKEN_PRIVILEGES
   PrivilegeCount As Long
   Privileges As LUID_AND_ATTRIBUTES
End Type

' Using : RegQueryKeyEX
' 레지스트리 값을 여러개 읽어올때
Private Type FILETIME
   dwLowDateTime As Long
   dwHighDateTime As Long
End Type

'' 레지스트리 보안 구문
'Private Type SECURITY_ATTRIBUTES
'   nLength As Long
'   lpSecurityDescriptor As Long
'   bInheritHandle As Long
'End Type
'Private Type ACL
'   AclRevision As Byte
'   Sbz1 As Byte
'   AclSize As Integer
'   AceCount As Integer
'   Sbz2 As Integer
'End Type
'Private Type SECURITY_DESCRIPTOR
'   Revision As Byte
'   Sbz1 As Byte
'   Control As Long
'   Owner As Long
'   Group As Long
'   Sacl As ACL
'   Dacl As ACL
'End Type
'''Private Type SECURITY_QUALITY_OF_SERVICE
'''   Length As Long
'''   Impersonationlevel As Integer
'''   ContextTrackingMode As Integer
'''   EffectiveOnly As Long
'''End Type

'' 보안 정보 상수
'Private Const SECURITY_ANONYMOUS_LOGON_RID = &H7
'Private Const SECURITY_BATCH_RID = &H3
'Private Const SECURITY_BUILTIN_DOMAIN_RID = &H20
'Private Const SECURITY_CONTEXT_TRACKING = &H40000
'Private Const SECURITY_CREATOR_GROUP_RID = &H1
'Private Const SECURITY_CREATOR_OWNER_RID = &H0
'Private Const SECURITY_DESCRIPTOR_MIN_LENGTH = (20)
'Private Const SECURITY_DESCRIPTOR_REVISION = (1)
'Private Const SECURITY_DESCRIPTOR_REVISION1 = (1)
'Private Const SECURITY_DIALUP_RID = &H1
'Private Const SECURITY_EFFECTIVE_ONLY = &H80000
'Private Const SECURITY_INTERACTIVE_RID = &H4
'Private Const SECURITY_LOCAL_RID = &H0
'Private Const SECURITY_LOCAL_SYSTEM_RID = &H12
'Private Const SECURITY_LOGON_IDS_RID = &H5
'Private Const SECURITY_NETWORK_RID = &H2
'Private Const SECURITY_NT_NON_UNIQUE = &H15
'Private Const SECURITY_NULL_RID = &H0
'Private Const SECURITY_SERVICE_RID = &H6
'Private Const SECURITY_SQOS_PRESENT = &H100000
'Private Const SECURITY_WORLD_RID = &H0
'Private Const SECURITY_VALID_SQOS_FLAGS = &H1F0000
'Private Const SecurityAnonymous = 1
'Private Const SecurityIdentification = 2


' API 함수
Private Declare Function GetCurrentProcess Lib "kernel32" () As Long
Private Declare Function AdjustTokenPrivileges Lib "advapi32.dll" (ByVal TokenHandle As Long, ByVal DisableAllPriv As Long, NewState As TOKEN_PRIVILEGES, ByVal BufferLength As Long, PreviousState As TOKEN_PRIVILEGES, ReturnLength As Long) As Long                'Used to adjust your program's security privileges, can't restore without it!
Private Declare Function LookupPrivilegeValue Lib "advapi32.dll" Alias "LookupPrivilegeValueA" (ByVal lpSystemName As Any, ByVal lpName As String, lpLuid As LUID) As Long          'Returns a valid LUID which is important when making security changes in NT.
Private Declare Function OpenProcessToken Lib "advapi32.dll" (ByVal ProcessHandle As Long, ByVal DesiredAccess As Long, TokenHandle As Long) As Long

' *****************************************************************************
' 레지스트리 관련 API 함수
' *****************************************************************************
Private Declare Function RegCloseKey Lib "advapi32.dll" (ByVal hKey As Long) As Long
' 레지스트리 생성 함수
'Private Declare Function RegCreateKey Lib "advapi32.dll" Alias "RegCreateKeyA" (ByVal hKey As Long, ByVal lpSubKey As String, phkResult As Long) As Long
Private Declare Function RegCreateKeyEx Lib "advapi32.dll" Alias "RegCreateKeyExA" (ByVal hKey As Long, ByVal lpSubKey As String, ByVal Reserved As Long, ByVal lpClass As String, ByVal dwOptions As Long, ByVal samDesired As Long, lpSecurityAttributes As Any, phkResult As Long, lpdwDisposition As Long) As Long
' 레지스트리 삭제 함수
Private Declare Function RegDeleteKey Lib "advapi32.dll" Alias "RegDeleteKeyA" (ByVal hKey As Long, ByVal lpSubKey As String) As Long
Private Declare Function RegDeleteValue Lib "advapi32.dll" Alias "RegDeleteValueA" (ByVal hKey As Long, ByVal lpValueName As String) As Long
' 레지스트리 여러 값/키 읽기
'Private Declare Function RegEnumKey Lib "advapi32.dll" Alias "RegEnumKeyA" (ByVal hKey As Long, ByVal dwIndex As Long, ByVal lpName As String, ByVal cbName As Long) As Long
Private Declare Function RegEnumKeyEx Lib "advapi32.dll" Alias "RegEnumKeyExA" (ByVal hKey As Long, ByVal dwIndex As Long, ByVal lpName As String, lpcbName As Long, ByVal lpReserved As Long, ByVal lpClass As String, lpcbClass As Long, lpftLastWriteTime As Any) As Long
Private Declare Function RegEnumValue Lib "advapi32.dll" Alias "RegEnumValueA" (ByVal hKey As Long, ByVal dwIndex As Long, ByVal lpValueName As String, lpcbValueName As Long, ByVal lpReserved As Long, lpType As Long, lpData As Byte, lpcbData As Long) As Long

'Private Declare Function RegNotifyChangeKeyValue Lib "advapi32" (ByVal hKey As Long, ByVal bWatchSubtree As Boolean, ByVal dwNotifyFilter As Long, ByVal hEvent As Long, ByVal fAsynchronous As Boolean) As Long
' 레지스트리 열기
'Private Declare Function RegOpenKey Lib "advapi32.dll" Alias "RegOpenKeyA" (ByVal hKey As Long, ByVal lpSubKey As String, phkResult As Long) As Long
Private Declare Function RegOpenKeyEx Lib "advapi32.dll" Alias "RegOpenKeyExA" (ByVal hKey As Long, ByVal lpSubKey As String, ByVal Reserved As Long, ByVal samDesired As Long, phkResult As Long) As Long
' 레지스트리 값 읽어오기
' 레지스트리 정보 가져오기
Private Declare Function RegQueryInfoKey Lib "advapi32.dll" Alias "RegQueryInfoKeyA" (ByVal hKey As Long, ByVal lpClass As String, lpcbClass As Long, ByVal lpReserved As Long, lpcSubKeys As Long, lpcbMaxSubKeyLen As Long, lpcbMaxClassLen As Long, lpcValues As Long, lpcbMaxValueNameLen As Long, lpcbMaxValueLen As Long, lpcbSecurityDescriptor As Long, lpftLastWriteTime As FILETIME) As Long
'Private Declare Function RegQueryValue Lib "advapi32.dll" Alias "RegQueryValueA" (ByVal hKey As Long, ByVal lpSubKey As String, ByVal lpValue As String, lpcbValue As Long) As Long
Private Declare Function RegQueryValueEx Lib "advapi32.dll" Alias "RegQueryValueExA" (ByVal hKey As Long, ByVal lpValueName As String, ByVal lpReserved As Long, lpType As Long, lpData As Any, lpcbData As Long) As Long
' 레지스트리 저장
'Private Declare Function RegSetValue Lib "advapi32.dll" Alias "RegSetValueA" (ByVal hKey As Long, ByVal lpSubKey As String, ByVal dwType As Long, ByVal lpData As String, ByVal cbData As Long) As Long
Private Declare Function RegSetValueEx Lib "advapi32.dll" Alias "RegSetValueExA" (ByVal hKey As Long, ByVal lpValueName As String, ByVal Reserved As Long, ByVal dwType As Long, lpData As Any, ByVal cbData As Long) As Long        ' Note that if you declare the lpData parameter as String, you must pass it By Value.
' 레지스트리 변경사항 바로 저장하기
'Private Declare Function RegFlushKey Lib "advapi32.dll" (ByVal hKey As Long) As Long

' 레지스트리 Import/Export 함수
Private Declare Function RegSaveKey Lib "advapi32.dll" Alias "RegSaveKeyA" (ByVal hKey As Long, ByVal lpFile As String, lpSecurityAttributes As Any) As Long
'Private Declare Function RegSaveKey Lib "advapi32.dll" Alias "RegSaveKeyA" (ByVal hKey As Long, ByVal lpFile As String, lpSecurityAttributes As SECURITY_ATTRIBUTES) As Long
Private Declare Function RegRestoreKey Lib "advapi32.dll" Alias "RegRestoreKeyA" (ByVal hKey As Long, ByVal lpFile As String, ByVal dwFlags As Long) As Long
Private Declare Function RegReplaceKey Lib "advapi32.dll" Alias "RegReplaceKeyA" (ByVal hKey As Long, ByVal lpSubKey As String, ByVal lpNewFile As String, ByVal lpOldFile As String) As Long
'
'' 레지스트리 보안 정보 가져오기
'Private Declare Function RegGetKeySecurity Lib "advapi32.dll" (ByVal hKey As Long, ByVal SecurityInformation As Long, pSecurityDescriptor As SECURITY_DESCRIPTOR, lpcbSecurityDescriptor As Long) As Long
'Private Declare Function RegSetKeySecurity Lib "advapi32.dll" (ByVal hKey As Long, ByVal SecurityInformation As Long, pSecurityDescriptor As SECURITY_DESCRIPTOR) As Long
'
'Private Declare Function GetSecurityDescriptorControl Lib "advapi32.dll" (pSecurityDescriptor As SECURITY_DESCRIPTOR, pControl As Integer, lpdwRevision As Long) As Long
'Private Declare Function GetSecurityDescriptorDacl Lib "advapi32.dll" (pSecurityDescriptor As SECURITY_DESCRIPTOR, lpbDaclPresent As Long, pDACL As ACL, lpbDaclDefaulted As Long) As Long
'Private Declare Function GetSecurityDescriptorGroup Lib "advapi32.dll" (pSecurityDescriptor As SECURITY_DESCRIPTOR, pGroup As Any, ByVal lpbGroupDefaulted As Long) As Long
'Private Declare Function GetSecurityDescriptorLength Lib "advapi32.dll" (pSecurityDescriptor As SECURITY_DESCRIPTOR) As Long
'Private Declare Function GetSecurityDescriptorOwner Lib "advapi32.dll" (pSecurityDescriptor As SECURITY_DESCRIPTOR, pOwner As Any, ByVal lpbOwnerDefaulted As Long) As Long
'Private Declare Function GetSecurityDescriptorSacl Lib "advapi32.dll" (pSecurityDescriptor As SECURITY_DESCRIPTOR, ByVal lpbSaclPresent As Long, pSACL As ACL, ByVal lpbSaclDefaulted As Long) As Long
'
'Private Declare Function GetUserDefaultLCID Lib "kernel32" () As Long
'Private Declare Function GetUserObjectInformation Lib "user32" Alias "GetUserObjectInformationA" (ByVal hObj As Long, ByVal nIndex As Long, pvInfo As Any, ByVal nLength As Long, lpnLengthNeeded As Long) As Long
'Private Declare Function GetUserObjectSecurity Lib "user32" (ByVal hObj As Long, pSIRequested As Long, pSd As SECURITY_DESCRIPTOR, ByVal nLength As Long, lpnLengthNeeded As Long) As Long
'
'Private Declare Function RegConnectRegistry Lib "advapi32.dll" Alias "RegConnectRegistryA" (ByVal lpMachineName As String, ByVal hKey As Long, phkResult As Long) As Long
'Private Declare Function RegLoadKey Lib "advapi32.dll" Alias "RegLoadKeyA" (ByVal hKey As Long, ByVal lpSubKey As String, ByVal lpFile As String) As Long
''''''Private Declare Function RegLoadKeyEx Lib "advapi32.dll" Alias "RegLoadKeyW" (ByVal hKey As Long, ByVal lpSubKey As String, ByVal lpFile As String) As Long
'Private Declare Function RegUnLoadKey Lib "advapi32.dll" Alias "RegUnLoadKeyA" (ByVal hKey As Long, ByVal lpSubKey As String) As Long
'
'
'
'
''&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
'' API에 정의된 레지스트리 관련 API 함수
''&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
'Declare Function RegCloseKey Lib "advapi32.dll" (ByVal hKey As Long) As Long
'Declare Function RegConnectRegistry Lib "advapi32.dll" Alias "RegConnectRegistryA" (ByVal lpMachineName As String, ByVal hKey As Long, phkResult As Long) As Long
'Declare Function RegCreateKey Lib "advapi32.dll" Alias "RegCreateKeyA" (ByVal hKey As Long, ByVal lpSubKey As String, phkResult As Long) As Long
'Declare Function RegCreateKeyEx Lib "advapi32.dll" Alias "RegCreateKeyExA" (ByVal hKey As Long, ByVal lpSubKey As String, ByVal Reserved As Long, ByVal lpClass As String, ByVal dwOptions As Long, ByVal samDesired As Long, lpSecurityAttributes As SECURITY_ATTRIBUTES, phkResult As Long, lpdwDisposition As Long) As Long
'Declare Function RegDeleteKey Lib "advapi32.dll" Alias "RegDeleteKeyA" (ByVal hKey As Long, ByVal lpSubKey As String) As Long
'Declare Function RegDeleteValue Lib "advapi32.dll" Alias "RegDeleteValueA" (ByVal hKey As Long, ByVal lpValueName As String) As Long
'Declare Function RegEnumKey Lib "advapi32.dll" Alias "RegEnumKeyA" (ByVal hKey As Long, ByVal dwIndex As Long, ByVal lpName As String, ByVal cbName As Long) As Long
'Declare Function RegEnumKeyEx Lib "advapi32.dll" Alias "RegEnumKeyExA" (ByVal hKey As Long, ByVal dwIndex As Long, ByVal lpName As String, lpcbName As Long, ByVal lpReserved As Long, ByVal lpClass As String, lpcbClass As Long, lpftLastWriteTime As FILETIME) As Long
'Declare Function RegEnumValue Lib "advapi32.dll" Alias "RegEnumValueA" (ByVal hKey As Long, ByVal dwIndex As Long, ByVal lpValueName As String, lpcbValueName As Long, ByVal lpReserved As Long, lpType As Long, lpData As Byte, lpcbData As Long) As Long
'Declare Function RegFlushKey Lib "advapi32.dll" (ByVal hKey As Long) As Long
'Declare Function RegGetKeySecurity Lib "advapi32.dll" (ByVal hKey As Long, ByVal SecurityInformation As Long, pSecurityDescriptor As SECURITY_DESCRIPTOR, lpcbSecurityDescriptor As Long) As Long
'Declare Function RegLoadKey Lib "advapi32.dll" Alias "RegLoadKeyA" (ByVal hKey As Long, ByVal lpSubKey As String, ByVal lpFile As String) As Long
'Declare Function RegNotifyChangeKeyValue Lib "advapi32.dll" (ByVal hKey As Long, ByVal bWatchSubtree As Long, ByVal dwNotifyFilter As Long, ByVal hEvent As Long, ByVal fAsynchronus As Long) As Long
'Declare Function RegOpenKey Lib "advapi32.dll" Alias "RegOpenKeyA" (ByVal hKey As Long, ByVal lpSubKey As String, phkResult As Long) As Long
'Declare Function RegOpenKeyEx Lib "advapi32.dll" Alias "RegOpenKeyExA" (ByVal hKey As Long, ByVal lpSubKey As String, ByVal ulOptions As Long, ByVal samDesired As Long, phkResult As Long) As Long
'Declare Function RegQueryInfoKey Lib "advapi32.dll" Alias "RegQueryInfoKeyA" (ByVal hKey As Long, ByVal lpClass As String, lpcbClass As Long, ByVal lpReserved As Long, lpcSubKeys As Long, lpcbMaxSubKeyLen As Long, lpcbMaxClassLen As Long, lpcValues As Long, lpcbMaxValueNameLen As Long, lpcbMaxValueLen As Long, lpcbSecurityDescriptor As Long, lpftLastWriteTime As FILETIME) As Long
'Declare Function RegQueryValue Lib "advapi32.dll" Alias "RegQueryValueA" (ByVal hKey As Long, ByVal lpSubKey As String, ByVal lpValue As String, lpcbValue As Long) As Long
'Declare Function RegQueryValueEx Lib "advapi32.dll" Alias "RegQueryValueExA" (ByVal hKey As Long, ByVal lpValueName As String, ByVal lpReserved As Long, lpType As Long, lpData As Any, lpcbData As Long) As Long         ' Note that if you declare the lpData parameter as String, you must pass it By Value.
'Declare Function RegReplaceKey Lib "advapi32.dll" Alias "RegReplaceKeyA" (ByVal hKey As Long, ByVal lpSubKey As String, ByVal lpNewFile As String, ByVal lpOldFile As String) As Long
'Declare Function RegRestoreKey Lib "advapi32.dll" Alias "RegRestoreKeyA" (ByVal hKey As Long, ByVal lpFile As String, ByVal dwFlags As Long) As Long
'Declare Function RegSaveKey Lib "advapi32.dll" Alias "RegSaveKeyA" (ByVal hKey As Long, ByVal lpFile As String, lpSecurityAttributes As SECURITY_ATTRIBUTES) As Long
'Declare Function RegSetKeySecurity Lib "advapi32.dll" (ByVal hKey As Long, ByVal SecurityInformation As Long, pSecurityDescriptor As SECURITY_DESCRIPTOR) As Long
'Declare Function RegSetValue Lib "advapi32.dll" Alias "RegSetValueA" (ByVal hKey As Long, ByVal lpSubKey As String, ByVal dwType As Long, ByVal lpData As String, ByVal cbData As Long) As Long
'Declare Function RegSetValueEx Lib "advapi32.dll" Alias "RegSetValueExA" (ByVal hKey As Long, ByVal lpValueName As String, ByVal Reserved As Long, ByVal dwType As Long, lpData As Any, ByVal cbData As Long) As Long         ' Note that if you declare the lpData parameter as String, you must pass it By Value.
'Declare Function RegUnLoadKey Lib "advapi32.dll" Alias "RegUnLoadKeyA" (ByVal hKey As Long, ByVal lpSubKey As String) As Long
'Declare Function InitiateSystemShutdown Lib "advapi32.dll" Alias "InitiateSystemShutdownA" (ByVal lpMachineName As String, ByVal lpMessage As String, ByVal dwTimeout As Long, ByVal bForceAppsClosed As Long, ByVal bRebootAfterShutdown As Long) As Long
'Declare Function AbortSystemShutdown Lib "advapi32.dll" Alias "AbortSystemShutdownA" (ByVal lpMachineName As String) As Long
''&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&



Private Function QueryRegValue(ByVal rKey As Long, ByVal ValueName As String, Optional DefaultValue As Variant = "") As Variant ' String
'***************************************************************************************************
' 함수명 : QueryRegValue
' 용  도 : 레지스트리에 저장된 값을 읽어오는 함수
' 파라미터 갯수 : 2개 필수, 1개 옵션
'          1. rKey         : 열려있는 키 핸들
'          2. Valuename    : 읽어올 값이름
'          3. DefaultValue : 값이 존재하지 않을 경우 반환할 기본값 ( 옵션)
' 리턴값 : Variant - 읽어올 값에따라 형이 달라짐.
' 범  위 : 모듈內
' 제작일 : 7월 22일 2001년
' 제작자 : 정호영 (goliat@freechal.com)
'***************************************************************************************************
   On Error GoTo RegError

   Dim pRet As Long, lValueType As Long
   Dim strBuf As String, lDataBufSize As Long
   Dim lngData As Long
   Dim pArray() As Byte


   ' 레지스트리 값의 정보 구함
   pRet = RegQueryValueEx(rKey, ValueName, 0, lValueType, ByVal 0, lDataBufSize)
   If pRet <> ERROR_SUCCESS Then GoTo RegError

   Select Case lValueType
      Case REG_SZ, REG_EXPAND_SZ:
         ' 버퍼 생성
         strBuf = String(lDataBufSize, Chr$(0))
         ' 레지스트리 값 읽기
         pRet = RegQueryValueEx(rKey, ValueName, 0, 0, ByVal strBuf, lDataBufSize)
         If pRet = ERROR_SUCCESS Then
            pArray = StrConv(strBuf, vbFromUnicode)
            ReDim Preserve pArray(lDataBufSize - 2)
            strBuf = Replace(StrConv(pArray, vbUnicode), Chr(0), vbCrLf)
            ' 불필요한 마지막 널문자 제거
            QueryRegValue = strBuf ' Left$(strBuf, InStr(1, strBuf, Chr$(0)) - 1)
         End If

      Case REG_DWORD:
         ' 레지스트리 값 읽기
         pRet = RegQueryValueEx(rKey, ValueName, 0, 0, lngData, lDataBufSize)
         If pRet = ERROR_SUCCESS Then QueryRegValue = lngData

      Case REG_DWORD_LITTLE_ENDIAN:
         ' 레지스트리 값 읽기
         pRet = RegQueryValueEx(rKey, ValueName, 0, 0, lngData, lDataBufSize)
         If pRet = ERROR_SUCCESS Then QueryRegValue = lngData

'      Case REG_DWORD_LITTLE_ENDIAN:
''      Case REG_DWORD_BIG_ENDIAN:

      Case REG_BINARY:
         ReDim pArray(lDataBufSize - 1)
         ' 레지스트리 값 읽기
         pRet = RegQueryValueEx(rKey, ValueName, 0, 0, pArray(0), lDataBufSize)
         If pRet = ERROR_SUCCESS Then QueryRegValue = pArray

      Case REG_RESOURCE_LIST:
         ReDim pArray(lDataBufSize - 1)
         ' 레지스트리 값 읽기
         pRet = RegQueryValueEx(rKey, ValueName, 0, 0, pArray(0), lDataBufSize)
         If pRet = ERROR_SUCCESS Then QueryRegValue = pArray

      Case REG_FULL_RESOURCE_DESCRIPTOR:
         ReDim pArray(lDataBufSize - 1)
         ' 레지스트리 값 읽기
         pRet = RegQueryValueEx(rKey, ValueName, 0, 0, pArray(0), lDataBufSize)
         If pRet = ERROR_SUCCESS Then QueryRegValue = pArray

      Case REG_RESOURCE_REQUIREMENTS_LIST:
         ReDim pArray(lDataBufSize - 1)
         ' 레지스트리 값 읽기
         pRet = RegQueryValueEx(rKey, ValueName, 0, 0, pArray(0), lDataBufSize)
         If pRet = ERROR_SUCCESS Then QueryRegValue = pArray

      Case REG_MULTI_SZ:
         '버퍼 생성
         strBuf = String(lDataBufSize, " ") ' Chr$(0))
         ' 레지스트리 값 읽기
         pRet = RegQueryValueEx(rKey, ValueName, 0, 0, ByVal strBuf, lDataBufSize)
         If pRet = ERROR_SUCCESS Then
            lDataBufSize = InStr(1, strBuf, String(2, Chr(0)))
            pArray = StrConv(strBuf, vbFromUnicode)
            ReDim Preserve pArray(lDataBufSize - 2)
            QueryRegValue = Replace(StrConv(pArray, vbUnicode), Chr(0), vbCrLf)
         End If

      Case REG_QWORD: ' 큰 정수 (LARGE_INTEGER 형)
         Dim qlngData As LARGE_INTEGER
         ' 레지스트리 값 읽기
         pRet = RegQueryValueEx(rKey, ValueName, 0, 0, qlngData, lDataBufSize) ' lngData, lDataBufSize)
         If pRet = ERROR_SUCCESS Then QueryRegValue = qlngData ' lngData

      Case Else:
   End Select

   pArray = Nothing
   Exit Function

RegError:
   QueryRegValue = DefaultValue
End Function ' QueryRegValue(hKey as Long, KeyName as string, Optional DefaultValue) as Variant

Public Function LoadRegValue(ByVal hRootKey As rRootKey, ByVal KeyPath As String, ByVal ValueName As String, Optional DefaultValue As Variant = "") As Variant
'***************************************************************************************************
' 함수명 : LoadRegValue
' 용  도 : QueryRegValue 함수를 호출하여 원하는 레지스트리의 값을 읽어옴
' 파라미터 갯수 : 4개 필수, 1개 옵션
'          1. hRootKey     : 열려있는 키 핸들
'          2. KeyPath      : 읽어올 키 경로
'          3. ValueName    : 읽어올 값이름
'          4. DefaultValue : 값이 존재하지 않을 경우 반환할 기본값 ( 옵션)
' 리턴값 : Variant - 읽어올 값에따라 형이 달라짐.
' 범  위 : 전체
' 제작일 : 7월 22일 2001년
' 제작자 : 정호영 (goliat@freechal.com)
'***************************************************************************************************

   Dim rKey As Long, pRet As Long

   ' 만들고자 하는 키가 존재하는지 확인
   pRet = RegOpenKeyEx(hRootKey, KeyPath, 0, KEY_ALL_ACCESS, rKey)

   ' 레지스트리 값 얻어오기
   LoadRegValue = QueryRegValue(rKey, ValueName, DefaultValue)
   
   ' 연 레지스트리 닫기
   RegCloseKey rKey
End Function ' LoadRegValue(hRootKey as rRootKey, KeyPath as String, ValueName as string, DefaultValue as Variant) as Variant

Public Function SaveRegValue(ByVal hRootKey As rRootKey, ByVal KeyPath As String, ByVal ValueName As String, rValue As Variant, Optional ByVal vType As rType = R_SZ) As Boolean
'***************************************************************************************************
' 함수명 : SaveRegValue
' 용  도 : 레지스트리에 값을 저장하는 함수
' 파라미터 갯수 : 4개 필수, 1개 옵션
'          1. hRootKey     : 열려있는 키 핸들
'          2. KeyPath      : 레지스트리 키 경로
'          3. Valuename    : 저장할 값이름
'          4. rValue       : 실제 저장할
'          5. vType        : 저장할 값의 형 ( 옵션)
' 리턴값 : Variant - 오류코드. ( 성공시 0 반환)
' 범  위 : 전체
' 제작일 : 7월 22일 2001년
' 제작자 : 정호영 (goliat@freechal.com)
'***************************************************************************************************
   On Error Resume Next

   Dim rKey As Long, pRet As Long
   Dim pArray() As Byte

   ' 레지스트리 키가 존재하는지 판단.
   If QueryRegKey(hRootKey, KeyPath) <> ERROR_SUCCESS Then
      ' 레지스트리 키를 새로 생성함
      If CreateRegKey(hRootKey, KeyPath) = False Then Exit Function
   End If

   ' 레지스트리 키를 연다.
   pRet = RegOpenKeyEx(hRootKey, KeyPath, 0&, KEY_ALL_ACCESS, rKey)
   If rKey <= 0 Then Exit Function

   Select Case vType
      Case REG_SZ, REG_EXPAND_SZ:
         pArray = StrConv(rValue, vbFromUnicode)
         pRet = RegSetValueEx(rKey, ValueName, 0&, vType, ByVal CStr(rValue), UBound(pArray) + 1)

      Case REG_DWORD:
         pRet = RegSetValueEx(rKey, ValueName, 0&, vType, CLng(rValue), 4)

      Case REG_DWORD_LITTLE_ENDIAN:
         pRet = RegSetValueEx(rKey, ValueName, 0&, vType, CLng(rValue), 4)

'      Case REG_DWORD_BIG_ENDIAN:
'         pRet = RegSetValueEx(rKey, ValueName, 0&, vType, CLng(rValue), 4)  ' Len(rValue) '4

      Case REG_BINARY, REG_RESOURCE_LIST, REG_FULL_RESOURCE_DESCRIPTOR, REG_RESOURCE_REQUIREMENTS_LIST, REG_LINK:     'Set the key's value
Binary_Reg:
         pArray = rValue
         pRet = RegSetValueEx(rKey, ValueName, 0&, vType, pArray(0), (UBound(pArray) + 1)) '* 4

      Case REG_MULTI_SZ:       'Save a MultiLine string to the key
'         rValue = Replace(rValue, vbCrLf, Chr(0))
         pArray = StrConv(rValue, vbUnicode)
         pRet = RegSetValueEx(rKey, ValueName, 0&, vType, ByVal CStr(rValue), UBound(pArray) + 1)

      Case REG_QWORD:
'         Dim pQData As LARGE_INTEGER
'         pQData = rValue
'         pRet = RegSetValueEx(rKey, ValueName, 0&, vType, pQData, Len(pQData))

         pRet = RegSetValueEx(rKey, ValueName, 0&, vType, rValue, Len(rValue))

      Case Else: Resume Binary_Reg
   End Select
   pArray = Nothing

   '레지스트리 키 닫기
   RegCloseKey rKey

   If pRet = ERROR_SUCCESS Then: SaveRegValue = True
   Else:                         SaveRegValue = False
   End If
End Function ' SaveRegValue(hRootKey as rRootKey, KeyPath as String, ValueName as String, rValue as Variant, Optional vType) as Long

Public Function QueryRegKey(ByVal hRootKey As rRootKey, ByVal KeyPath As String) As Boolean
'***************************************************************************************************
' 함수명 : QueryRegKey
' 용  도 : 레지스트리에 키 존재 여부 확인
' 파라미터 갯수 : 2개 필수, 0개 옵션
'          1. hRootKey     : 루트키
'          2. KeyPath      : 레지스트리 키 경로
' 리턴값 : Long - 오류코드. ( 성공시 0 반환, 오류 발생시 오류코드의 음수값.)
' 범  위 : 전체
' 제작일 : 7월 22일 2001년
' 제작자 : 정호영 (goliat@freechal.com)
'***************************************************************************************************
   On Error Resume Next

   Dim pRet As Long, rKey As Long

   pRet = RegOpenKeyEx(hRootKey, KeyPath, 0, KEY_ALL_ACCESS, rKey)
   If pRet <> ERROR_SUCCESS Then
      ' 키가 존재하지 않을 경우 FALSE를 반환
      QueryRegKey = False
      Exit Function
   End If

   RegCloseKey rKey
   
   ' 키가 존재할 경우 TRUE를 반환
   QueryRegKey = True
End Function ' QueryRegKey(hRootKey as rRootKey, KeyPath as String) as Long

Public Function CreateRegKey(ByVal hRootKey As rRootKey, ByVal KeyPath As String) As Boolean
'***************************************************************************************************
' 함수명 : CreateRegKey
' 용  도 : 레지스트리에 키를 생성하는 함수
' 파라미터 갯수 : 2개 필수, 0개 옵션
'          1. hRootKey     : 레지스트리 루트 키
'          2. KeyPath      : 레지스트리 키 경로
' 리턴값 : Boolean - 결과 ( 성공시 True 반환)
' 범  위 : 전체
' 제작일 : 7월 22일 2001년
' 제작자 : 정호영 (goliat@freechal.com)
'***************************************************************************************************
   On Error GoTo RegError

   Dim rKey As Long
   Dim pResult As Long, pRet As Long

   If Right(KeyPath, 1) = "\" Then KeyPath = Left(KeyPath, Len(KeyPath) - 1)

   ' 만들고자 하는 키가 존재하는지 확인
   If QueryRegKey(hRootKey, KeyPath) = False Then
      ' 레지스트리 키 생성
      pRet = RegCreateKeyEx(hRootKey, KeyPath, 0, "REG_DWORD", REG_OPTION_NON_VOLATILE, KEY_ALL_ACCESS, ByVal 0&, rKey, pResult)
      ' 키 생성을 못했을 경우
      If pRet <> ERROR_SUCCESS Then GoTo RegError
'      If rKey = 0 Then GoTo RegError
   End If

   CreateRegKey = True

RegContinue:
   ' 레지스트리 핸들 닫기
   RegCloseKey rKey
   Exit Function

RegError:
   CreateRegKey = False
   Resume RegContinue
End Function ' CreateRegKey(hRootKey as rRootKey, KeyPath as String) as Boolean

Public Function DeleteAllRegKey(ByVal hRootKey As rRootKey, ByVal KeyPath As String) As Long
'***************************************************************************************************
' 함수명 : DeleteRegKey
' 용  도 : 레지스트리에 키를 삭제하는 함수 (NT, 2K 환경에서는 하위키 존재시 삭제 안됨.)
' 파라미터 갯수 : 2개 필수, 0개 옵션
'          1. hRootKey     : 레지스트리 루트 키
'          2. KeyPath      : 레지스트리 키 경로
' 리턴값 : Long - 삭제하지 못한 키의 갯수
' 범  위 : 전체
' 제작일 : 7월 22일 2001년
' 제작자 : 정호영 (goliat@freechal.com)
'***************************************************************************************************
   On Error GoTo RegError

   Dim pSubKey() As String, pSubKeyCount As Long
   Dim pResult As Long, pi As Long

   pSubKeyCount = GetAllRegSubKey(hRootKey, KeyPath, pSubKey)
   If pSubKeyCount > 0 Then
      For pi = 0 To pSubKeyCount - 1
         DoEvents
         pResult = pResult + DeleteAllRegKey(hRootKey, KeyPath & "\" & pSubKey(pi))
      Next pi
   End If

'   pResult = DeleteRegKey(hRootKey, KeyPath)
   If RegDeleteKey(hRootKey, KeyPath) <> ERROR_SUCCESS Then pResult = pResult + 1

RegError:
   DeleteAllRegKey = pResult
End Function ' DeleteForceRegKey(hRootKey as rRootKey, KeyPath as String) as Boolean

Public Function DeleteRegKey(ByVal hRootKey As rRootKey, ByVal KeyPath As String) As Boolean
'***************************************************************************************************
' 함수명 : DeleteRegKey
' 용  도 : 레지스트리에 키를 삭제하는 함수
' 파라미터 갯수 : 2개 필수, 0개 옵션
'          1. hRootKey     : 레지스트리 루트 키
'          2. KeyPath      : 레지스트리 키 경로
' 리턴값 : Boolean - 오류코드. ( 성공시 True 반환)
' 범  위 : 전체
' 제작일 : 7월 22일 2001년
' 제작자 : 정호영 (goliat@freechal.com)
'***************************************************************************************************
   On Error GoTo RegError

   Dim rKey As Long
   Dim Result As Long, pRet As Long

   ' 레지스트리 키 존재여부 판별
   If QueryRegKey(hRootKey, KeyPath) = True Then
      ' Delete Key
      pRet = RegDeleteKey(hRootKey, KeyPath)
      ' 키 삭제 실패 했을 경우
      If pRet <> ERROR_SUCCESS Then GoTo RegError
   End If

   DeleteRegKey = True

RegContinue:
   Exit Function

RegError:
   DeleteRegKey = False
End Function ' DeleteRegKey(hRootKey as rRootKey, KeyPath as String) as Boolean

Public Function DeleteRegValue(ByVal hRootKey As rRootKey, ByVal KeyPath As String, ByVal rValue As String) As Boolean
'***************************************************************************************************
' 함수명 : DelRegValue
' 용  도 : 레지스트리에 값을 삭제하는 함수
' 파라미터 갯수 : 3개 필수, 0개 옵션
'          1. hRootKey     : 레지스트리 루트 키
'          2. KeyPath      : 레지스트리 키 경로
'          3. Valuename    : 저장할 값이름
' 리턴값 : Boolean - 오류코드. ( 성공시 True 반환)
' 범  위 : 전체
' 제작일 : 7월 22일 2001년
' 제작자 : 정호영 (goliat@freechal.com)
'***************************************************************************************************
   On Error Resume Next

   Dim rKey As Long, pRet As Long

   ' 만들고자 하는 키가 존재하는지 확인
   pRet = RegOpenKeyEx(hRootKey, KeyPath, 0, KEY_ALL_ACCESS, rKey)
   ' 키를 열수 없으면 그냥 종료
   If rKey = 0 Then
      DelRegValue = True
      Exit Function
   End If

   'Delete the key's value
   pRet = RegDeleteValue(rKey, rValue)
   If pRet <> ERROR_SUCCESS Then Exit Function

   'close the key
   pRet = RegCloseKey(rKey)

   DelRegValue = True

End Function ' DelRegValue(hRootKey as rRootKey, KeyPath as String, rValue as String) as Boolean

Public Function GetAllRegSubKey(ByVal hRootKey As rRootKey, ByVal KeyPath As String, pKeys() As String) As Long
'***************************************************************************************************
' 함수명 : GetAllRegSubKey
' 용  도 : 레지스트리에 하위 키를 구하는 함수
' 파라미터 갯수 : 3개 필수, 0개 옵션
'          1. hRootKey     : 레지스트리 루트 키
'          2. KeyPath      : 레지스트리 키 경로
'          3. pKeys()      : 반환할 서브키 목록
' 리턴값 : Long - 찾은 서브키 갯수
' 범  위 : 전체
' 제작일 : 7월 22일 2001년
' 제작자 : 정호영 (goliat@freechal.com)
'***************************************************************************************************

   Dim rKey As Long, pRet As Long
   Dim sKeyName As String, Cnt As Long

   ReDim pKeys(0)

   ' 만들고자 하는 키가 존재하는지 확인
   pRet = RegOpenKeyEx(hRootKey, KeyPath, 0, KEY_ALL_ACCESS, rKey)
'   pRet = RegOpenKey(hRootKey, KeyPath, rKey)
   Do Until (pRet <> 0)
      sKeyName = String(255, 0)

      pRet = RegEnumKeyEx(rKey, Cnt, sKeyName, 255, 0, vbNullString, ByVal 0&, ByVal 0&)
      If pRet = ERROR_NO_MORE_ITEMS Or pRet <> ERROR_SUCCESS Then Exit Do

      ReDim Preserve pKeys(Cnt)
      pKeys(Cnt) = Left(sKeyName, InStr(1, sKeyName, vbNullChar) - 1)

      Cnt = Cnt + 1
      DoEvents
   Loop

   GetAllRegSubKey = Cnt

   pRet = RegCloseKey(rKey)
End Function ' GetAllRegSubKeys(hRootKey as rRootKey, Keypath as String, pKeys() as String) as Long

Public Function GetAllRegSubValue(ByVal hRootKey As rRootKey, ByVal KeyPath As String, pValue() As String) As Long
'***************************************************************************************************
' 함수명 : GetAllRegSubValue
' 용  도 : 레지스트리에 값을 모두 읽어오는 함수
' 파라미터 갯수 : 3개 필수, 0개 옵션
'          1. hRootKey     : 레지스트리 루트 키
'          2. KeyPath      : 레지스트리 키 경로
'          3. pValue()     : 값을 읽어서 반환할 변수
' 리턴값 : Long - 발견한 값 갯수
' 범  위 : 전체
' 제작일 : 7월 22일 2001년
' 제작자 : 정호영 (goliat@freechal.com)
'***************************************************************************************************

   Dim rKey As Long, pRet As Long
   Dim sValueName As String
   Dim sValueType As Long, lSaveTime As Long
   Dim pValueCount As Long, pTmp As String

   ' 만들고자 하는 키가 존재하는지 확인
   pRet = RegOpenKeyEx(hRootKey, KeyPath, 0, KEY_ALL_ACCESS, rKey)
'   pRet = RegOpenKey(hRootKey, KeyPath, rKey)
   If pRet <> ERROR_SUCCESS Then
      GetAllRegSubValue = -pRet
      Exit Function
   End If

   Do
      sValueName = String(255, 0)
'      vValue = String(255, 0)

'      pRet = RegEnumValue(rKey, pValueCount, sValueName, 255, 0, ByVal 0&, ByVal 0&, ByVal 0&)
      pRet = RegEnumValue(rKey, pValueCount, sValueName, 255, 0, sValueType, ByVal 0&, lSaveTime)
      If pRet <> ERROR_SUCCESS Then Exit Do

      ReDim Preserve pValue(3, pValueCount)
      pValue(0, pValueCount) = Left(sValueName, InStr(1, sValueName, vbNullChar) - 1)
      pValue(1, pValueCount) = ValueType(sValueType)

      Dim pVa As Variant
      pVa = QueryRegValue(rKey, pValue(0, pValueCount))
      Select Case sValueType
         Case REG_SZ, REG_EXPAND_SZ:
         Case REG_MULTI_SZ:
         Case REG_DWORD:
         Case REG_DWORD_LITTLE_ENDIAN:
'         case REG_DWORD_BIG_ENDIAN:
         Case REG_BINARY, REG_RESOURCE_LIST, REG_FULL_RESOURCE_DESCRIPTOR, REG_RESOURCE_REQUIREMENTS_LIST, REG_NONE:
            Dim pbyte() As Byte
            pbyte = pVa
            pVa = ByteToHex(pbyte, True)
         Case REG_QWORD:
'            Dim pStr$, pQData As LARGE_INTEGER
'            pQData = pVa
'            pStr$ = pQData.LowPart & "," & pQData.HighPart
'            pVa = pStr$
'            pQData = Nothing
         Case Else:
      End Select

      pValue(2, pValueCount) = pVa ' ValueToString(QueryRegValue(rKey, pValue(0, pValueCount)), sValueType)
      pValue(3, pValueCount) = lSaveTime

      pValueCount = pValueCount + 1
      DoEvents
   Loop

   pRet = RegCloseKey(rKey)

   GetAllRegSubValue = pValueCount
End Function ' GetAllRegSubValue(hRootKey as rRootKey, KeyPath as String, pValue() as String) as Long

Public Function ExportRegKey(ByVal lPredefinedKey As rRootKey, ByVal KeyPath As String, ByVal sFileName As String) As Boolean
'***************************************************************************************************
' 함수명 : ExportRegKey
' 용  도 : 레지스트리에 키를 파일로 저장하는 함수
' 파라미터 갯수 : 3개 필수, 0개 옵션
'          1. lPredefinedKey : 레지스트리 루트 키
'          2. KeyPath        : 레지스트리 키 경로
'          3. sFileName      : 저장할 파일이름
' 리턴값 : Boolean - 오류코드. ( 성공시 True 반환)
' 범  위 : 전체
' 제작일 : 7월 22일 2001년
' 제작자 : 정호영 (goliat@freechal.com)
'***************************************************************************************************

   Dim rKey As Long, lRetVal As Long

   If EnablePrivilege(SE_BACKUP_NAME) = False Then Exit Function

   lRetVal = RegOpenKeyEx(lPredefinedKey, KeyPath, 0&, KEY_ALL_ACCESS, rKey)  ' 저장할 레지스트리 열기

   ' 저장하고자 하는 파일이 존재하면 기존 파일 삭제
   If Dir(sFileName) <> "" Then Kill sFileName

   ' 레지스트리 키 저장하는 루틴
   lRetVal = RegSaveKey(rKey, sFileName, ByVal 0&)
   If lRetVal <> 0 Then
      ExportRegKey = False
   Else: ExportRegKey = True
   End If

   RegCloseKey rKey ' 레지스트리 닫기
End Function ' ExportRegKey(lPredefinedKey as rRootKey, KeyPath as String, sFileName as String) as Boolean

Public Function ImportRegKey(lPredefinedKey As rRootKey, ByVal KeyPath As String, ByVal sFileName As String) As Boolean
'***************************************************************************************************
' 함수명 : ImportRegKey
' 용  도 : ExportKey 함수로 저장된 레지스트리 키를 레지스트리에 재등록 시켜주는 함수(불러오기 전에 저장된 키가 존재해야 함.)
' 파라미터 갯수 : 3개 필수, 0개 옵션
'          1. lPredefinedKey : 레지스트리 루트 키
'          2. KeyPath        : 레지스트리 키 경로
'          3. sFileName      : Import 할 파일이름
' 리턴값 : Boolean - 오류코드. ( 성공시 True 반환)
' 범  위 : 전체
' 제작일 : 7월 22일 2001년
' 제작자 : 정호영 (goliat@freechal.com)
'***************************************************************************************************

   Dim rKey As Long, lRetVal As Long

   If EnablePrivilege(SE_RESTORE_NAME) = False Then Exit Function

   lRetVal = RegOpenKeyEx(lPredefinedKey, KeyPath, 0&, KEY_ALL_ACCESS, rKey) ' 읽어올 레지스트리 열기
   If rKey = 0 Then
      ' 레지스트리가 존재하지 않아서 생성
      lRetVal = RegCreateKeyEx(lPredefinedKey, KeyPath, 0, "REG_DWORD", REG_OPTION_NON_VOLATILE, KEY_ALL_ACCESS, ByVal 0&, rKey, rKey)
      ' 키 생성을 못했을 경우
      If rKey = 0 Then GoTo RegError
   End If

   ' RegSaveKey 함수로 저장된 파일을 레지스트리에 등록시켜줌
   lRetVal = RegRestoreKey(rKey, sFileName, REG_FORCE_RESTORE)

   If lRetVal = ERROR_SUCCESS Then ImportRegKey = True

RegContinue:
   RegCloseKey rKey ' Don't want to keep the key ope. It causes problems.
   Exit Function

RegError:
   ImportRegKey = False
   Resume RegContinue
End Function ' ImportRegKey(lPredefinedKey as rRootKey, KeyPath as String, sFileName as String) as Boolean

Public Function ReplaceRegKey(lPredefinedKey As rRootKey, ByVal KeyPath As String, ByVal sFileName As String, ByVal sOldFileName As String) As Boolean
'***************************************************************************************************
' 함수명 : ReplaceRegKey
' 용  도 : 레지스트리에 키를 변경하는 함수 (아직 정상작동 안함)
' 파라미터 갯수 : 4개 필수, 0개 옵션
'          1. lPredefinedKey : 열려있는 키 핸들
'          2. KeyPath        : 레지스트리 키 경로
'          3. sFileName      : '''저장할 파일이름
'          4. sOldFileName   : '''예전 파일
' 리턴값 : Boolean - 오류코드. ( 성공시 True 반환)
' 범  위 : 전체
' 제작일 : 7월 22일 2001년
' 제작자 : 정호영 (goliat@freechal.com)
'***************************************************************************************************

   Dim rKey As Long, lRetVal As Long

   If EnablePrivilege(SE_RESTORE_NAME) = False Then Exit Function

   lRetVal = RegOpenKeyEx(lPredefinedKey, KeyPath, 0&, KEY_ALL_ACCESS, rKey) ' Must open key to restore it

   'The file it's restoring from was created using the RegSaveKey function
   lRetVal = RegReplaceKey(rKey, KeyPath, sFileName, sOldFileName)

   If lRetVal = ERROR_SUCCESS Then ReplaceRegKey = True

   RegCloseKey rKey ' Don't want to keep the key ope. It causes problems.
End Function ' ReplaceRegKey(lPredefinedKey as rRootKey, KeyPath as String, sFileName as String, sOldFileName as String) as Boolean

Private Function EnablePrivilege(seName As String) As Boolean
'***************************************************************************************************
' 함수명 : EnablePrivilege
' 용  도 : 레지스트리 유효성 검사 ( Import/Export 시 필수 사용)
' 파라미터 갯수 : 1개 필수, 0개 옵션
'          1. seName : SeCurity 이름
' 리턴값 : Boolean - 오류코드. ( 성공시 True 반환)
' 범  위 : 모듈內
' 제작일 : 7월 22일 2001년
' 제작자 : 정호영 (goliat@freechal.com)
'***************************************************************************************************

   Dim p_lngRtn As Long
   Dim p_lngToken As Long
   Dim p_lngBufferLen As Long
   Dim p_typLUID As LUID
   Dim p_typTokenPriv As TOKEN_PRIVILEGES
   Dim p_typPrevTokenPriv As TOKEN_PRIVILEGES

   p_lngRtn = OpenProcessToken(GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES Or TOKEN_QUERY, p_lngToken)
   If p_lngRtn = 0 Then
      Exit Function ' Failed
   ElseIf Err.LastDllError <> 0 Then
      Exit Function ' Failed
   End If

   p_lngRtn = LookupPrivilegeValue(0&, seName, p_typLUID)  ' Used to look up privileges LUID.
   If p_lngRtn = 0 Then Exit Function                      ' Failed

   ' Set it up to adjust the program's security privilege.
   p_typTokenPriv.PrivilegeCount = 1
   p_typTokenPriv.Privileges.Attributes = SE_PRIVILEGE_ENABLED
   p_typTokenPriv.Privileges.pLuid = p_typLUID

   p_lngRtn = AdjustTokenPrivileges(p_lngToken, False, p_typTokenPriv, Len(p_typPrevTokenPriv), p_typPrevTokenPriv, p_lngBufferLen)
   EnablePrivilege = (p_lngRtn <> 0)
End Function ' EnablePrivilege(seName as String) as Boolean

Private Function ValueType(vType As rType) As String
'***************************************************************************************************
' 함수명 : ValueType
' 용  도 : 레지스트리 형을 문자로 변경
' 파라미터 갯수 : 1개 필수, 0개 옵션
'          1. vType : 레지스트리 값 타입
' 리턴값 : String - 레지스트리 값 형태 문자열값.
' 범  위 : 모듈內
' 제작일 : 7월 22일 2001년
' 제작자 : 정호영 (goliat@freechal.com)
'***************************************************************************************************
   Select Case vType
      Case REG_NONE:                       ValueType = "REG_NONE"                       ' No value type
      Case REG_SZ:                         ValueType = "REG_SZ"                         ' Unicode nul terminated string
      Case REG_EXPAND_SZ:                  ValueType = "REG_EXPAND_SZ"                  ' Unicode nul terminated string
      Case REG_BINARY:                     ValueType = "REG_BINARY"                     ' Free form binary
      Case REG_DWORD:                      ValueType = "REG_DWORD"                      ' 32-bit number
      Case REG_DWORD_LITTLE_ENDIAN:        ValueType = "REG_DWORD_LITTLE_ENDIAN"        ' 32-bit number (same as REG_DWORD)
'      Case REG_DWORD_BIG_ENDIAN:           ValueType = "REG_DWORD_BIG_ENDIAN"           ' 32-bit number
      Case REG_LINK:                       ValueType = "REG_LINK"                       ' Symbolic Link (unicode)
      Case REG_MULTI_SZ:                   ValueType = "REG_MULTI_SZ"                   ' Multiple Unicode strings
      Case REG_RESOURCE_LIST:              ValueType = "REG_RESOURCE_LIST"              ' Resource list in the resource map
      Case REG_FULL_RESOURCE_DESCRIPTOR:   ValueType = "REG_FULL_RESOURCE_DESCRIPTOR"   ' Resource list in the resource map
      Case REG_RESOURCE_REQUIREMENTS_LIST: ValueType = "REG_RESOURCE_REQUIREMENTS_LIST"
      Case REG_QWORD:                      ValueType = "REG_QWORD"                      ' 32-bit number
      Case Else:                           ValueType = "0x" & Hex(vType)
   End Select
End Function ' ValueType(vType as rType) as String

' 문자열 값 형태를 값(Long)으로 변환
Private Function StrValueType(vType As String) As Long
'***************************************************************************************************
' 함수명 : StrValueType
' 용  도 : 문자형 데이터 타입을 상수값으로 변경
' 파라미터 갯수 : 1개 필수, 0개 옵션
'          1. vType          : 레지스트리 데이터 타입 문자형
' 리턴값 : Long - 레지스트리 값 형태의 상수값
' 범  위 : 모듈內
' 제작일 : 7월 22일 2001년
' 제작자 : 정호영 (goliat@freechal.com)
'***************************************************************************************************
   Select Case UCase(vType)
'      Case "REG_NONE":                       StrValueType = REG_NONE                       ' No value type
      Case "REG_SZ":                         StrValueType = REG_SZ                         ' Unicode nul terminated string
      Case "REG_EXPAND_SZ":                  StrValueType = REG_EXPAND_SZ                  ' Unicode nul terminated string
      Case "REG_BINARY":                     StrValueType = REG_BINARY                     ' Free form binary
      Case "REG_DWORD":                      StrValueType = REG_DWORD                      ' 32-bit number
      Case "REG_DWORD_LITTLE_ENDIAN":        StrValueType = REG_DWORD_LITTLE_ENDIAN        ' 32-bit number (same as REG_DWORD)
'      Case "REG_DWORD_BIG_ENDIAN":           StrValueType = REG_DWORD_BIG_ENDIAN           ' 32-bit number
      Case "REG_LINK":                       StrValueType = REG_LINK                       ' Symbolic Link (unicode)
      Case "REG_MULTI_SZ":                   StrValueType = REG_MULTI_SZ                   ' Multiple Unicode strings
      Case "REG_RESOURCE_LIST":              StrValueType = REG_RESOURCE_LIST              ' Resource list in the resource map
      Case "REG_FULL_RESOURCE_DESCRIPTOR":   StrValueType = REG_FULL_RESOURCE_DESCRIPTOR   ' Resource list in the resource map
      Case "REG_RESOURCE_REQUIREMENTS_LIST": StrValueType = REG_RESOURCE_REQUIREMENTS_LIST
      Case "REG_QWORD":                      StrValueType = REG_QWORD                      ' 32-bit number
      Case Else:                             StrValueType = REG_NONE                       '"Unknown Type"
   End Select
End Function ' StrValueType(vType As String) as Long
'
'Private Function ValueToString(vValue As Byte, r_Type As Long) As String
''***************************************************************************************************
'' 함수명 : ValueToString
'' 용  도 : 레지스트리 값을 문자열로 변경
'' 파라미터 갯수 : 2개 필수, 0개 옵션
''          1. vValue         : 레지스트리 값
''          2. r_Type         : 레지스트리 값 형.
'' 리턴값 : String - 문자열로 변경된 데이터
'' 범  위 : 모듈內
'' 제작일 : 7월 22일 2001년
'' 제작자 : 정호영 (goliat@freechal.com)
''***************************************************************************************************
'   Select Case r_Type
'      Case REG_NONE:                       ValueToString = CStr(vValue)       ' No value type
'      Case REG_SZ:                         ValueToString = CStr(vValue)       ' Unicode nul terminated string
'      Case REG_EXPAND_SZ:                  ValueToString = CStr(vValue)       ' Unicode nul terminated string
'      Case REG_BINARY:                     ValueToString = CStr(vValue)       ' Free form binary
'      Case REG_DWORD:                      ValueToString = CStr(vValue)       ' 32-bit number
'      Case REG_DWORD_LITTLE_ENDIAN:        ValueToString = CStr(vValue)       ' 32-bit number (same as REG_DWORD)
''      Case REG_DWORD_BIG_ENDIAN:           ValueToString = CStr(vValue)       ' 32-bit number
'      Case REG_LINK:                       ValueToString = CStr(vValue)       ' Symbolic Link (unicode)
'      Case REG_MULTI_SZ:                   ValueToString = CStr(vValue)       ' Multiple Unicode strings
'      Case REG_RESOURCE_LIST:              ValueToString = BinaryToHex(CByte(vValue))  ' Resource list in the resource map
'      Case REG_FULL_RESOURCE_DESCRIPTOR:   ValueToString = BinaryToHex(CByte(vValue))  ' Resource list in the resource map
'      Case REG_RESOURCE_REQUIREMENTS_LIST: ValueToString = BinaryToHex(CByte(vValue))
'      Case REG_QWORD:                      ValueToString = CStr(vValue)       ' 32-bit number
'      Case Else:                           ValueToString = CStr(vValue)
'   End Select
'End Function ' ValueToString(vValue as Byte, r_Type as Long) as String
'
'Private Function Byte2String(pbyte() As Byte) As String
''***************************************************************************************************
'' 함수명 : Byte2String
'' 용  도 : 바이트형 데이터를 문자열로 표시해 줌
'' 파라미터 갯수 : 1개 필수, 0개 옵션
''          1. pByte()        : Byte형 배열
'' 리턴값 : String - String형으로 변환된 데이터
'' 범  위 : 모듈內
'' 제작일 : 7월 22일 2001년
'' 제작자 : 정호영 (goliat@freechal.com)
''***************************************************************************************************
'
'      Byte2String = StrConv(pbyte, vbFromUnicode)
'End Function ' Byte2String(pByte() as Byte) as String

Public Function ByteToHex(pbyte() As Byte, Optional ByVal IsComma As Boolean = False) As String
'***************************************************************************************************
' 함수명 : ByteToHex
' 용  도 : 바이너리 배열의 값을 16진수로 표시(구분문자)
' 파라미터 갯수 : 1개 필수, 1개 옵션
'          1. pByte()       : Byte 형 배열
'          2. IsComma       : 옵션 사항 (True 이면 2자리마다 "," 추가)
' 리턴값 : String - 16진수로 변경된 문자열 ("," 문자로 바이트 단윌 분리)
' 범  위 : 전체
' 제작일 : 7월 22일 2001년
' 제작자 : 정호영 (goliat@freechal.com)
'***************************************************************************************************
   On Error Resume Next

   Dim pB() As Byte
   Dim pTmp As String

   pB = pbyte
   
   pTmp = Hex(pB(UBound(pB)))
   pTmp = String(2 - Len(pTmp), "0") & pTmp

   If UBound(pB) = 0 Then
      ByteToHex = pTmp ' & ByteToHex
      Exit Function
   End If

   ReDim Preserve pB(UBound(pB) - 1)
   ByteToHex = pTmp & IIf(IsComma = True, ",", "") & ByteToHex(pB, IsComma)

   If Left(ByteToHex, 1) = "," Then ByteToHex = Mid(ByteToHex, 2)
   If Right(ByteToHex, 1) = "," Then ByteToHex = Left(ByteToHex, Len(ByteToHex) - 1)
End Function

Public Function HexToByte(ByVal pHex As String) As Byte()
'***************************************************************************************************
' 함수명 : HexToByte
' 용  도 : 16진수 문자열을 Byte 배열에 넣어 주는 함수
' 파라미터 갯수 : 1개 필수, 0개 옵션
'          1. pHex       : 16진수 문자열
' 리턴값 : String - 16진수로 변경된 문자열 ("," 문자로 바이트 단윌 분리)
' 범  위 : 전체
' 제작일 : 7월 22일 2001년
' 제작자 : 정호영 (goliat@freechal.com)
'***************************************************************************************************
   On Error Resume Next

   Dim pi&, pTmp$, pTVal$, pArray() As Byte

   pHex = Trim(pHex)
   If InStr(1, pHex, ",") > 0 Then
      Dim pTmpStr() As String
      
      pTmpStr = Split(pHex, ",")
      ReDim pArray(UBound(pTmpStr))
      For pi = UBound(pTmpStr) To 0
         pArray(pi) = "&H" & pTmpStr(pi)
      Next pi
   Else
      pTVal$ = String(16 - Len(pHex), "0") & phtx
      For pi& = 0 To 7
         pArray(pi&) = "&H" & Mid(pTVal$, 16 - (pi& + 1) * 2, 2)
      Next pi&
   End If

   HexToByte = pArray
End Function ' HexToByte(pHex as String) as Byte()
