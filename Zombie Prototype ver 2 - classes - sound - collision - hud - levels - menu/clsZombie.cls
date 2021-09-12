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
'Zombies - HARDCODED FOR A SPECIFIC MODEL
Private model As TVActor2 'WARNING edit to add more zombies
Private sfx(3) As TVSoundWave3D

Public state As String
Public health As Integer
Public wait As Long '  used only to time attackedPlayer and lackInterest states !!!
Public speed As Single
Public tvName As String
Private pos As D3DVECTOR
Private move As D3DVECTOR
Private target As D3DVECTOR
Private coll As TVCollisionResult

Private i As Integer
Function MovePoint3D(Source As D3DVECTOR, Destination As D3DVECTOR, SpeedMovTm As Single) As D3DVECTOR
Dim VectorPosTm As D3DVECTOR
VectorPosTm = VNormalize(VSubtract(Destination, Source))
MovePoint3D = VAdd(Source, VScale(VectorPosTm, SpeedMovTm * TV.TimeElapsed * speed)) 'Update REQUIRED :EDIT- DONE !
End Function
Function GetPos() As D3DVECTOR
GetPos = pos
End Function
Public Sub Load()
    Set model = New TVActor2
    Set coll = New TVCollisionResult
    model.Load "Models\alien.mdl"
    model.SetScale 1, 1, 1
    model.SetAnimationByName "idle"
    model.PlayAnimation 20
    'model.ShowBoundingBox True
    Randomize
    Dim tmpx, tmpz As Single
    tmpx = Int((1400 * Rnd) + 500) '1400+500 =1900 max limit
    tmpz = Int((1400 * Rnd) + 500)
    pos = Vector3(tmpx, Land.GetHeight(tmpx, tmpz) + 35, tmpz)
    model.RotateY Int((270 * Rnd) + 10)
    health = plDifficulty
    speed = 0.1
    state = "idle"
    tvName = model.GetName
    For i = 0 To 3
    Set sfx(i) = New TVSoundWave3D
    Next
    sfx(0).Load "SFX\zombie_seen.wav"
    sfx(1).Load "SFX\zombie_attack.wav"
    sfx(2).Load "SFX\zombie_pain.wav"
    sfx(3).Load "SFX\zombie_die.wav"
End Sub
Public Sub AI()
'don't want them attacking the player in the middle right ?
If lvlChange = True Then
GoTo setPos
End If
'Get triggered initially
Dim tmpDist As Single
tmpDist = GetDistance2D(pos.X, pos.z, plPos.X, plPos.z)
If state = "idle" And tmpDist < 400 Then
model.SetAnimationByName "run"
model.PlayAnimation 20
model.SetAnimationLoop True
sfx(0).Play
state = "seenPlayer"
End If
'Let zombie enrage seeing the player flee
If state = "seenPlayer" And tmpDist > 600 Then
model.SetAnimationByName "run2"
model.PlayAnimation 40
model.SetAnimationLoop True
sfx(0).Play
state = "furiousEscape"
End If
'Attack when near 70 DEVELOPMENT NEEDED
If tmpDist > 100 Then
If state = "seenPlayer" And tmpDist < 200 Then
model.SetAnimationByName "long_jump"
model.PlayAnimation 30
model.SetAnimationLoop False
sfx(0).Stop_
sfx(1).Stop_
sfx(1).Play
target = plPos
state = "attackPlayer"
End If
If state = "furiousEscape" And tmpDist < 200 Then
model.SetAnimationByName "long_jump"
model.PlayAnimation 40
model.SetAnimationLoop False
target = plPos
sfx(0).Stop_
sfx(1).Stop_
sfx(1).Play
state = "attackPlayer"
End If
ElseIf state = "seenPlayer" And tmpDist < 30 Then
plHealth = 0
End If
'After attack
If state = "attackedPlayer" And TV.TickCount - wait > 200 Then
hudEffects.StopFlash ' HUDEFFECT TEST
model.SetAnimationByName "run"
model.PlayAnimation 20
model.SetAnimationLoop True
state = "seenPlayer"
End If
'Let zombie gain interest back again
If state = "lackInterest" And TV.TickCount - wait > 3000 Then
speed = 0.1
state = "seenPlayer"
End If
'MOVE
If state = "seenPlayer" Or state = "lackInterest" Then
move = MovePoint3D(pos, plPos, 1.5)
pos = Vector3(move.X, Land.GetHeight(move.X, move.z) + 30, move.z)
model.Lookat plPos.X, plPos.Y, plPos.z
model.RotateY 90
End If
If state = "furiousEscape" Then
move = MovePoint3D(pos, plPos, 3)
pos = Vector3(move.X, Land.GetHeight(move.X, move.z) + 30, move.z)
model.Lookat plPos.X, plPos.Y, plPos.z
model.RotateY 90 'required to make it look in proper direction
End If
If state = "attackPlayer" Then
move = MovePoint3D(pos, target, 3)
pos = Vector3(move.X, Land.GetHeight(move.X, move.z) + 45, move.z)
model.Lookat target.X, target.Y, target.z
model.RotateY 90
End If
If state = "dead_anim1" Then 'dissappear animation
model.RotateY 0.05 * TV.TimeElapsed
pos.Y = pos.Y + 0.02 * TV.TimeElapsed
End If
If state = "dead_anim2" Then 'dissappear animation
model.RotateY 0.05 * TV.TimeElapsed
pos.Y = pos.Y + 1 * TV.TimeElapsed
End If
'Zombie check [from minor checks]
If state = "attackPlayer" Then
If tmpDist < 130 And model.GetKeyFrame > 25 Then 'attackDist suggestion for harder levels
hudEffects.Flash 0.5, 0, 0, 500 'HUDEFFECT TEST
plSFX(0).Stop_
plSFX(0).Play
Add_plBlood plPos
plHealth = plHealth - Round((130 - tmpDist) / 4)
model.Lookat plPos.X, plPos.Y, plPos.z
model.RotateY 90
model.SetAnimationByName "idle"
model.PlayAnimation 20
model.SetAnimationLoop True
wait = TV.TickCount
state = "attackedPlayer"
ElseIf tmpDist < 200 And model.GetKeyFrame > 30 Then
model.Lookat plPos.X, plPos.Y, plPos.z
model.RotateY 90
model.SetAnimationByName "jump"
model.PlayAnimation 40
model.SetAnimationLoop False
state = "wait"
ElseIf 200 < tmpDist And model.GetKeyFrame > 30 Then
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
If state = "flinch" And model.GetKeyFrame > 10 Then
model.SetAnimationByName "run"
model.PlayAnimation 20
model.SetAnimationLoop True
state = "seenPlayer"
End If
If state = "dead" And TV.TickCount - wait > 3000 Then
model.SetAnimationByName "deadback"
model.ShowBoundingBox True
wait = TV.TickCount
state = "dead_anim1"
End If
If state = "dead_anim1" And TV.TickCount - wait > 5000 Then
wait = TV.TickCount
state = "dead_anim2"
End If
If state = "dead_anim2" And TV.TickCount - wait > 1000 Then
lvlKilled = lvlKilled + 1
clear
state = "disabled"
Exit Sub
End If
setPos:
model.SetPosition pos.X, pos.Y, pos.z
For i = 0 To 3
sfx(i).SetPosition pos.X / 100, pos.Y / 100, pos.z / 100
Next
End Sub
Public Sub Hit(dist As Integer, range As Integer)

If Mid(state, 1, 4) <> "dead" And state <> "flinch" Then

If dist <> 0 And dist < range Then 'if zb is not hit why bother ?
Add_zbBlood pos
health = health - Int((1200 - range) / 30) 'max distance 1000
Death

'Furious when shot
If state = "idle" Then
model.SetAnimationByName "run2"
model.PlayAnimation 40
model.SetAnimationLoop True
sfx(0).Play
state = "furiousEscape"
End If
End If

End If
End Sub
Public Sub Death()
If health > 5 Then
If health Mod 10 < 4 Then
model.SetAnimationByName "headshot"
model.PlayAnimation 40
model.SetAnimationLoop False
hudEffects.StopFlash
sfx(1).Stop_
sfx(2).Play
state = "flinch"
End If
ElseIf health > 4 Then
model.SetAnimationByName "die_simple"
model.PlayAnimation 30
model.SetAnimationLoop False
sfx(3).Play
hudEffects.StopFlash 'otherwise if he dies when flash is on it wont turn off
wait = TV.TickCount
state = "dead"
Else
model.SetAnimationByName "die_spin"
model.PlayAnimation 30
model.SetAnimationLoop False
sfx(3).Play
hudEffects.StopFlash
wait = TV.TickCount
state = "dead"
End If
End Sub
Public Sub back_off()
'Let zombie lose interest when another is after the prey
speed = 0.05
wait = TV.TickCount
state = "lackInterest"
End Sub
Public Sub render()
model.render
End Sub
Public Sub clear()
Set model = Nothing
Set coll = Nothing
For i = 0 To 3
Set sfx(i) = Nothing
Next
End Sub
