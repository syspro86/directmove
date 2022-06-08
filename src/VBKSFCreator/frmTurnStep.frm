VERSION 5.00
Begin VB.Form frmTurnStep 
   BorderStyle     =   4  '고정 도구 창
   Caption         =   "스텝회전"
   ClientHeight    =   1110
   ClientLeft      =   45
   ClientTop       =   315
   ClientWidth     =   2880
   Icon            =   "frmTurnStep.frx":0000
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1110
   ScaleWidth      =   2880
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  '소유자 가운데
   Begin VB.CheckBox Check 
      Caption         =   "2P 회전"
      Height          =   180
      Index           =   3
      Left            =   1440
      TabIndex        =   5
      Top             =   480
      Value           =   1  '확인
      Width           =   1095
   End
   Begin VB.CheckBox Check 
      Caption         =   "1P 회전"
      Height          =   180
      Index           =   2
      Left            =   240
      TabIndex        =   4
      Top             =   480
      Value           =   1  '확인
      Width           =   1095
   End
   Begin VB.CheckBox Check 
      Caption         =   "상하회전"
      Height          =   180
      Index           =   1
      Left            =   1440
      TabIndex        =   1
      Top             =   120
      Width           =   1095
   End
   Begin VB.CheckBox Check 
      Caption         =   "좌우회전"
      Height          =   180
      Index           =   0
      Left            =   240
      TabIndex        =   0
      Top             =   120
      Width           =   1095
   End
   Begin VB.CommandButton CmdOK 
      Caption         =   "확인"
      Default         =   -1  'True
      Height          =   255
      Left            =   840
      TabIndex        =   2
      Top             =   720
      Width           =   855
   End
   Begin VB.CommandButton CmdCancel 
      Caption         =   "취소"
      Height          =   255
      Left            =   1800
      TabIndex        =   3
      Top             =   720
      Width           =   855
   End
End
Attribute VB_Name = "frmTurnStep"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Sub CmdCancel_Click()
Unload Me
End Sub
Private Sub CmdOK_Click()
Dim A As Integer, B As Integer
A = Check(0).Value + Check(1).Value * 2
B = Check(2).Value + Check(3).Value * 2
If B = 0 Then
MsgBox "1P , 2P 둘다 회전하지 않습니다."
Exit Sub
End If
If Not Form1.ActiveForm Is Nothing Then Form1.ActiveForm.TurnStep A, B
Unload Me
End Sub
Private Sub Form_KeyPress(KeyAscii As Integer)
If KeyAscii = vbKeyEscape Then Unload Me
End Sub
Private Sub Option1_KeyPress(Index As Integer, KeyAscii As Integer)
If KeyAscii = vbKeyEscape Then Unload Me
End Sub
Private Sub Check_KeyPress(Index As Integer, KeyAscii As Integer)
If KeyAscii = vbKeyEscape Then Unload Me
End Sub
Private Sub CmdOK_KeyPress(KeyAscii As Integer)
If KeyAscii = vbKeyEscape Then Unload Me
End Sub
Private Sub CmdCancel_KeyPress(KeyAscii As Integer)
If KeyAscii = vbKeyEscape Then Unload Me
End Sub


