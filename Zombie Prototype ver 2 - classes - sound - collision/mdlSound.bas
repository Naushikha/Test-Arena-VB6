Attribute VB_Name = "mdlSound"
Option Explicit

Public SoundEngine As TVSoundEngine
Public Listener As TVListener
Public Sub Initialize_Sound()
Set SoundEngine = New TVSoundEngine
SoundEngine.Init frmTest.hWnd
Set Listener = SoundEngine.Get3DListener
End Sub
Public Sub Sound_Clear()
Set SoundEngine = Nothing
Set Listener = Nothing
End Sub
