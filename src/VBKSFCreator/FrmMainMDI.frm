VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.MDIForm Form1 
   BackColor       =   &H8000000C&
   Caption         =   "KSFCreator x.xx"
   ClientHeight    =   7035
   ClientLeft      =   165
   ClientTop       =   855
   ClientWidth     =   10035
   Icon            =   "FrmMainMDI.frx":0000
   LinkTopic       =   "MDIForm1"
   OLEDropMode     =   1  '����
   StartUpPosition =   3  'Windows �⺻��
   Begin MSComctlLib.Toolbar tbProperty 
      Align           =   1  '�� ����
      Height          =   615
      Left            =   0
      TabIndex        =   3
      Top             =   360
      Width           =   10035
      _ExtentX        =   17701
      _ExtentY        =   1085
      ButtonWidth     =   609
      ButtonHeight    =   926
      Appearance      =   1
      _Version        =   393216
      Begin KSFCreator.ctlProperty ctlPro 
         Height          =   615
         Left            =   0
         TabIndex        =   4
         Top             =   0
         Width           =   10095
         _ExtentX        =   17806
         _ExtentY        =   1085
         Start           =   "0"
         BPM             =   "120"
         Tickcount       =   0
      End
   End
   Begin MSComctlLib.Toolbar tbToolBar 
      Align           =   1  '�� ����
      Height          =   360
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   10035
      _ExtentX        =   17701
      _ExtentY        =   635
      ButtonWidth     =   609
      ButtonHeight    =   582
      Appearance      =   1
      Style           =   1
      ImageList       =   "imlToolbarIcons"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   13
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "�� ����"
            Object.ToolTipText     =   "�� ����"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "����"
            Object.ToolTipText     =   "����"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "����"
            Object.ToolTipText     =   "����"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "�߶󳻱�"
            Object.ToolTipText     =   "�߶󳻱�"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "����"
            Object.ToolTipText     =   "����"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "�ٿ��ֱ�"
            Object.ToolTipText     =   "�ٿ��ֱ�"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "���"
            Object.ToolTipText     =   "���"
            ImageIndex      =   7
            Style           =   5
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   4
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Key             =   "���1"
                  Text            =   "x1"
               EndProperty
               BeginProperty ButtonMenu2 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Key             =   "���2"
                  Text            =   "x2"
               EndProperty
               BeginProperty ButtonMenu3 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Key             =   "���4"
                  Text            =   "x4"
               EndProperty
               BeginProperty ButtonMenu4 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Key             =   "���8"
                  Text            =   "x8"
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "�̱۴���"
            Object.ToolTipText     =   "�̱�/����"
            ImageIndex      =   11
            Style           =   5
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   2
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Key             =   "�̱�"
                  Text            =   "Single"
               EndProperty
               BeginProperty ButtonMenu2 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Key             =   "����"
                  Text            =   "Double"
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button11 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "�߰�"
            Object.ToolTipText     =   "���� �߰�"
            ImageIndex      =   13
         EndProperty
         BeginProperty Button12 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "����"
            Object.ToolTipText     =   "���� ����"
            ImageIndex      =   14
         EndProperty
         BeginProperty Button13 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "�ǽð�"
            Object.ToolTipText     =   "�ǽð� ä�� �Է�"
            ImageIndex      =   15
         EndProperty
      EndProperty
      Begin VB.FileListBox File1 
         Height          =   270
         Left            =   8400
         Pattern         =   "KSFViewer.exe"
         TabIndex        =   2
         Top             =   0
         Visible         =   0   'False
         Width           =   1575
      End
   End
   Begin MSComDlg.CommonDialog DlgBox 
      Left            =   8640
      Top             =   1080
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin MSComctlLib.StatusBar StatusBar 
      Align           =   2  '�Ʒ� ����
      Height          =   375
      Left            =   0
      TabIndex        =   1
      Top             =   6660
      Width           =   10035
      _ExtentX        =   17701
      _ExtentY        =   661
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   4
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   9472
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
         BeginProperty Panel3 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
         BeginProperty Panel4 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList imlToolbarIcons 
      Left            =   8040
      Top             =   1080
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   15
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMainMDI.frx":030A
            Key             =   "New"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMainMDI.frx":041C
            Key             =   "Open"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMainMDI.frx":052E
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMainMDI.frx":0640
            Key             =   "Cut"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMainMDI.frx":0752
            Key             =   "Copy"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMainMDI.frx":0864
            Key             =   "Paste"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMainMDI.frx":0976
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMainMDI.frx":0C90
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMainMDI.frx":0FAA
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMainMDI.frx":12C4
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMainMDI.frx":15DE
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMainMDI.frx":18F8
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMainMDI.frx":1C12
            Key             =   ""
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMainMDI.frx":2064
            Key             =   ""
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMainMDI.frx":24B6
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Menu mnuFile 
      Caption         =   "����(&F)"
      Begin VB.Menu mnuFileNew 
         Caption         =   "�� ����(&N)"
         Shortcut        =   ^N
      End
      Begin VB.Menu mnuFileOpen 
         Caption         =   "�ҷ�����(&O)..."
         Shortcut        =   ^O
      End
      Begin VB.Menu mnuFileSave 
         Caption         =   "�����ϱ�(&S)"
         Shortcut        =   ^S
      End
      Begin VB.Menu mnuFileSaveAs 
         Caption         =   "�ٸ��̸����� ����(&A)"
      End
      Begin VB.Menu mnuFileClose 
         Caption         =   "�ݱ�(&W)"
         Shortcut        =   ^W
      End
      Begin VB.Menu line0 
         Caption         =   "-"
      End
      Begin VB.Menu mnuFileExit 
         Caption         =   "����(&X)"
      End
   End
   Begin VB.Menu mnuEdit 
      Caption         =   "����(&E)"
      Begin VB.Menu mnuEditCut 
         Caption         =   "�߶󳻱�(&T)"
         Shortcut        =   ^X
      End
      Begin VB.Menu mnuEditCopy 
         Caption         =   "����(&C)"
         Shortcut        =   ^C
      End
      Begin VB.Menu mnuEditPaste 
         Caption         =   "�ٿ��ֱ�(&P)"
         Index           =   0
         Shortcut        =   ^V
      End
      Begin VB.Menu mnuEditPaste 
         Caption         =   "���ܹٲ�(&A)"
         Index           =   1
         Shortcut        =   ^B
      End
      Begin VB.Menu line9 
         Caption         =   "-"
      End
      Begin VB.Menu mnuEditAdd 
         Caption         =   "�߰�(&I)"
      End
      Begin VB.Menu mnuEditDelete 
         Caption         =   "����(&D)"
      End
      Begin VB.Menu mnuEditEmptyStep 
         Caption         =   "����"
         Begin VB.Menu mnuEditEmptySteps 
            Caption         =   "1P Steps"
            Index           =   0
         End
         Begin VB.Menu mnuEditEmptySteps 
            Caption         =   "2P Steps"
            Index           =   1
         End
         Begin VB.Menu mnuEditEmptySteps 
            Caption         =   "1, 2P Steps"
            Index           =   2
         End
      End
      Begin VB.Menu mnuEditRandom 
         Caption         =   "���� ����(&R)"
      End
      Begin VB.Menu mnuEditTurn 
         Caption         =   "���� ȸ��(&U)"
         Shortcut        =   ^T
      End
      Begin VB.Menu mnu1p2pequal 
         Caption         =   "1P 2P ����ä����"
         Begin VB.Menu mnu1p2pequalto 
            Caption         =   "1P -> 2P"
            Index           =   0
         End
         Begin VB.Menu mnu1p2pequalto 
            Caption         =   "1P <- 2P"
            Index           =   1
         End
      End
      Begin VB.Menu mnuToBig 
         Caption         =   "���̱�"
      End
      Begin VB.Menu mnuToSmall 
         Caption         =   "���̱�"
      End
      Begin VB.Menu line2 
         Caption         =   "-"
      End
      Begin VB.Menu mnuEditBunki 
         Caption         =   "�б�� �̾Ƴ���"
      End
      Begin VB.Menu mnuSelectAll 
         Caption         =   "��ü����"
         Shortcut        =   ^A
      End
   End
   Begin VB.Menu mnuView 
      Caption         =   "����(&V)"
      Begin VB.Menu mnuView1p2p 
         Caption         =   "�̱�(&S)"
         Index           =   0
         Shortcut        =   {F1}
      End
      Begin VB.Menu mnuView1p2p 
         Caption         =   "����(&D)"
         Index           =   1
         Shortcut        =   {F2}
      End
      Begin VB.Menu line3 
         Caption         =   "-"
      End
      Begin VB.Menu mnuViewX 
         Caption         =   "&1���"
         Index           =   0
         Shortcut        =   {F5}
      End
      Begin VB.Menu mnuViewX 
         Caption         =   "&2���"
         Index           =   1
         Shortcut        =   {F6}
      End
      Begin VB.Menu mnuViewX 
         Caption         =   "&4���"
         Index           =   2
         Shortcut        =   {F7}
      End
      Begin VB.Menu mnuViewX 
         Caption         =   "&8���"
         Index           =   3
         Shortcut        =   {F8}
      End
   End
   Begin VB.Menu mnuTools 
      Caption         =   "����(&T)"
      Begin VB.Menu mnuToolsSongFile 
         Caption         =   "�뷡 ���� ����"
      End
      Begin VB.Menu mnuToolsRealTime 
         Caption         =   "�ǽð� ä�� �Է�"
         Shortcut        =   ^R
      End
      Begin VB.Menu line4 
         Caption         =   "-"
      End
      Begin VB.Menu mnuKSF2BMP 
         Caption         =   "KSF2&PIC"
         Shortcut        =   ^P
      End
      Begin VB.Menu line5 
         Caption         =   "-"
      End
      Begin VB.Menu mnuKSFViewer 
         Caption         =   "KSFV&iewer"
         Shortcut        =   ^I
      End
      Begin VB.Menu line8 
         Caption         =   "-"
      End
      Begin VB.Menu mnuOption 
         Caption         =   "�ɼ�(&P)"
      End
   End
   Begin VB.Menu mnuWindow 
      Caption         =   "â(&W)"
      WindowList      =   -1  'True
      Begin VB.Menu mnuWindowNewWindow 
         Caption         =   "�� â(&N)"
      End
      Begin VB.Menu line6 
         Caption         =   "-"
      End
      Begin VB.Menu mnuWindowCascade 
         Caption         =   "��ܽ� �迭(&C)"
      End
      Begin VB.Menu mnuWindowTileHorizontal 
         Caption         =   "���� �ٵ��ǽ� �迭(&H)"
      End
      Begin VB.Menu mnuWindowTileVertical 
         Caption         =   "���� �ٵ��ǽ� �迭(&V)"
      End
      Begin VB.Menu mnuWindowArrangeIcons 
         Caption         =   "������ ����(&A)"
      End
   End
   Begin VB.Menu mnuHelp 
      Caption         =   "����(&H)"
      Begin VB.Menu mnuAbout 
         Caption         =   "KSFCreator ����(&A)"
      End
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim FormCount As Long
Private Sub MDIForm_DblClick()
Call mnuFileOpen_Click
End Sub
Private Sub MDIForm_Load()
On Error GoTo A
Dim FileNum As Integer, NextLine As String, LinesFromFile As Variant
File1.Path = App.Path
If File1.ListCount = 0 Then
    mnuKSFViewer.Visible = False
    line8.Visible = False
End If
Me.Caption = "KSFCreator " & App.Major & "." & App.Minor & IIf(App.Revision = 0, "", App.Revision)
RegInfo.FrmSave = GetSetting("Kiho", "KSFCreator", "FormInformationSave", 1)
RegInfo.AutoProperty = GetSetting("Kiho", "KSFCreator", "AutoProperty", 1)
RegInfo.UseLongNote = GetSetting("Kiho", "KSFCreator", "UseLongNote", 1)
RegInfo.ResizeBetter = GetSetting("Kiho", "KSFCreator", "ResizeBetter", 1)
DlgBox.InitDir = GetSetting("Kiho", "KSFCreator", "LastDir", App.Path)
If RegInfo.FrmSave = 1 Then
    Me.Left = GetSetting("Kiho", "KSFCreator", "Left", 0)
    Me.Width = GetSetting("Kiho", "KSFCreator", "Width", 10000)
    Me.Top = GetSetting("Kiho", "KSFCreator", "Top", 0)
    Me.Height = GetSetting("Kiho", "KSFCreator", "Height", 7000)
End If
If GetSetting("Kiho", "KSFCreator", "Maximized", 0) = 1 Then Me.WindowState = vbMaximized
If Len(Command$) <= 1 Then
    mnuFileNew_Click
Else
    mnuFileNew_Click
    FileNum = FreeFile
    Open Mid(Command$, 2, Len(Command$) - 2) For Input As FileNum
    Do Until EOF(FileNum)
    Line Input #FileNum, NextLine
    LinesFromFile = LinesFromFile + NextLine + vbCrLf
    Loop
    ActiveForm.ReadBox.Text = LinesFromFile
    Close FileNum
    ActiveForm.ReadKSF True, Mid(Command$, 2, Len(Command$) - 2)
End If
A:
DlgBox.Filter = "KSF File (*.ksf)|*.ksf"
End Sub
Private Sub MDIForm_OLEDragDrop(data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)
Dim A As Integer
Dim FileNum As Integer, NextLine As String, LinesFromFile As Variant
For A = 1 To data.Files.Count
    mnuFileNew_Click
    FileNum = FreeFile
    Open data.Files.Item(A) For Input As FileNum
    Do Until EOF(FileNum)
    Line Input #FileNum, NextLine
    LinesFromFile = LinesFromFile + NextLine + vbCrLf
    Loop
    ActiveForm.ReadBox.Text = LinesFromFile
    Close FileNum
    ActiveForm.ReadKSF True, data.Files.Item(A)
Next
End Sub
Private Sub MDIForm_Unload(Cancel As Integer)
SaveSetting "Kiho", "KSFCreator", "LastDir", RegInfo.LastDir
SaveSetting "Kiho", "KSFCreator", "FormInformationSave", RegInfo.FrmSave
SaveSetting "Kiho", "KSFCreator", "AutoProperty", RegInfo.AutoProperty
SaveSetting "Kiho", "KSFCreator", "UseLongNote", RegInfo.UseLongNote
SaveSetting "Kiho", "KSFCreator", "ResizeBetter", RegInfo.ResizeBetter
If RegInfo.FrmSave = 1 Then
    If Me.WindowState = vbMaximized Then
        SaveSetting "Kiho", "KSFCreator", "Maximized", 1
    Else
        SaveSetting "Kiho", "KSFCreator", "Maximized", 0
        If Me.WindowState <> vbMinimized Then
            SaveSetting "Kiho", "KSFCreator", "Left", Me.Left
            SaveSetting "Kiho", "KSFCreator", "Top", Me.Top
            SaveSetting "Kiho", "KSFCreator", "Height", Me.Height
            SaveSetting "Kiho", "KSFCreator", "Width", Me.Width
        End If
    End If
End If
End
End Sub
Private Sub mnu1p2pequalto_Click(Index As Integer)
Select Case Index
    Case 0
        If Not ActiveForm Is Nothing Then ActiveForm.P1P2Equal True
    Case 1
        If Not ActiveForm Is Nothing Then ActiveForm.P1P2Equal False
End Select
End Sub
Private Sub mnuEditAdd_Click()
If Not ActiveForm Is Nothing Then ActiveForm.Form_KeyDown 45, 0
End Sub
Private Sub mnuEditBunki_Click()
If Not ActiveForm Is Nothing Then ActiveForm.GetBunki
End Sub
Private Sub mnuEditDelete_Click()
If Not ActiveForm Is Nothing Then ActiveForm.Form_KeyDown 46, 0
End Sub
Private Sub mnuEditEmptySteps_Click(Index As Integer)
If Not ActiveForm Is Nothing Then ActiveForm.EmptyStep Index
End Sub
Private Sub mnuEditRandom_Click()
If Not ActiveForm Is Nothing Then ActiveForm.RanDomStep
End Sub
Private Sub mnuEditTurn_Click()
frmTurnStep.Show
End Sub
Private Sub mnuFileClose_Click()
If Not ActiveForm Is Nothing Then
Unload ActiveForm
End If
End Sub
Private Sub mnuFileExit_Click()
Unload Me
End Sub
Private Sub mnuFileNew_Click()
Dim FrmD As FrmDocu
Set FrmD = New FrmDocu
FormCount = FormCount + 1
FrmD.Caption = "New " & FormCount
FrmD.Show
ActiveForm.PropertyReset
End Sub
Private Sub mnuFileOpen_Click()
Dim FileNum As Integer, NextLine As String, LinesFromFile As Variant
With DlgBox
.Filename = ""
.ShowOpen
If .Filename = "" Then Exit Sub
mnuFileNew_Click
FileNum = FreeFile
Open .Filename For Input As FileNum
Do Until EOF(FileNum)
    Line Input #FileNum, NextLine
    LinesFromFile = LinesFromFile + NextLine + vbCrLf
Loop
ActiveForm.ReadBox.Text = LinesFromFile
Close FileNum
ActiveForm.ReadKSF
End With
End Sub
Private Sub mnuFileSave_Click()
If Not ActiveForm Is Nothing Then
If ActiveForm.GetFileName = "" Then
    With DlgBox
    .Filename = ""
    .ShowSave
    If .Filename = "" Then Exit Sub
    ActiveForm.SaveKSF
    End With
Else
    ActiveForm.SaveKSF False
End If
End If
End Sub
Private Sub mnuFileSaveAs_Click()
If Not ActiveForm Is Nothing Then
With DlgBox
.Filename = ""
.ShowSave
If .Filename = "" Then Exit Sub
ActiveForm.SaveKSF
End With
End If
End Sub
Private Sub mnuKSF2BMP_Click()
If Not ActiveForm Is Nothing Then frmKSF2PIC.Show
End Sub
Private Sub mnuKSFViewer_Click()
If Not ActiveForm Is Nothing Then ActiveForm.GOKSFViewer
End Sub
Private Sub mnuOption_Click()
frmOption.Show
End Sub
Private Sub mnuEditCut_Click()
If Not ActiveForm Is Nothing Then ActiveForm.EditCopy
If Not ActiveForm Is Nothing Then ActiveForm.Form_KeyDown 46, 0
End Sub
Private Sub mnuEditCopy_Click()
If Not ActiveForm Is Nothing Then ActiveForm.EditCopy
End Sub
Private Sub mnuEditPaste_Click(Index As Integer)
If Not ActiveForm Is Nothing Then ActiveForm.EditPaste Index
End Sub
Private Sub mnuAbout_Click()
frmAbout.Show
End Sub
Private Sub mnuSelectAll_Click()
If Not ActiveForm Is Nothing Then ActiveForm.SelectAll
End Sub
Private Sub mnuToBig_Click()
If Not ActiveForm Is Nothing Then ActiveForm.ToBigSmall True
End Sub
Private Sub mnuToSmall_Click()
If Not ActiveForm Is Nothing Then ActiveForm.ToBigSmall False
End Sub
Private Sub mnuToolsRealTime_Click()
If Not ActiveForm Is Nothing Then ActiveForm.RealTimeStart
End Sub
Private Sub mnuToolsSongFile_Click()
If Not ActiveForm Is Nothing Then ActiveForm.ChangeSongFile
End Sub
Private Sub mnuView1p2p_Click(Index As Integer)
If Not ActiveForm Is Nothing Then ActiveForm.Change1p2p Index + 1
End Sub
Private Sub mnuViewX_Click(Index As Integer)
If Not ActiveForm Is Nothing Then ActiveForm.ChangeSpeed2 Index
End Sub
Private Sub mnuWindowArrangeIcons_Click()
    Me.Arrange vbArrangeIcons
End Sub
Private Sub mnuWindowTileVertical_Click()
    Me.Arrange vbTileVertical
End Sub
Private Sub mnuWindowTileHorizontal_Click()
    Me.Arrange vbTileHorizontal
End Sub
Private Sub mnuWindowCascade_Click()
    Me.Arrange vbCascade
End Sub
Private Sub mnuWindowNewWindow_Click()
    mnuFileNew_Click
End Sub
Private Sub tbToolBar_ButtonClick(ByVal Button As MSComCtlLib.Button)
Select Case Button.Key
    Case "�� ����"
    mnuFileNew_Click
    Case "����"
    mnuFileOpen_Click
    Case "����"
    mnuFileSave_Click
    Case "�߶󳻱�"
    mnuEditCut_Click
    Case "����"
    mnuEditCopy_Click
    Case "�ٿ��ֱ�"
    mnuEditPaste_Click (0)
    Case "�߰�"
    mnuEditAdd_Click
    Case "����"
    mnuEditDelete_Click
    Case "�ǽð�"
    mnuToolsRealTime_Click
End Select
End Sub
Private Sub tbToolBar_ButtonMenuClick(ByVal ButtonMenu As MSComCtlLib.ButtonMenu)
If Mid(ButtonMenu.Key, 1, 2) = "���" Then
    If Not ActiveForm Is Nothing Then ActiveForm.ChangeSpeed ButtonMenu
Else
    If Not ActiveForm Is Nothing Then ActiveForm.Change1p2p ButtonMenu.Index
End If
End Sub
