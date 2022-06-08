Attribute VB_Name = "Module1"
Option Explicit
'API함수
Public Declare Function GetAsyncKeyState Lib "user32" (ByVal vKey As Long) As Integer
Public Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long
Public Declare Function GetDC Lib "user32" (ByVal hwnd As Long) As Long
Public Declare Function GetTickCount Lib "kernel32" () As Long
Public Declare Function mciSendString Lib "winmm.dll" Alias "mciSendStringA" (ByVal lpstrCommand As String, ByVal lpstrReturnString As String, ByVal uReturnLength As Long, ByVal hwndCallback As Long) As Long

Public KSFViewerFocus As Boolean
Public KSFVIewerSpeed As Integer
Global retVal As Long, RetStr As String * 128
Global rfSpeed As Integer
Global openFileName
Global filepath

Type KickStepFile 'KSF파일정보
    Title As String '제목
    StartTime As Long '스타트타임
    StartTime2 As Long '스타트타임2
    StartTime3 As Long '스타트타임3
    BPM As Single 'BPM
    BPM2 As Single 'BPM2
    BPM3 As Single 'BPM3
    Bunki As Long '분기
    Bunki2 As Long '분기2
    Difficult As Integer '난이도
    TickCount As Integer '틱카운트
    Speed As Integer '배속보기
    FileName As String '파일이름
    Changed As Boolean '변경되었나.
    Mode1p2p As Integer ' 싱글 혹은 더블
    RealTimeFile As String
End Type
Public Sub openMp3(file As String)
    Call closeMp3
    retVal = mciSendString("open " & Chr$(34) & file & Chr$(34) & " alias mp wait", RetStr, 128, 0)
End Sub
Public Sub playMp3()
    retVal = mciSendString("play mp", RetStr, 128, 0)
End Sub
Public Sub stopMp3()
    Call closeMp3
End Sub
Public Sub closeMp3()
    retVal = mciSendString("close mp", RetStr, 128, 0)
End Sub
Public Function getMp3Pos() As String   '그 음악의 현재 시간
    Dim TTime As String
    retVal = mciSendString("status mp position", RetStr, 128, 0)
    TTime = Val(RetStr)
    getMp3Pos = CDbl(TTime)
End Function
Public Function getMp3Len() As String   '그 음악의 총시간
    Dim TTime As String
    retVal = mciSendString("status mp length wait", RetStr, 128, 0)
    TTime = Val(RetStr)
    If Len(TTime) <= 3 Then getMp3Len = "00:00": Exit Function
    getMp3Len = CDbl(TTime)
End Function
Public Sub chgMp3Pos(Place As Single)
    retVal = mciSendString("play mp from " & CStr(Place), 0, 0, 0)
End Sub

'작업일지(?)
'   Ver 0.1
'KSFCreator 에서 나옴 -_-
'   Ver 0.2
'롱노트 -_-
