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
Public Sub Initialize_Player()
    plPos = Vector3(500, 0, 500)
    plLook = Vector3(0, 20, 50)
    plAngleX = 0
    plAngleY = 0
    plWalk = 0
    plStrafe = 0
    plHealth = 100
    wpNo = 0
    plState = "joined"
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
Public Sub Update_Weapon()
    Weapon(wpNo).SetPosition plPos.x, plPos.y, plPos.z
    Weapon(wpNo).SetRotation 0, (180 - Rad2Deg(plAngleY)), -Rad2Deg(plAngleX)
    'This block deals with testing action completion(mainly)
    'Weapon check[from minor checks
    If plState = "weapChange" And Weapon(wpNo).IsAnimationFinished = True Then
    Weapon(wpNo).SetAnimationByName wpData(wpNo).anim(1)
    Weapon(wpNo).PlayAnimation 30
    Weapon(wpNo).SetAnimationLoop True
    plState = "idle"
    End If
    If plState = "reload" And Weapon(wpNo).IsAnimationFinished = True Then
    wpAmmo(wpNo).bull = wpData(wpNo).ammo(3)
    wpAmmo(wpNo).mags = wpAmmo(wpNo).mags - 1
    Weapon(wpNo).SetAnimationByName wpData(wpNo).anim(1)
    Weapon(wpNo).PlayAnimation 30
    Weapon(wpNo).SetAnimationLoop True
    plState = "idle"
    End If
    If plState = "fire" And Weapon(wpNo).IsAnimationFinished = True Then
    Weapon(wpNo).SetAnimationByName wpData(wpNo).anim(1)
    Weapon(wpNo).PlayAnimation 30
    Weapon(wpNo).SetAnimationLoop True
    plState = "idle"
    End If
    If plState = "rapidFire" And Weapon(wpNo).GetKeyFrame > 2 Then
    Weapon(wpNo).SetAnimationByName wpData(wpNo).anim(1)
    Weapon(wpNo).PlayAnimation 30
    Weapon(wpNo).SetAnimationLoop True
    plState = "idle"
    End If
End Sub
Public Sub Change_Weapon()
Weapon(wpNo).SetAnimationByName wpData(wpNo).anim(0)
Weapon(wpNo).PlayAnimation 30
Weapon(wpNo).SetAnimationLoop False
plState = "weapChange"
End Sub
Public Sub Fire_Weapon()
'Check ammo of current weapon if not enough reload or change weapon
If wpAmmo(wpNo).mags = 0 And wpAmmo(wpNo).bull = 0 Then
'change weapon
If wpNo < wpMax Then
wpNo = wpNo + 1
Else
wpNo = 0
End If
Change_Weapon
ElseIf wpAmmo(wpNo).bull = 0 And plState <> "reload" Then
'reload
Weapon(wpNo).SetAnimationByName wpData(wpNo).anim(3)
Weapon(wpNo).PlayAnimation 30
Weapon(wpNo).SetAnimationLoop False
plState = "reload"
ElseIf plState = "idle" Then
'shoot
If wpData(wpNo).ammo(0) = "Slow" Then
    wpAmmo(wpNo).bull = wpAmmo(wpNo).bull - 1
    Weapon(wpNo).SetAnimationByName wpData(wpNo).anim(2)
    Weapon(wpNo).PlayAnimation 60
    Weapon(wpNo).SetAnimationLoop False
    plState = "fire"
End If
If wpData(wpNo).ammo(0) = "Rapid" Then
    wpAmmo(wpNo).bull = wpAmmo(wpNo).bull - 1
    Weapon(wpNo).SetAnimationByName wpData(wpNo).anim(2)
    Weapon(wpNo).PlayAnimation 35
    Weapon(wpNo).SetAnimationLoop False
    plState = "rapidFire"
End If
'Test
Dim tmpDist As Single
Dim tmpTarget As D3DVECTOR
Dim test As Boolean
Dim coll As TV_COLLISIONRESULT
tmpTarget = Vector(plPos.x + Cos(plAngleY) * wpData(wpNo).ammo(1), plPos.y + Sin(plAngleX) * wpData(wpNo).ammo(1), Sin(plAngleY) * wpData(wpNo).ammo(1) + plPos.z)
Zombie.Collide plPos, tmpTarget, TV_TESTTYPE_BOUNDINGSPHERE, tmpDist
test = Scene.AdvancedCollision(plPos, tmpTarget, coll, TV_COLLIDE_LANDSCAPE, TV_TESTTYPE_BOUNDINGBOX, False)
If test = True And coll.distance > tmpDist Then
test = False
End If
If tmpDist < wpData(wpNo).ammo(1) And test = False And zbState <> "dead" Then
zbHealth = zbHealth - (1000 - tmpDist) / 200 'max distance 1000
Zombie_Kill
End If
'Me.Caption = zbHealth
End If
End Sub

