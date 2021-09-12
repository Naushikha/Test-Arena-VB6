Attribute VB_Name = "mdlPlayer"
Option Explicit

Public plPos As D3DVECTOR
Public plLook As D3DVECTOR
Public plAngleX As Single
Public plAngleY As Single
Public plWalk As Single
Public plStrafe As Single
Public plState As String
Public plHealth As String

Public Const wpMax As Integer = 2
Public wpNo As Integer
Public Weapon(0 To wpMax) As clsWeapon

Public Const zbMax As Integer = 5
Public Zombie(0 To zbMax) As clsZombie

Private i As Integer
Public Sub Initialize_Player()
    plPos = Vector3(200, 0, 200)
    plLook = Vector3(0, 20, 50)
    plAngleX = 0
    plAngleY = 0
    plWalk = 0
    plStrafe = 0
    plHealth = 100
    wpNo = 0
    plState = "idle"
    For i = 0 To wpMax
        Set Weapon(i) = New clsWeapon
    Next
    Weapon(0).Load "v_knife"
    Weapon(1).Load "v_deagle"
    Weapon(2).Load "v_m4a1"
End Sub
Public Sub Initialize_Zombies()
        For i = 0 To zbMax
            Set Zombie(i) = New clsZombie
            Zombie(i).Load
        Next
End Sub
Public Sub Check_Movement()
        If plAngleX > 1 Then plAngleX = 1
        If plAngleX < -1 Then plAngleX = -1

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
        
        plPos.x = plPos.x + (Cos(plAngleY) * plWalk / 5 * TV.TimeElapsed) + (Cos(plAngleY + 3.141596 / 2) * plStrafe / 5 * TV.TimeElapsed)
        plPos.y = Land.GetHeight(plPos.x, plPos.z) + 60
        plPos.z = plPos.z + (Sin(plAngleY) * plWalk / 5 * TV.TimeElapsed) + (Sin(plAngleY + 3.141596 / 2) * plStrafe / 5 * TV.TimeElapsed)
        plLook.x = plPos.x + Cos(plAngleY)
        plLook.y = plPos.y + Tan(plAngleX)
        plLook.z = plPos.z + Sin(plAngleY)
        
        Scene.SetCamera plPos.x, plPos.y, plPos.z, plLook.x, plLook.y, plLook.z
End Sub

