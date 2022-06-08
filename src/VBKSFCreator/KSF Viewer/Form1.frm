VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form Form1 
   AutoRedraw      =   -1  'True
   BackColor       =   &H00FFFFFF&
   Caption         =   "KSFViewer"
   ClientHeight    =   6045
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   7605
   LinkTopic       =   "Form1"
   ScaleHeight     =   403
   ScaleMode       =   3  '픽셀
   ScaleWidth      =   507
   StartUpPosition =   3  'Windows 기본값
   Begin MSComDlg.CommonDialog DlgBox 
      Left            =   2100
      Top             =   3000
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.PictureBox PicArrowLong 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   1920
      Index           =   1
      Left            =   2760
      Picture         =   "Form1.frx":0000
      ScaleHeight     =   128
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   19
      Top             =   120
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.PictureBox PicArrowLong 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   1920
      Index           =   0
      Left            =   2520
      Picture         =   "Form1.frx":1842
      ScaleHeight     =   128
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   18
      Top             =   120
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.Timer Timer1 
      Interval        =   50
      Left            =   960
      Top             =   2520
   End
   Begin VB.FileListBox FileSong 
      Height          =   270
      Left            =   75
      Pattern         =   "Song.mp3"
      TabIndex        =   17
      Top             =   1680
      Visible         =   0   'False
      Width           =   855
   End
   Begin RichTextLib.RichTextBox ReadBox 
      Height          =   375
      Left            =   75
      TabIndex        =   16
      Top             =   1200
      Visible         =   0   'False
      Width           =   2415
      _ExtentX        =   4260
      _ExtentY        =   661
      _Version        =   393217
      Enabled         =   -1  'True
      Appearance      =   0
      TextRTF         =   $"Form1.frx":3084
   End
   Begin VB.PictureBox PicArrow 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   240
      Index           =   0
      Left            =   120
      Picture         =   "Form1.frx":3121
      ScaleHeight     =   16
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   15
      Top             =   120
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.PictureBox PicArrow 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   240
      Index           =   1
      Left            =   360
      Picture         =   "Form1.frx":3463
      ScaleHeight     =   16
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   14
      Top             =   120
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.PictureBox PicArrow 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   240
      Index           =   2
      Left            =   600
      Picture         =   "Form1.frx":37A5
      ScaleHeight     =   16
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   13
      Top             =   120
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.PictureBox PicArrow 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   240
      Index           =   3
      Left            =   840
      Picture         =   "Form1.frx":3AE7
      ScaleHeight     =   16
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   12
      Top             =   120
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.PictureBox PicArrow 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   240
      Index           =   4
      Left            =   1080
      Picture         =   "Form1.frx":3E29
      ScaleHeight     =   16
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   11
      Top             =   120
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.PictureBox PicArrow 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   240
      Index           =   5
      Left            =   120
      Picture         =   "Form1.frx":416B
      ScaleHeight     =   16
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   10
      Top             =   360
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.PictureBox PicArrow 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   240
      Index           =   6
      Left            =   360
      Picture         =   "Form1.frx":44AD
      ScaleHeight     =   16
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   9
      Top             =   360
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.PictureBox PicArrow 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   240
      Index           =   7
      Left            =   600
      Picture         =   "Form1.frx":47EF
      ScaleHeight     =   16
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   8
      Top             =   360
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.PictureBox PicArrow 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   240
      Index           =   8
      Left            =   840
      Picture         =   "Form1.frx":4B31
      ScaleHeight     =   16
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   7
      Top             =   360
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.PictureBox PicArrow 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   240
      Index           =   9
      Left            =   1080
      Picture         =   "Form1.frx":4E73
      ScaleHeight     =   16
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   6
      Top             =   360
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.PictureBox PicArrow 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   240
      Index           =   10
      Left            =   120
      Picture         =   "Form1.frx":51B5
      ScaleHeight     =   16
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   5
      Top             =   600
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.PictureBox PicArrow 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   240
      Index           =   11
      Left            =   360
      Picture         =   "Form1.frx":54F7
      ScaleHeight     =   16
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   4
      Top             =   600
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.PictureBox PicArrow 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   240
      Index           =   12
      Left            =   600
      Picture         =   "Form1.frx":5839
      ScaleHeight     =   16
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   3
      Top             =   600
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.PictureBox PicArrow 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   240
      Index           =   13
      Left            =   840
      Picture         =   "Form1.frx":5B7B
      ScaleHeight     =   16
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   2
      Top             =   600
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.PictureBox PicArrow 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   240
      Index           =   14
      Left            =   1080
      Picture         =   "Form1.frx":5EBD
      ScaleHeight     =   16
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   1
      Top             =   600
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.PictureBox PicTOP 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   240
      Left            =   75
      Picture         =   "Form1.frx":61FF
      ScaleHeight     =   16
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   160
      TabIndex        =   0
      Top             =   840
      Visible         =   0   'False
      Width           =   2400
   End
   Begin VB.Menu mnuOpen 
      Caption         =   "열기"
      Visible         =   0   'False
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim Step(2048) As String '스텝정보
Dim StepIndex As Long '선택된 스텝
Dim StepCount As Long '스텝수
Dim KSFile As KickStepFile '정보
Dim LastGetTicks As Double ' 틱카운트 마지막에 설정한 값
Dim FormShown As Boolean
Dim FileName As String
Public Sub KSFViewer()
On Error Resume Next
Dim BPMBPM As Double, STARTTIMEPLUS As Integer, Score As Long
Dim A As Integer, B As Integer, x As Integer, y As Integer, z As Integer, M As Boolean, N As Boolean
'A는 리스트에서 뽑아올때,B는 화살표 읽을때, X,Y는 좌표 , Z는 선 or 점선
openMp3 KSFile.RealTimeFile
StepIndex = 0
BPMBPM = (60000 / (KSFile.BPM * KSFile.TickCount))
If KSFile.Speed < 1 Then KSFile.Speed = 1
STARTTIMEPLUS = Int((KSFile.StartTime * 10) / BPMBPM)
chgMp3Pos CSng(((KSFile.StartTime * 10) - (STARTTIMEPLUS * BPMBPM)) / 1000)
playMp3
LastGetTicks = GetTickCount
KSFVIewerSpeed = KSFile.Speed
Do
DoEvents
If GetTickCount - LastGetTicks >= BPMBPM Then
KSFile.Speed = KSFVIewerSpeed
StepIndex = StepIndex + 1
LastGetTicks = GetTickCount - ((GetTickCount - LastGetTicks) - BPMBPM)
Me.Cls
Me.Caption = "KSFViewer - " & KSFile.Title & " - Score : " & Score
' 롱노트 그리기
x = 0: y = 0: z = 0
For A = StepIndex - STARTTIMEPLUS To StepIndex + (64 * KSFile.TickCount / KSFile.Speed) - 1 - STARTTIMEPLUS
    If A >= 0 Then
    For B = 0 To KSFile.Mode1p2p * 5 - 1
    If Mid(Step(A), B + 1, 1) = "4" Then
    If Mid(Step(A + 1), B + 1, 1) <> "4" Then
        BitBlt Me.hDC, (B * 16 + x * 100 * KSFile.Mode1p2p) + 5, y * 16 / KSFile.TickCount, 16, 8, PicArrowLong(1).hDC, 0, 0, vbSrcAnd
        BitBlt Me.hDC, (B * 16 + x * 100 * KSFile.Mode1p2p) + 5, y * 16 / KSFile.TickCount, 16, 8, PicArrowLong(0).hDC, 0, 0, vbSrcPaint
    ElseIf Mid(Step(A - 1), B + 1, 1) <> "4" Then
    BitBlt Me.hDC, (B * 16 + x * 100 * KSFile.Mode1p2p) + 5, y * 16 / KSFile.TickCount + 8, 16, ((16 / KSFile.TickCount) * KSFile.Speed) - 8, PicArrowLong(1).hDC, 0, 0, vbSrcAnd
    BitBlt Me.hDC, (B * 16 + x * 100 * KSFile.Mode1p2p) + 5, y * 16 / KSFile.TickCount + 8, 16, ((16 / KSFile.TickCount) * KSFile.Speed) - 8, PicArrowLong(0).hDC, 0, 0, vbSrcPaint
    Else
    BitBlt Me.hDC, (B * 16 + x * 100 * KSFile.Mode1p2p) + 5, y * 16 / KSFile.TickCount, 16, ((16 / KSFile.TickCount) * KSFile.Speed), PicArrowLong(1).hDC, 0, 0, vbSrcAnd
    BitBlt Me.hDC, (B * 16 + x * 100 * KSFile.Mode1p2p) + 5, y * 16 / KSFile.TickCount, 16, ((16 / KSFile.TickCount) * KSFile.Speed), PicArrowLong(0).hDC, 0, 0, vbSrcPaint
    End If
    End If
    Next
    y = y + KSFile.Speed
    If A + 1 = StepCount Then Exit For
    Else
        y = y + KSFile.Speed
    End If
Next
BitBlt Me.hDC, 5, 0, 80 * KSFile.Mode1p2p, 16, Me.PicTOP.hDC, 0, 0, vbSrcCopy
' 스텝 그리기
x = 0: y = 0: z = 0
For A = StepIndex - STARTTIMEPLUS To StepIndex + (64 * KSFile.TickCount / KSFile.Speed) - 1 - STARTTIMEPLUS
    If A >= 0 Then
    For B = 0 To KSFile.Mode1p2p * 5 - 1
    M = IIf(A = 0, (Mid(Step(A), B + 1, 1) = "4"), ((Mid(Step(A), B + 1, 1) = "4") And (Mid(Step(A - 1), B + 1, 1) <> "4")))
    N = IIf(A = 0, (Mid(Step(A), B + 1, 1) = "4"), ((Mid(Step(A), B + 1, 1) = "4") And (Mid(Step(A + 1), B + 1, 1) <> "4")))
    If (Mid(Step(A), B + 1, 1) = "1") Or M = True Or N = True Then
        If A = StepIndex - STARTTIMEPLUS Then
        BitBlt Me.hDC, (B * 16 + x * 100 * KSFile.Mode1p2p) + 5, y * 16 / KSFile.TickCount, 16, 16, PicArrow((B Mod 5) + 10).hDC, 0, 0, vbSrcAnd
        BitBlt Me.hDC, (B * 16 + x * 100 * KSFile.Mode1p2p) + 5, y * 16 / KSFile.TickCount, 16, 16, PicArrow((B Mod 5)).hDC, 0, 0, vbSrcPaint
        Score = Score + 1
        Else
        BitBlt Me.hDC, (B * 16 + x * 100 * KSFile.Mode1p2p) + 5, y * 16 / KSFile.TickCount, 16, 16, PicArrow((B Mod 5) + 10).hDC, 0, 0, vbSrcAnd
        BitBlt Me.hDC, (B * 16 + x * 100 * KSFile.Mode1p2p) + 5, y * 16 / KSFile.TickCount, 16, 16, PicArrow((B Mod 5) + 5).hDC, 0, 0, vbSrcPaint
        End If
    End If
    Next
    y = y + KSFile.Speed
    If A + 1 = StepCount Then Exit For
    Else
        y = y + KSFile.Speed
    End If
Next
End If
If StepIndex + 1 - STARTTIMEPLUS >= StepCount Then Exit Do
Loop
stopMp3
End
End Sub
Private Sub ReadKSF(path As String)
On Error Resume Next
Dim Temp As Integer, Temp2 As Integer, Temp3 As Integer, Data As String
Temp2 = 0: Temp3 = 0
KSFile.Title = ""
KSFile.StartTime = 0
KSFile.StartTime2 = -1
KSFile.StartTime3 = -1
KSFile.BPM = 0
KSFile.BPM2 = -1
KSFile.BPM3 = -1
KSFile.Bunki = -1
KSFile.Bunki2 = -1
KSFile.Difficult = -1
KSFile.TickCount = 4
Data = ReadBox.Text
Do Until UCase(Mid(Data, 1, 5)) = "#STEP"
    If Data = "" Then GoTo A
    Temp2 = Temp2 + 1
    If Temp2 = 30 Then Exit Sub
    Temp = 0
    Do Until Mid(Data, Temp, 1) = ";" ' Temp 번째가 문자가 ; 가 될때까지 반복한다
        DoEvents
        Temp = Temp + 1 ' Temp를 1씩 증가
        If Temp > Len(Data) Then Exit Sub ' Temp가 전체길이보다 크면 빠져나온다
    Loop ' 반복한다
    If UCase(Mid(Data, 2, 5)) = "TITLE" Then
        KSFile.Title = Mid(Data, 8, Temp - 8)
    ElseIf UCase(Mid(Data, 2, 10)) = "STARTTIME:" Then
        KSFile.StartTime = Val(Mid(Data, 12, Temp - 12))
    ElseIf UCase(Mid(Data, 2, 10)) = "STARTTIME2" Then
        KSFile.StartTime2 = Val(Mid(Data, 13, Temp - 13))
    ElseIf UCase(Mid(Data, 2, 10)) = "STARTTIME3" Then
        KSFile.StartTime3 = Val(Mid(Data, 13, Temp - 13))
    ElseIf UCase(Mid(Data, 2, 4)) = "BPM:" Then
        KSFile.BPM = Val(Mid(Data, 6, Temp - 6))
    ElseIf UCase(Mid(Data, 2, 4)) = "BPM2" Then
        KSFile.BPM2 = Val(Mid(Data, 7, Temp - 7))
    ElseIf UCase(Mid(Data, 2, 4)) = "BPM3" Then
        KSFile.BPM3 = Val(Mid(Data, 7, Temp - 7))
    ElseIf UCase(Mid(Data, 2, 6)) = "BUNKI:" Then
        KSFile.Bunki = Val(Mid(Data, 8, Temp - 8))
    ElseIf UCase(Mid(Data, 2, 6)) = "BUNKI2" Then
        KSFile.Bunki2 = Val(Mid(Data, 9, Temp - 9))
    ElseIf UCase(Mid(Data, 2, 10)) = "DIFFICULTY" Then
        KSFile.Difficult = Val(Mid(Data, 13, Temp - 13))
    ElseIf UCase(Mid(Data, 2, 9)) = "TICKCOUNT" Then
        KSFile.TickCount = Val(Mid(Data, 12, Temp - 12))
    End If
    Data = Mid(Data, Temp + 3, Len(Data))
Loop
Me.Caption = KSFile.Title
KSFile.FileName = path
Do Until Mid(KSFile.FileName, Len(KSFile.FileName) - Temp3, 1) = "\"
DoEvents
Temp3 = Temp3 + 1
Loop
FileSong.path = Mid(KSFile.FileName, 1, Len(KSFile.FileName) - Temp3)
If FileSong.ListCount = 1 Then KSFile.RealTimeFile = FileSong.path & "\Song.mp3"
AddFromKSF Data
A:
End Sub
Private Function AddFromKSF(Data As String) As String
Dim Temp As Integer
Data = Mid(Data, 9, Len(Data))
StepCount = 0
StepIndex = 0
KSFile.Mode1p2p = 1
Do
DoEvents
If Mid(Data, 1, 1) = "2" Then Exit Do
Step(StepCount) = Mid(Data, 1, 10)
If Mid(Step(StepCount), 6, 1) = "1" Or Mid(Step(StepCount), 7, 1) = "1" Or Mid(Step(StepCount), 8, 1) = "1" Or Mid(Step(StepCount), 9, 1) = "1" Or Mid(Step(StepCount), 10, 1) = "1" Then KSFile.Mode1p2p = 2
Temp = 0
    Do
    DoEvents
    Temp = Temp + 1
    If Mid(Data, Temp, 2) = vbCrLf Then Exit Do
    Loop
Data = Mid(Data, Temp + 2, Len(Data))
StepCount = StepCount + 1
If Len(Data) < 10 Then Exit Do
Loop
StepIndex = 0
End Function
Private Sub Form_Load()
On Error GoTo Ending
DlgBox.CancelError = True
DlgBox.Filter = "KSF(*.ksf)|*.ksf"
DlgBox.DialogTitle = "KSF파일 찾기 - 그 폴더에 Song.MP3가 있어야함"
If Command$ <> "" Then
FileName = Mid(Command$, 2, Len(Command$) - 2)
ReadBox.LoadFile FileName, rtfText
ReadKSF FileName
FormShown = True
Else
mnuOpen.Visible = True
End If
Exit Sub
Ending:
End
End Sub
Private Sub mnuOpen_Click()
On Error GoTo Ending
DlgBox.ShowOpen
FileName = DlgBox.FileName
ReadBox.LoadFile FileName, rtfText
ReadKSF FileName
FormShown = True
mnuOpen.Visible = False
Ending:
End Sub
Private Sub Form_Resize()
On Error Resume Next
Me.Width = 2700
End Sub
Private Sub Form_Unload(Cancel As Integer)
stopMp3
End
End Sub
Public Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
On Error Resume Next
Select Case KeyCode
Case vbKey1
KSFVIewerSpeed = 1
Case vbKey2
KSFVIewerSpeed = 2
Case vbKey3
KSFVIewerSpeed = 3
Case vbKey4
KSFVIewerSpeed = 4
Case vbKey5
KSFVIewerSpeed = 5
Case vbKey6
KSFVIewerSpeed = 6
Case vbKey7
KSFVIewerSpeed = 7
Case vbKey8
KSFVIewerSpeed = 8
End Select
End Sub
Private Sub Timer1_Timer()
If FormShown = True Then
    Timer1.Interval = 0
    Timer1.Enabled = False
    KSFViewer
End If
End Sub
