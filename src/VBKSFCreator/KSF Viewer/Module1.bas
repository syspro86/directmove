Attribute VB_Name = "Module1"
Option Explicit
'API�Լ�
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

Type KickStepFile 'KSF��������
    Title As String '����
    StartTime As Long '��ŸƮŸ��
    StartTime2 As Long '��ŸƮŸ��2
    StartTime3 As Long '��ŸƮŸ��3
    BPM As Single 'BPM
    BPM2 As Single 'BPM2
    BPM3 As Single 'BPM3
    Bunki As Long '�б�
    Bunki2 As Long '�б�2
    Difficult As Integer '���̵�
    TickCount As Integer 'ƽī��Ʈ
    Speed As Integer '��Ӻ���
    FileName As String '�����̸�
    Changed As Boolean '����Ǿ���.
    Mode1p2p As Integer ' �̱� Ȥ�� ����
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
Public Function getMp3Pos() As String   '�� ������ ���� �ð�
    Dim TTime As String
    retVal = mciSendString("status mp position", RetStr, 128, 0)
    TTime = Val(RetStr)
    getMp3Pos = CDbl(TTime)
End Function
Public Function getMp3Len() As String   '�� ������ �ѽð�
    Dim TTime As String
    retVal = mciSendString("status mp length wait", RetStr, 128, 0)
    TTime = Val(RetStr)
    If Len(TTime) <= 3 Then getMp3Len = "00:00": Exit Function
    getMp3Len = CDbl(TTime)
End Function
Public Sub chgMp3Pos(Place As Single)
    retVal = mciSendString("play mp from " & CStr(Place), 0, 0, 0)
End Sub

'�۾�����(?)
'   Ver 0.1
'KSFCreator ���� ���� -_-
'   Ver 0.2
'�ճ�Ʈ -_-
