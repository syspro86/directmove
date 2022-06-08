VERSION 5.00
Begin VB.Form frmAbout 
   BorderStyle     =   3  '크기 고정 대화 상자
   Caption         =   "정보"
   ClientHeight    =   2175
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   3870
   ControlBox      =   0   'False
   Icon            =   "frmAbout.frx":0000
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2175
   ScaleWidth      =   3870
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  '소유자 가운데
   Begin VB.TextBox Text1 
      Height          =   855
      Left            =   120
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      ScrollBars      =   2  '수직
      TabIndex        =   4
      Text            =   "frmAbout.frx":000C
      Top             =   840
      Width           =   3615
   End
   Begin VB.CommandButton CmdOK 
      Caption         =   "확인"
      Default         =   -1  'True
      Height          =   255
      Left            =   2760
      TabIndex        =   3
      Top             =   1800
      Width           =   975
   End
   Begin VB.PictureBox Picture1 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  '없음
      Height          =   480
      Left            =   120
      Picture         =   "frmAbout.frx":0060
      ScaleHeight     =   480
      ScaleWidth      =   480
      TabIndex        =   0
      Top             =   120
      Width           =   480
   End
   Begin VB.Label Label2 
      Alignment       =   1  '오른쪽 맞춤
      AutoSize        =   -1  'True
      Caption         =   "Version x.xx"
      BeginProperty Font 
         Name            =   "굴림"
         Size            =   9.75
         Charset         =   129
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   720
      TabIndex        =   2
      Top             =   600
      Width           =   2895
   End
   Begin VB.Label Label1 
      Alignment       =   2  '가운데 맞춤
      Caption         =   "KSFCreator"
      BeginProperty Font 
         Name            =   "Arial Black"
         Size            =   14.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   405
      Left            =   690
      TabIndex        =   1
      Top             =   120
      Width           =   3075
   End
End
Attribute VB_Name = "frmAbout"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Sub CmdOK_Click()
Form1.Enabled = True
Unload Me
End Sub
Private Sub Form_Load()
Form1.Enabled = False
Label2.Caption = App.Major & "." & App.Minor & IIf(App.Revision = 0, "", App.Revision) & " 버전 입니다."
End Sub
