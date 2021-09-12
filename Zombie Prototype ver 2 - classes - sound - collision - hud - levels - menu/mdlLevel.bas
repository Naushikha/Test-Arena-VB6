Attribute VB_Name = "mdlLevel"
Option Explicit
Public lvlNo As Integer '1 to 5 (Humanly possible :P)
Public lvlZbs As Integer
Public lvlKilled As Integer
Public lvlChange As Boolean

Private i As Integer
Public Sub Level_Begin()
'Add hud message here LEVEL BEGINS, FIGHT !
        lvlChange = True
        hudLvlWait = TV.TickCount
        lvlZbs = (2 ^ lvlNo) - 1
        For i = 0 To wpMax
        Weapon(i).reset_ammo
        Next
        For i = 0 To lvlZbs
            Set Zombie(i) = New clsZombie
            Zombie(i).Load
        Next
        'Used to speed up references of zombies between the engine and the program
        zbIdStart = Int(Mid(Zombie(0).tvName, 7, Len(Zombie(0).tvName))) - 1 '1 less than the actual id
        zbIdEnd = zbIdStart + lvlZbs + 2 '1 greater than the actual. reason, using < / > in the comparison of theses vars.
        
        Atmosphere.SkyBox_SetTexture GetTex("virtual"), GetTex("virtual"), GetTex("virtual"), GetTex("virtual"), GetTex("virtual"), GetTex("virtual")
        
        lvlSFX(2).Load "SFX\" & "lvl_music" & lvlNo & ".wav"
        lvlSFX(2).Volume = -1700
        lvlSFX(2).Loop_ = True
        lvlSFX(2).Play
End Sub
Public Sub Level_Check()
If plState <> "dead" Then
If lvlKilled = lvlZbs + 1 Then
If lvlNo < 5 Then
Level_Clear
Else
DoLoop = False
frmScore.lblStatus = "Test Survived."
frmScore.Show
Unload frmTest
End If
End If
If plHealth < 1 Then
For i = 0 To lvlZbs
    If Zombie(i).state <> "disabled" Then
    Zombie(i).health = 0
    Zombie(i).Death
    End If
Next
hudEffects.Flash 0.5, 0, 0, 600
plState = "dead"
plEscape = True
Weapon(wpNo).show_box
plSFX(1).Play
End If
End If

If plState = "dead" Then
If plPos.Y > 1600 Then
DoLoop = False
frmScore.lblStatus = "Test Failed."
frmScore.Show
Unload frmTest
Else
escapeWait = TV.TickCount
plPos.Y = plPos.Y + 0.2 * TV.TimeElapsed
End If
End If
End Sub
Public Sub Level_Clear()
'Add hud messag here LEVEL WAS CLEARED
        lvlSFX(1).Play
        For i = 0 To lvlZbs
            Set Zombie(i) = Nothing
        Next
        lvlKilled = 0
        lvlNo = lvlNo + 1
        Level_Begin
End Sub
'Had no place to put this function lol
Public Sub Add_zbBlood(pos As D3DVECTOR)
Dim tmppos As D3DVECTOR
Randomize
tmppos = Vector(pos.X, Land.GetHeight(pos.X, pos.z) + 5, pos.z)
CreateDecal tmppos, VNormalize(Land.GetNormal(tmppos.X, tmppos.z)), GetTex("zbBlood" & (Int(Rnd * 2 + 1))), (Rnd * 30 + 10), 10000
End Sub
Public Sub Add_plBlood(pos As D3DVECTOR)
Dim tmppos As D3DVECTOR
Randomize
tmppos = Vector(plPos.X, Land.GetHeight(plPos.X, plPos.z) + 5, plPos.z)
CreateDecal tmppos, VNormalize(Land.GetNormal(tmppos.X, tmppos.z)), GetTex("plBlood"), (Rnd * 30 + 10), 10000
End Sub

