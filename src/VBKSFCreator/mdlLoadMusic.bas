Attribute VB_Name = "mdlLoadMusic"
Option Explicit
Public Sub LoadMusic(FileName As String, Audio As IBasicAudio, MediaControl As IMediaControl, MediaPosition As IMediaPosition)
On Error Resume Next
UnloadMusic Audio, MediaControl, MediaPosition
Set MediaControl = New FilgraphManager
Set Audio = MediaControl
Set MediaPosition = MediaControl
MediaControl.RenderFile FileName ' find a rendering for it. and load it up
End Sub
Public Sub UnloadMusic(Audio As IBasicAudio, MediaControl As IMediaControl, MediaPosition As IMediaPosition)
Set MediaControl = Nothing
Set Audio = Nothing
Set MediaPosition = Nothing
End Sub
