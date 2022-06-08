VERSION 5.00
Begin VB.Form Form2 
   BorderStyle     =   1  '단일 고정
   Caption         =   "등록정보"
   ClientHeight    =   2430
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   4770
   ControlBox      =   0   'False
   Icon            =   "frmProperty.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2430
   ScaleWidth      =   4770
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  '소유자 가운데
   Begin VB.CommandButton CmdCancel 
      Caption         =   "취소"
      Height          =   375
      Left            =   3600
      TabIndex        =   18
      Top             =   1920
      Width           =   975
   End
   Begin VB.CommandButton CmdOK 
      Caption         =   "확인"
      Default         =   -1  'True
      Height          =   375
      Left            =   2520
      TabIndex        =   17
      Top             =   1920
      Width           =   975
   End
   Begin VB.ComboBox CboTick 
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1042
         SubFormatType   =   1
      EndProperty
      Height          =   300
      Left            =   1080
      Style           =   2  '드롭다운 목록
      TabIndex        =   10
      Top             =   1920
      Width           =   1095
   End
   Begin VB.ComboBox CboDiff 
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1042
         SubFormatType   =   1
      EndProperty
      Height          =   300
      Left            =   1080
      Style           =   2  '드롭다운 목록
      TabIndex        =   9
      Top             =   1560
      Width           =   1095
   End
   Begin VB.TextBox txtBunki2 
      Height          =   270
      Left            =   2280
      TabIndex        =   8
      Top             =   1200
      Width           =   1095
   End
   Begin VB.TextBox txtBunki 
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1042
         SubFormatType   =   1
      EndProperty
      Height          =   270
      Left            =   1080
      TabIndex        =   7
      Top             =   1200
      Width           =   1095
   End
   Begin VB.TextBox txtStart3 
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1042
         SubFormatType   =   1
      EndProperty
      Height          =   270
      Left            =   3480
      TabIndex        =   6
      Top             =   840
      Width           =   1095
   End
   Begin VB.TextBox txtStart2 
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1042
         SubFormatType   =   1
      EndProperty
      Height          =   270
      Left            =   2280
      TabIndex        =   5
      Top             =   840
      Width           =   1095
   End
   Begin VB.TextBox txtStart 
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1042
         SubFormatType   =   1
      EndProperty
      Height          =   270
      Left            =   1080
      TabIndex        =   4
      Top             =   840
      Width           =   1095
   End
   Begin VB.TextBox txtBPM3 
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1042
         SubFormatType   =   1
      EndProperty
      Height          =   270
      Left            =   3480
      TabIndex        =   3
      Top             =   480
      Width           =   1095
   End
   Begin VB.TextBox txtBPM2 
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1042
         SubFormatType   =   1
      EndProperty
      Height          =   270
      Left            =   2280
      TabIndex        =   2
      Top             =   480
      Width           =   1095
   End
   Begin VB.TextBox txtBPM 
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1042
         SubFormatType   =   1
      EndProperty
      Height          =   270
      Left            =   1080
      TabIndex        =   1
      Top             =   480
      Width           =   1095
   End
   Begin VB.TextBox txtTitle 
      Height          =   270
      Left            =   1080
      TabIndex        =   0
      Top             =   120
      Width           =   3495
   End
   Begin VB.Label lblTick 
      Alignment       =   2  '가운데 맞춤
      AutoSize        =   -1  'True
      Caption         =   "틱카운트"
      Height          =   180
      Left            =   120
      TabIndex        =   16
      Top             =   1995
      Width           =   840
   End
   Begin VB.Label lblDiff 
      Alignment       =   2  '가운데 맞춤
      AutoSize        =   -1  'True
      Caption         =   "난이도"
      Height          =   180
      Left            =   120
      TabIndex        =   15
      Top             =   1560
      Width           =   840
   End
   Begin VB.Label lblBunki 
      Alignment       =   2  '가운데 맞춤
      AutoSize        =   -1  'True
      Caption         =   "분기"
      Height          =   180
      Left            =   120
      TabIndex        =   14
      Top             =   1200
      Width           =   840
   End
   Begin VB.Label lblStart 
      Alignment       =   2  '가운데 맞춤
      AutoSize        =   -1  'True
      Caption         =   "스타트"
      Height          =   180
      Left            =   120
      TabIndex        =   13
      Top             =   840
      Width           =   840
   End
   Begin VB.Label lblBPM 
      Alignment       =   2  '가운데 맞춤
      AutoSize        =   -1  'True
      Caption         =   "BPM"
      Height          =   180
      Left            =   120
      TabIndex        =   12
      Top             =   480
      Width           =   840
   End
   Begin VB.Label lblTitle 
      Alignment       =   2  '가운데 맞춤
      AutoSize        =   -1  'True
      Caption         =   "제목"
      Height          =   180
      Left            =   120
      TabIndex        =   11
      Top             =   120
      Width           =   840
   End
End
Attribute VB_Name = "Form2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Sub CmdCancel_Click()
Form1.ActiveForm.ChangeProperty False, False
End Sub
Private Sub CmdOK_Click()
Form1.ActiveForm.ChangeProperty False, True
End Sub
Private Sub Form_Unload(Cancel As Integer)
Form1.ActiveForm.ChangeProperty False, False
End Sub
