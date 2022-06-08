VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomct2.ocx"
Begin VB.Form FrmDocu2 
   AutoRedraw      =   -1  'True
   BackColor       =   &H00FFFFFF&
   Caption         =   "New"
   ClientHeight    =   3495
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   3885
   Icon            =   "FrmDocu2.frx":0000
   LinkTopic       =   "Form3"
   MDIChild        =   -1  'True
   ScaleHeight     =   233
   ScaleMode       =   3  '픽셀
   ScaleWidth      =   259
   Begin VB.FileListBox FileSong 
      Height          =   270
      Left            =   120
      Pattern         =   "Song.mp3"
      TabIndex        =   20
      Top             =   1920
      Visible         =   0   'False
      Width           =   855
   End
   Begin VB.PictureBox PicLine 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   240
      Index           =   2
      Left            =   120
      Picture         =   "FrmDocu2.frx":000C
      ScaleHeight     =   16
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   160
      TabIndex        =   18
      Top             =   720
      Visible         =   0   'False
      Width           =   2400
   End
   Begin VB.PictureBox PicArrow 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  '없음
      Height          =   240
      Index           =   14
      Left            =   3480
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
      Index           =   13
      Left            =   3240
      Picture         =   "FrmDocu2.frx":1E4E
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
      Index           =   12
      Left            =   3000
      Picture         =   "FrmDocu2.frx":2190
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
      Index           =   11
      Left            =   2760
      Picture         =   "FrmDocu2.frx":24D2
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
      Index           =   10
      Left            =   2520
      Picture         =   "FrmDocu2.frx":2814
      ScaleHeight     =   16
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   13
      Top             =   120
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.PictureBox PicLine 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   15
      Index           =   1
      Left            =   120
      Picture         =   "FrmDocu2.frx":2B56
      ScaleHeight     =   1
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   160
      TabIndex        =   12
      Top             =   600
      Visible         =   0   'False
      Width           =   2400
   End
   Begin VB.PictureBox PicLine 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   15
      Index           =   0
      Left            =   120
      Picture         =   "FrmDocu2.frx":2D78
      ScaleHeight     =   1
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   160
      TabIndex        =   11
      Top             =   480
      Visible         =   0   'False
      Width           =   2400
   End
   Begin VB.PictureBox PicArrow 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BackColor       =   &H00000000&
      BorderStyle     =   0  '없음
      Height          =   240
      Index           =   9
      Left            =   2280
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
      Index           =   8
      Left            =   2040
      Picture         =   "FrmDocu2.frx":2F9A
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
      Index           =   7
      Left            =   1800
      Picture         =   "FrmDocu2.frx":32DC
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
      Index           =   6
      Left            =   1560
      Picture         =   "FrmDocu2.frx":361E
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
      Index           =   5
      Left            =   1320
      Picture         =   "FrmDocu2.frx":3960
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
      BackColor       =   &H00000000&
      BorderStyle     =   0  '없음
      Height          =   240
      Index           =   4
      Left            =   1080
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
      Index           =   3
      Left            =   840
      Picture         =   "FrmDocu2.frx":3CA2
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
      Index           =   2
      Left            =   600
      Picture         =   "FrmDocu2.frx":3FE4
      ScaleHeight     =   16
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   3
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
      Picture         =   "FrmDocu2.frx":4326
      ScaleHeight     =   16
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   2
      Top             =   120
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.PictureBox PicArrow 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   240
      Index           =   0
      Left            =   120
      Picture         =   "FrmDocu2.frx":4668
      ScaleHeight     =   16
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   16
      TabIndex        =   1
      Top             =   120
      Visible         =   0   'False
      Width           =   240
   End
   Begin MSComCtl2.FlatScrollBar ScrRows 
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   1080
      Width           =   3495
      _ExtentX        =   6165
      _ExtentY        =   450
      _Version        =   393216
      Arrows          =   65536
      Max             =   0
      Orientation     =   1179649
   End
   Begin RichTextLib.RichTextBox ReadBox 
      Height          =   375
      Left            =   120
      TabIndex        =   19
      Top             =   1440
      Visible         =   0   'False
      Width           =   3615
      _ExtentX        =   6376
      _ExtentY        =   661
      _Version        =   393217
      Appearance      =   0
      TextRTF         =   $"FrmDocu2.frx":49AA
   End
End
Attribute VB_Name = "FrmDocu2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim Step(2048) As String '스텝정보
Dim StepIndex As Long '선택된 스텝
Dim StepCount As Long '스텝수
Dim KSFile As KickStepFile '정보
Dim Multi As MultiSelect '다중선택
Dim TotalWidth As Long ' 총 넓이 스크롤을 이용해서 스텝을 표시해 사용
Dim CanDWidth As Long ' 표시 할수 있는 총 넓이
Dim CanDHeight As Long ' 표시 할수 있는 총 높이
Dim NowLeft As Long ' 현재 X 좌표
Dim LastGetTicks As Double ' 틱카운트 마지막에 설정한 값
Private Sub Form_GotFocus()
Select Case KSFile.Speed
Case 0
KSFile.Speed = 1
Form1.tbToolBar.Buttons(10).Image = 7
Case 1
Form1.tbToolBar.Buttons(10).Image = 7
Case 2
Form1.tbToolBar.Buttons(10).Image = 8
Case 4
Form1.tbToolBar.Buttons(10).Image = 9
Case 8
Form1.tbToolBar.Buttons(10).Image = 10
End Select
Select Case KSFile.Mode1p2p
Case 1
Form1.tbToolBar.Buttons(11).Image = 11
Case 2
Form1.tbToolBar.Buttons(11).Image = 12
End Select
ScrRows.Max = TotalWidth
ScrRows.Value = NowLeft
Form1.StatusBar.Panels(2).Text = StepIndex + 1 & " Keyboard"
Form1.StatusBar.Panels(4).Text = StepCount & " Steps"
Redraw
End Sub
Private Sub Form_LostFocus()
RealTimeInsert = False
End Sub
Private Sub Form_Resize()
On Error Resume Next
CanDWidth = Int(Me.ScaleWidth / 80 / KSFile.Mode1p2p)
CanDHeight = Int(Me.ScaleHeight / 128)
ScrRows.Left = 0
ScrRows.Top = Me.ScaleHeight - ScrRows.Height
ScrRows.Width = Me.ScaleWidth
Redraw
End Sub
Private Sub Form_Unload(Cancel As Integer)
stopMp3
If KSFile.Changed = True Then
Dim strMsgCode_Msg As String, strMsgCode_Title As String
Dim strMsgCode_Style As VbMsgBoxStyle
Dim strMsgCode_Response As VbMsgBoxResult
strMsgCode_Msg = "내용이 변경 되었습니다." & vbCrLf & "저장하시겠습니까?"
strMsgCode_Style = vbYesNoCancel + vbDefaultButton1 + vbQuestion + vbApplicationModal
strMsgCode_Title = KSFile.Title
strMsgCode_Response = MsgBox(strMsgCode_Msg, strMsgCode_Style, strMsgCode_Title)
Select Case strMsgCode_Response 'vbYesNoCancel
    Case vbYes '예 선택.
    If Me.Caption = "New" Then
    With Form1.DlgBox
    .FileName = ""
    .ShowSave
    If .FileName = "" Then
        Cancel = 1
        Exit Sub
    End If
    SaveKSF
    ReadBox.SaveFile .FileName, rtfText
    KSFile.FileName = .FileName
    End With
    Else
        SaveKSF
        ReadBox.SaveFile KSFile.FileName, rtfText
    End If
    Case vbNo '아니오 선택.
    Case vbCancel '취소 선택.
        Cancel = 1
End Select
Else
End If
End Sub
Public Sub SelectAll()
Multi.Multied = True
Multi.SelectStart = 0
Multi.SelectEnd = StepCount - 1
Multi.Start = 0
Redraw
End Sub
Public Sub EditCopy()
CBoard = ""
If Multi.Multied = False Then
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
Dim Temp As Integer, Temp2 As Integer, Temp3 As Integer, Data As String
Temp2 = 0
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
If Start = False Then
    KSFile.FileName = Form1.DlgBox.FileName
    Do Until Mid(KSFile.FileName, Len(KSFile.FileName) - Temp3, 1) = "\"
    DoEvents
    Temp3 = Temp3 + 1
    Loop
    FileSong.Path = Mid(KSFile.FileName, 1, Len(KSFile.FileName) - Temp3)
    If FileSong.ListCount = 1 Then KSFile.RealTimeFile = FileSong.Path & "\Song.mp3"
ElseIf Start = True Then
    KSFile.FileName = Path
    Do Until Mid(KSFile.FileName, Len(KSFile.FileName) - Temp3, 1) = "\"
    DoEvents
    Temp3 = Temp3 + 1
    Loop
    FileSong.Path = Mid(KSFile.FileName, 1, Len(KSFile.FileName) - Temp3)
    If FileSong.ListCount = 1 Then KSFile.RealTimeFile = FileSong.Path & "\Song.mp3"
End If
AddFromKSF Data
A:
End Sub
Public Sub SaveKSF()
Dim Data As String
Data = ""
Data = Data & "#TITLE:" & KSFile.Title & ";" & vbCrLf
Data = Data & "#BPM:" & KSFile.BPM & ";" & vbCrLf
If KSFile.BPM2 <> -1 Then Data = Data & "#BPM2:" & KSFile.BPM2 & ";" & vbCrLf
If KSFile.BPM3 <> -1 Then Data = Data & "#BPM3:" & KSFile.BPM3 & ";" & vbCrLf
Data = Data & "#TICKCOUNT:" & KSFile.TickCount & ";" & vbCrLf
Data = Data & "#STARTTIME:" & KSFile.StartTime & ";" & vbCrLf
If KSFile.StartTime2 <> -1 Then Data = Data & "#STARTTIME2:" & KSFile.StartTime2 & ";" & vbCrLf
If KSFile.StartTime3 <> -1 Then Data = Data & "#STARTTIME3:" & KSFile.StartTime3 & ";" & vbCrLf
If KSFile.Bunki <> -1 Then Data = Data & "#BUNKI:" & KSFile.Bunki & ";" & vbCrLf
If KSFile.Bunki2 <> -1 Then Data = Data & "#BUNKI2:" & KSFile.Bunki2 & ";" & vbCrLf
If KSFile.Difficult <> -1 Then Data = Data & "#DIFFICULTY:" & KSFile.Difficult & ";" & vbCrLf
Data = Data & "#STEP:" & vbCrLf & GetKSF
ReadBox.Text = Data
ReadBox.SaveFile Form1.DlgBox.FileName, rtfText
KSFile.FileName = Form1.DlgBox.FileName
KSFile.Changed = False
Me.Caption = KSFile.Title
End Sub
Public Sub PropertyReset()
Dim A As Integer
For A = 0 To 2047
    DoEvents
    Step(A) = ""
Next
Step(0) = "0000000000"
StepCount = 1
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
KSFile.TickCount = 4
KSFile.Difficult = -1
KSFile.Speed = 1
KSFile.Mode1p2p = 1
Form_Resize
End Sub
Public Sub ChangeSpeed(ByVal ButtonMenu As MSComctlLib.ButtonMenu)
Form1.tbToolBar.Buttons(10).Image = ButtonMenu.Index + 6
KSFile.Speed = Right(ButtonMenu.Key, 1)
Form_Resize
Redraw
End Sub
Public Sub ChangeSpeed2(Index As Integer)
Form1.tbToolBar.Buttons(10).Image = Index + 7
KSFile.Speed = Left(Form1.mnuViewX(Index).Caption, 1)
Form_Resize
Redraw
End Sub
Public Sub ChangeNowLeft()
NowLeft = ScrRows.Value
Form_Resize
Redraw
End Sub
Public Sub Change1p2p(Mode As Integer)
KSFile.Mode1p2p = Mode
Form1.tbToolBar.Buttons(11).Image = 10 + KSFile.Mode1p2p
Form_Resize
Redraw
End Sub
Public Sub Change1p2p2(Mode As Integer)
KSFile.Mode1p2p = Mode
Form1.tbToolBar.Buttons(11).Image = 10 + KSFile.Mode1p2p
Form_Resize
Redraw
End Sub
Public Sub ChangeProperty(Inputs As Boolean, Optional Save As Boolean = True)
On Error Resume Next
Select Case Inputs
Case True
    Form2.Show
    Form2.txtTitle.Text = KSFile.Title
    Form2.txtBPM.Text = KSFile.BPM
    Form2.txtBPM2.Text = KSFile.BPM2
    Form2.txtBPM3.Text = KSFile.BPM3
    Form2.txtStart.Text = KSFile.StartTime
    Form2.txtStart2.Text = KSFile.StartTime2
    Form2.txtStart3.Text = KSFile.StartTime3
    Form2.txtBunki.Text = KSFile.Bunki
    Form2.txtBunki2.Text = KSFile.Bunki2
    If KSFile.StartTime2 = -1 Then Form2.txtStart2.Text = ""
    If KSFile.StartTime3 = -1 Then Form2.txtStart3.Text = ""
    If KSFile.BPM2 = -1 Then Form2.txtBPM2.Text = ""
    If KSFile.BPM3 = -1 Then Form2.txtBPM3.Text = ""
    If KSFile.Bunki = -1 Then Form2.txtBunki.Text = ""
    If KSFile.Bunki2 = -1 Then Form2.txtBunki2.Text = ""
    Form2.CboTick.Text = KSFile.TickCount
    Form2.CboDiff.Text = KSFile.Difficult
Case False
If Save = True Then
If CSng(Form2.txtBPM.Text) <= 0 Then
    MsgBox "BPM이 잘못됐습니다"
    Exit Sub
Else
    KSFile.BPM = CSng(Form2.txtBPM.Text)
End If
If Form2.txtBPM2.Text = "" Then
    KSFile.BPM2 = -1
ElseIf CSng(Form2.txtBPM2.Text) > 0 Then
    KSFile.BPM2 = CSng(Form2.txtBPM2.Text)
Else
    MsgBox "BPM2이 잘못됐습니다"
    Exit Sub
End If
If Form2.txtBPM3.Text = "" Then
    KSFile.BPM3 = -1
ElseIf CSng(Form2.txtBPM3.Text) > 0 Then
    KSFile.BPM3 = CSng(Form2.txtBPM3.Text)
Else
    MsgBox "BPM3이 잘못됐습니다"
    Exit Sub
End If
If CInt(CStr(Form2.CboTick.Text)) <= 0 Then
    MsgBox "틱카운트가 잘못됐습니다"
    Exit Sub
Else
    KSFile.TickCount = CInt(Form2.CboTick.Text)
End If
If Form2.CboDiff.Text = "없음" Or Form2.CboDiff.Text = "" Then
    KSFile.Difficult = -1
ElseIf CInt(CStr(Form2.CboDiff.Text)) < 0 Then
    MsgBox "난이도가 잘못됐습니다"
    Exit Sub
Else
    KSFile.Difficult = CInt(Form2.CboDiff.Text)
End If
If Form2.txtStart.Text = "" Then
    KSFile.StartTime = 0
ElseIf CLng(Form2.txtStart.Text) < 0 Then
    KSFile.StartTime = 0
Else
    KSFile.StartTime = CLng(Form2.txtStart.Text)
End If
If Form2.txtStart2.Text = "" Then
    KSFile.StartTime2 = -1
ElseIf CLng(Form2.txtStart2.Text) < 0 Then
    MsgBox "스타트타임2가 잘못됐습니다"
    Exit Sub
Else
    KSFile.StartTime2 = CLng(Form2.txtStart2.Text)
End If
If Form2.txtStart3.Text = "" Then
    KSFile.StartTime3 = -1
ElseIf CLng(Form2.txtStart3.Text) < 0 Then
    MsgBox "스타트타임3가 잘못됐습니다"
    Exit Sub
Else
    KSFile.StartTime3 = CLng(Form2.txtStart3.Text)
End If
If Form2.txtBunki.Text = "" Then
    KSFile.Bunki = -1
ElseIf CLng(Form2.txtBunki.Text) < 0 Then
    MsgBox "분기가 잘못됐습니다"
    Exit Sub
Else
    KSFile.Bunki = CLng(Form2.txtBunki.Text)
End If
If Form2.txtBunki2.Text = "" Then
    KSFile.Bunki2 = -1
ElseIf CLng(Form2.txtBunki2.Text) < 0 Then
    MsgBox "분기가 잘못됐습니다"
    Exit Sub
Else
    KSFile.Bunki2 = CLng(Form2.txtBunki2.Text)
End If
KSFile.Title = Form2.txtTitle.Text
KSFile.Changed = True
End If
Unload Form2
Form_Resize
Redraw
Form1.Enabled = True
End Select
End Sub
Public Sub GetBunki()
Dim TempBunki As Long
If Multi.Multied = True Then
    TempBunki = Int((6000 / (KSFile.BPM * KSFile.TickCount)) * Multi.SelectStart) + KSFile.StartTime
Else
    TempBunki = Int((6000 / (KSFile.BPM * KSFile.TickCount)) * StepIndex) + KSFile.StartTime
End If
MsgBox TempBunki
End Sub
Public Sub Redraw()
On Error Resume Next
If KSFile.Speed < 1 Then KSFile.Speed = 1
TotalWidth = Int((StepCount - 1) / (8 * CanDHeight * KSFile.TickCount / KSFile.Speed)) + 1
ScrRows.Max = (TotalWidth - CanDWidth)
If ScrRows.Max < 0 Then ScrRows.Max = 0
Form1.StatusBar.Panels(2).Text = StepIndex + 1 & " Keyboard"
Form1.StatusBar.Panels(4).Text = StepCount & " Steps"
Dim A As Integer, B As Integer, x As Integer, y As Integer, z As Integer
'A는 리스트에서 뽑아올때,B는 화살표 읽을때, X,Y는 좌표 , Z는 선 or 점선
Me.Cls
' 선택된 스텝 표시
x = 0: y = 0: z = 0
For A = NowLeft * 8 * CanDHeight * KSFile.TickCount / KSFile.Speed To (NowLeft + CanDWidth) * 8 * CanDHeight * KSFile.TickCount / KSFile.Speed - 1
    If A >= 0 Then
    If Multi.Multied = True Then
        If A >= Multi.SelectStart And A <= Multi.SelectEnd Then BitBlt Me.hDC, (x * 80 * KSFile.Mode1p2p) + 5, y * 16 / KSFile.TickCount, 64 * KSFile.Mode1p2p, 16, PicLine(2).hDC, 0, 0, vbSrcAnd
    Else
        If A = StepIndex Then BitBlt Me.hDC, (x * 80 * KSFile.Mode1p2p) + 5, y * 16 / KSFile.TickCount, 64 * KSFile.Mode1p2p, 16, PicLine(2).hDC, 0, 0, vbSrcAnd
    End If
    y = y + KSFile.Speed
    If y = 8 * CanDHeight * KSFile.TickCount Then
        y = 0
        x = x + 1
    End If
    If A + 1 = StepCount Then Exit For
    Else
        y = y + KSFile.Speed
        If y = 8 * CanDHeight * KSFile.TickCount Then
            y = 0
            x = x + 1
        End If
    End If
Next
' 스텝 그리기
x = 0: y = 0: z = 0
For A = NowLeft * 8 * CanDHeight * KSFile.TickCount / KSFile.Speed To (NowLeft + CanDWidth) * 8 * CanDHeight * KSFile.TickCount / KSFile.Speed - 1
    If A >= 0 Then
    For B = 0 To KSFile.Mode1p2p * 5 - 1
    If Mid(Step(A), B + 1, 1) = "1" Then
    If Multi.Multied = True Then
        If A >= Multi.SelectStart And A <= Multi.SelectEnd Then
            If B < 4 Then
            BitBlt Me.hDC, (B * 16 + x * 80 * KSFile.Mode1p2p) + 5, y * 16 / KSFile.TickCount, 16, 16, PicArrow((B Mod 5) + 10).hDC, 0, 0, vbSrcAnd
            BitBlt Me.hDC, (B * 16 + x * 80 * KSFile.Mode1p2p) + 5, y * 16 / KSFile.TickCount, 16, 16, PicArrow((B Mod 5) + 5).hDC, 0, 0, vbSrcPaint
            Else
            BitBlt Me.hDC, (B * 16 + x * 80 * KSFile.Mode1p2p) + 5, y * 16 / KSFile.TickCount, 16, 16, PicArrow(((B - 1) Mod 5) + 10).hDC, 0, 0, vbSrcAnd
            BitBlt Me.hDC, (B * 16 + x * 80 * KSFile.Mode1p2p) + 5, y * 16 / KSFile.TickCount, 16, 16, PicArrow(((B - 1) Mod 5) + 5).hDC, 0, 0, vbSrcPaint
            End If
        Else
            If B < 4 Then
            BitBlt Me.hDC, (B * 16 + x * 80 * KSFile.Mode1p2p) + 5, y * 16 / KSFile.TickCount, 16, 16, PicArrow((B Mod 5) + 10).hDC, 0, 0, vbSrcAnd
            BitBlt Me.hDC, (B * 16 + x * 80 * KSFile.Mode1p2p) + 5, y * 16 / KSFile.TickCount, 16, 16, PicArrow((B Mod 5)).hDC, 0, 0, vbSrcPaint
            Else
            BitBlt Me.hDC, (B * 16 + x * 80 * KSFile.Mode1p2p) + 5, y * 16 / KSFile.TickCount, 16, 16, PicArrow(((B - 1) Mod 5) + 10).hDC, 0, 0, vbSrcAnd
            BitBlt Me.hDC, (B * 16 + x * 80 * KSFile.Mode1p2p) + 5, y * 16 / KSFile.TickCount, 16, 16, PicArrow(((B - 1) Mod 5)).hDC, 0, 0, vbSrcPaint
            End If
        End If
    ElseIf Multi.Multied = False Then
        If A = StepIndex Then
            If B < 4 Then
            BitBlt Me.hDC, (B * 16 + x * 80 * KSFile.Mode1p2p) + 5, y * 16 / KSFile.TickCount, 16, 16, PicArrow((B Mod 5) + 10).hDC, 0, 0, vbSrcAnd
            BitBlt Me.hDC, (B * 16 + x * 80 * KSFile.Mode1p2p) + 5, y * 16 / KSFile.TickCount, 16, 16, PicArrow((B Mod 5) + 5).hDC, 0, 0, vbSrcPaint
            Else
            BitBlt Me.hDC, (B * 16 + x * 80 * KSFile.Mode1p2p) + 5, y * 16 / KSFile.TickCount, 16, 16, PicArrow(((B - 1) Mod 5) + 10).hDC, 0, 0, vbSrcAnd
            BitBlt Me.hDC, (B * 16 + x * 80 * KSFile.Mode1p2p) + 5, y * 16 / KSFile.TickCount, 16, 16, PicArrow(((B - 1) Mod 5) + 5).hDC, 0, 0, vbSrcPaint
            End If
        Else
            If B < 4 Then
            BitBlt Me.hDC, (B * 16 + x * 80 * KSFile.Mode1p2p) + 5, y * 16 / KSFile.TickCount, 16, 16, PicArrow((B Mod 5) + 10).hDC, 0, 0, vbSrcAnd
            BitBlt Me.hDC, (B * 16 + x * 80 * KSFile.Mode1p2p) + 5, y * 16 / KSFile.TickCount, 16, 16, PicArrow((B Mod 5)).hDC, 0, 0, vbSrcPaint
            Else
            BitBlt Me.hDC, (B * 16 + x * 80 * KSFile.Mode1p2p) + 5, y * 16 / KSFile.TickCount, 16, 16, PicArrow(((B - 1) Mod 5) + 10).hDC, 0, 0, vbSrcAnd
            BitBlt Me.hDC, (B * 16 + x * 80 * KSFile.Mode1p2p) + 5, y * 16 / KSFile.TickCount, 16, 16, PicArrow(((B - 1) Mod 5)).hDC, 0, 0, vbSrcPaint
            End If
        End If
    End If
    End If
    Next
    y = y + KSFile.Speed
    If y = 8 * CanDHeight * KSFile.TickCount Then
        y = 0
        x = x + 1
    End If
    If A + 1 = StepCount Then Exit For
    Else
        y = y + KSFile.Speed
        If y = 8 * CanDHeight * KSFile.TickCount Then
            y = 0
            x = x + 1
        End If
    End If
Next
' 박자 구분선 그리기
x = 0: y = 0: z = 4
For A = NowLeft * 8 * CanDHeight * KSFile.TickCount / KSFile.Speed To (NowLeft + CanDWidth) * 8 * CanDHeight * KSFile.TickCount / KSFile.Speed - 1
    If A >= 0 Then
    If A / KSFile.TickCount = Int(A / KSFile.TickCount) Then
    If y > 0 And y <= 8 * CanDHeight * KSFile.TickCount Then
        If z = 4 Then
        BitBlt Me.hDC, (x * 80 * KSFile.Mode1p2p) + 5, y * 16 / KSFile.TickCount, 64 * KSFile.Mode1p2p, 1, PicLine(0).hDC, 0, 0, vbSrcCopy
        z = 1
        Else
        BitBlt Me.hDC, (x * 80 * KSFile.Mode1p2p) + 5, y * 16 / KSFile.TickCount, 64 * KSFile.Mode1p2p, 1, PicLine(1).hDC, 0, 0, vbSrcCopy
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
    y = y + KSFile.Speed
    If y = 8 * CanDHeight * KSFile.TickCount Then
        y = 0
        x = x + 1
        z = 4
    End If
    If A + 1 = StepCount Then Exit For
    Else
    y = y + KSFile.Speed
    If y = 8 * CanDHeight * KSFile.TickCount Then
    y = 0
    x = x + 1
    z = 4
    End If
    End If
Next
End Sub
Public Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
On Error Resume Next
Dim A As Long, B As Long
Select Case KeyCode
Case 45
    If RealTimeInsert = False Then
    If Multi.Multied = False Then
        If StepCount = 0 Then '화살표가 하나도 없으면 - 그럴리는 없지만 -_-a
            StepCount = StepCount + 1
            Step(StepIndex) = "0000000000" '처음에 화살표 추가
        Else
            If StepCount + 1 > 2048 Then Exit Sub
            StepCount = StepCount + 1
            For B = StepCount To StepIndex + 1 Step -1
                If StepCount < 2048 Then Step(B) = Step(B - 1)
            Next
            Step(StepIndex) = "0000000000"
        End If
    Else
    A = Multi.SelectEnd - Multi.SelectStart + 1
    If StepCount + A > 2047 Then Exit Sub
    StepCount = StepCount + A
    For B = StepCount To Multi.SelectEnd Step -1
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
    If Multi.Multied = False Then
        If StepCount = 1 Then
            Step(0) = "0000000000"
            StepIndex = 0
        Else
            For B = StepIndex To StepCount - 1
                If B < 2048 Then Step(B) = Step(B + 1)
            Next
            Step(StepCount - 1) = ""
            StepCount = StepCount - 1
            If StepIndex >= StepCount - 1 Then StepIndex = StepCount - 1
        End If
    Else
    A = Multi.SelectEnd - Multi.SelectStart + 1
    For B = StepIndex To StepCount - 1
        If B + A < 2048 Then Step(B) = Step(B + A)
    Next
    For B = 1 To A
        Step(StepCount - B) = ""
    Next
    StepCount = StepCount - A
    If StepIndex >= StepCount - 1 Then StepIndex = StepCount - 1
    If Multi.SelectEnd >= StepCount - 1 Then Multi.SelectEnd = StepCount - 1
    If Multi.SelectEnd - Multi.SelectStart <> A Then
        StepIndex = Multi.SelectEnd
        Multi.Multied = False
    End If
    End If
    KSFile.Changed = True
    End If
    If StepCount < 1 Then
    StepCount = 1
    StepIndex = 0
    Step(0) = "0000000000"
    End If
Case vbKeyNumpad4
If RealTimeInsert = True And RealTimePressed = False Then
    RealTimePressed = True
End If
If KSFile.Mode1p2p = 1 Then
    If Len(Step(StepIndex)) <> 10 Then Step(StepIndex) = "0000000000"
    If Mid(Step(StepIndex), 1, 1) = "1" Then
        Step(StepIndex) = "0" & Mid(Step(StepIndex), 2, 9)
    Else
        Step(StepIndex) = "1" & Mid(Step(StepIndex), 2, 9)
    End If
ElseIf KSFile.Mode1p2p = 2 Then
    If Len(Step(StepIndex)) <> 10 Then Step(StepIndex) = "0000000000"
    If Mid(Step(StepIndex), 6, 1) = "1" Then
        Step(StepIndex) = Mid(Step(StepIndex), 1, 5) & "0" & Mid(Step(StepIndex), 7, 4)
    Else
        Step(StepIndex) = Mid(Step(StepIndex), 1, 5) & "1" & Mid(Step(StepIndex), 7, 4)
    End If
End If
    KSFile.Changed = True
Case vbKeyNumpad2
If RealTimeInsert = True And RealTimePressed = False Then
    RealTimePressed = True
End If
If KSFile.Mode1p2p = 1 Then
    If Len(Step(StepIndex)) <> 10 Then Step(StepIndex) = "0000000000"
    If Mid(Step(StepIndex), 2, 1) = "1" Then
        Step(StepIndex) = Mid(Step(StepIndex), 1, 1) & "0" & Mid(Step(StepIndex), 3, 8)
    Else
        Step(StepIndex) = Mid(Step(StepIndex), 1, 1) & "1" & Mid(Step(StepIndex), 3, 8)
    End If
ElseIf KSFile.Mode1p2p = 2 Then
    If Len(Step(StepIndex)) <> 10 Then Step(StepIndex) = "0000000000"
    If Mid(Step(StepIndex), 7, 1) = "1" Then
        Step(StepIndex) = Mid(Step(StepIndex), 1, 6) & "0" & Mid(Step(StepIndex), 8, 3)
    Else
        Step(StepIndex) = Mid(Step(StepIndex), 1, 6) & "1" & Mid(Step(StepIndex), 8, 3)
    End If
End If
    KSFile.Changed = True
Case vbKeyNumpad8
If RealTimeInsert = True And RealTimePressed = False Then
    RealTimePressed = True
End If
If KSFile.Mode1p2p = 1 Then
    If Len(Step(StepIndex)) <> 10 Then Step(StepIndex) = "0000000000"
    If Mid(Step(StepIndex), 3, 1) = "1" Then
        Step(StepIndex) = Mid(Step(StepIndex), 1, 2) & "0" & Mid(Step(StepIndex), 4, 7)
    Else
        Step(StepIndex) = Mid(Step(StepIndex), 1, 2) & "1" & Mid(Step(StepIndex), 4, 7)
    End If
ElseIf KSFile.Mode1p2p = 2 Then
    If Len(Step(StepIndex)) <> 10 Then Step(StepIndex) = "0000000000"
    If Mid(Step(StepIndex), 8, 1) = "1" Then
        Step(StepIndex) = Mid(Step(StepIndex), 1, 7) & "0" & Mid(Step(StepIndex), 9, 2)
    Else
        Step(StepIndex) = Mid(Step(StepIndex), 1, 7) & "1" & Mid(Step(StepIndex), 9, 2)
    End If
End If
    KSFile.Changed = True
Case vbKeyNumpad6
If RealTimeInsert = True And RealTimePressed = False Then
    RealTimePressed = True
End If
If KSFile.Mode1p2p = 1 Then
    If Len(Step(StepIndex)) <> 10 Then Step(StepIndex) = "0000000000"
    If Mid(Step(StepIndex), 4, 1) = "1" Then
        Step(StepIndex) = Mid(Step(StepIndex), 1, 3) & "0" & Mid(Step(StepIndex), 5, 6)
    Else
        Step(StepIndex) = Mid(Step(StepIndex), 1, 3) & "1" & Mid(Step(StepIndex), 5, 6)
    End If
ElseIf KSFile.Mode1p2p = 2 Then
    If Len(Step(StepIndex)) <> 10 Then Step(StepIndex) = "0000000000"
    If Mid(Step(StepIndex), 9, 1) = "1" Then
        Step(StepIndex) = Mid(Step(StepIndex), 1, 8) & "0" & Mid(Step(StepIndex), 10, 1)
    Else
        Step(StepIndex) = Mid(Step(StepIndex), 1, 8) & "1" & Mid(Step(StepIndex), 10, 1)
    End If
End If
    KSFile.Changed = True
Case vbKeyA
'If RealTimeInsert = False And RealTimePressed = False And KSFile.Mode1p2p = 2 Then
If RealTimeInsert = False And RealTimePressed = False Then
    RealTimePressed = True
End If
'    If KSFile.Mode1p2p = 2 Then
    If Len(Step(StepIndex)) <> 10 Then Step(StepIndex) = "0000000000"
    If Mid(Step(StepIndex), 1, 1) = "1" Then
        Step(StepIndex) = "0" & Mid(Step(StepIndex), 2, 9)
    Else
        Step(StepIndex) = "1" & Mid(Step(StepIndex), 2, 9)
    End If
    KSFile.Changed = True
'    End If
Case vbKeyX
'If RealTimeInsert = False And RealTimePressed = False And KSFile.Mode1p2p = 2 Then
If RealTimeInsert = False And RealTimePressed = False Then
    RealTimePressed = True
End If
If GetAsyncKeyState(vbKeyControl) = 0 Then
'    If KSFile.Mode1p2p = 2 Then
    If Len(Step(StepIndex)) <> 10 Then Step(StepIndex) = "0000000000"
    If Mid(Step(StepIndex), 2, 1) = "1" Then
        Step(StepIndex) = Mid(Step(StepIndex), 1, 1) & "0" & Mid(Step(StepIndex), 3, 8)
    Else
        Step(StepIndex) = Mid(Step(StepIndex), 1, 1) & "1" & Mid(Step(StepIndex), 3, 8)
    End If
    KSFile.Changed = True
'    End If
End If
Case vbKeyW
'If RealTimeInsert = False And RealTimePressed = False And KSFile.Mode1p2p = 2 Then
If RealTimeInsert = False And RealTimePressed = False Then
    RealTimePressed = True
End If
'    If KSFile.Mode1p2p = 2 Then
    If Len(Step(StepIndex)) <> 10 Then Step(StepIndex) = "0000000000"
    If Mid(Step(StepIndex), 3, 1) = "1" Then
        Step(StepIndex) = Mid(Step(StepIndex), 1, 2) & "0" & Mid(Step(StepIndex), 4, 7)
    Else
        Step(StepIndex) = Mid(Step(StepIndex), 1, 2) & "1" & Mid(Step(StepIndex), 4, 7)
    End If
    KSFile.Changed = True
'    End If
Case vbKeyD
'If RealTimeInsert = False And RealTimePressed = False And KSFile.Mode1p2p = 2 Then
If RealTimeInsert = False And RealTimePressed = False Then
    RealTimePressed = True
End If
'    If KSFile.Mode1p2p = 2 Then
    If Len(Step(StepIndex)) <> 10 Then Step(StepIndex) = "0000000000"
    If Mid(Step(StepIndex), 4, 1) = "1" Then
        Step(StepIndex) = Mid(Step(StepIndex), 1, 3) & "0" & Mid(Step(StepIndex), 5, 6)
    Else
        Step(StepIndex) = Mid(Step(StepIndex), 1, 3) & "1" & Mid(Step(StepIndex), 5, 6)
    End If
    KSFile.Changed = True
'    End If
Case vbKeyDown
    If RealTimeInsert = False Then
    Multi.Multied = False
    If GetAsyncKeyState(vbKeyControl) <> 0 Then
        If StepIndex >= StepCount - (4 * KSFile.TickCount) Then
        Else
            StepIndex = StepIndex + (4 * KSFile.TickCount)
        End If
    Else
        If StepIndex >= StepCount - 1 Then
        Else
            StepIndex = StepIndex + 1
        End If
    End If
    End If
Case vbKeyUp
    If RealTimeInsert = False Then
    Multi.Multied = False
    If GetAsyncKeyState(vbKeyControl) <> 0 Then
        If StepIndex - (4 * KSFile.TickCount) + 1 <= 0 Then
        Else
            StepIndex = StepIndex - (4 * KSFile.TickCount)
        End If
    Else
        If StepIndex = 0 Then
        Else
            StepIndex = StepIndex - 1
        End If
    End If
    End If
Case vbKeyLeft
    If RealTimeInsert = False Then
    Multi.Multied = False
    If StepIndex - (8 * CanDHeight * KSFile.TickCount / KSFile.Speed) >= 0 Then StepIndex = StepIndex - (8 * CanDHeight * KSFile.TickCount / KSFile.Speed)
    End If
Case vbKeyRight
    If RealTimeInsert = False Then
    Multi.Multied = False
    If StepIndex + (8 * CanDHeight * KSFile.TickCount / KSFile.Speed) < StepCount Then StepIndex = StepIndex + (8 * CanDHeight * KSFile.TickCount / KSFile.Speed)
    End If
Case vbKeyEscape
    RealTimeInsert = False
End Select
Do
DoEvents
If StepIndex > ((NowLeft + CanDWidth) * 8 * CanDHeight * KSFile.TickCount / KSFile.Speed) - 1 Then
    NowLeft = NowLeft + 1
    ScrRows.Value = NowLeft
Else
    Exit Do
End If
Loop
Do
DoEvents
If StepIndex < (NowLeft * 8 * CanDHeight * KSFile.TickCount / KSFile.Speed) Then
    NowLeft = NowLeft - 1
    ScrRows.Value = NowLeft
Else
    Exit Do
End If
Loop
Redraw
End Sub
Private Sub Form_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Error Resume Next
Dim A As Integer, B As Integer, C As Integer
If Button = 1 Then
    Multi.Multied = False
    A = Int((x - 5) / 80 / KSFile.Mode1p2p)
    B = Int(y / 16 * KSFile.TickCount)
    C = ((NowLeft + A) * 8 * CanDHeight * KSFile.TickCount / KSFile.Speed) + B / KSFile.Speed
    If C >= 0 And C < StepCount Then
        StepIndex = C
        Multi.Start = C
    End If
ElseIf Button = 2 Then
    PopupMenu Form1.mnuEdit
End If
End Sub
Private Sub Form_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
On Error Resume Next
Dim A As Integer, B As Integer, C As Integer
A = Int((x - 5) / 80 / KSFile.Mode1p2p)
B = Int(y / 16 * KSFile.TickCount)
C = ((NowLeft + A) * 8 * CanDHeight * KSFile.TickCount / KSFile.Speed) + B / KSFile.Speed
Form1.StatusBar.Panels(3).Text = C + 1 & " Mouse"
If Button = 1 Then
    A = Int((x - 5) / 80 / KSFile.Mode1p2p)
    B = Int(y / 16 * KSFile.TickCount)
    C = ((NowLeft + A) * 8 * CanDHeight * KSFile.TickCount / KSFile.Speed) + B / KSFile.Speed
    If C / KSFile.Speed >= 0 And C / KSFile.Speed < StepCount Then
        If C > Multi.Start Then
        Multi.SelectStart = Multi.Start
        Multi.SelectEnd = C
        ElseIf C < Multi.Start Then
        Multi.SelectStart = C
        Multi.SelectEnd = Multi.Start
        End If
        Multi.Multied = True
    End If
    Redraw
End If
End Sub
Private Sub Form_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
Redraw
End Sub
Private Function GetKSF() As String
    Dim A As Integer, B As Integer
    GetKSF = ""
    For A = 0 To StepCount - 1
        DoEvents
        If Len(Step(A)) = 10 Then GetKSF = GetKSF & Step(A) & "000" & vbCrLf
    Next
    GetKSF = GetKSF & "2222222222222"
End Function
Private Function PasteSteps(Steps As Integer, Stepstr As String) As Variant
Dim A As Long, B As Long, SStart As Long, SEnd As Long
If Multi.Multied = False Then
    If StepCount + Steps > 2048 Then Exit Function
    StepCount = StepCount + Steps
    SStart = StepIndex
    SEnd = StepIndex + Steps - 1
Else
    If StepCount + Steps > 2048 Then Exit Function
    StepCount = StepCount + Steps
    SStart = Multi.SelectStart
    SEnd = Multi.SelectStart + Steps - 1
End If
A = 0
For B = StepCount To SEnd + 1 Step -1
        Step(B) = Step(B - Steps)
Next
For B = SStart To SEnd
    Step(B) = Mid(Stepstr, A * 10 + 1, 10)
    A = A + 1
Next
Redraw
End Function
Private Function PasteSteps2(Steps As Integer, Stepstr As String) As Variant
Dim A As Long, B As Long, SStart As Long, SEnd As Long
If Multi.Multied = False Then
    SStart = StepIndex
Else
    SStart = Multi.SelectStart
End If
SEnd = SStart + Steps
For B = SStart To SEnd - 1
    If B >= StepCount Then Exit For
    Step(B) = Mid(Stepstr, A * 10 + 1, 10)
    A = A + 1
Next
Redraw
End Function
Private Function AddFromKSF(Data As String) As String
Dim Temp As Integer
Data = Mid(Data, 9, Len(Data))
StepCount = 0
StepIndex = 0
Do
DoEvents
If Mid(Data, 1, 1) = "2" Then Exit Do
Step(StepCount) = Mid(Data, 1, 10)
Temp = 0
    Do
    DoEvents
    Temp = Temp + 1
    If Mid(Data, Temp, 2) = vbCrLf Then Exit Do
    Loop
Data = Mid(Data, Temp + 2, Len(Data))
StepCount = StepCount + 1
Loop
StepIndex = 0
Redraw
End Function
Public Sub RealTimeStart()
On Error Resume Next
Dim StepIndex2 As Long, BPMBPM As Double
openMp3 KSFile.RealTimeFile
RealTimeInsert = True
StepIndex2 = 0
StepIndex = 0
BPMBPM = (60000 / (KSFile.BPM * KSFile.TickCount))
playMp3
LastGetTicks = GetTickCount
Do While RealTimeInsert = True
DoEvents
If getMp3Len = getMp3Pos And getMp3Len > 0 Then RealTimeInsert = False
If RealTimePressed = False Then
    Do
    DoEvents
    If RealTimePressed = True Then
        KSFile.StartTime = Int((getMp3Pos) * 100)
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
    If StepCount - 1 < StepIndex2 Then StepCount = StepIndex2 + 1
    Redraw
    If StepCount >= 2048 Then Exit Do
    Do
    DoEvents
    If StepIndex > ((NowLeft + CanDWidth) * 8 * CanDHeight * KSFile.TickCount / KSFile.Speed) - 1 Then
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
Form1.DlgBox.Filter = "Song File(*.wav,*.mp3)|*.wav;*.mp3"
Form1.DlgBox.ShowOpen
KSFile.RealTimeFile = Form1.DlgBox.FileName
Form1.DlgBox.Filter = "KSF File (*.ksf)|*.ksf"
openMp3 KSFile.RealTimeFile
End Sub
Public Sub tmpKSF2BMP(Index As Integer)
Dim Tempsteps As TempStep, tempA As Long
For tempA = 0 To 2048
    Tempsteps.Step(tempA) = Step(tempA)
Next
If Index = 0 Then
KSF2BMP KSFile, StepCount, Tempsteps, False
Else
KSF2BMP KSFile, StepCount, Tempsteps, True
End If
End Sub
Public Function GetFileName() As String
GetFileName = KSFile.FileName
End Function
Public Sub MRUChange()
RegiInfo.FilesMRU(2) = RegiInfo.FilesMRU(1)
RegiInfo.FilesMRU(1) = RegiInfo.FilesMRU(0)
RegiInfo.FilesMRU(0) = KSFile.FileName
End Sub
Public Sub GOKSFViewer()
End Sub
Public Sub P1P2Equal(p1top2 As Boolean)
Dim TempNum As Long
Select Case p1top2
Case True
    For TempNum = 0 To StepCount - 1
        Step(TempNum) = Mid(Step(TempNum), 1, 5) & Mid(Step(TempNum), 1, 5)
    Next
Case False
    For TempNum = 0 To StepCount - 1
        Step(TempNum) = Mid(Step(TempNum), 6, 5) & Mid(Step(TempNum), 6, 5)
    Next
End Select
Redraw
End Sub

