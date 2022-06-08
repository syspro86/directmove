Attribute VB_Name = "KSF"
Option Explicit
'API함수
Public Declare Function NViewLibLoad Lib "NViewLib.dll" (ByVal Filename As String, ByVal A As Integer) As Long
Public Declare Function NViewLibSaveAsJPG Lib "NViewLib.dll" (ByVal Quality As Integer, ByVal Filename As String) As Integer

Public Declare Function KeyState Lib "user32" Alias "GetAsyncKeyState" (ByVal vKey As Long) As Integer
Public Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal X As Long, ByVal Y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long
Public Declare Function GetTickCount Lib "kernel32" () As Long
Public Declare Function GetDC Lib "user32" (ByVal hwnd As Long) As Long

Public CBoard As String             'clip board
Public RealTimeInsert As Boolean
Public RealTimePressed As Boolean
Public RegInfo As RegistryInformation   ' 레지스트리 정보
Public ProChanging As Boolean

Public Type RegistryInformation
    FrmSave As Byte         ' 폼 정보 저장
    AutoProperty As Byte    ' 자동 정보저장
    UseLongNote As Byte     ' 롱노트 사용
    LastDir As String       ' 마지막사용한 폴더
    ResizeBetter As Byte    ' 리사이즈 베러 -_-?;
End Type

Public Type KickStepFile    'KSF파일정보
    Title As String         '제목
    StartTime As Long       '스타트타임
    StartTime2 As Long      '스타트타임2
    StartTime3 As Long      '스타트타임3
    BPM As Single       'BPM
    BPM2 As Single      'BPM2
    BPM3 As Single      'BPM3
    Bunki As Long       '분기
    Bunki2 As Long      '분기2
    Difficult As Byte   '난이도
    Tickcount As Byte   '틱카운트
    speed As Byte       '배속보기
    Filename As String  '파일이름
    Changed As Boolean  '변경되었나.
    Mode1p2p As Byte    '싱글 혹은 더블
    RealTimeFile As String
    'RealTimeFileType As String
End Type

Public Type KickStepFile2 'KSF파일정보
    Title As String '제목
    BPM As Single 'BPM
    BPM2 As Single 'BPM2
    BPM3 As Single 'BPM3
    Difficult As Byte '난이도
    Tickcount As Byte '틱카운트
    speed As Single '배속보기
    gtype As Byte
    color As Boolean
    Filename As String '파일이름
    Mode1p2p As Byte ' 싱글 혹은 더블
    Step() As String * 10
    Stepcount As Long
End Type

Public Type MultiSelect '다중선택
    Multi As Boolean '다중선택
    SelectStart As Integer '시작
    SelectEnd As Integer '끝
    Start As Integer '처음찍힌 스텝
End Type


'작업일지(?)
'   Ver 0.1
' 2001-??-?? : 초기상태 -_-;
'   Ver 0.2
' 2002-01-07 : 배속보기 기능 완성 -_-v
' 2002-01-08 : 복사 붙여넣기 기능 완성 -_-v
' 2002-01-08 : 전체선택 -_-;;;;
' 2002-01-09 : 그자리에 붙여넣기
'   Ver 0.3
' 2002-01-10 : 폼 크기에 따라 스텝표시 변경 (엄청난 업그레이드다 -_-)
' 2002-01-11 : MDI형식 채택
' 2002-01-11 : 더블모드완성 ㅠ_ㅠ
'   Ver 0.35
' 2002-01-12 : 키변경 -_- Insert,Delete
' 2002-01-12 : 아이콘 몇개 추가 (추가,삭제,싱글/더블,실시간)
'   Ver 0.36
' 2002-01-12 : 실시간 입력 완성 ㅠ_ㅠ
'   Ver 0.4
' 2002-01-12 : 분기로 뽑아내기
' 2002-01-13 : KSF2BMP
'   Ver 0.41
' 2002-01-13 : Real Player -> Media Player
' 2002-01-13 : 4 Arrow Editing
' 2002-01-14 : KSF Viewer, 실시간 음악 파일 자동 로드
' 2002-01-14 : 1P 2P 같은채보
'   Ver 0.45
' 2002-01-14 : 좌우,상하 회전 -_-
'   Ver 0.455
' 2002-01-29 : MRU목록 삭제
'   Ver 0.5
' 2002-02-01 : 여러 자잘한 것들 수정
' 2002-02-02 : 롱노트!
' 2002-??-?? : 4 Arrow Editing 없앰
'   Ver 0.52
' 2002-02-13 : OLEDrop
'   Ver 0.535
' 2002-02-28 : KSF2BMP 다듬기
