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
Public plEscape As Boolean

Public Const wpMax As Integer = 3
Public wpNo As Integer
Public Weapon(0 To wpMax) As clsWeapon

Public Const zbMax As Integer = 4
Public Zombie(0 To zbMax) As clsZombie
Public zbIdStart, zbIdEnd As Integer
Private i As Integer
Private matCamera As D3DMATRIX
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
    plEscape = False
    For i = 0 To wpMax
        Set Weapon(i) = New clsWeapon
    Next
    Weapon(0).Load "knife"
    Weapon(1).Load "deagle"
    Weapon(2).Load "m4a1"
    Weapon(3).Load "ump45"
End Sub
Public Sub Initialize_Zombies()
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
        'frmTest.Caption = plPos.x & " " & plPos.z
        If plEscape = False Then 'Do not go out of the map
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
        End If
        plLook.x = plPos.x + Cos(plAngleY)
        plLook.y = plPos.y + Tan(plAngleX)
        plLook.z = plPos.z + Sin(plAngleY)
        
        
        
        Scene.SetCamera plPos.x, plPos.y, plPos.z, plLook.x, plLook.y, plLook.z
        Listener.SetPosition plPos.x / 100, plPos.y / 100, plPos.z / 100
        matCamera = Scene.GetCamera.GetRotationMatrix
        Listener.SetOrientation matCamera.m31, matCamera.m32, matCamera.m33, matCamera.m21, matCamera.m22, matCamera.m23
End Sub

