Attribute VB_Name = "mp3_Mod"
Option Explicit
'mp3포멧을 재생해주는 api 함수
Public Declare Function mciSendString Lib "winmm.dll" Alias "mciSendStringA" (ByVal lpstrCommand As String, ByVal lpstrReturnString As String, ByVal uReturnLength As Long, ByVal hwndCallback As Long) As Long
'mciSendString 함수의 리턴값과 보존변수
Dim retVal As Long, RetStr As String * 128
Dim rfSpeed As Integer
Dim openFileName
Dim filepath
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
    getMp3Len = CDbl(TTime)
End Function
Public Sub chgMp3Pos(Place As Single)
    retVal = mciSendString("play mp from " & CStr(Place), 0, 0, 0)
End Sub
