VERSION 5.00
Begin VB.Form frmOption 
   Caption         =   "옵션"
   ClientHeight    =   2385
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   3645
   ControlBox      =   0   'False
   Icon            =   "frmOption.frx":0000
   LinkTopic       =   "Form3"
   ScaleHeight     =   2385
   ScaleWidth      =   3645
   StartUpPosition =   1  '소유자 가운데
   Begin VB.CheckBox ChkResize 
      Caption         =   "창크기 변경됬을때 4마디씩 표시"
      Height          =   180
      Left            =   120
      TabIndex        =   5
      Top             =   1400
      Width           =   3315
   End
   Begin VB.CheckBox ChkLongNote 
      Caption         =   "롱노트 사용"
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   960
      Width           =   3375
   End
   Begin VB.CheckBox ChkPropertyAuto 
      Caption         =   "KSF파일 바뀌면 자동으로 정보 변경(자동저장)"
      Height          =   375
      Left            =   120
      TabIndex        =   1
      Top             =   480
      Width           =   3255
   End
   Begin VB.CommandButton CmdOK 
      Caption         =   "확인"
      Default         =   -1  'True
      Height          =   375
      Left            =   1440
      TabIndex        =   3
      Top             =   1890
      Width           =   975
   End
   Begin VB.CheckBox ChkFrmSave 
      Caption         =   "폼 정보 저장"
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   1335
   End
   Begin VB.CommandButton CmdCancel 
      Caption         =   "취소"
      Height          =   375
      Left            =   2550
      TabIndex        =   4
      Top             =   1890
      Width           =   975
   End
End
Attribute VB_Name = "frmOption"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Sub ChkFrmSave_KeyPress(KeyAscii As Integer)
If KeyAscii = vbKeyEscape Then Unload Me
End Sub
Private Sub ChkLongNote_KeyPress(KeyAscii As Integer)
If KeyAscii = vbKeyEscape Then Unload Me
End Sub
Private Sub ChkPropertyAuto_KeyPress(KeyAscii As Integer)
If KeyAscii = vbKeyEscape Then Unload Me
End Sub
Private Sub chkResize_KeyPress(KeyAscii As Integer)
If KeyAscii = vbKeyEscape Then Unload Me
End Sub
Private Sub CmdOK_KeyPress(KeyAscii As Integer)
If KeyAscii = vbKeyEscape Then Unload Me
End Sub
Private Sub CmdCancel_KeyPress(KeyAscii As Integer)
If KeyAscii = vbKeyEscape Then Unload Me
End Sub
Private Sub CmdCancel_Click()
Unload Me
End Sub
Private Sub CmdCancel_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
ChkFrmSave.SetFocus
End Sub
Private Sub CmdOK_Click()
RegInfo.FrmSave = ChkFrmSave.Value
RegInfo.AutoProperty = ChkPropertyAuto.Value
RegInfo.UseLongNote = ChkLongNote.Value
RegInfo.ResizeBetter = ChkResize.Value
Unload Me
End Sub
Private Sub CmdOK_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
ChkFrmSave.SetFocus
End Sub
Private Sub Form_Load()
ChkFrmSave.Value = RegInfo.FrmSave
ChkPropertyAuto.Value = RegInfo.AutoProperty
ChkLongNote.Value = RegInfo.UseLongNote
ChkResize.Value = RegInfo.ResizeBetter
End Sub
