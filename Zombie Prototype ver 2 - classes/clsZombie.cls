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
Private model As TVActor2 'WARNING edit to add more zombies
Public state As String
Public health As Integer
Public wait As Long
Private tvName As String
Private pos As D3DVECTOR
Private move As D3DVECTOR
Private target As D3DVECTOR
Private coll As TVCollisionResult
Function MovePoint3D(Source As D3DVECTOR, Destination As D3DVECTOR, SpeedMovTm As Single) As D3DVECTOR
Dim VectorPosTm As D3DVECTOR
VectorPosTm = VNormalize(VSubtract(Destination, Source))
MovePoint3D = VAdd(Source, VScale(VectorPosTm, SpeedMovTm)) 'Update REQUIRED
End Function
Public Sub Load()
    Set model = New TVActor2
    Set coll = New TVCollisionResult
    model.Load "alien.mdl"
    model.SetScale 1, 1, 1
    model.SetAnimationByName "idle"
    model.PlayAnimation 20
    Randomize
    Dim tmpx, tmpz As Single
    tmpx = Int((1000 * Rnd) + 500)
    tmpz = Int((1000 * Rnd) + 500)
    pos = Vector3(tmpx, Land.GetHeight(tmpx, tmpz) + 35, tmpz)
    model.RotateY Int((270 * Rnd) + 10)
    health = 100
    state = "idle"
    tvName = model.GetName
End Sub
Public Sub AI()
'Get triggered initially
Dim tmpDist As Single
tmpDist = GetDistance2D(pos.x, pos.z, plPos.x, plPos.z)
If state = "idle" And tmpDist < 400 Then
model.SetAnimationByName "run"
model.PlayAnimation 20
model.SetAnimationLoop True
state = "seenPlayer"
End If
'Let zombie enrage seeing the player flee
If state = "seenPlayer" And tmpDist > 600 Then
model.SetAnimationByName "run2"
model.PlayAnimation 40
model.SetAnimationLoop True
state = "furiousEscape"
End If
'Attack when near 70 DEVELOPMENT NEEDED
If tmpDist > 100 Then
If state = "seenPlayer" And tmpDist < 200 Then
model.SetAnimationByName "long_jump"
model.PlayAnimation 30
model.SetAnimationLoop False
target = plPos
state = "attackPlayer"
End If
If state = "furiousEscape" And tmpDist < 200 Then
model.SetAnimationByName "long_jump"
model.PlayAnimation 40
model.SetAnimationLoop False
target = plPos
state = "attackPlayer"
End If
End If
'After attack
If state = "attackedPlayer" And TV.TickCount - wait > 1500 Then
wait = TV.TickCount
model.SetAnimationByName "run"
model.PlayAnimation 20
model.SetAnimationLoop True
state = "seenPlayer"
End If
'MOVE
If state = "seenPlayer" Then
move = MovePoint3D(pos, plPos, 1.5)
pos = Vector3(move.x, Land.GetHeight(move.x, move.z) + 30, move.z)
model.Lookat plPos.x, plPos.y, plPos.z
model.RotateY 90
End If
If state = "furiousEscape" Then
move = MovePoint3D(pos, plPos, 3)
pos = Vector3(move.x, Land.GetHeight(move.x, move.z) + 30, move.z)
model.Lookat plPos.x, plPos.y, plPos.z
model.RotateY 90 'required to make it look in proper direction
End If
If state = "attackPlayer" Then
move = MovePoint3D(pos, target, 3)
pos = Vector3(move.x, Land.GetHeight(move.x, move.z) + 45, move.z)
model.Lookat target.x, target.y, target.z
model.RotateY 90
End If

'Zombie check [from minor checks]
If state = "attackPlayer" And model.GetKeyFrame > 33 Then
If tmpDist < 150 Then
plHealth = plHealth - Round(tmpDist / 4)
model.SetAnimationByName "idle"
model.PlayAnimation 20
model.SetAnimationLoop True
state = "attackedPlayer"
ElseIf tmpDist < 200 Then
model.Lookat plPos.x, plPos.y, plPos.z
model.RotateY 90
model.SetAnimationByName "jump"
model.PlayAnimation 40
model.SetAnimationLoop False
state = "wait"
Else
model.SetAnimationByName "run"
model.PlayAnimation 20
model.SetAnimationLoop True
state = "seenPlayer"
End If
End If
If state = "wait" And model.IsAnimationFinished = True Then
model.SetAnimationByName "run"
model.PlayAnimation 20
model.SetAnimationLoop True
state = "seenPlayer"
End If

model.SetPosition pos.x, pos.y, pos.z
End Sub
Public Sub Hit(range As String)
Dim tmpDist As Single
Set coll = Scene.MousePicking(chMX, chMY, TV_COLLIDE_ACTOR2, TV_TESTTYPE_MDL_HITBOXES)
tmpDist = coll.GetCollisionDistance
If coll.IsCollision Then
If coll.GetCollisionActor2.GetName = tvName And state <> "dead" And tmpDist < range Then 'if zb is not hit why bother ?
health = health - (1000 - tmpDist) / 200 'max distance 1000
Death
'Furious when shot
If state = "idle" Then
model.SetAnimationByName "run2"
model.PlayAnimation 40
model.SetAnimationLoop True
state = "furiousEscape"
End If
End If
End If
End Sub
Public Sub Death()
If health < 0 Then
If health > -2 Then
model.SetAnimationByName "die_simple"
model.PlayAnimation 30
model.SetAnimationLoop False
Else
model.SetAnimationByName "die_spin"
model.PlayAnimation 30
model.SetAnimationLoop False
End If
state = "dead"
End If
End Sub
Public Sub render()
model.render
End Sub
Public Sub clear()
Set model = Nothing
Set coll = Nothing
End Sub
