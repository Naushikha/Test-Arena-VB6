Attribute VB_Name = "mdlPlayer"
Option Explicit

Public plSFX(5) As TVSoundWaveStereo

Public plPos As D3DVECTOR
Public plLook As D3DVECTOR
Public plAngleX As Single
Public plAngleY As Single
Public plWalk As Single
Public plStrafe As Single
Public plState As String
Public plHealth As String
Public plEscape As Boolean
Public plDifficulty As Integer

Public Const wpMax As Integer = 3
Public wpNo As Integer
Public Weapon(0 To wpMax) As clsWeapon

Public Const zbMax As Integer = 127
Public Zombie(0 To zbMax) As clsZombie
Public zbIdStart, zbIdEnd As Integer
Private i As Integer
Public walkWait As Long ' for the walking sounds
Private matCamera As D3DMATRIX
Public Sub Player_Initialize()
    plPos = Vector(200, 300, 200)
    plLook = Vector(0, 20, 50)
    plAngleX = 0
    plAngleY = 0
    plWalk = 0
    plStrafe = 0
    plHealth = 100
    wpNo = 0
    plState = "idle"
    plEscape = False
    For i = 0 To wpMax
        Set Weapon(i) = New clsWeapon
    Next
    Weapon(0).Load "knife"
    Weapon(1).Load "deagle"
    Weapon(2).Load "m4a1"
    Weapon(3).Load "ump45"
    For i = 0 To 5
    Set plSFX(i) = New TVSoundWaveStereo
    Next
    plSFX(0).Load "SFX\pl_hurt.wav"
    plSFX(1).Load "SFX\pl_die.wav"
    plSFX(2).Load "SFX\pl_step1.wav"
    plSFX(3).Load "SFX\pl_step2.wav"
    plSFX(4).Load "SFX\pl_step3.wav"
    plSFX(5).Load "SFX\pl_step4.wav"
    plSFX(0).Volume = -1000
    plSFX(1).Volume = -1000
    For i = 2 To 5
    plSFX(i).Volume = -1300
    Next
End Sub
Public Sub Zombies_Initialize()
        For i = 0 To zbMax
            Set Zombie(i) = New clsZombie
            Zombie(i).Load
        Next
        'Used to speed up references of zombies between the engine and the program
        zbIdStart = Int(Mid(Zombie(0).tvName, 7, Len(Zombie(0).tvName))) - 1 '1 less than the actual id
        zbIdEnd = zbIdStart + zbMax + 2 '1 greater than the actual. reason, using < / > in the comparison of theses vars.
End Sub
Public Sub Check_Movement()
        If plAngleX > 1 Then plAngleX = 1
        If plAngleX < -1 Then plAngleX = -1
        Escape_Collision
        If plEscape = False And lvlChange = False Then 'Do not go out of the map
        
        If plWalk = 2 Then
            If walkWait < TV.TickCount - 300 Then
            walkWait = TV.TickCount
            plSFX(Int(Rnd * 4) + 2).Play
            End If
        ElseIf plWalk = 1 Or plWalk = -1 Or plStrafe = 1 Or plStrafe = -1 Then
            If walkWait < TV.TickCount - 400 Then
            walkWait = TV.TickCount
            plSFX(Int(Rnd * 4) + 2).Play
            End If
        End If
        
        Select Case plWalk
        Case Is > 0
            plWalk = plWalk - 0.005 * TV.TimeElapsed
            If plWalk < 0 Then plWalk = 0
        Case Is < 0
            plWalk = plWalk + 0.005 * TV.TimeElapsed
            If plWalk > 0 Then plWalk = 0
        End Select

        Select Case plStrafe
        Case Is > 0
            plStrafe = plStrafe - 0.005 * TV.TimeElapsed
            If plStrafe < 0 Then plStrafe = 0
        Case Is < 0
            plStrafe = plStrafe + 0.005 * TV.TimeElapsed
            If plStrafe > 0 Then plStrafe = 0
        End Select


        plPos.X = plPos.X + (Cos(plAngleY) * plWalk / 5 * TV.TimeElapsed) + (Cos(plAngleY + 3.141596 / 2) * plStrafe / 5 * TV.TimeElapsed)
        plPos.Y = Land.GetHeight(plPos.X, plPos.z) + 60
        plPos.z = plPos.z + (Sin(plAngleY) * plWalk / 5 * TV.TimeElapsed) + (Sin(plAngleY + 3.141596 / 2) * plStrafe / 5 * TV.TimeElapsed)
        End If
        plLook.X = plPos.X + Cos(plAngleY)
        plLook.Y = plPos.Y + Tan(plAngleX)
        plLook.z = plPos.z + Sin(plAngleY)
        
        
        
        Scene.SetCamera plPos.X, plPos.Y, plPos.z, plLook.X, plLook.Y, plLook.z
        Listener.SetPosition plPos.X / 100, plPos.Y / 100, plPos.z / 100
        matCamera = Scene.GetCamera.GetRotationMatrix
        Listener.SetOrientation matCamera.m31, matCamera.m32, matCamera.m33, matCamera.m21, matCamera.m22, matCamera.m23
       
End Sub
Public Sub Player_Clear()
For i = 0 To 5
Set plSFX(i) = Nothing
Next
End Sub
