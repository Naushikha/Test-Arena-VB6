VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsWeapon"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
'Weapons
Private model As TVActor2 'WARNING edit to add more weapons
Private sfx(3) As TVSoundWaveStereo
Private anim() As String
Private ammo() As String  'contains fire mode, range, mags & bullets
Private crossHairData() As String 'contains size,x1,z1,x2,z2
'current available ammo
Public mags As Integer
Public bull As Integer
Private i As Integer
Private clipIn As Boolean
Private coll As TVCollisionResult
Public Sub Load(gun As String)
Set model = New TVActor2
model.Load "Models\" & gun & ".mdl"
model.SetScale 0.5, 0.5, 0.5 'good scale for cs 1.6 models
    Dim tmpLine As String
    Dim tmpFile As Integer
    tmpFile = FreeFile
    Open App.Path & "\Data\Models\" & gun & ".txt" For Input As #tmpFile
    Line Input #tmpFile, tmpLine
    ammo = Split(tmpLine, ",")
    Line Input #tmpFile, tmpLine
    anim = Split(tmpLine, ",")
    Line Input #tmpFile, tmpLine
    crossHairData = Split(tmpLine, ",")
    Close #tmpFile
    mags = Int(ammo(2))
    bull = Int(ammo(3))
For i = 0 To 3 ' probably best if we had a count of sounds
Set sfx(i) = New TVSoundWaveStereo
Next
sfx(0).Load "SFX\" & gun & "_change.wav"
sfx(1).Load "SFX\" & gun & "_fire.wav"
sfx(2).Load "SFX\" & gun & "_reload1.wav"
sfx(3).Load "SFX\" & gun & "_reload2.wav"
For i = 0 To 3
sfx(i).Volume = -1500
Next
End Sub
'!!!Active process
Public Sub Update()

    model.SetPosition plPos.x, plPos.y, plPos.z
    model.SetRotation 0, (180 - Rad2Deg(plAngleY)), -Rad2Deg(plAngleX)
    'This block deals with testing action completion(mainly)
    'Weapon check[from minor checks
    If plState = "weapChange" And model.IsAnimationFinished = True Then
    'Change crosshair
    chX1 = scrWidth / 2 - Int(crossHairData(0)): chY1 = scrHeight / 2 - Int(crossHairData(0)): chX2 = scrWidth / 2 + Int(crossHairData(0)): chY2 = scrHeight / 2 + Int(crossHairData(0))
    chDX1 = CSng(crossHairData(1)): chDZ1 = CSng(crossHairData(2)): chDX2 = CSng(crossHairData(3)): chDZ2 = CSng(crossHairData(4))
    
    model.SetAnimationByName anim(1)
    model.PlayAnimation 45
    model.SetAnimationLoop True
    plState = "idle"
    End If
    If plState = "reload" Then
    If clipIn = False And model.GetKeyFrame > 25 Then
    sfx(3).Play
    clipIn = True
    ElseIf model.IsAnimationFinished = True Then
    bull = Int(ammo(3))
    mags = mags - 1
    model.SetAnimationByName anim(1)
    model.PlayAnimation 45
    model.SetAnimationLoop True
    plState = "idle"
    End If
    End If
    If plState = "fire" And model.IsAnimationFinished = True Then
    model.SetAnimationByName anim(1)
    model.PlayAnimation 45
    model.SetAnimationLoop True
    plState = "idle"
    End If
    If plState = "rapidFire" And model.GetKeyFrame > 3 Then
    model.SetAnimationByName anim(1)
    model.PlayAnimation 45
    model.SetAnimationLoop True
    plState = "idle"
    End If
End Sub
Public Sub Change()
'Crosshair none during change
chDX1 = 0: chDZ1 = 0: chDX2 = 0: chDZ2 = 0
model.SetAnimationByName anim(0)
model.PlayAnimation 45
model.SetAnimationLoop False
sfx(0).Play
plState = "weapChange"
End Sub
Public Sub Fire()
'Check ammo of current weapon if not enough reload or change weapon
If plState = "idle" Then
If mags = 0 And bull = 0 Then
'change weapon
If wpNo < wpMax Then
wpNo = wpNo + 1
Else
wpNo = 0
End If
Weapon(wpNo).Change 'WOW SPENT A LOT OF TIME FIGURING THIS ONE OUT !!! SLOW AND STEADY :) :D
ElseIf bull = 0 Then
'reload
model.SetAnimationByName anim(3)
model.PlayAnimation 45
model.SetAnimationLoop False
sfx(2).Play
clipIn = False
plState = "reload"
Else
'shoot
If ammo(0) = "Slow" Then
    bull = bull - 1
    model.SetAnimationByName anim(2)
    model.PlayAnimation 45
    model.SetAnimationLoop False
    plState = "fire"
End If
If ammo(0) = "Rapid" Then
    bull = bull - 1
    model.SetAnimationByName anim(2)
    model.PlayAnimation 45
    model.SetAnimationLoop False
    plState = "rapidFire"
End If
'Hit zombie ?
Set coll = Scene.MousePicking(chMX, chMY, TV_COLLIDE_ACTOR2, TV_TESTTYPE_MDL_HITBOXES)
Dim zbIdHit As Integer
zbIdHit = Int(Mid(coll.GetCollisionActor2.GetName, 7, Len(coll.GetCollisionActor2.GetName))) ' 7 because "entity"_

If zbIdStart < zbIdHit And zbIdHit < zbIdEnd Then
Zombie(zbIdHit - zbIdStart - 1).Hit Int(coll.GetCollisionDistance), Int(ammo(1))
End If

'Sound
sfx(1).Stop_
sfx(1).Play
End If
End If
End Sub
Public Sub reset_ammo()
    mags = Int(ammo(2))
    bull = Int(ammo(3))
End Sub
Public Sub show_box()
model.Enable False
End Sub
Public Sub render()
model.render
End Sub
Public Sub clear()
Set model = Nothing
For i = 0 To 3 ' probably best if we had a count of sounds
Set sfx(i) = Nothing
Next
End Sub

