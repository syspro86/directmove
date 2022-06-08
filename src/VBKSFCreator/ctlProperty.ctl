VERSION 5.00
Begin VB.UserControl ctlProperty 
   ClientHeight    =   570
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   9990
   LockControls    =   -1  'True
   ScaleHeight     =   570
   ScaleWidth      =   9990
   Begin VB.TextBox txtTitle 
      Height          =   270
      Left            =   960
      TabIndex        =   12
      Top             =   0
      Width           =   2415
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
      Left            =   4320
      TabIndex        =   11
      Text            =   "120"
      Top             =   0
      Width           =   735
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
      Left            =   5160
      TabIndex        =   10
      Top             =   0
      Width           =   735
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
      Left            =   6000
      TabIndex        =   9
      Top             =   0
      Width           =   735
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
      Left            =   960
      TabIndex        =   8
      Text            =   "0"
      Top             =   300
      Width           =   735
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
      Left            =   1800
      TabIndex        =   7
      Top             =   300
      Width           =   735
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
      Left            =   2640
      TabIndex        =   6
      Top             =   300
      Width           =   735
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
      Left            =   4320
      TabIndex        =   5
      Top             =   300
      Width           =   735
   End
   Begin VB.TextBox txtBunki2 
      Height          =   270
      Left            =   5160
      TabIndex        =   4
      Top             =   300
      Width           =   735
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
      Left            =   7800
      TabIndex        =   3
      Text            =   "CboDiff"
      Top             =   0
      Width           =   1095
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
      Left            =   7800
      TabIndex        =   2
      Text            =   "CboTick"
      Top             =   300
      Width           =   1095
   End
   Begin VB.CommandButton CmdAccept 
      Caption         =   "적용"
      Height          =   255
      Left            =   9000
      TabIndex        =   1
      Top             =   0
      Width           =   975
   End
   Begin VB.CommandButton CmdReturn 
      Caption         =   "원래대로"
      Height          =   255
      Left            =   9000
      TabIndex        =   0
      Top             =   300
      Width           =   975
   End
   Begin VB.Label lblTitle 
      Alignment       =   2  '가운데 맞춤
      AutoSize        =   -1  'True
      Caption         =   "제목"
      Height          =   180
      Left            =   0
      TabIndex        =   18
      Top             =   45
      Width           =   960
   End
   Begin VB.Label lblBPM 
      Alignment       =   2  '가운데 맞춤
      AutoSize        =   -1  'True
      Caption         =   "BPM"
      Height          =   180
      Left            =   3360
      TabIndex        =   17
      Top             =   45
      Width           =   960
   End
   Begin VB.Label lblStart 
      Alignment       =   2  '가운데 맞춤
      AutoSize        =   -1  'True
      Caption         =   "스타트"
      Height          =   180
      Left            =   0
      TabIndex        =   16
      Top             =   345
      Width           =   960
   End
   Begin VB.Label lblBunki 
      Alignment       =   2  '가운데 맞춤
      AutoSize        =   -1  'True
      Caption         =   "분기"
      Height          =   180
      Left            =   3360
      TabIndex        =   15
      Top             =   345
      Width           =   960
   End
   Begin VB.Label lblDiff 
      Alignment       =   2  '가운데 맞춤
      AutoSize        =   -1  'True
      Caption         =   "난이도"
      Height          =   180
      Left            =   6840
      TabIndex        =   14
      Top             =   45
      Width           =   960
   End
   Begin VB.Label lblTick 
      Alignment       =   2  '가운데 맞춤
      AutoSize        =   -1  'True
      Caption         =   "틱카운트"
      Height          =   180
      Left            =   6840
      TabIndex        =   13
      Top             =   345
      Width           =   960
   End
End
Attribute VB_Name = "ctlProperty"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
Dim TickTick As Integer
'경고! 주석으로 되어 있는 다음 줄은 제거하거나 수정하지 마십시오!
'MappingInfo=txtTitle,txtTitle,-1,Text
Public Property Get Title() As String
Attribute Title.VB_Description = "컨트롤에 포함된 텍스트를 반환하거나 설정합니다."
    Title = txtTitle.Text
End Property
Public Property Let Title(ByVal New_Title As String)
    txtTitle.Text() = New_Title
    PropertyChanged "Title"
End Property
'경고! 주석으로 되어 있는 다음 줄은 제거하거나 수정하지 마십시오!
'MappingInfo=txtStart,txtStart,-1,Text
Public Property Get Start() As String
Attribute Start.VB_Description = "컨트롤에 포함된 텍스트를 반환하거나 설정합니다."
    Start = txtStart.Text
End Property
Public Property Let Start(ByVal New_Start As String)
    txtStart.Text() = New_Start
    PropertyChanged "Start"
End Property
'경고! 주석으로 되어 있는 다음 줄은 제거하거나 수정하지 마십시오!
'MappingInfo=txtStart2,txtStart2,-1,Text
Public Property Get Start2() As String
Attribute Start2.VB_Description = "컨트롤에 포함된 텍스트를 반환하거나 설정합니다."
    Start2 = txtStart2.Text
End Property
Public Property Let Start2(ByVal New_Start2 As String)
    txtStart2.Text() = New_Start2
    PropertyChanged "Start2"
End Property
'경고! 주석으로 되어 있는 다음 줄은 제거하거나 수정하지 마십시오!
'MappingInfo=txtStart3,txtStart3,-1,Text
Public Property Get Start3() As String
Attribute Start3.VB_Description = "컨트롤에 포함된 텍스트를 반환하거나 설정합니다."
    Start3 = txtStart3.Text
End Property
Public Property Let Start3(ByVal New_Start3 As String)
    txtStart3.Text() = New_Start3
    PropertyChanged "Start3"
End Property
'경고! 주석으로 되어 있는 다음 줄은 제거하거나 수정하지 마십시오!
'MappingInfo=txtBPM,txtBPM,-1,Text
Public Property Get BPM() As String
Attribute BPM.VB_Description = "컨트롤에 포함된 텍스트를 반환하거나 설정합니다."
    BPM = txtBPM.Text
End Property
Public Property Let BPM(ByVal New_BPM As String)
    txtBPM.Text() = New_BPM
    PropertyChanged "BPM"
End Property
'경고! 주석으로 되어 있는 다음 줄은 제거하거나 수정하지 마십시오!
'MappingInfo=txtBPM2,txtBPM2,-1,Text
Public Property Get BPM2() As String
Attribute BPM2.VB_Description = "컨트롤에 포함된 텍스트를 반환하거나 설정합니다."
    BPM2 = txtBPM2.Text
End Property
Public Property Let BPM2(ByVal New_BPM2 As String)
    txtBPM2.Text() = New_BPM2
    PropertyChanged "BPM2"
End Property
'경고! 주석으로 되어 있는 다음 줄은 제거하거나 수정하지 마십시오!
'MappingInfo=txtBPM3,txtBPM3,-1,Text
Public Property Get BPM3() As String
Attribute BPM3.VB_Description = "컨트롤에 포함된 텍스트를 반환하거나 설정합니다."
    BPM3 = txtBPM3.Text
End Property
Public Property Let BPM3(ByVal New_BPM3 As String)
    txtBPM3.Text() = New_BPM3
    PropertyChanged "BPM3"
End Property
'경고! 주석으로 되어 있는 다음 줄은 제거하거나 수정하지 마십시오!
'MappingInfo=txtBunki,txtBunki,-1,Text
Public Property Get Bunki() As String
Attribute Bunki.VB_Description = "컨트롤에 포함된 텍스트를 반환하거나 설정합니다."
    Bunki = txtBunki.Text
End Property
Public Property Let Bunki(ByVal New_Bunki As String)
    txtBunki.Text() = New_Bunki
    PropertyChanged "Bunki"
End Property
'경고! 주석으로 되어 있는 다음 줄은 제거하거나 수정하지 마십시오!
'MappingInfo=txtBunki2,txtBunki2,-1,Text
Public Property Get Bunki2() As String
Attribute Bunki2.VB_Description = "컨트롤에 포함된 텍스트를 반환하거나 설정합니다."
    Bunki2 = txtBunki2.Text
End Property
Public Property Let Bunki2(ByVal New_Bunki2 As String)
    txtBunki2.Text() = New_Bunki2
    PropertyChanged "Bunki2"
End Property
'경고! 주석으로 되어 있는 다음 줄은 제거하거나 수정하지 마십시오!
'MappingInfo=CboDiff,CboDiff,-1,Text
Public Property Get Diff() As String
Attribute Diff.VB_Description = "컨트롤에 포함된 텍스트를 반환하거나 설정합니다."
    Diff = CboDiff.Text
End Property
Public Property Let Diff(ByVal New_Diff As String)
    CboDiff.Text() = New_Diff
    PropertyChanged "Diff"
End Property
'경고! 주석으로 되어 있는 다음 줄은 제거하거나 수정하지 마십시오!
'MappingInfo=CboTick,CboTick,-1,Text
Public Property Get Tickcount() As String
    Tickcount = CboTick.Text
End Property
Public Property Let Tickcount(ByVal New_Tickcount As String)
    CboTick.Text() = New_Tickcount
    PropertyChanged "Tickcount"
End Property
'경고! 주석으로 되어 있는 다음 줄은 제거하거나 수정하지 마십시오!
'MemberInfo=14
Public Function Accept() As Variant
If Not Form1.ActiveForm Is Nothing Then Form1.ActiveForm.ChangeProperty False, True
End Function
Private Sub CboDiff_LostFocus()
If ProChanging = False And RegInfo.AutoProperty = 1 Then Accept
End Sub
Private Sub CboTick_LostFocus()
If ProChanging = False And RegInfo.AutoProperty = 1 And CInt(CboTick.Text) <> TickTick Then
TickTick = CboTick.ListIndex + 1
Accept
End If
End Sub
Private Sub CmdAccept_Click()
    Accept
End Sub
'경고! 주석으로 되어 있는 다음 줄은 제거하거나 수정하지 마십시오!
'MemberInfo=14
Public Function Returns() As Variant
If Not Form1.ActiveForm Is Nothing Then
    Form1.ActiveForm.ChangeProperty True
Else
With UserControl
.txtBPM = "0"
.txtBPM2 = ""
.txtBPM3 = ""
.txtBunki = ""
.txtBunki2 = ""
.txtStart = "0"
.txtStart2 = ""
.txtStart3 = ""
.txtTitle = ""
.CboDiff = "없음"
.CboTick = "4"
TickTick = 4
End With
End If
End Function
Private Sub CmdReturn_Click()
    Returns
End Sub
Private Sub txtBPM_Change()
If ProChanging = False And RegInfo.AutoProperty = 1 Then Accept
End Sub
Private Sub txtBPM2_Change()
If ProChanging = False And RegInfo.AutoProperty = 1 Then Accept
End Sub
Private Sub txtBPM3_Change()
If ProChanging = False And RegInfo.AutoProperty = 1 Then Accept
End Sub
Private Sub txtBunki_Change()
If ProChanging = False And RegInfo.AutoProperty = 1 Then Accept
End Sub
Private Sub txtBunki2_Change()
If ProChanging = False And RegInfo.AutoProperty = 1 Then Accept
End Sub
Private Sub txtStart_Change()
If ProChanging = False And RegInfo.AutoProperty = 1 Then Accept
End Sub
Private Sub txtStart2_Change()
If ProChanging = False And RegInfo.AutoProperty = 1 Then Accept
End Sub
Private Sub txtStart3_Change()
If ProChanging = False And RegInfo.AutoProperty = 1 Then Accept
End Sub
Private Sub txtTitle_Change()
If ProChanging = False And RegInfo.AutoProperty = 1 Then Accept
End Sub
Private Sub UserControl_Initialize()
Dim A As Integer
For A = 1 To 8
    CboTick.AddItem A
Next
CboDiff.AddItem "없음"
For A = 3 To 13
    CboDiff.AddItem A
Next
If CboDiff.Text = "-1" Then
    CboDiff.Text = "없음"
Else
End If
End Sub
'저장소에서 속성값을 로드합니다.
Private Sub UserControl_ReadProperties(PropBag As PropertyBag)
    txtTitle.Text = PropBag.ReadProperty("Title", "")
    txtStart.Text = PropBag.ReadProperty("Start", "")
    txtStart2.Text = PropBag.ReadProperty("Start2", "")
    txtStart3.Text = PropBag.ReadProperty("Start3", "")
    txtBPM.Text = PropBag.ReadProperty("BPM", "")
    txtBPM2.Text = PropBag.ReadProperty("BPM2", "")
    txtBPM3.Text = PropBag.ReadProperty("BPM3", "")
    txtBunki.Text = PropBag.ReadProperty("Bunki", "")
    txtBunki2.Text = PropBag.ReadProperty("Bunki2", "")
    CboDiff.Text = PropBag.ReadProperty("Diff", "CboDiff")
    CboTick.Text = PropBag.ReadProperty("Tickcount", "CboTick")
End Sub
'속성값을 저장소에 기록합니다.
Private Sub UserControl_WriteProperties(PropBag As PropertyBag)
    Call PropBag.WriteProperty("Title", txtTitle.Text, "")
    Call PropBag.WriteProperty("Start", txtStart.Text, "")
    Call PropBag.WriteProperty("Start2", txtStart2.Text, "")
    Call PropBag.WriteProperty("Start3", txtStart3.Text, "")
    Call PropBag.WriteProperty("BPM", txtBPM.Text, "")
    Call PropBag.WriteProperty("BPM2", txtBPM2.Text, "")
    Call PropBag.WriteProperty("BPM3", txtBPM3.Text, "")
    Call PropBag.WriteProperty("Bunki", txtBunki.Text, "")
    Call PropBag.WriteProperty("Bunki2", txtBunki2.Text, "")
    Call PropBag.WriteProperty("Diff", CboDiff.Text, "CboDiff")
    Call PropBag.WriteProperty("Tickcount", CboTick.ListIndex + 1, "CboTick")
End Sub
