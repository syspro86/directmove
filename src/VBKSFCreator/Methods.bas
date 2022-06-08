Attribute VB_Name = "Methods"
Option Explicit
Public Sub KSF2BMP(KSFile2 As KickStepFile2)
On Error Resume Next
Dim pic As PictureBox
Set pic = frmKSF2PIC.A
If KSFile2.speed < 1 Then KSFile2.speed = 1
Dim A As Integer, B As Integer, X As Integer, Y As Integer, z As Integer, M As Boolean, N As Boolean
Dim yy As Integer
Dim k1p2p As Byte, ktick As Byte
k1p2p = KSFile2.Mode1p2p
ktick = KSFile2.Tickcount
'A는 리스트에서 뽑아올때,B는 화살표 읽을때, X,Y는 좌표 , Z는 선 or 점선
pic.Cls
pic.Height = 570
pic.Width = (Int((KSFile2.Stepcount - 1) / (32 * KSFile2.Tickcount / KSFile2.speed)) + 1) * (KSFile2.Mode1p2p * 80)
pic.CurrentX = 0
pic.CurrentY = 0
pic.Print KSFile2.Title & " " & KSFile2.BPM & IIf(KSFile2.BPM2 = -1, "", " " & KSFile2.BPM2) & IIf(KSFile2.BPM3 = -1, "", " " & KSFile2.BPM3) & " BPM " & IIf(KSFile2.Mode1p2p = 1, "Single", "Double") & " " & KSFile2.speed & "배속"
' 박자 구분선 그리기
X = -1: Y = 32 * KSFile2.Tickcount - KSFile2.speed
pic.DrawMode = 0
' 스텝 그리기
X = 0: Y = 0: z = 0
For yy = 0 To 7
pic.Line (0, yy * 64 + 13)-(80 * k1p2p - 1, yy * 64 + 13)
pic.Line (0, yy * 64 + 13)-(0, (1 + yy) * 64 + 13)
pic.Line (80 * k1p2p - 1, yy * 64 + 13)-(80 * k1p2p - 1, (1 + yy) * 64 + 13)
pic.Line (0, (1 + yy) * 64 + 13)-(80 * k1p2p - 1, (1 + yy) * 64 + 13)
Next
For A = 0 To KSFile2.Stepcount - 1
    For B = 0 To KSFile2.Mode1p2p * 5 - 1
    M = IIf(A = 0, (Mid(KSFile2.Step(A), B + 1, 1) = "4"), ((Mid(KSFile2.Step(A), B + 1, 1) = "4") And (Mid(KSFile2.Step(A - 1), B + 1, 1) <> "4")))
    N = IIf(A = 0, (Mid(KSFile2.Step(A), B + 1, 1) = "4"), ((Mid(KSFile2.Step(A), B + 1, 1) = "4") And (Mid(KSFile2.Step(A + 1), B + 1, 1) <> "4")))
    If (Mid(KSFile2.Step(A), B + 1, 1) = "1") Or M = True Or N = True Then
        If KSFile2.color = True Then
            BitBlt pic.hDC, (B * 16 + X * (80 * KSFile2.Mode1p2p)), Y * 16 / KSFile2.Tickcount + 13, 16, 16, Form1.ActiveForm.PicArrow((B Mod 5) + 10).hDC, 0, 0, vbSrcAnd
            BitBlt pic.hDC, (B * 16 + X * (80 * KSFile2.Mode1p2p)), Y * 16 / KSFile2.Tickcount + 13, 16, 16, Form1.ActiveForm.PicArrow((B Mod 5) + 5).hDC, 0, 0, vbSrcPaint
        Else
            BitBlt pic.hDC, (B * 16 + X * (80 * KSFile2.Mode1p2p)), Y * 16 / KSFile2.Tickcount + 13, 16, 16, Form1.ActiveForm.PicArrow((B Mod 5) + 10).hDC, 0, 0, vbSrcAnd
            BitBlt pic.hDC, (B * 16 + X * (80 * KSFile2.Mode1p2p)), Y * 16 / KSFile2.Tickcount + 13, 16, 16, Form1.ActiveForm.PicArrow((B Mod 5)).hDC, 0, 0, vbSrcPaint
        End If
    End If
    Next
    Y = Y + KSFile2.speed
    If Y = 32 * KSFile2.Tickcount Then
        Y = 0
        X = X + 1
        For yy = 0 To 7
        pic.Line (X * 80 * k1p2p, yy * 64 + 13)-((X + 1) * 80 * k1p2p - 1, yy * 64 + 13)
        pic.Line (X * 80 * k1p2p, yy * 64 + 13)-(X * 80 * k1p2p, (1 + yy) * 64 + 13)
        pic.Line ((X + 1) * 80 * k1p2p - 1, yy * 64 + 13)-((X + 1) * 80 * k1p2p - 1, (1 + yy) * 64 + 13)
        pic.Line (X * 80 * k1p2p, (1 + yy) * 64 + 13)-((X + 1) * 80 * k1p2p - 1, (1 + yy) * 64 + 13)
        Next
    End If
    If A + 1 = KSFile2.Stepcount Then Exit For
Next
'pic.FontName = "바탕"
'pic.CurrentX = pic.Width - 150
'pic.CurrentY = 535
'pic.Print "Project Rebirth"
'pic.CurrentX = pic.Width - 150
'pic.CurrentY = 550
'pic.Print "http://prebirth.wo.to"
Form1.DlgBox.Filename = ""
Form1.DlgBox.FilterIndex = 1
Form1.DlgBox.Filter = IIf(KSFile2.gtype = 1, "BMP", "JPG") & "(*." & IIf(KSFile2.gtype = 1, "BMP", "JPG") & ")"
Form1.DlgBox.ShowSave
If Form1.DlgBox.Filename = "" Then Exit Sub
Select Case KSFile2.gtype
Case 1
If UCase(Right(Form1.DlgBox.Filename, 4)) <> ".BMP" Then Form1.DlgBox.Filename = Form1.DlgBox.Filename & ".BMP"
SavePicture pic.Image, Form1.DlgBox.Filename
Case 2
If UCase(Right(Form1.DlgBox.Filename, 4)) <> ".JPG" Then Form1.DlgBox.Filename = Form1.DlgBox.Filename & ".JPG"
NviewLibSave Form1.DlgBox.Filename
End Select
Form1.DlgBox.Filter = "KSF File (*.ksf)|*.ksf"
Form1.DlgBox.FilterIndex = 1
MsgBox "생성완료", vbOKOnly + vbExclamation, "KSFCreator"
End Sub
Public Function FileNameCut(Name As String) As String
Dim data As String, temp As Long
data = Name
Do Until Mid(Name, Len(Name) - temp, 1) = "\"
    DoEvents
    temp = temp + 1
Loop
data = Mid(Name, Len(Name) - temp + 1, Len(Name))
FileNameCut = data
End Function
Public Sub NviewLibSave(Filename As String)
On Error Resume Next
Dim A As Integer
'A = NViewLibSaveAsJPG(JpegQuality, filename)
'If A = 0 Then
SavePicture frmKSF2PIC.A.Image, "~temp.BMP"
A = NViewLibLoad("~temp.BMP", 0)
A = NViewLibSaveAsJPG(100, Filename)
Kill "~temp.bmp"
'End If
End Sub
