VERSION 5.00
Begin VB.Form frmKSF2PIC 
   BorderStyle     =   4  '고정 도구 창
   Caption         =   "KSF2PIC 옵션"
   ClientHeight    =   1575
   ClientLeft      =   45
   ClientTop       =   285
   ClientWidth     =   3375
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   105
   ScaleMode       =   3  '픽셀
   ScaleWidth      =   225
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows 기본값
   Begin VB.PictureBox A 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  '없음
      BeginProperty Font 
         Name            =   "돋움"
         Size            =   9.75
         Charset         =   129
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   1710
      Left            =   120
      ScaleHeight     =   114
      ScaleMode       =   3  '픽셀
      ScaleWidth      =   147
      TabIndex        =   7
      Top             =   2520
      Width           =   2205
   End
   Begin VB.CommandButton Command1 
      Caption         =   "취소"
      Height          =   255
      Left            =   2280
      TabIndex        =   6
      Top             =   1200
      Width           =   975
   End
   Begin VB.CommandButton cmdPrint 
      Caption         =   "출력"
      Height          =   255
      Left            =   1320
      TabIndex        =   5
      Top             =   1200
      Width           =   975
   End
   Begin VB.ComboBox cboType 
      Height          =   300
      Left            =   960
      Style           =   2  '드롭다운 목록
      TabIndex        =   2
      Top             =   480
      Width           =   2295
   End
   Begin VB.CheckBox chkColor 
      Caption         =   "컬러"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   840
      Width           =   3015
   End
   Begin VB.ComboBox cboSpeed 
      Height          =   300
      Left            =   960
      Style           =   2  '드롭다운 목록
      TabIndex        =   0
      Top             =   120
      Width           =   2295
   End
   Begin VB.Label Label2 
      Alignment       =   2  '가운데 맞춤
      Caption         =   "포맷"
      Height          =   255
      Left            =   120
      TabIndex        =   4
      Top             =   480
      Width           =   855
   End
   Begin VB.Label Label1 
      Alignment       =   2  '가운데 맞춤
      Caption         =   "배속"
      Height          =   255
      Left            =   120
      TabIndex        =   3
      Top             =   120
      Width           =   855
   End
End
Attribute VB_Name = "frmKSF2PIC"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdPrint_Click()
If Not Form1.ActiveForm Is Nothing Then Form1.ActiveForm.tmpKSF2BMP cboSpeed.Text, cboType.Text, chkColor.Value
Unload Me
End Sub
Private Sub Command1_Click()
Unload Me
End Sub
Private Sub Form_Load()
cboSpeed.AddItem "1"
cboSpeed.AddItem "1.5"
cboSpeed.AddItem "2"
cboSpeed.AddItem "3"
cboSpeed.AddItem "4"
cboSpeed.AddItem "6"
cboSpeed.AddItem "8"
cboType.AddItem "BMP"
cboType.AddItem "JPG"
cboSpeed.ListIndex = 0
cboType.ListIndex = 0
End Sub

