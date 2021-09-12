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

Private anim() As String
Private ammo() As String  'contains fire mode, range, mags & bullets
'current available ammo
Public mags As Integer
Public bull As Integer
Private i As Integer
Public Sub Load(gun As String)
Set model = New TVActor2
model.Load gun & ".mdl"
model.SetScale 0.5, 0.5, 0.5 'good scale for cs 1.6 models
    Dim tmpLine As String
    Dim tmpFile As Integer
    tmpFile = FreeFile
    Open gun & ".txt" For Input As #tmpFile
    Line Input #tmpFile, tmpLine
    ammo = Split(tmpLine, ",")
    Line Input #tmpFile, tmpLine
    anim = Split(tmpLine, ",")
    Close #tmpFile
    mags = Int(ammo(2))
    bull = Int(ammo(3))
End Sub
'!!!Active process
Public Sub Update()
    model.SetPosition plPos.x, plPos.y, plPos.z
    model.SetRotation 0, (180 - Rad2Deg(plAngleY)), -Rad2Deg(plAngleX)
    'This block deals with testing action completion(mainly)
    'Weapon check[from minor checks
    If plState = "weapChange" And model.IsAnimationFinished = True Then
    model.SetAnimationByName anim(1)
    model.PlayAnimation 30
    model.SetAnimationLoop True
    plState = "idle"
    End If
    If plState = "reload" And model.IsAnimationFinished = True Then
    bull = ammo(3)
    mags = mags - 1
    model.SetAnimationByName anim(1)
    model.PlayAnimation 30
    model.SetAnimationLoop True
    plState = "idle"
    End If
    If plState = "fire" And model.IsAnimationFinished = True Then
    model.SetAnimationByName anim(1)
    model.PlayAnimation 30
    model.SetAnimationLoop True
    plState = "idle"
    End If
    If plState = "rapidFire" And model.GetKeyFrame > 2 Then
    model.SetAnimationByName anim(1)
    model.PlayAnimation 30
    model.SetAnimationLoop True
    plState = "idle"
    End If
End Sub
Public Sub Change()
model.SetAnimationByName anim(0)
model.PlayAnimation 30
model.SetAnimationLoop False
plState = "weapChange"
End Sub
Public Sub Fire()
'Check ammo of current weapon if not enough reload or change weapon
If mags = 0 And bull = 0 Then
'change weapon
If wpNo < wpMax Then
wpNo = wpNo + 1
Else
wpNo = 0
End If
Change
ElseIf bull = 0 And plState <> "reload" Then
'reload
model.SetAnimationByName anim(3)
model.PlayAnimation 30
model.SetAnimationLoop False
plState = "reload"
ElseIf plState = "idle" Then
'shoot
If ammo(0) = "Slow" Then
    bull = bull - 1
    model.SetAnimationByName anim(2)
    model.PlayAnimation 60
    model.SetAnimationLoop False
    plState = "fire"
End If
If ammo(0) = "Rapid" Then
    bull = bull - 1
    model.SetAnimationByName anim(2)
    model.PlayAnimation 35
    model.SetAnimationLoop False
    plState = "rapidFire"
End If
'Test
For i = 0 To zbMax
Zombie(i).Hit ammo(1)
Next

End If
End Sub
Public Sub render()
model.render
End Sub
Public Sub clear()
Set model = Nothing
End Sub

