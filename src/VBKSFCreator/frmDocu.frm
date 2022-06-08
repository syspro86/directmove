VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomct2.ocx"
Begin VB.Form FrmDocu 
   Appearance      =   0  '평면
   AutoRedraw      =   -1  'True
   BackColor       =   &H80000005&
   Caption         =   "New"
   ClientHeight    =   3765
   ClientLeft      =   165
   ClientTop       =   855
   ClientWidth     =   4755
   Icon            =   "frmDocu.frx":0000
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   251
   ScaleMode       =   3  '픽셀
   ScaleWidth      =   317
   Begin VB.TextBox ReadBox 
      Height          =   375
      Left            =   120
      MultiLine       =   -1  'True
      TabIndex        =   22
      Top             =   2880
      Visible         =   0   'False
      Width           =   3495
   End
   Begin VB.PictureBox PicArrowLong 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   1920
      Index           =   0
      Left            =   2520
      Picture         =   "frmDocu.frx":000C
      ScaleHeight     =   128
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   21
      Top             =   480
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.PictureBox PicArrowLong 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   1920
      Index           =   1
      Left            =   2760
      Picture         =   "frmDocu.frx":184E
      ScaleHeight     =   128
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   20
      Top             =   480
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.PictureBox PicArrow 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   240
      Index           =   14
      Left            =   3480
      Picture         =   "frmDocu.frx":3090
      ScaleHeight     =   16
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   19
      Top             =   120
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.PictureBox PicArrow 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   240
      Index           =   13
      Left            =   3240
      Picture         =   "frmDocu.frx":33D2
      ScaleHeight     =   16
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   18
      Top             =   120
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.PictureBox PicArrow 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   240
      Index           =   12
      Left            =   3000
      Picture         =   "frmDocu.frx":3714
      ScaleHeight     =   16
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   17
      Top             =   120
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.PictureBox PicArrow 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   240
      Index           =   11
      Left            =   2760
      Picture         =   "frmDocu.frx":3A56
      ScaleHeight     =   16
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   16
      Top             =   120
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.PictureBox PicArrow 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   240
      Index           =   10
      Left            =   2520
      Picture         =   "frmDocu.frx":3D98
      ScaleHeight     =   16
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   15
      Top             =   120
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.FileListBox FileSong 
      Height          =   270
      Left            =   2640
      Pattern         =   "Song.mp3"
      TabIndex        =   14
      Top             =   3360
      Visible         =   0   'False
      Width           =   855
   End
   Begin MSComCtl2.FlatScrollBar ScrRows 
      Height          =   255
      Left            =   120
      TabIndex        =   13
      Top             =   2520
      Width           =   3495
      _ExtentX        =   6165
      _ExtentY        =   450
      _Version        =   393216
      Arrows          =   65536
      Max             =   0
      Orientation     =   1179649
   End
   Begin VB.PictureBox PicArrow 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   240
      Index           =   0
      Left            =   120
      Picture         =   "frmDocu.frx":40DA
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
      Index           =   1
      Left            =   360
      Picture         =   "frmDocu.frx":441C
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
      Index           =   2
      Left            =   600
      Picture         =   "frmDocu.frx":475E
      ScaleHeight     =   16
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   10
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
      Picture         =   "frmDocu.frx":4AA0
      ScaleHeight     =   16
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   9
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
      Picture         =   "frmDocu.frx":4DE2
      ScaleHeight     =   16
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   8
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
      Left            =   1320
      Picture         =   "frmDocu.frx":5124
      ScaleHeight     =   16
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   7
      Top             =   120
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.PictureBox PicArrow 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   240
      Index           =   6
      Left            =   1560
      Picture         =   "frmDocu.frx":5466
      ScaleHeight     =   16
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   6
      Top             =   120
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.PictureBox PicArrow 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   240
      Index           =   7
      Left            =   1800
      Picture         =   "frmDocu.frx":57A8
      ScaleHeight     =   16
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   5
      Top             =   120
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.PictureBox PicArrow 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   240
      Index           =   8
      Left            =   2040
      Picture         =   "frmDocu.frx":5AEA
      ScaleHeight     =   16
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   4
      Top             =   120
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.PictureBox PicArrow 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   240
      Index           =   9
      Left            =   2280
      Picture         =   "frmDocu.frx":5E2C
      ScaleHeight     =   16
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   3
      Top             =   120
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.PictureBox PicLine 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   15
      Index           =   0
      Left            =   120
      Picture         =   "frmDocu.frx":616E
      ScaleHeight     =   1
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   160
      TabIndex        =   2
      Top             =   3360
      Visible         =   0   'False
      Width           =   2400
   End
   Begin VB.PictureBox PicLine 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   15
      Index           =   1
      Left            =   120
      Picture         =   "frmDocu.frx":6390
      ScaleHeight     =   1
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   160
      TabIndex        =   1
      Top             =   3480
      Visible         =   0   'False
      Width           =   2400
   End
   Begin VB.PictureBox PicLine 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   1920
      Index           =   2
      Left            =   120
      Picture         =   "frmDocu.frx":65B4
      ScaleHeight     =   128
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   160
      TabIndex        =   0
      Top             =   480
      Visible         =   0   'False
      Width           =   2400
   End
End
Attribute VB_Name = "FrmDocu"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim Step() As String * 10   ' 스텝정보
Dim StepIndex As Integer    ' 선택된 스텝
Dim Stepcount As Integer    ' 스텝수
Dim KSFile As KickStepFile  ' 정보
Dim Multi As MultiSelect    ' 다중선택
Dim TotalWidth As Integer   ' 총 넓이 스크롤을 이용해서 스텝을 표시해 사용
Dim CanDWidth As Integer    ' 표시 할수 있는 총 넓이
Dim CanDHeight As Integer   ' 표시 할수 있는 총 높이
Dim NowLeft As Integer      ' 현재 X 좌표
Dim LastGetTicks As Double  ' 틱카운트 마지막에 설정한 값
'Dim EditTick As Long
Private Sub Form_GotFocus()
Select Case KSFile.speed
Case 0
KSFile.speed = 1
Form1.tbToolBar.Buttons(9).Image = 7
Case 1
Form1.tbToolBar.Buttons(9).Image = 7
Case 2
Form1.tbToolBar.Buttons(9).Image = 8
Case 4
Form1.tbToolBar.Buttons(9).Image = 9
Case 8
Form1.tbToolBar.Buttons(9).Image = 10
End Select
Change1p2p KSFile.Mode1p2p
If RegInfo.AutoProperty = 1 Then Form1.ctlPro.Returns
ScrRows.Max = TotalWidth
ScrRows.Value = NowLeft
Form1.StatusBar.Panels(2).Text = StepIndex + 1 & " Keyboard"
Form1.StatusBar.Panels(4).Text = Stepcount & " Steps"
Redraw
End Sub
Private Sub Form_LostFocus()
RealTimeInsert = False
If RegInfo.AutoProperty = 1 Then Form1.ctlPro.Returns
End Sub
Private Sub Form_Resize()
On Error Resume Next
CanDWidth = Int(Me.ScaleWidth / ((80 * KSFile.Mode1p2p) + 20))
CanDHeight = Int((Me.ScaleHeight - ScrRows.Height) / (64 * (RegInfo.ResizeBetter + 1)))
ScrRows.Left = 0
ScrRows.Top = Me.ScaleHeight - ScrRows.Height
ScrRows.Width = Me.ScaleWidth
If KSFile.Tickcount = 0 Then KSFile.Tickcount = 4
If KSFile.speed = 0 Then KSFile.speed = 1
Do
DoEvents
If StepIndex < (NowLeft * (4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount / KSFile.speed) Then
    NowLeft = NowLeft - 1
    ScrRows.Value = NowLeft
Else
    Exit Do
End If
Loop
Redraw
End Sub
Private Sub Form_Unload(Cancel As Integer)
If KSFile.Changed = True Then
Dim strMsgCode_Msg As String, strMsgCode_Title As String
Dim strMsgCode_Style As VbMsgBoxStyle
Dim strMsgCode_Response As VbMsgBoxResult
strMsgCode_Msg = "변경내용을 " & KSFile.Title & "에 저장할까요?"
strMsgCode_Style = vbYesNoCancel + vbDefaultButton1 + vbExclamation + vbApplicationModal
strMsgCode_Title = "KSFCreator"
strMsgCode_Response = MsgBox(strMsgCode_Msg, strMsgCode_Style, strMsgCode_Title)
Select Case strMsgCode_Response
    Case vbYes
    If Mid(Me.Caption, 1, 3) = "New" Then
    With Form1.DlgBox
    .Filename = ""
    .ShowSave
    If .Filename = "" Then
        Cancel = 1
        Exit Sub
    End If
    SaveKSF True
    End With
    Else
    SaveKSF False
    End If
    Case vbNo
    Case vbCancel
        Cancel = 1
End Select
Else
End If
End Sub
Public Sub SelectAll()
Multi.Multi = True
Multi.SelectStart = 0
Multi.SelectEnd = Stepcount - 1
Multi.Start = 0
Redraw
End Sub
Public Sub EditCopy()
CBoard = ""
If Multi.Multi = False Then
    CBoard = Step(StepIndex)
Else
    Dim A As Long
    For A = Multi.SelectStart To Multi.SelectEnd
        CBoard = CBoard & Step(A)
    Next
End If
End Sub
Public Sub EditPaste(Index As Integer)
Dim A As Integer
Select Case Index
Case 0
    A = Len(CBoard)
    PasteSteps A / 10, CBoard
Case 1
    A = Len(CBoard)
    PasteSteps2 A / 10, CBoard
End Select
KSFile.Changed = True
End Sub
Private Sub ScrRows_Change()
NowLeft = ScrRows.Value
Redraw
End Sub
Public Sub ReadKSF(Optional Start As Boolean = False, Optional Path As String = "")
On Error Resume Next
Dim temp As Integer, Temp2 As Integer, Temp3 As Integer, data As String
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
KSFile.Difficult = 255
KSFile.Tickcount = 4
data = ReadBox.Text
If Start = False Then
    KSFile.Filename = Form1.DlgBox.Filename
    Do Until Mid(KSFile.Filename, Len(KSFile.Filename) - Temp3, 1) = "\"
    DoEvents
    Temp3 = Temp3 + 1
    Loop
    FileSong.Path = Mid(KSFile.Filename, 1, Len(KSFile.Filename) - Temp3)
    RegInfo.LastDir = FileSong.Path
    If FileSong.ListCount = 1 Then KSFile.RealTimeFile = FileSong.Path & "\Song.mp3"
ElseIf Start = True Then
    KSFile.Filename = Path
    Do Until Mid(KSFile.Filename, Len(KSFile.Filename) - Temp3, 1) = "\"
    DoEvents
    Temp3 = Temp3 + 1
    Loop
    FileSong.Path = Mid(KSFile.Filename, 1, Len(KSFile.Filename) - Temp3)
    RegInfo.LastDir = FileSong.Path
    If FileSong.ListCount = 1 Then KSFile.RealTimeFile = FileSong.Path & "\Song.mp3"
End If
Do Until UCase(Mid(data, 1, 5)) = "#STEP"
    If data = "" Then GoTo A
    Temp2 = Temp2 + 1
    If Temp2 = 30 Then Exit Sub
    temp = 0
    Do Until Mid(data, temp, 1) = ";" ' Temp 번째가 문자가 ; 가 될때까지 반복한다
        DoEvents
        temp = temp + 1 ' Temp를 1씩 증가
        If temp > Len(data) Then Exit Sub ' Temp가 전체길이보다 크면 빠져나온다
    Loop ' 반복한다
    If UCase(Mid(data, 2, 5)) = "TITLE" Then
        KSFile.Title = Mid(data, 8, temp - 8)
    ElseIf UCase(Mid(data, 2, 10)) = "STARTTIME:" Then
        KSFile.StartTime = Val(Mid(data, 12, temp - 12))
    ElseIf UCase(Mid(data, 2, 10)) = "STARTTIME2" Then
        KSFile.StartTime2 = Val(Mid(data, 13, temp - 13))
    ElseIf UCase(Mid(data, 2, 10)) = "STARTTIME3" Then
        KSFile.StartTime3 = Val(Mid(data, 13, temp - 13))
    ElseIf UCase(Mid(data, 2, 4)) = "BPM:" Then
        KSFile.BPM = Val(Mid(data, 6, temp - 6))
    ElseIf UCase(Mid(data, 2, 4)) = "BPM2" Then
        KSFile.BPM2 = Val(Mid(data, 7, temp - 7))
    ElseIf UCase(Mid(data, 2, 4)) = "BPM3" Then
        KSFile.BPM3 = Val(Mid(data, 7, temp - 7))
    ElseIf UCase(Mid(data, 2, 6)) = "BUNKI:" Then
        KSFile.Bunki = Val(Mid(data, 8, temp - 8))
    ElseIf UCase(Mid(data, 2, 6)) = "BUNKI2" Then
        KSFile.Bunki2 = Val(Mid(data, 9, temp - 9))
    ElseIf UCase(Mid(data, 2, 10)) = "DIFFICULTY" Then
        KSFile.Difficult = Val(Mid(data, 13, temp - 13))
    ElseIf UCase(Mid(data, 2, 9)) = "TICKCOUNT" Then
        KSFile.Tickcount = Val(Mid(data, 12, temp - 12))
    End If
    data = Mid(data, temp + 3, Len(data))
Loop
If UCase(Right(KSFile.Filename, 10)) = "DOUBLE.KSF" Or UCase(Right(KSFile.Filename, 6)) = "_2.KSF" Then Change1p2p 2
Me.Caption = KSFile.Title
AddFromKSF data
If RegInfo.AutoProperty = 1 Then Form1.ctlPro.Returns
A:
End Sub
Public Sub SaveKSF(Optional SaveAs As Boolean = True)
Dim data As String, FileNum As Integer, Temp3 As Integer
Form1.ctlPro.Accept
data = ""
data = data & "#TITLE:" & KSFile.Title & ";" & vbCrLf
data = data & "#BPM:" & KSFile.BPM & ";" & vbCrLf
If KSFile.BPM2 <> -1 Then data = data & "#BPM2:" & KSFile.BPM2 & ";" & vbCrLf
If KSFile.BPM3 <> -1 Then data = data & "#BPM3:" & KSFile.BPM3 & ";" & vbCrLf
data = data & "#TICKCOUNT:" & KSFile.Tickcount & ";" & vbCrLf
data = data & "#STARTTIME:" & KSFile.StartTime & ";" & vbCrLf
If KSFile.StartTime2 <> -1 Then data = data & "#STARTTIME2:" & KSFile.StartTime2 & ";" & vbCrLf
If KSFile.StartTime3 <> -1 Then data = data & "#STARTTIME3:" & KSFile.StartTime3 & ";" & vbCrLf
If KSFile.Bunki <> -1 Then data = data & "#BUNKI:" & KSFile.Bunki & ";" & vbCrLf
If KSFile.Bunki2 <> -1 Then data = data & "#BUNKI2:" & KSFile.Bunki2 & ";" & vbCrLf
If KSFile.Difficult <> 255 Then data = data & "#DIFFICULTY:" & KSFile.Difficult & ";" & vbCrLf
data = data & "#STEP:" & vbCrLf & GetKSF
ReadBox.Text = data
If SaveAs = True Then
'ReadBox.SaveFile Form1.DlgBox.FileName, rtfText
FileNum = FreeFile
Open Form1.DlgBox.Filename For Output As FileNum
Print #FileNum, ReadBox.Text
KSFile.Filename = Form1.DlgBox.Filename
Close FileNum
ElseIf SaveAs = False Then
'ReadBox.SaveFile KSFile.FileName, rtfText
FileNum = FreeFile
Open KSFile.Filename For Output As FileNum
Print #FileNum, ReadBox.Text
Close FileNum
End If
Do Until Mid(KSFile.Filename, Len(KSFile.Filename) - Temp3, 1) = "\"
DoEvents
Temp3 = Temp3 + 1
Loop
RegInfo.LastDir = Mid(KSFile.Filename, 1, Len(KSFile.Filename) - Temp3)
KSFile.Changed = False
Me.Caption = KSFile.Title
End Sub
Public Sub PropertyReset()
'Dim A As Integer
'For A = 0 To 2047
'    DoEvents
'    Step(A) = ""
'Next
ReDim Step(1) As String * 10
Step(0) = "0000000000"
Stepcount = 1
StepIndex = 0
KSFile.Title = "New KSF File"
KSFile.BPM = 120
KSFile.BPM2 = -1
KSFile.BPM3 = -1
KSFile.StartTime = 0
KSFile.StartTime2 = -1
KSFile.StartTime3 = -1
KSFile.Bunki = -1
KSFile.Bunki2 = -1
KSFile.Tickcount = 4
KSFile.Difficult = 255
KSFile.speed = 1
KSFile.Mode1p2p = 1
If RegInfo.AutoProperty = 1 Then Form1.ctlPro.Returns
Form_Resize
End Sub
Public Sub ChangeSpeed(ByVal ButtonMenu As MSComCtlLib.ButtonMenu)
Form1.tbToolBar.Buttons(9).Image = ButtonMenu.Index + 6
KSFile.speed = Right(ButtonMenu.Key, 1)
Form_Resize
End Sub
Public Sub ChangeSpeed2(Index As Integer)
Form1.tbToolBar.Buttons(9).Image = Index + 7
KSFile.speed = Right(Left(Form1.mnuViewX(Index).Caption, 2), 1)
Form_Resize
End Sub
Public Sub ChangeNowLeft()
NowLeft = ScrRows.Value
Form_Resize
End Sub
Public Sub Change1p2p(Mode As Byte)
If Mode = 0 Then Mode = 1
KSFile.Mode1p2p = Mode
Form1.tbToolBar.Buttons(10).Image = 10 + KSFile.Mode1p2p
Form_Resize
End Sub
Public Sub ChangeProperty(Inputs As Boolean, Optional Save As Boolean = True)
On Error Resume Next
With Form1.ctlPro
Select Case Inputs
Case True
    ProChanging = True
    .Title = KSFile.Title
    .BPM = KSFile.BPM
    .BPM2 = KSFile.BPM2
    .BPM3 = KSFile.BPM3
    .Start = KSFile.StartTime
    .Start2 = KSFile.StartTime2
    .Start3 = KSFile.StartTime3
    .Bunki = KSFile.Bunki
    .Bunki2 = KSFile.Bunki2
    If KSFile.StartTime2 = -1 Then .Start2 = ""
    If KSFile.StartTime3 = -1 Then .Start3 = ""
    If KSFile.BPM2 = -1 Then .BPM2 = ""
    If KSFile.BPM3 = -1 Then .BPM3 = ""
    If KSFile.Bunki = -1 Then .Bunki = ""
    If KSFile.Bunki2 = -1 Then .Bunki2 = ""
    .Tickcount = KSFile.Tickcount
    .Diff = KSFile.Difficult
    If KSFile.Difficult = 255 Then .Diff = "없음"
    ProChanging = False
Case False
If Save = True Then
If CSng(.BPM) <= 0 Then
    MsgBox "BPM이 잘못됐습니다"
    Exit Sub
Else
    KSFile.BPM = CSng(.BPM)
End If
If .BPM2 = "" Then
    KSFile.BPM2 = -1
ElseIf CSng(.BPM2) > 0 Then
    KSFile.BPM2 = CSng(.BPM2)
Else
    MsgBox "BPM2이 잘못됐습니다"
    Exit Sub
End If
If .BPM3 = "" Then
    KSFile.BPM3 = -1
ElseIf CSng(.BPM3) > 0 Then
    KSFile.BPM3 = CSng(.BPM3)
Else
    MsgBox "BPM3이 잘못됐습니다"
    Exit Sub
End If
If CInt(CStr(.Tickcount)) <= 0 And CInt(CStr(.Tickcount)) >= 8 Then
    MsgBox "틱카운트가 잘못됐습니다"
    Exit Sub
Else
    KSFile.Tickcount = CInt(.Tickcount)
End If
If .Diff = "없음" Or .Diff = "" Then
    KSFile.Difficult = 255
ElseIf CInt(CStr(.Diff)) < 0 And CInt(CStr(.Diff)) > 15 Then
    MsgBox "난이도가 잘못됐습니다"
    Exit Sub
Else
    KSFile.Difficult = CInt(.Diff)
End If
If .Start = "" Then
    KSFile.StartTime = 0
ElseIf CLng(.Start) < 0 Then
    KSFile.StartTime = 0
Else
    KSFile.StartTime = CLng(.Start)
End If
If .Start2 = "" Then
    KSFile.StartTime2 = -1
ElseIf CLng(.Start2) < 0 Then
    MsgBox "스타트타임2가 잘못됐습니다"
    Exit Sub
Else
    KSFile.StartTime2 = CLng(.Start2)
End If
If .Start3 = "" Then
    KSFile.StartTime3 = -1
ElseIf CLng(.Start3) < 0 Then
    MsgBox "스타트타임3가 잘못됐습니다"
    Exit Sub
Else
    KSFile.StartTime3 = CLng(.Start3)
End If
If .Bunki = "" Then
    KSFile.Bunki = -1
ElseIf CLng(.Bunki) < 0 Then
    MsgBox "분기가 잘못됐습니다"
    Exit Sub
Else
    KSFile.Bunki = CLng(.Bunki)
End If
If .Bunki2 = "" Then
    KSFile.Bunki2 = -1
ElseIf CLng(.Bunki2) < 0 Then
    MsgBox "분기가 잘못됐습니다"
    Exit Sub
Else
    KSFile.Bunki2 = CLng(.Bunki2)
End If
KSFile.Title = .Title
KSFile.Changed = True
End If
Form_Resize
End Select
End With
End Sub
Public Sub GetBunki()
Dim TempBunki As Long
If Multi.Multi = True Then
    TempBunki = Int((6000 / (KSFile.BPM * KSFile.Tickcount)) * Multi.SelectStart) + KSFile.StartTime
Else
    TempBunki = Int((6000 / (KSFile.BPM * KSFile.Tickcount)) * StepIndex) + KSFile.StartTime
End If
MsgBox TempBunki
End Sub
Public Sub Redraw()
On Error Resume Next
If KSFile.speed < 1 Then KSFile.speed = 1
TotalWidth = Int((Stepcount - 1) / ((4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount / KSFile.speed)) + 1
ScrRows.Max = (TotalWidth - CanDWidth)
If ScrRows.Max < 0 Then ScrRows.Max = 0
Form1.StatusBar.Panels(2).Text = StepIndex + 1 & " Keyboard"
Form1.StatusBar.Panels(4).Text = Stepcount & " Steps"
'Form1.StatusBar.Panels(1).Text =
If RealTimeInsert = True Then
Do
DoEvents
If StepIndex > ((NowLeft + CanDWidth) * (4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount / KSFile.speed) - 1 Then
    NowLeft = NowLeft + 1
    ScrRows.Value = NowLeft
Else
    Exit Do
End If
Loop
Do
DoEvents
If StepIndex < (NowLeft * (4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount / KSFile.speed) Then
    NowLeft = NowLeft - 1
    ScrRows.Value = NowLeft
Else
    Exit Do
End If
Loop
End If
Dim A As Integer, B As Integer, X As Integer, Y As Integer, z As Integer, M As Boolean, N As Boolean
'A는 리스트에서 뽑아올때,B는 화살표 읽을때, X,Y는 좌표 , Z는 선 or 점선
Me.Cls
' 선택된 스텝 표시
X = 0: Y = 0: z = 0
For A = NowLeft * (4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount / KSFile.speed To (NowLeft + CanDWidth) * (4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount / KSFile.speed - 1
    If A >= 0 Then
    If Multi.Multi = True And RealTimeInsert = False Then
    If A >= Multi.SelectStart And A < Multi.SelectEnd Then
        BitBlt Me.hDC, (X * ((80 * KSFile.Mode1p2p) + 20)) + 20, Y * 16 / KSFile.Tickcount, 80 * KSFile.Mode1p2p, ((16 / KSFile.Tickcount) * KSFile.speed), PicLine(2).hDC, 0, 0, vbSrcCopy
    ElseIf A = Multi.SelectEnd Then
        BitBlt Me.hDC, (X * ((80 * KSFile.Mode1p2p) + 20)) + 20, Y * 16 / KSFile.Tickcount, 80 * KSFile.Mode1p2p, 16, PicLine(2).hDC, 0, 0, vbSrcCopy
    End If
    Else
    If A = StepIndex Then
        BitBlt Me.hDC, (X * ((80 * KSFile.Mode1p2p) + 20)) + 20, Y * 16 / KSFile.Tickcount, 80 * KSFile.Mode1p2p, 16, PicLine(2).hDC, 0, 0, vbSrcCopy
    End If
    End If
    Y = Y + KSFile.speed
    If Y = (4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount Then
        Y = 0
        X = X + 1
    End If
    Else
        Y = Y + KSFile.speed
        If Y = (4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount Then
            Y = 0
            X = X + 1
        End If
    End If
    If A + 1 >= Stepcount Then Exit For
Next
' 롱노트 그리기
If RegInfo.UseLongNote = 1 Then
X = 0: Y = 0: z = 0
For A = NowLeft * (4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount / KSFile.speed To (NowLeft + CanDWidth) * (4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount / KSFile.speed - 1
    If A >= 0 Then
    For B = 0 To KSFile.Mode1p2p * 5 - 1
    If Mid(Step(A), B + 1, 1) = "4" Then
    If Mid(Step(A + 1), B + 1, 1) <> "4" Then
    BitBlt Me.hDC, (B * 16 + X * ((80 * KSFile.Mode1p2p) + 20)) + 20, Y * 16 / KSFile.Tickcount, 16, 8, PicArrowLong(1).hDC, 0, 0, vbSrcAnd
    BitBlt Me.hDC, (B * 16 + X * ((80 * KSFile.Mode1p2p) + 20)) + 20, Y * 16 / KSFile.Tickcount, 16, 8, PicArrowLong(0).hDC, 0, 0, vbSrcPaint
    BitBlt Me.hDC, (B * 16 + X * ((80 * KSFile.Mode1p2p) + 20)) + 20, Y * 16 / KSFile.Tickcount, 16, 16, PicArrow((B Mod 5) + 10).hDC, 0, 0, vbSrcAnd
    BitBlt Me.hDC, (B * 16 + X * ((80 * KSFile.Mode1p2p) + 20)) + 20, Y * 16 / KSFile.Tickcount, 16, 16, PicArrow((B Mod 5)).hDC, 0, 0, vbSrcPaint
    ElseIf Mid(Step(A - 1), B + 1, 1) <> "4" Then
    BitBlt Me.hDC, (B * 16 + X * ((80 * KSFile.Mode1p2p) + 20)) + 20, Y * 16 / KSFile.Tickcount + 8, 16, ((16 / KSFile.Tickcount) * KSFile.speed) - 8, PicArrowLong(1).hDC, 0, 0, vbSrcAnd
    BitBlt Me.hDC, (B * 16 + X * ((80 * KSFile.Mode1p2p) + 20)) + 20, Y * 16 / KSFile.Tickcount + 8, 16, ((16 / KSFile.Tickcount) * KSFile.speed) - 8, PicArrowLong(0).hDC, 0, 0, vbSrcPaint
    BitBlt Me.hDC, (B * 16 + X * ((80 * KSFile.Mode1p2p) + 20)) + 20, Y * 16 / KSFile.Tickcount, 16, 16, PicArrow((B Mod 5) + 10).hDC, 0, 0, vbSrcAnd
    BitBlt Me.hDC, (B * 16 + X * ((80 * KSFile.Mode1p2p) + 20)) + 20, Y * 16 / KSFile.Tickcount, 16, 16, PicArrow((B Mod 5)).hDC, 0, 0, vbSrcPaint
    Else
    BitBlt Me.hDC, (B * 16 + X * ((80 * KSFile.Mode1p2p) + 20)) + 20, Y * 16 / KSFile.Tickcount, 16, ((16 / KSFile.Tickcount) * KSFile.speed), PicArrowLong(1).hDC, 0, 0, vbSrcAnd
    BitBlt Me.hDC, (B * 16 + X * ((80 * KSFile.Mode1p2p) + 20)) + 20, Y * 16 / KSFile.Tickcount, 16, ((16 / KSFile.Tickcount) * KSFile.speed), PicArrowLong(0).hDC, 0, 0, vbSrcPaint
    End If
    End If
    Next
    Y = Y + KSFile.speed
    If Y = (4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount Then
        Y = 0
        X = X + 1
    End If
    Else
        Y = Y + KSFile.speed
        If Y = (4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount Then
            Y = 0
            X = X + 1
        End If
    End If
    If A + 1 >= Stepcount Then Exit For
Next
End If
' 스텝 그리기
X = 0: Y = 0: z = 0
For A = NowLeft * (4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount / KSFile.speed To (NowLeft + CanDWidth) * (4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount / KSFile.speed - 1
    If A >= 0 Then
    For B = 0 To KSFile.Mode1p2p * 5 - 1
    If (Mid(Step(A), B + 1, 1) = "1") Then
    If Multi.Multi = True And RealTimeInsert = False Then
        If A >= Multi.SelectStart And A <= Multi.SelectEnd Then
            BitBlt Me.hDC, (B * 16 + X * ((80 * KSFile.Mode1p2p) + 20)) + 20, Y * 16 / KSFile.Tickcount, 16, 16, PicArrow((B Mod 5) + 10).hDC, 0, 0, vbSrcAnd
            BitBlt Me.hDC, (B * 16 + X * ((80 * KSFile.Mode1p2p) + 20)) + 20, Y * 16 / KSFile.Tickcount, 16, 16, PicArrow((B Mod 5) + 5).hDC, 0, 0, vbSrcPaint
        Else
            BitBlt Me.hDC, (B * 16 + X * ((80 * KSFile.Mode1p2p) + 20)) + 20, Y * 16 / KSFile.Tickcount, 16, 16, PicArrow((B Mod 5) + 10).hDC, 0, 0, vbSrcAnd
            BitBlt Me.hDC, (B * 16 + X * ((80 * KSFile.Mode1p2p) + 20)) + 20, Y * 16 / KSFile.Tickcount, 16, 16, PicArrow((B Mod 5)).hDC, 0, 0, vbSrcPaint
        End If
    ElseIf Multi.Multi = False Or RealTimeInsert = True Then
        If A = StepIndex Then
            BitBlt Me.hDC, (B * 16 + X * ((80 * KSFile.Mode1p2p) + 20)) + 20, Y * 16 / KSFile.Tickcount, 16, 16, PicArrow((B Mod 5) + 10).hDC, 0, 0, vbSrcAnd
            BitBlt Me.hDC, (B * 16 + X * ((80 * KSFile.Mode1p2p) + 20)) + 20, Y * 16 / KSFile.Tickcount, 16, 16, PicArrow((B Mod 5) + 5).hDC, 0, 0, vbSrcPaint
        Else
            BitBlt Me.hDC, (B * 16 + X * ((80 * KSFile.Mode1p2p) + 20)) + 20, Y * 16 / KSFile.Tickcount, 16, 16, PicArrow((B Mod 5) + 10).hDC, 0, 0, vbSrcAnd
            BitBlt Me.hDC, (B * 16 + X * ((80 * KSFile.Mode1p2p) + 20)) + 20, Y * 16 / KSFile.Tickcount, 16, 16, PicArrow((B Mod 5)).hDC, 0, 0, vbSrcPaint
        End If
    End If
    End If
    Next
    Y = Y + KSFile.speed
    If Y = (4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount Then
        Y = 0
        X = X + 1
    End If
    Else
        Y = Y + KSFile.speed
        If Y = (4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount Then
            Y = 0
            X = X + 1
        End If
    End If
    If A + 1 >= Stepcount Then Exit For
Next
' 박자 구분선 그리기
X = 0: Y = 0: z = 4
For A = NowLeft * (4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount / KSFile.speed To (NowLeft + CanDWidth) * (4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount / KSFile.speed
    If A >= 0 Then
    If A / KSFile.Tickcount = Int(A / KSFile.Tickcount) Then
    If Y > 0 And Y <= (4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount + 0 Then
        If z = 4 Then
        BitBlt Me.hDC, (X * ((80 * KSFile.Mode1p2p) + 20)) + 20, Y * 16 / KSFile.Tickcount, 80 * KSFile.Mode1p2p, 1, PicLine(0).hDC, 0, 0, vbSrcCopy
        z = 1
        Else
        BitBlt Me.hDC, (X * ((80 * KSFile.Mode1p2p) + 20)) + 20, Y * 16 / KSFile.Tickcount, 80 * KSFile.Mode1p2p, 1, PicLine(1).hDC, 0, 0, vbSrcCopy
        z = z + 1
        End If
    Else
        If z = 4 Then
            z = 1
        Else
            z = z + 1
        End If
    End If
    End If
    Y = Y + KSFile.speed
    If Y = (4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount + KSFile.speed Then
        Y = KSFile.speed
        X = X + 1
    End If
    Else
    Y = Y + KSFile.speed
    If Y >= (4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount + KSFile.speed Then
    Y = KSFile.speed
    X = X + 1
    End If
    End If
    If A >= Stepcount Then Exit For
Next
End Sub
Public Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
On Error Resume Next
Dim A As Long, B As Long, C As Long
Select Case KeyCode
Case 45
    If RealTimeInsert = False Then
    If Multi.Multi = False Then
        If Stepcount = 0 Then '화살표가 하나도 없으면 - 그럴리는 없지만 -_-a
            Stepcount = Stepcount + 1
            Step(StepIndex) = "0000000000" '처음에 화살표 추가
        Else
            Stepcount = Stepcount + 1
            ReDim Preserve Step(Stepcount - 1) As String * 10
            For B = Stepcount To StepIndex + 1 Step -1
                Step(B) = Step(B - 1)
            Next
            Step(StepIndex) = "0000000000"
        End If
    Else
    A = Multi.SelectEnd - Multi.SelectStart + 1
    Stepcount = Stepcount + A
    ReDim Preserve Step(Stepcount - 1) As String * 10
    For B = Stepcount To Multi.SelectEnd Step -1
        Step(B) = Step(B - A)
    Next
    For B = Multi.SelectStart To Multi.SelectEnd
        Step(B) = "0000000000"
    Next
    End If
    KSFile.Changed = True
    End If
Case 46
    If RealTimeInsert = False Then
    If Multi.Multi = False Then '다중선택이 아니면
        If Stepcount = 1 Then
            Step(0) = "0000000000"
            StepIndex = 0
        Else
            For B = StepIndex To Stepcount - 1
                Step(B) = Step(B + 1)
            Next
            Step(Stepcount - 1) = ""
            Stepcount = Stepcount - 1
            If StepIndex >= Stepcount - 1 Then StepIndex = Stepcount - 1
        End If
    Else '다중선택이면
    A = Multi.SelectEnd - Multi.SelectStart + 1
    For B = StepIndex To Stepcount - 1
        Step(B) = Step(B + A)
    Next
    For B = 1 To A
        Step(Stepcount - B) = ""
    Next
    Stepcount = Stepcount - A
    If Multi.SelectEnd >= Stepcount - 1 Then Multi.SelectEnd = Stepcount - 1
    If Multi.SelectEnd + 1 > Stepcount Then Multi.SelectEnd = Stepcount - 1
    If Multi.SelectEnd <= Multi.SelectStart Then Multi.Multi = False: StepIndex = Multi.SelectStart - 1
    End If '다중선택 부분 끝
    KSFile.Changed = True
    End If
    If Stepcount < 1 Then
    Stepcount = 1
    StepIndex = 0
    Step(0) = "0000000000"
    End If
    ReDim Preserve Step(Stepcount - 1) As String * 10
Case vbKeyNumpad1
If RealTimeInsert = True And RealTimePressed = False Then
    RealTimePressed = True
End If
If KSFile.Mode1p2p = 1 Then
    If Multi.Multi = False Then '다중선택 X
        If Len(Step(StepIndex)) <> 10 Then Step(StepIndex) = "0000000000"
        If Mid(Step(StepIndex), 1, 1) = "1" Then
            Mid(Step(StepIndex), 1, 1) = "0"
        Else
            Mid(Step(StepIndex), 1, 1) = "1"
        End If
    Else '다중선택 O
        A = 0: B = 0: C = 0
        B = Mid(Step(Multi.SelectStart), 1, 1)
        For A = Multi.SelectStart + 1 To Multi.SelectEnd
            If Mid(Step(A), 1, 1) = B Then
                If A = Multi.SelectEnd Then
                    C = B
                End If
            Else
                B = 0
                Exit For
            End If
        Next
    Select Case C
    Case 0
        For A = Multi.SelectStart To Multi.SelectEnd
            If RegInfo.UseLongNote = 1 Then
                Mid(Step(A), 1, 1) = "4"
            Else
                Mid(Step(A), 1, 1) = "1"
            End If
        Next
    Case 1
        For A = Multi.SelectStart To Multi.SelectEnd
            Step(A) = "0" & Mid(Step(A), 2, 9)
        Next
    Case 4
        For A = Multi.SelectStart To Multi.SelectEnd
            Step(A) = "1" & Mid(Step(A), 2, 9)
        Next
    End Select
    End If
ElseIf KSFile.Mode1p2p = 2 Then
    If Len(Step(StepIndex)) <> 10 Then Step(StepIndex) = "0000000000"
    If Multi.Multi = False Then '다중선택 X
    If Mid(Step(StepIndex), 6, 1) = "1" Then
        Step(StepIndex) = Mid(Step(StepIndex), 1, 5) & "0" & Mid(Step(StepIndex), 7, 4)
    Else
        Step(StepIndex) = Mid(Step(StepIndex), 1, 5) & "1" & Mid(Step(StepIndex), 7, 4)
    End If
    Else '다중선택 O
    A = 0: B = 0: C = 0
    B = Mid(Step(Multi.SelectStart), 6, 1)
    For A = Multi.SelectStart + 1 To Multi.SelectEnd
    If Mid(Step(A), 6, 1) = B Then
    If A = Multi.SelectEnd Then
    C = B
    End If
    Else
    B = 0
    Exit For
    End If
    Next
    Select Case C
    Case 0
    For A = Multi.SelectStart To Multi.SelectEnd
    If RegInfo.UseLongNote = 1 Then
    Step(A) = Mid(Step(A), 1, 5) & "4" & Mid(Step(A), 7, 4)
    Else
    Step(A) = Mid(Step(A), 1, 5) & "1" & Mid(Step(A), 7, 4)
    End If
    Next
    Case 1
    For A = Multi.SelectStart To Multi.SelectEnd
    Step(A) = Mid(Step(A), 1, 5) & "0" & Mid(Step(A), 7, 4)
    Next
    Case 4
    For A = Multi.SelectStart To Multi.SelectEnd
    Step(A) = Mid(Step(A), 1, 5) & "1" & Mid(Step(A), 7, 4)
    Next
    End Select
    End If
End If
    KSFile.Changed = True
Case vbKeyNumpad7
If RealTimeInsert = True And RealTimePressed = False Then
    RealTimePressed = True
End If
If KSFile.Mode1p2p = 1 Then
    If Multi.Multi = False Then '다중선택 X
    If Len(Step(StepIndex)) <> 10 Then Step(StepIndex) = "0000000000"
    If Mid(Step(StepIndex), 2, 1) = "1" Then
        Step(StepIndex) = Mid(Step(StepIndex), 1, 1) & "0" & Mid(Step(StepIndex), 3, 8)
    Else
        Step(StepIndex) = Mid(Step(StepIndex), 1, 1) & "1" & Mid(Step(StepIndex), 3, 8)
    End If
    Else '다중선택 O
    A = 0: B = 0: C = 0
    B = Mid(Step(Multi.SelectStart), 2, 1)
    For A = Multi.SelectStart + 1 To Multi.SelectEnd
    If Mid(Step(A), 2, 1) = B Then
    If A = Multi.SelectEnd Then
    C = B
    End If
    Else
    B = 0
    Exit For
    End If
    Next
    Select Case C
    Case 0
    For A = Multi.SelectStart To Multi.SelectEnd
    If RegInfo.UseLongNote = 1 Then
    Step(A) = Mid(Step(A), 1, 1) & "4" & Mid(Step(A), 3, 8)
    Else
    Step(A) = Mid(Step(A), 1, 1) & "1" & Mid(Step(A), 3, 8)
    End If
    Next
    Case 1
    For A = Multi.SelectStart To Multi.SelectEnd
    Step(A) = Mid(Step(A), 1, 1) & "0" & Mid(Step(A), 3, 8)
    Next
    Case 4
    For A = Multi.SelectStart To Multi.SelectEnd
    Step(A) = Mid(Step(A), 1, 1) & "1" & Mid(Step(A), 3, 8)
    Next
    End Select
    End If
ElseIf KSFile.Mode1p2p = 2 Then
    If Len(Step(StepIndex)) <> 10 Then Step(StepIndex) = "0000000000"
    If Multi.Multi = False Then '다중선택 X
    If Mid(Step(StepIndex), 7, 1) = "1" Then
        Step(StepIndex) = Mid(Step(StepIndex), 1, 6) & "0" & Mid(Step(StepIndex), 8, 3)
    Else
        Step(StepIndex) = Mid(Step(StepIndex), 1, 6) & "1" & Mid(Step(StepIndex), 8, 3)
    End If
    Else '다중선택 O
    A = 0: B = 0: C = 0
    B = Mid(Step(Multi.SelectStart), 7, 1)
    For A = Multi.SelectStart + 1 To Multi.SelectEnd
    If Mid(Step(A), 7, 1) = B Then
    If A = Multi.SelectEnd Then
    C = B
    End If
    Else
    B = 0
    Exit For
    End If
    Next
    Select Case C
    Case 0
    For A = Multi.SelectStart To Multi.SelectEnd
    If RegInfo.UseLongNote = 1 Then
    Step(A) = Mid(Step(A), 1, 6) & "4" & Mid(Step(A), 8, 3)
    Else
    Step(A) = Mid(Step(A), 1, 6) & "1" & Mid(Step(A), 8, 3)
    End If
    Next
    Case 1
    For A = Multi.SelectStart To Multi.SelectEnd
    Step(A) = Mid(Step(A), 1, 6) & "0" & Mid(Step(A), 8, 3)
    Next
    Case 4
    For A = Multi.SelectStart To Multi.SelectEnd
    Step(A) = Mid(Step(A), 1, 6) & "1" & Mid(Step(A), 8, 3)
    Next
    End Select
    End If
End If
    KSFile.Changed = True
Case vbKeyNumpad5
If RealTimeInsert = True And RealTimePressed = False Then
    RealTimePressed = True
End If
If KSFile.Mode1p2p = 1 Then
    If Multi.Multi = False Then '다중선택 X
    If Len(Step(StepIndex)) <> 10 Then Step(StepIndex) = "0000000000"
    If Mid(Step(StepIndex), 3, 1) = "1" Then
        Step(StepIndex) = Mid(Step(StepIndex), 1, 2) & "0" & Mid(Step(StepIndex), 4, 7)
    Else
        Step(StepIndex) = Mid(Step(StepIndex), 1, 2) & "1" & Mid(Step(StepIndex), 4, 7)
    End If
    Else '다중선택 O
    A = 0: B = 0: C = 0
    B = Mid(Step(Multi.SelectStart), 3, 1)
    For A = Multi.SelectStart + 1 To Multi.SelectEnd
    If Mid(Step(A), 3, 1) = B Then
    If A = Multi.SelectEnd Then
    C = B
    End If
    Else
    B = 0
    Exit For
    End If
    Next
    Select Case C
    Case 0
    For A = Multi.SelectStart To Multi.SelectEnd
    If RegInfo.UseLongNote = 1 Then
    Step(A) = Mid(Step(A), 1, 2) & "4" & Mid(Step(A), 4, 7)
    Else
    Step(A) = Mid(Step(A), 1, 2) & "1" & Mid(Step(A), 4, 7)
    End If
    Next
    Case 1
    For A = Multi.SelectStart To Multi.SelectEnd
    Step(A) = Mid(Step(A), 1, 2) & "0" & Mid(Step(A), 4, 7)
    Next
    Case 4
    For A = Multi.SelectStart To Multi.SelectEnd
    Step(A) = Mid(Step(A), 1, 2) & "1" & Mid(Step(A), 4, 7)
    Next
    End Select
    End If
ElseIf KSFile.Mode1p2p = 2 Then
    If Len(Step(StepIndex)) <> 10 Then Step(StepIndex) = "0000000000"
    If Multi.Multi = False Then '다중선택 X
    If Mid(Step(StepIndex), 8, 1) = "1" Then
        Step(StepIndex) = Mid(Step(StepIndex), 1, 7) & "0" & Mid(Step(StepIndex), 9, 2)
    Else
        Step(StepIndex) = Mid(Step(StepIndex), 1, 7) & "1" & Mid(Step(StepIndex), 9, 2)
    End If
    Else '다중선택 O
    A = 0: B = 0: C = 0
    B = Mid(Step(Multi.SelectStart), 8, 1)
    For A = Multi.SelectStart + 1 To Multi.SelectEnd
    If Mid(Step(A), 8, 1) = B Then
    If A = Multi.SelectEnd Then
    C = B
    End If
    Else
    B = 0
    Exit For
    End If
    Next
    Select Case C
    Case 0
    For A = Multi.SelectStart To Multi.SelectEnd
    If RegInfo.UseLongNote = 1 Then
    Step(A) = Mid(Step(A), 1, 7) & "4" & Mid(Step(A), 9, 2)
    Else
    Step(A) = Mid(Step(A), 1, 7) & "1" & Mid(Step(A), 9, 2)
    End If
    Next
    Case 1
    For A = Multi.SelectStart To Multi.SelectEnd
    Step(A) = Mid(Step(A), 1, 7) & "0" & Mid(Step(A), 9, 2)
    Next
    Case 4
    For A = Multi.SelectStart To Multi.SelectEnd
    Step(A) = Mid(Step(A), 1, 7) & "1" & Mid(Step(A), 9, 2)
    Next
    End Select
    End If
End If
    KSFile.Changed = True
Case vbKeyNumpad9
If RealTimeInsert = True And RealTimePressed = False Then
    RealTimePressed = True
End If
If KSFile.Mode1p2p = 1 Then
    If Multi.Multi = False Then '다중선택 X
    If Len(Step(StepIndex)) <> 10 Then Step(StepIndex) = "0000000000"
    If Mid(Step(StepIndex), 4, 1) = "1" Then
        Step(StepIndex) = Mid(Step(StepIndex), 1, 3) & "0" & Mid(Step(StepIndex), 5, 6)
    Else
        Step(StepIndex) = Mid(Step(StepIndex), 1, 3) & "1" & Mid(Step(StepIndex), 5, 6)
    End If
    Else '다중선택 O
    A = 0: B = 0: C = 0
    B = Mid(Step(Multi.SelectStart), 4, 1)
    For A = Multi.SelectStart + 1 To Multi.SelectEnd
    If Mid(Step(A), 4, 1) = B Then
    If A = Multi.SelectEnd Then
    C = B
    End If
    Else
    B = 0
    Exit For
    End If
    Next
    Select Case C
    Case 0
    For A = Multi.SelectStart To Multi.SelectEnd
    If RegInfo.UseLongNote = 1 Then
    Step(A) = Mid(Step(A), 1, 3) & "4" & Mid(Step(A), 5, 6)
    Else
    Step(A) = Mid(Step(A), 1, 3) & "1" & Mid(Step(A), 5, 6)
    End If
    Next
    Case 1
    For A = Multi.SelectStart To Multi.SelectEnd
    Step(A) = Mid(Step(A), 1, 3) & "0" & Mid(Step(A), 5, 6)
    Next
    Case 4
    For A = Multi.SelectStart To Multi.SelectEnd
    Step(A) = Mid(Step(A), 1, 3) & "1" & Mid(Step(A), 5, 6)
    Next
    End Select
    End If
ElseIf KSFile.Mode1p2p = 2 Then
    If Len(Step(StepIndex)) <> 10 Then Step(StepIndex) = "0000000000"
    If Multi.Multi = False Then '다중선택 X
    If Mid(Step(StepIndex), 9, 1) = "1" Then
        Step(StepIndex) = Mid(Step(StepIndex), 1, 8) & "0" & Mid(Step(StepIndex), 10, 1)
    Else
        Step(StepIndex) = Mid(Step(StepIndex), 1, 8) & "1" & Mid(Step(StepIndex), 10, 1)
    End If
    Else '다중선택 O
    A = 0: B = 0: C = 0
    B = Mid(Step(Multi.SelectStart), 9, 1)
    For A = Multi.SelectStart + 1 To Multi.SelectEnd
    If Mid(Step(A), 9, 1) = B Then
    If A = Multi.SelectEnd Then
    C = B
    End If
    Else
    B = 0
    Exit For
    End If
    Next
    Select Case C
    Case 0
    For A = Multi.SelectStart To Multi.SelectEnd
    If RegInfo.UseLongNote = 1 Then
    Step(A) = Mid(Step(A), 1, 8) & "4" & Mid(Step(A), 10, 1)
    Else
    Step(A) = Mid(Step(A), 1, 8) & "1" & Mid(Step(A), 10, 1)
    End If
    Next
    Case 1
    For A = Multi.SelectStart To Multi.SelectEnd
    Step(A) = Mid(Step(A), 1, 8) & "0" & Mid(Step(A), 10, 1)
    Next
    Case 4
    For A = Multi.SelectStart To Multi.SelectEnd
    Step(A) = Mid(Step(A), 1, 8) & "1" & Mid(Step(A), 10, 1)
    Next
    End Select
    End If
End If
    KSFile.Changed = True
Case vbKeyNumpad3
If RealTimeInsert = True And RealTimePressed = False Then
    RealTimePressed = True
End If
If KSFile.Mode1p2p = 1 Then
    If Multi.Multi = False Then '다중선택 X
    If Len(Step(StepIndex)) <> 10 Then Step(StepIndex) = "0000000000"
    If Mid(Step(StepIndex), 5, 1) = "1" Then
        Step(StepIndex) = Mid(Step(StepIndex), 1, 4) & "0" & Mid(Step(StepIndex), 6, 5)
    Else
        Step(StepIndex) = Mid(Step(StepIndex), 1, 4) & "1" & Mid(Step(StepIndex), 6, 5)
    End If
    Else '다중선택 O
    A = 0: B = 0: C = 0
    B = Mid(Step(Multi.SelectStart), 5, 1)
    For A = Multi.SelectStart + 1 To Multi.SelectEnd
    If Mid(Step(A), 5, 1) = B Then
    If A = Multi.SelectEnd Then
    C = B
    End If
    Else
    B = 0
    Exit For
    End If
    Next
    Select Case C
    Case 0
    For A = Multi.SelectStart To Multi.SelectEnd
    If RegInfo.UseLongNote = 1 Then
    Step(A) = Mid(Step(A), 1, 4) & "4" & Mid(Step(A), 6, 5)
    Else
    Step(A) = Mid(Step(A), 1, 4) & "1" & Mid(Step(A), 6, 5)
    End If
    Next
    Case 1
    For A = Multi.SelectStart To Multi.SelectEnd
    Step(A) = Mid(Step(A), 1, 4) & "0" & Mid(Step(A), 6, 5)
    Next
    Case 4
    For A = Multi.SelectStart To Multi.SelectEnd
    Step(A) = Mid(Step(A), 1, 4) & "1" & Mid(Step(A), 6, 5)
    Next
    End Select
    End If
ElseIf KSFile.Mode1p2p = 2 Then
    If Len(Step(StepIndex)) <> 10 Then Step(StepIndex) = "0000000000"
    If Multi.Multi = False Then '다중선택 X
    If Mid(Step(StepIndex), 10, 1) = "1" Then
        Step(StepIndex) = Mid(Step(StepIndex), 1, 9) & "0"
    Else
        Step(StepIndex) = Mid(Step(StepIndex), 1, 9) & "1"
    End If
    Else '다중선택 O
    A = 0: B = 0: C = 0
    B = Mid(Step(Multi.SelectStart), 10, 1)
    For A = Multi.SelectStart + 1 To Multi.SelectEnd
    If Mid(Step(A), 10, 1) = B Then
    If A = Multi.SelectEnd Then
    C = B
    End If
    Else
    B = 0
    Exit For
    End If
    Next
    Select Case C
    Case 0
    For A = Multi.SelectStart To Multi.SelectEnd
    If RegInfo.UseLongNote = 1 Then
    Step(A) = Mid(Step(A), 1, 9) & "4"
    Else
    Step(A) = Mid(Step(A), 1, 9) & "1"
    End If
    Next
    Case 1
    For A = Multi.SelectStart To Multi.SelectEnd
    Step(A) = Mid(Step(A), 1, 9) & "0"
    Next
    Case 4
    For A = Multi.SelectStart To Multi.SelectEnd
    Step(A) = Mid(Step(A), 1, 9) & "1"
    Next
    End Select
    End If
End If
    KSFile.Changed = True
Case vbKeyZ
If RealTimeInsert = False And RealTimePressed = False Then
    RealTimePressed = True
End If
    If Len(Step(StepIndex)) <> 10 Then Step(StepIndex) = "0000000000"
    If Multi.Multi = False Then '다중선택 X
    If Mid(Step(StepIndex), 1, 1) = "1" Then
        Step(StepIndex) = "0" & Mid(Step(StepIndex), 2, 9)
    Else
        Step(StepIndex) = "1" & Mid(Step(StepIndex), 2, 9)
    End If
    Else '다중선택 O
    A = 0: B = 0: C = 0
    B = Mid(Step(Multi.SelectStart), 1, 1)
    For A = Multi.SelectStart + 1 To Multi.SelectEnd
    If Mid(Step(A), 1, 1) = B Then
    If A = Multi.SelectEnd Then
    C = B
    End If
    Else
    B = 0
    Exit For
    End If
    Next
    Select Case C
    Case 0
    For A = Multi.SelectStart To Multi.SelectEnd
    If RegInfo.UseLongNote = 1 Then
    Step(A) = "4" & Mid(Step(A), 2, 9)
    Else
    Step(A) = "1" & Mid(Step(A), 2, 9)
    End If
    Next
    Case 1
    For A = Multi.SelectStart To Multi.SelectEnd
    Step(A) = "0" & Mid(Step(A), 2, 9)
    Next
    Case 4
    For A = Multi.SelectStart To Multi.SelectEnd
    Step(A) = "1" & Mid(Step(A), 2, 9)
    Next
    End Select
    End If
    KSFile.Changed = True
Case vbKeyQ
If RealTimeInsert = False And RealTimePressed = False Then
    RealTimePressed = True
End If
    If Len(Step(StepIndex)) <> 10 Then Step(StepIndex) = "0000000000"
    If Multi.Multi = False Then '다중선택 X
    If Mid(Step(StepIndex), 2, 1) = "1" Then
        Step(StepIndex) = Mid(Step(StepIndex), 1, 1) & "0" & Mid(Step(StepIndex), 3, 8)
    Else
        Step(StepIndex) = Mid(Step(StepIndex), 1, 1) & "1" & Mid(Step(StepIndex), 3, 8)
    End If
    Else '다중선택 O
    A = 0: B = 0: C = 0
    B = Mid(Step(Multi.SelectStart), 2, 1)
    For A = Multi.SelectStart + 1 To Multi.SelectEnd
    If Mid(Step(A), 2, 1) = B Then
    If A = Multi.SelectEnd Then
    C = B
    End If
    Else
    B = 0
    Exit For
    End If
    Next
    Select Case C
    Case 0
    For A = Multi.SelectStart To Multi.SelectEnd
    If RegInfo.UseLongNote = 1 Then
    Step(A) = Mid(Step(A), 1, 1) & "4" & Mid(Step(A), 3, 8)
    Else
    Step(A) = Mid(Step(A), 1, 1) & "1" & Mid(Step(A), 3, 8)
    End If
    Next
    Case 1
    For A = Multi.SelectStart To Multi.SelectEnd
    Step(A) = Mid(Step(A), 1, 1) & "0" & Mid(Step(A), 3, 8)
    Next
    Case 4
    For A = Multi.SelectStart To Multi.SelectEnd
    Step(A) = Mid(Step(A), 1, 1) & "1" & Mid(Step(A), 3, 8)
    Next
    End Select
    End If
    KSFile.Changed = True
Case vbKeyS
If RealTimeInsert = False And RealTimePressed = False Then
    RealTimePressed = True
End If
If KeyState(vbKeyControl) = 0 Then
    If Len(Step(StepIndex)) <> 10 Then Step(StepIndex) = "0000000000"
    If Multi.Multi = False Then '다중선택 X
    If Mid(Step(StepIndex), 3, 1) = "1" Then
        Step(StepIndex) = Mid(Step(StepIndex), 1, 2) & "0" & Mid(Step(StepIndex), 4, 7)
    Else
        Step(StepIndex) = Mid(Step(StepIndex), 1, 2) & "1" & Mid(Step(StepIndex), 4, 7)
    End If
    Else '다중선택 O
    A = 0: B = 0: C = 0
    B = Mid(Step(Multi.SelectStart), 3, 1)
    For A = Multi.SelectStart + 1 To Multi.SelectEnd
    If Mid(Step(A), 3, 1) = B Then
    If A = Multi.SelectEnd Then
    C = B
    End If
    Else
    B = 0
    Exit For
    End If
    Next
    Select Case C
    Case 0
    For A = Multi.SelectStart To Multi.SelectEnd
    If RegInfo.UseLongNote = 1 Then
    Step(A) = Mid(Step(A), 1, 2) & "4" & Mid(Step(A), 4, 7)
    Else
    Step(A) = Mid(Step(A), 1, 2) & "1" & Mid(Step(A), 4, 7)
    End If
    Next
    Case 1
    For A = Multi.SelectStart To Multi.SelectEnd
    Step(A) = Mid(Step(A), 1, 2) & "0" & Mid(Step(A), 4, 7)
    Next
    Case 4
    For A = Multi.SelectStart To Multi.SelectEnd
    Step(A) = Mid(Step(A), 1, 2) & "1" & Mid(Step(A), 4, 7)
    Next
    End Select
    End If
    KSFile.Changed = True
End If
Case vbKeyE
If RealTimeInsert = False And RealTimePressed = False Then
    RealTimePressed = True
End If
    If Len(Step(StepIndex)) <> 10 Then Step(StepIndex) = "0000000000"
    If Multi.Multi = False Then '다중선택 X
    If Mid(Step(StepIndex), 4, 1) = "1" Then
        Step(StepIndex) = Mid(Step(StepIndex), 1, 3) & "0" & Mid(Step(StepIndex), 5, 6)
    Else
        Step(StepIndex) = Mid(Step(StepIndex), 1, 3) & "1" & Mid(Step(StepIndex), 5, 6)
    End If
    Else '다중선택 O
    A = 0: B = 0: C = 0
    B = Mid(Step(Multi.SelectStart), 4, 1)
    For A = Multi.SelectStart + 1 To Multi.SelectEnd
    If Mid(Step(A), 4, 1) = B Then
    If A = Multi.SelectEnd Then
    C = B
    End If
    Else
    B = 0
    Exit For
    End If
    Next
    Select Case C
    Case 0
    For A = Multi.SelectStart To Multi.SelectEnd
    If RegInfo.UseLongNote = 1 Then
    Step(A) = Mid(Step(A), 1, 3) & "4" & Mid(Step(A), 5, 6)
    Else
    Step(A) = Mid(Step(A), 1, 3) & "1" & Mid(Step(A), 5, 6)
    End If
    Next
    Case 1
    For A = Multi.SelectStart To Multi.SelectEnd
    Step(A) = Mid(Step(A), 1, 3) & "0" & Mid(Step(A), 5, 6)
    Next
    Case 4
    For A = Multi.SelectStart To Multi.SelectEnd
    Step(A) = Mid(Step(A), 1, 3) & "1" & Mid(Step(A), 5, 6)
    Next
    End Select
    End If
    KSFile.Changed = True
Case vbKeyC
If RealTimeInsert = False And RealTimePressed = False Then
    RealTimePressed = True
End If
If KeyState(vbKeyControl) = 0 Then
    If Len(Step(StepIndex)) <> 10 Then Step(StepIndex) = "0000000000"
    If Multi.Multi = False Then '다중선택 X
    If Mid(Step(StepIndex), 5, 1) = "1" Then
        Step(StepIndex) = Mid(Step(StepIndex), 1, 4) & "0" & Mid(Step(StepIndex), 6, 5)
    Else
        Step(StepIndex) = Mid(Step(StepIndex), 1, 4) & "1" & Mid(Step(StepIndex), 6, 5)
    End If
    Else '다중선택 O
    A = 0: B = 0: C = 0
    B = Mid(Step(Multi.SelectStart), 5, 1)
    For A = Multi.SelectStart + 1 To Multi.SelectEnd
    If Mid(Step(A), 5, 1) = B Then
    If A = Multi.SelectEnd Then
    C = B
    End If
    Else
    B = 0
    Exit For
    End If
    Next
    Select Case C
    Case 0
    For A = Multi.SelectStart To Multi.SelectEnd
    If RegInfo.UseLongNote = 1 Then
    Step(A) = Mid(Step(A), 1, 4) & "4" & Mid(Step(A), 6, 5)
    Else
    Step(A) = Mid(Step(A), 1, 4) & "1" & Mid(Step(A), 6, 5)
    End If
    Next
    Case 1
    For A = Multi.SelectStart To Multi.SelectEnd
    Step(A) = Mid(Step(A), 1, 4) & "0" & Mid(Step(A), 6, 5)
    Next
    Case 4
    For A = Multi.SelectStart To Multi.SelectEnd
    Step(A) = Mid(Step(A), 1, 4) & "1" & Mid(Step(A), 6, 5)
    Next
    End Select
    End If
    KSFile.Changed = True
End If
Case vbKeyNumpad2
    If RealTimeInsert = False Then
    Multi.Multi = False
    If KeyState(vbKeyControl) < 0 Then
        If StepIndex >= Stepcount - (4 * KSFile.Tickcount) Then
        Else
            StepIndex = StepIndex + (4 * KSFile.Tickcount)
        End If
    Else
        If StepIndex >= Stepcount - 1 Then
        Else
            StepIndex = StepIndex + 1
        End If
    End If
    If Multi.Multi = False Then Multi.Start = StepIndex
    End If
Case vbKeyNumpad8
    If RealTimeInsert = False Then
    Multi.Multi = False
    If KeyState(vbKeyControl) < 0 Then
        If StepIndex - (4 * KSFile.Tickcount) + 1 <= 0 Then
        Else
            StepIndex = StepIndex - (4 * KSFile.Tickcount)
        End If
    Else
        If StepIndex = 0 Then
        Else
            StepIndex = StepIndex - 1
        End If
    End If
    If Multi.Multi = False Then Multi.Start = StepIndex
    End If
Case vbKeyNumpad4
    If RealTimeInsert = False Then
    Multi.Multi = False
    If StepIndex - ((4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount / KSFile.speed) >= 0 Then StepIndex = StepIndex - ((4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount / KSFile.speed)
    End If
Case vbKeyNumpad6
    If RealTimeInsert = False Then
    Multi.Multi = False
    If StepIndex + ((4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount / KSFile.speed) < Stepcount Then StepIndex = StepIndex + ((4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount / KSFile.speed)
    End If
Case vbKeyDown
    If RealTimeInsert = False Then
    Multi.Multi = False
    If KeyState(vbKeyControl) < 0 Then
        If StepIndex >= Stepcount - (4 * KSFile.Tickcount) Then
        Else
            StepIndex = StepIndex + (4 * KSFile.Tickcount)
        End If
    Else
        If StepIndex >= Stepcount - 1 Then
        Else
            StepIndex = StepIndex + 1
        End If
    End If
    If Multi.Multi = False Then Multi.Start = StepIndex
    End If
Case vbKeyUp
    If RealTimeInsert = False Then
    Multi.Multi = False
    If KeyState(vbKeyControl) < 0 Then
        If StepIndex - (4 * KSFile.Tickcount) + 1 <= 0 Then
        Else
            StepIndex = StepIndex - (4 * KSFile.Tickcount)
        End If
    Else
        If StepIndex = 0 Then
        Else
            StepIndex = StepIndex - 1
        End If
    End If
    If Multi.Multi = False Then Multi.Start = StepIndex
    End If
Case vbKeyLeft
    If RealTimeInsert = False Then
    Multi.Multi = False
    If StepIndex - ((4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount / KSFile.speed) >= 0 Then StepIndex = StepIndex - ((4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount / KSFile.speed)
    End If
Case vbKeyRight
    If RealTimeInsert = False Then
    Multi.Multi = False
    If StepIndex + ((4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount / KSFile.speed) < Stepcount Then StepIndex = StepIndex + ((4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount / KSFile.speed)
    End If
Case vbKeyEscape
    RealTimeInsert = False
    stopMp3
    Form1.mnuToolsRealTime.Caption = "실시간 채보 입력 멈춤"
Case vbKeyHome
    StepIndex = 0
Case vbKeyEnd
    StepIndex = Stepcount - 1
Case vbKeyPageUp
    If StepIndex = NowLeft * (4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount / KSFile.speed Then
    StepIndex = StepIndex - CanDWidth * (4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount / KSFile.speed
    If StepIndex < 0 Then StepIndex = 0
    Else
    StepIndex = NowLeft * (4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount / KSFile.speed
    End If
Case vbKeyPageDown
    If StepIndex = (NowLeft + CanDWidth) * (4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount / KSFile.speed - 1 Then
    StepIndex = StepIndex + CanDWidth * (4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount / KSFile.speed
    If StepIndex >= Stepcount Then StepIndex = Stepcount - 1
    Else
    StepIndex = (NowLeft + CanDWidth) * (4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount / KSFile.speed - 1
    If StepIndex >= Stepcount Then StepIndex = Stepcount - 1
    End If

End Select
Do
DoEvents
If StepIndex > ((NowLeft + CanDWidth) * (4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount / KSFile.speed) - 1 Then
    NowLeft = NowLeft + 1
    ScrRows.Value = NowLeft
Else
    Exit Do
End If
Loop
Do
DoEvents
If StepIndex < (NowLeft * (4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount / KSFile.speed) Then
    NowLeft = NowLeft - 1
    ScrRows.Value = NowLeft
Else
    Exit Do
End If
Loop
Redraw
End Sub
Private Sub Form_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Error Resume Next
Dim A As Integer, B As Integer, C As Integer
If Button = 1 Then
    If KeyState(vbKeyShift) = 0 Then
    Multi.Multi = False
    A = Int((X) / ((80 * KSFile.Mode1p2p) + 20))
    B = Int(Y / 16 * KSFile.Tickcount)
    C = ((NowLeft + A) * (4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount / KSFile.speed) + B / KSFile.speed
    If C >= 0 And C < Stepcount Then
        StepIndex = C
        Multi.Start = C
        Multi.SelectStart = C
        Multi.SelectEnd = C
    End If
    Else
    A = Int((X) / ((80 * KSFile.Mode1p2p) + 20))
    B = Int(Y / 16 * KSFile.Tickcount)
    C = ((NowLeft + A) * (4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount / KSFile.speed) + B / KSFile.speed
    If C / KSFile.speed >= 0 And C / KSFile.speed < Stepcount Then
        If C > Multi.Start Then
        Multi.SelectStart = Multi.Start
        Multi.SelectEnd = C
        ElseIf C < Multi.Start Then
        Multi.SelectStart = C
        Multi.SelectEnd = Multi.Start
        End If
        Multi.Multi = True
    End If
    End If
    Redraw
ElseIf Button = 2 Then
    PopupMenu Form1.mnuEdit
End If
End Sub
Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Error Resume Next
Dim A As Integer, B As Integer, C As Integer
A = Int((X) / ((80 * KSFile.Mode1p2p) + 20))
B = Int(Y / 16 * KSFile.Tickcount)
C = ((NowLeft + A) * (4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount / KSFile.speed) + B / KSFile.speed
Form1.StatusBar.Panels(3).Text = C + 1 & " Mouse"
If Button = 1 Then
    A = Int((X) / ((80 * KSFile.Mode1p2p) + 20))
    B = Int(Y / 16 * KSFile.Tickcount)
    C = ((NowLeft + A) * (4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount / KSFile.speed) + B / KSFile.speed
    If C / KSFile.speed >= 0 And C / KSFile.speed < Stepcount Then
        If C > Multi.Start And C + 1 <= Stepcount Then
        Multi.SelectStart = Multi.Start
        Multi.SelectEnd = C
        ElseIf C < Multi.Start Then
        Multi.SelectStart = C
        Multi.SelectEnd = Multi.Start
        ElseIf C = Multi.Start Then
        Multi.Multi = False
        Multi.SelectStart = C
        Multi.SelectEnd = C
        StepIndex = C
        End If
        Multi.Multi = True
    End If
    Redraw
End If
End Sub
Private Sub Form_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
Redraw
End Sub
Private Function GetKSF() As String
    Dim A As Integer, B As Integer
    GetKSF = ""
    For A = 0 To Stepcount - 1
        DoEvents
        If Len(Step(A)) = 10 Then
            GetKSF = GetKSF & Step(A) & "000" & vbCrLf
        Else
        End If
    Next
    GetKSF = GetKSF & "2222222222222"
End Function
Private Sub PasteSteps(Steps As Integer, Stepstr As String)
Dim A As Long, B As Long, SStart As Long, SEnd As Long
If Multi.Multi = False Then
    Stepcount = Stepcount + Steps
    ReDim Preserve Step(Stepcount) As String * 10
    SStart = StepIndex
    SEnd = StepIndex + Steps - 1
Else
    Stepcount = Stepcount + Steps
    ReDim Preserve Step(Stepcount) As String * 10
    SStart = Multi.SelectStart
    SEnd = Multi.SelectStart + Steps - 1
End If
A = 0
For B = Stepcount To SEnd + 1 Step -1
        Step(B) = Step(B - Steps)
Next
For B = SStart To SEnd
    Step(B) = Mid(Stepstr, A * 10 + 1, 10)
    A = A + 1
Next
KSFile.Changed = True
Redraw
End Sub
Private Sub PasteSteps2(Steps As Integer, Stepstr As String)
Dim A As Long, B As Long, SStart As Long, SEnd As Long
If Multi.Multi = False Then
    SStart = StepIndex
Else
    SStart = Multi.SelectStart
End If
SEnd = SStart + Steps
For B = SStart To SEnd - 1
    If B >= Stepcount Then Exit For
    Step(B) = Mid(Stepstr, A * 10 + 1, 10)
    A = A + 1
Next
KSFile.Changed = True
Redraw
End Sub
Private Sub AddFromKSF(data As String)
Dim temp As Integer
data = Mid(data, 9, Len(data))
Stepcount = 0
StepIndex = 0
Do
DoEvents
If Mid(data, 1, 1) = "2" Then Exit Do
ReDim Preserve Step(Stepcount) As String * 10
temp = 0
    Do
    DoEvents
    temp = temp + 1
    If Mid(data, temp, 2) = vbCrLf Then Exit Do
    Loop
If temp = 14 Then
Step(Stepcount) = Mid(data, 1, 10)
Stepcount = Stepcount + 1
End If
data = Mid(data, temp + 2, Len(data))
If Len(data) < 10 Then Exit Do
Loop
StepIndex = 0
Redraw
End Sub
Public Sub RealTimeStart()
On Error Resume Next
Dim StepIndex2 As Long, BPMBPM As Double
If KSFile.RealTimeFile = "" Then
MsgBox "노래 파일을 선택해주세요"
Form1.mnuToolsRealTime.Caption = "실시간 채보 입력 시작"
RealTimeInsert = False
Exit Sub
End If
If Form1.mnuToolsRealTime.Caption = "실시간 채보 입력 멈춤" Then
RealTimeInsert = False
stopMp3
Form1.mnuToolsRealTime.Caption = "실시간 채보 입력 시작"
Exit Sub
End If
Form1.mnuToolsRealTime.Caption = "실시간 채보 입력 멈춤"
openMp3 KSFile.RealTimeFile
RealTimeInsert = True
StepIndex2 = 0
StepIndex = 0
BPMBPM = (60000 / (KSFile.BPM * KSFile.Tickcount))
playMp3
LastGetTicks = GetTickCount
Do While RealTimeInsert = True
DoEvents
If getMp3Len = getMp3Pos Then RealTimeInsert = False
If RealTimePressed = False Then
    Do
    DoEvents
    If KSFile.StartTime <= Int(getMp3Pos / 10) Then
        RealTimePressed = True
        Exit Do
    End If
    Loop
    LastGetTicks = GetTickCount
End If
If GetTickCount - LastGetTicks >= BPMBPM Then
    LastGetTicks = GetTickCount - ((GetTickCount - LastGetTicks) - BPMBPM)
    StepIndex2 = StepIndex2 + 1
    If StepIndex2 < 0 Then StepIndex2 = 0
    StepIndex = StepIndex2
    If Len(Step(StepIndex2)) <> 10 Then Step(StepIndex2) = "0000000000"
    If Stepcount - 1 < StepIndex2 Then
        Stepcount = StepIndex2 + 1
        ReDim Preserve Step(Stepcount) As String * 10
        KSFile.Changed = True
    End If
    Redraw
    Do
    DoEvents
    If StepIndex > ((NowLeft + CanDWidth) * (4 * (RegInfo.ResizeBetter + 1)) * CanDHeight * KSFile.Tickcount / KSFile.speed) - 1 Then
        NowLeft = NowLeft + 1
        ScrRows.Value = NowLeft
    Else
        Exit Do
    End If
    Loop
End If
Loop
stopMp3
RealTimeInsert = False
RealTimePressed = False
Exit Sub
End Sub
Public Sub ChangeSongFile()
Form1.DlgBox.Filter = "MP3 File(*.mp3)|*.mp3|WAV File(*.wav)|*.wav"
Form1.DlgBox.ShowOpen
KSFile.RealTimeFile = Form1.DlgBox.Filename
'KSFile.RealTimeFileType = UCase(Right(KSFile.RealTimeFile, 3))
Form1.DlgBox.Filter = "KSF File (*.ksf)|*.ksf"
End Sub
Public Sub tmpKSF2BMP(speed As String, gtype As String, color As Integer)
Dim tmpKSF As KickStepFile2
Dim tempA As Long
ReDim tmpKSF.Step(Stepcount - 1) As String * 10
For tempA = 0 To Stepcount - 1
    tmpKSF.Step(tempA) = Step(tempA)
Next
tmpKSF.Title = KSFile.Title
tmpKSF.BPM = KSFile.BPM
tmpKSF.BPM2 = KSFile.BPM2
tmpKSF.BPM3 = KSFile.BPM3
tmpKSF.Difficult = KSFile.Difficult
tmpKSF.Tickcount = KSFile.Tickcount
tmpKSF.speed = CSng(speed)
tmpKSF.Filename = KSFile.Filename
tmpKSF.Mode1p2p = KSFile.Mode1p2p
tmpKSF.Stepcount = Stepcount
tmpKSF.color = CBool(color)
tmpKSF.gtype = IIf(gtype = "BMP", 1, 2)
KSF2BMP tmpKSF
End Sub

Public Function GetFileName() As String
GetFileName = KSFile.Filename
End Function

Public Sub GOKSFViewer()
    Shell App.Path & "\KSFViewer.exe '" & KSFile.Filename & "'", vbNormalFocus
End Sub

Public Sub P1P2Equal(p1top2 As Boolean)
Dim TempNum As Long
Select Case p1top2
Case True
    If Multi.Multi = False Then
    For TempNum = 0 To Stepcount - 1
        Step(TempNum) = Mid(Step(TempNum), 1, 5) & Mid(Step(TempNum), 1, 5)
    Next
    ElseIf Multi.Multi = True Then
    For TempNum = Multi.SelectStart To Multi.SelectEnd
        Step(TempNum) = Mid(Step(TempNum), 1, 5) & Mid(Step(TempNum), 1, 5)
    Next
    End If
Case False
    If Multi.Multi = False Then
    For TempNum = 0 To Stepcount - 1
        Step(TempNum) = Mid(Step(TempNum), 6, 5) & Mid(Step(TempNum), 6, 5)
    Next
    ElseIf Multi.Multi = True Then
    For TempNum = Multi.SelectStart To Multi.SelectEnd
        Step(TempNum) = Mid(Step(TempNum), 6, 5) & Mid(Step(TempNum), 6, 5)
    Next
    End If
End Select
KSFile.Changed = True
Redraw
End Sub
Public Sub TurnStep(Mode As Integer, Player As Integer)
Dim TempNum As Long
Dim CStart As Long, CEnd As Long
If Multi.Multi = False Then
CStart = 0: CEnd = Stepcount - 1
ElseIf Multi.Multi = True Then
CStart = Multi.SelectStart: CEnd = Multi.SelectEnd
End If
Select Case Mode
Case 1
    For TempNum = CStart To CEnd
        Select Case Player
        Case 1
        Step(TempNum) = Mid(Step(TempNum), 5, 1) & Mid(Step(TempNum), 4, 1) & Mid(Step(TempNum), 3, 1) & Mid(Step(TempNum), 2, 1) & Mid(Step(TempNum), 1, 1) & Right(Step(TempNum), 5)
        Case 2
        Step(TempNum) = Left(Step(TempNum), 5) & Mid(Step(TempNum), 10, 1) & Mid(Step(TempNum), 9, 1) & Mid(Step(TempNum), 8, 1) & Mid(Step(TempNum), 7, 1) & Mid(Step(TempNum), 6, 1)
        Case 3
        Step(TempNum) = Mid(Step(TempNum), 5, 1) & Mid(Step(TempNum), 4, 1) & Mid(Step(TempNum), 3, 1) & Mid(Step(TempNum), 2, 1) & Mid(Step(TempNum), 1, 1) & Mid(Step(TempNum), 10, 1) & Mid(Step(TempNum), 9, 1) & Mid(Step(TempNum), 8, 1) & Mid(Step(TempNum), 7, 1) & Mid(Step(TempNum), 6, 1)
        End Select
    Next
Case 2
    For TempNum = CStart To CEnd
        Select Case Player
        Case 1
        Step(TempNum) = Mid(Step(TempNum), 2, 1) & Mid(Step(TempNum), 1, 1) & Mid(Step(TempNum), 3, 1) & Mid(Step(TempNum), 5, 1) & Mid(Step(TempNum), 4, 1) & Right(Step(TempNum), 5)
        Case 2
        Step(TempNum) = Left(Step(TempNum), 5) & Mid(Step(TempNum), 7, 1) & Mid(Step(TempNum), 6, 1) & Mid(Step(TempNum), 8, 1) & Mid(Step(TempNum), 10, 1) & Mid(Step(TempNum), 9, 1)
        Case 3
        Step(TempNum) = Mid(Step(TempNum), 2, 1) & Mid(Step(TempNum), 1, 1) & Mid(Step(TempNum), 3, 1) & Mid(Step(TempNum), 5, 1) & Mid(Step(TempNum), 4, 1) & Mid(Step(TempNum), 7, 1) & Mid(Step(TempNum), 6, 1) & Mid(Step(TempNum), 8, 1) & Mid(Step(TempNum), 10, 1) & Mid(Step(TempNum), 9, 1)
        End Select
    Next
Case 3
    For TempNum = CStart To CEnd
        Select Case Player
        Case 1
        Step(TempNum) = Mid(Step(TempNum), 4, 1) & Mid(Step(TempNum), 5, 1) & Mid(Step(TempNum), 3, 1) & Mid(Step(TempNum), 1, 1) & Mid(Step(TempNum), 2, 1) & Right(Step(TempNum), 5)
        Case 2
        Step(TempNum) = Left(Step(TempNum), 5) & Mid(Step(TempNum), 9, 1) & Mid(Step(TempNum), 10, 1) & Mid(Step(TempNum), 8, 1) & Mid(Step(TempNum), 6, 1) & Mid(Step(TempNum), 7, 1)
        Case 3
        Step(TempNum) = Mid(Step(TempNum), 4, 1) & Mid(Step(TempNum), 5, 1) & Mid(Step(TempNum), 3, 1) & Mid(Step(TempNum), 1, 1) & Mid(Step(TempNum), 2, 1) & Mid(Step(TempNum), 9, 1) & Mid(Step(TempNum), 10, 1) & Mid(Step(TempNum), 8, 1) & Mid(Step(TempNum), 6, 1) & Mid(Step(TempNum), 7, 1)
        End Select
    Next
End Select
KSFile.Changed = True
Redraw
End Sub
Public Sub RanDomStep()
Dim A As Integer
If Multi.Multi = True Then
    For A = Multi.SelectStart To Multi.SelectEnd
        Select Case KSFile.Mode1p2p
        Case 1
        Step(A) = CInt(1 * Rnd + 0) & CInt(1 * Rnd + 0) & CInt(1 * Rnd + 0) & CInt(1 * Rnd + 0) & CInt(1 * Rnd + 0) & Mid(Step(A), 6, 5)
        Case 2
        Step(A) = CInt(1 * Rnd + 0) & CInt(1 * Rnd + 0) & CInt(1 * Rnd + 0) & CInt(1 * Rnd + 0) & CInt(1 * Rnd + 0) & CInt(1 * Rnd + 0) & CInt(1 * Rnd + 0) & CInt(1 * Rnd + 0) & CInt(1 * Rnd + 0) & CInt(1 * Rnd + 0)
        End Select
    Next
Else
    Select Case KSFile.Mode1p2p
    Case 1
    Step(StepIndex) = CInt(1 * Rnd + 0) & CInt(1 * Rnd + 0) & CInt(1 * Rnd + 0) & CInt(1 * Rnd + 0) & CInt(1 * Rnd + 0) & Mid(Step(A), 6, 5)
    Case 2
    Step(StepIndex) = CInt(1 * Rnd + 0) & CInt(1 * Rnd + 0) & CInt(1 * Rnd + 0) & CInt(1 * Rnd + 0) & CInt(1 * Rnd + 0) & CInt(1 * Rnd + 0) & CInt(1 * Rnd + 0) & CInt(1 * Rnd + 0) & CInt(1 * Rnd + 0) & CInt(1 * Rnd + 0)
    End Select
End If
KSFile.Changed = True
Redraw
End Sub
Public Sub EmptyStep(Index As Integer)
Dim A As Integer
If Multi.Multi = True Then
    For A = Multi.SelectStart To Multi.SelectEnd
        Select Case Index
        Case 0
            Mid(Step(A), 1, 5) = "00000"
        Case 1
            Mid(Step(A), 6, 5) = "00000"
        Case 2
            Step(A) = "0000000000"
        End Select
    Next
Else
    Select Case Index
    Case 0
        Mid(Step(StepIndex), 1, 5) = "00000"
    Case 1
        Mid(Step(StepIndex), 6, 5) = "00000"
    Case 2
        Step(StepIndex) = "0000000000"
    End Select
End If
KSFile.Changed = True
Redraw
End Sub
Public Sub ToBigSmall(IsBig As Boolean)
Dim A As Long
Select Case IsBig
Case True
    If Multi.Multi = True Then
        Stepcount = Stepcount + (Multi.SelectEnd - Multi.SelectStart)
        ReDim Preserve Step(Stepcount - 1) As String * 10
        For A = Stepcount - 1 To Multi.SelectEnd + (Multi.SelectEnd - Multi.SelectStart) + 1 Step -1
            Step(A) = Step(A - (Multi.SelectEnd - Multi.SelectStart))
        Next
        For A = Multi.SelectEnd + (Multi.SelectEnd - Multi.SelectStart) To Multi.SelectStart Step -1
            If ((A - Multi.SelectStart) / 2 + Multi.SelectStart) = Int(((A - Multi.SelectStart) / 2 + Multi.SelectStart)) Then
                Step(A) = Step((A - Multi.SelectStart) / 2 + Multi.SelectStart)
            Else
                Step(A) = "0000000000"
            End If
        Next
        Multi.SelectStart = Multi.SelectStart * 2
        Multi.SelectEnd = Multi.SelectEnd * 2
    Else
        Stepcount = Stepcount * 2
        ReDim Preserve Step(Stepcount - 1) As String * 10
        For A = Stepcount - 1 To 0 Step -1
            If A / 2 = Int(A / 2) Then
                Step(A) = Step(A / 2)
            Else
                Step(A) = "0000000000"
            End If
        Next
        StepIndex = StepIndex * 2
    End If
Case False
    If Multi.Multi = True Then
        For A = Multi.SelectStart To Multi.SelectStart + Int((Multi.SelectEnd - Multi.SelectStart) / 2) - 1
            Step(A) = Step(Multi.SelectStart + (A - Multi.SelectStart) * 2)
        Next
        For A = Multi.SelectStart + Int((Multi.SelectEnd - Multi.SelectStart) / 2) To (Stepcount - 1) - (Multi.SelectEnd - Multi.SelectStart) / 2
            Step(A) = Step(A + Int((Multi.SelectEnd - Multi.SelectStart) / 2))
        Next
        Stepcount = (Stepcount - 1) - (Multi.SelectEnd - Multi.SelectStart) / 2 + 1
        ReDim Preserve Step(Stepcount - 1) As String * 10
        Multi.SelectStart = Int(Multi.SelectStart / 2)
        Multi.SelectEnd = Int(Multi.SelectEnd / 2)
    Else
        Stepcount = Round(Stepcount / 2)
        For A = 0 To Stepcount - 1
            Step(A) = Step(A * 2)
        Next
        If Stepcount < 1 Then Stepcount = 1
        ReDim Preserve Step(Stepcount - 1) As String * 10
        StepIndex = Int(StepIndex / 2)
    End If
End Select
Redraw
Exit Sub
End Sub
