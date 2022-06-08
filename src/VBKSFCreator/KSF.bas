Attribute VB_Name = "KSF"
Option Explicit
'API�Լ�
Public Declare Function NViewLibLoad Lib "NViewLib.dll" (ByVal Filename As String, ByVal A As Integer) As Long
Public Declare Function NViewLibSaveAsJPG Lib "NViewLib.dll" (ByVal Quality As Integer, ByVal Filename As String) As Integer

Public Declare Function KeyState Lib "user32" Alias "GetAsyncKeyState" (ByVal vKey As Long) As Integer
Public Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal X As Long, ByVal Y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long
Public Declare Function GetTickCount Lib "kernel32" () As Long
Public Declare Function GetDC Lib "user32" (ByVal hwnd As Long) As Long

Public CBoard As String             'clip board
Public RealTimeInsert As Boolean
Public RealTimePressed As Boolean
Public RegInfo As RegistryInformation   ' ������Ʈ�� ����
Public ProChanging As Boolean

Public Type RegistryInformation
    FrmSave As Byte         ' �� ���� ����
    AutoProperty As Byte    ' �ڵ� ��������
    UseLongNote As Byte     ' �ճ�Ʈ ���
    LastDir As String       ' ����������� ����
    ResizeBetter As Byte    ' �������� ���� -_-?;
End Type

Public Type KickStepFile    'KSF��������
    Title As String         '����
    StartTime As Long       '��ŸƮŸ��
    StartTime2 As Long      '��ŸƮŸ��2
    StartTime3 As Long      '��ŸƮŸ��3
    BPM As Single       'BPM
    BPM2 As Single      'BPM2
    BPM3 As Single      'BPM3
    Bunki As Long       '�б�
    Bunki2 As Long      '�б�2
    Difficult As Byte   '���̵�
    Tickcount As Byte   'ƽī��Ʈ
    speed As Byte       '��Ӻ���
    Filename As String  '�����̸�
    Changed As Boolean  '����Ǿ���.
    Mode1p2p As Byte    '�̱� Ȥ�� ����
    RealTimeFile As String
    'RealTimeFileType As String
End Type

Public Type KickStepFile2 'KSF��������
    Title As String '����
    BPM As Single 'BPM
    BPM2 As Single 'BPM2
    BPM3 As Single 'BPM3
    Difficult As Byte '���̵�
    Tickcount As Byte 'ƽī��Ʈ
    speed As Single '��Ӻ���
    gtype As Byte
    color As Boolean
    Filename As String '�����̸�
    Mode1p2p As Byte ' �̱� Ȥ�� ����
    Step() As String * 10
    Stepcount As Long
End Type

Public Type MultiSelect '���߼���
    Multi As Boolean '���߼���
    SelectStart As Integer '����
    SelectEnd As Integer '��
    Start As Integer 'ó������ ����
End Type


'�۾�����(?)
'   Ver 0.1
' 2001-??-?? : �ʱ���� -_-;
'   Ver 0.2
' 2002-01-07 : ��Ӻ��� ��� �ϼ� -_-v
' 2002-01-08 : ���� �ٿ��ֱ� ��� �ϼ� -_-v
' 2002-01-08 : ��ü���� -_-;;;;
' 2002-01-09 : ���ڸ��� �ٿ��ֱ�
'   Ver 0.3
' 2002-01-10 : �� ũ�⿡ ���� ����ǥ�� ���� (��û�� ���׷��̵�� -_-)
' 2002-01-11 : MDI���� ä��
' 2002-01-11 : ������ϼ� ��_��
'   Ver 0.35
' 2002-01-12 : Ű���� -_- Insert,Delete
' 2002-01-12 : ������ � �߰� (�߰�,����,�̱�/����,�ǽð�)
'   Ver 0.36
' 2002-01-12 : �ǽð� �Է� �ϼ� ��_��
'   Ver 0.4
' 2002-01-12 : �б�� �̾Ƴ���
' 2002-01-13 : KSF2BMP
'   Ver 0.41
' 2002-01-13 : Real Player -> Media Player
' 2002-01-13 : 4 Arrow Editing
' 2002-01-14 : KSF Viewer, �ǽð� ���� ���� �ڵ� �ε�
' 2002-01-14 : 1P 2P ����ä��
'   Ver 0.45
' 2002-01-14 : �¿�,���� ȸ�� -_-
'   Ver 0.455
' 2002-01-29 : MRU��� ����
'   Ver 0.5
' 2002-02-01 : ���� ������ �͵� ����
' 2002-02-02 : �ճ�Ʈ!
' 2002-??-?? : 4 Arrow Editing ����
'   Ver 0.52
' 2002-02-13 : OLEDrop
'   Ver 0.535
' 2002-02-28 : KSF2BMP �ٵ��
