VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsZombie"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
'Zombies
Private Zombie As TVActor2 'WARNING edit to add more zombies
Private zbState As String
Private zbHealth As Integer
Private zbWait As Long
Private zbPos As D3DVECTOR
Private zbMove As D3DVECTOR
Private zbTarget As D3DVECTOR
Function MovePoint3D(Source As D3DVECTOR, Destination As D3DVECTOR, SpeedMovTm As Single) As D3DVECTOR
Dim VectorPosTm As D3DVECTOR
VectorPosTm = VNormalize(VSubtract(Destination, Source))
MovePoint3D = VAdd(Source, VScale(VectorPosTm, SpeedMovTm))
End Function
Private Sub Zombie_AI()
Me.Caption = GetDistance2D(zbPos.x, zbPos.z, plPos.x, plPos.z) & "   " & zbState
'Get triggered initially
Dim tmpDist As Single
tmpDist = GetDistance2D(zbPos.x, zbPos.z, plPos.x, plPos.z)
If zbState = "idle" And tmpDist < 400 Then
Zombie.SetAnimationByName "run"
Zombie.PlayAnimation 20
Zombie.SetAnimationLoop True
zbState = "seenPlayer"
End If
'Let zombie enrage seeing the player flee
If zbState = "seenPlayer" And tmpDist > 600 Then
Zombie.SetAnimationByName "run2"
Zombie.PlayAnimation 40
Zombie.SetAnimationLoop True
zbState = "furiousEscape"
End If
'Attack when near 70 DEVELOPMENT NEEDED
If tmpDist > 100 Then
If zbState = "seenPlayer" And tmpDist < 200 Then
Zombie.SetAnimationByName "long_jump"
Zombie.PlayAnimation 30
Zombie.SetAnimationLoop False
zbTarget = plPos
zbState = "attackPlayer"
End If
If zbState = "furiousEscape" And tmpDist < 200 Then
Zombie.SetAnimationByName "long_jump"
Zombie.PlayAnimation 40
Zombie.SetAnimationLoop False
zbTarget = plPos
zbState = "attackPlayer"
End If
End If
'After attack
If zbState = "attackedPlayer" And TV.TickCount - zbWait > 1500 Then
zbWait = TV.TickCount
Zombie.SetAnimationByName "run"
Zombie.PlayAnimation 20
Zombie.SetAnimationLoop True
zbState = "seenPlayer"
End If
'MOVE
If zbState = "seenPlayer" Then
zbMove = MovePoint3D(zbPos, plPos, 1.5)
zbPos = Vector3(zbMove.x, Land.GetHeight(zbMove.x, zbMove.z) + 30, zbMove.z)
Zombie.Lookat plPos.x, plPos.y, plPos.z
Zombie.RotateY 90
End If
If zbState = "furiousEscape" Then
zbMove = MovePoint3D(zbPos, plPos, 3)
zbPos = Vector3(zbMove.x, Land.GetHeight(zbMove.x, zbMove.z) + 30, zbMove.z)
Zombie.Lookat plPos.x, plPos.y, plPos.z
Zombie.RotateY 90 'required to make it look in proper direction
End If
If zbState = "attackPlayer" Then
zbMove = MovePoint3D(zbPos, zbTarget, 3)
zbPos = Vector3(zbMove.x, Land.GetHeight(zbMove.x, zbMove.z) + 45, zbMove.z)
Zombie.Lookat zbTarget.x, zbTarget.y, zbTarget.z
Zombie.RotateY 90
End If

'Zombie check [from minor checks]
If zbState = "attackPlayer" And Zombie.GetKeyFrame > 33 Then
If GetDistance2D(zbPos.x, zbPos.z, plPos.x, plPos.z) < 150 Then
plHealth = plHealth - Round(GetDistance2D(zbPos.x, zbPos.z, plPos.x, plPos.z) / 4)
Zombie.SetAnimationByName "idle"
Zombie.PlayAnimation 20
Zombie.SetAnimationLoop True
zbState = "attackedPlayer"
ElseIf GetDistance2D(zbPos.x, zbPos.z, plPos.x, plPos.z) < 200 Then
Zombie.Lookat plPos.x, plPos.y, plPos.z
Zombie.RotateY 90
Zombie.SetAnimationByName "jump"
Zombie.PlayAnimation 40
Zombie.SetAnimationLoop False
zbState = "wait"
Else
Zombie.SetAnimationByName "run"
Zombie.PlayAnimation 20
Zombie.SetAnimationLoop True
zbState = "seenPlayer"
End If
End If
If zbState = "wait" And Zombie.IsAnimationFinished = True Then
Zombie.SetAnimationByName "run"
Zombie.PlayAnimation 20
Zombie.SetAnimationLoop True
zbState = "seenPlayer"
End If

Zombie.SetPosition zbPos.x, zbPos.y, zbPos.z
End Sub
Private Sub Zombie_Kill()
If zbHealth < 0 Then
If zbHealth > -2 Then
Zombie.SetAnimationByName "die_simple"
Zombie.PlayAnimation 30
Zombie.SetAnimationLoop False
Else
Zombie.SetAnimationByName "die_spin"
Zombie.PlayAnimation 30
Zombie.SetAnimationLoop False
End If
zbState = "dead"
End If
End Sub
