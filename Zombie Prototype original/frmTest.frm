VERSION 5.00
Begin VB.Form frmTest 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Test FPS"
   ClientHeight    =   11340
   ClientLeft      =   2640
   ClientTop       =   2775
   ClientWidth     =   14595
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   756
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   973
   StartUpPosition =   2  'CenterScreen
   WindowState     =   2  'Maximized
End
Attribute VB_Name = "frmTest"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private TV As TVEngine
Private Scene As TVScene
Private InputEngine As TVInputEngine
Private Screen2d As TVScreen2DImmediate

Private TexFactory As TVTextureFactory
Private Land As TVLandscape
Private Atmosphere As TVAtmosphere

Private Weapon(2) As TVActor2 'WARNING edit to add more weapons
Private Type weaponData
  anim() As String
  ammo() As String 'contains fire mode, range, mags & bullets
End Type
Private Type currentAmmo
  mags As Integer
  bull As Integer
End Type
Private wpData(2) As weaponData
Private wpAmmo(2) As currentAmmo

Private Zombie As TVActor2 'WARNING edit to add more zombies
Private zbState As String
Private zbHealth As Integer
Private zbWait As Long
Private zbPos As D3DVECTOR
Private zbMove As D3DVECTOR
Private zbTarget As D3DVECTOR


Private hudFont As TVBitmapParts

Private plPos As D3DVECTOR
Private plLook As D3DVECTOR
Private plAngleX As Single
Private plAngleY As Single
Private plWalk As Single
Private plStrafe As Single
Private plState As String
Private plHealth As String

Private tmpMouseX As Long, tmpMouseY As Long
Private tmpMouseB1 As Integer, tmpMouseB2 As Integer, tmpMouseB3 As Integer
Private tmpMouseScrollOld As Long, tmpMouseScrollNew As Long


Private DoLoop As Boolean

Private wpNo, wpMax As Integer '0 is a weapon too
Private chX1, chY1, chX2, chY2, scrHeight, scrWidth, hudHealX, hudHealY, hudAmmoX, hudAmmoY As Integer
Function MovePoint3D(Source As D3DVECTOR, Destination As D3DVECTOR, SpeedMovTm As Single) As D3DVECTOR
Dim VectorPosTm As D3DVECTOR
VectorPosTm = VNormalize(VSubtract(Destination, Source))
MovePoint3D = VAdd(Source, VScale(VectorPosTm, SpeedMovTm))
End Function
Private Sub Form_Load()
'initialize
    Set TV = New TVEngine
    TV.Initialize Me.hWnd
    TV.DisplayFPS = True
    TV.SetAngleSystem TV_ANGLE_DEGREE
    TV.SetSearchDirectory App.Path
    scrHeight = Me.ScaleHeight
    scrWidth = Me.ScaleWidth
    chX1 = scrWidth / 2 - 35
    chY1 = scrHeight / 2 - 35
    chX2 = scrWidth / 2 + 35
    chY2 = scrHeight / 2 + 35
    wpNo = 0
    wpMax = 2

    Set InputEngine = New TVInputEngine
    Set Scene = New TVScene
    Set Screen2d = New TVScreen2DImmediate
    Set Atmosphere = New TVAtmosphere
    Set TexFactory = New TVTextureFactory
    Set Land = New TVLandscape
    Dim i As Integer
    For i = 0 To wpMax
    Set Weapon(i) = New TVActor2
    Next
    Set Zombie = New TVActor2
    Set hudFont = New TVBitmapParts
    
    Load_Files
    
    Scene.SetViewFrustum 80, 1000
    TV.ShowWinCursor False 'WARNING CURSOR
    Main_Loop
End Sub
Private Sub Main_Quit()
    TV.ShowWinCursor True 'WARNING CURSOR
    Set hudFont = Nothing

    Set Zombie = Nothing

    Dim i As Integer
    For i = 0 To wpMax
    Set Weapon(i) = Nothing
    Next
    
    Set Land = Nothing
    Set Atmosphere = Nothing
    
    Set InputEngine = Nothing
    Set Screen2d = Nothing
    Set TexFactory = Nothing
    Set Scene = Nothing
    Set TV = Nothing
    End
End Sub
Private Sub Load_Files()
    With TexFactory
        .LoadTexture "snow.bmp", "terrain"
        .LoadTexture "Down.jpg", "Up"
        .LoadTexture "Left.jpg", "Left"
        .LoadTexture "Up.jpg", "Down"
        .LoadTexture "Right.jpg", "Right"
        .LoadTexture "Front.jpg", "Front"
        .LoadTexture "Back.jpg", "Back"
        .LoadTexture "crosshair.bmp", "Cross", , , TV_COLORKEY_BLACK
    End With
    
    Atmosphere.SkyBox_SetTexture GetTex("Front"), GetTex("Back"), GetTex("Left"), GetTex("Right"), GetTex("Down"), GetTex("Up")
    Atmosphere.SkyBox_SetDistance 5
    Atmosphere.SkyBox_Enable True
    
    Land.SetFactorY 2
    Land.GenerateHugeTerrain "height.jpg", TV_PRECISION_AVERAGE, 8, 8, 0, 0, True
    Land.SetTexture GetTex("terrain")
    Land.SetTextureScale 3, 3
    
    hudFont.LoadXML App.Path & "\nghthwk.xml"
    hudFont.textureid = TexFactory.LoadTexture(App.Path & "\" & hudFont.Location, , , , hudFont.Colorkey, False)
    
    Weapon(0).Load "v_knife.mdl"
    Weapon(0).SetScale 0.5, 0.5, 0.5
    
    Weapon(1).Load "v_deagle.mdl"
    Weapon(1).SetScale 0.5, 0.5, 0.5
    
    Weapon(2).Load "v_m4a1.mdl"
    Weapon(2).SetScale 0.5, 0.5, 0.5
    
    Dim tmpLine As String
    Dim tmpFile As Integer
    Dim x As Integer
    tmpFile = FreeFile
    Open "weapon_anim.txt" For Input As #tmpFile
    For x = 0 To wpMax
    Line Input #tmpFile, tmpLine
    wpData(x).anim = Split(tmpLine, ",")
    Next
    Close #tmpFile
    Open "weapon_ammo.txt" For Input As #tmpFile
    For x = 0 To wpMax
    Line Input #tmpFile, tmpLine
    wpData(x).ammo = Split(tmpLine, ",")
    Next
    Close #tmpFile
    For x = 0 To wpMax
    wpAmmo(x).mags = Int(wpData(x).ammo(2))
    wpAmmo(x).bull = Int(wpData(x).ammo(3))
    Next
    
    Zombie.Load "alien.mdl"
    Zombie.SetScale 1, 1, 1
    Zombie.SetAnimationByName "idle"
    Zombie.PlayAnimation 20
    zbPos = Vector3(900, Land.GetHeight(900, 900) + 35, 900)
    zbHealth = 100
    zbState = "idle"
    
    plPos = Vector3(500, 0, 500)
    plLook = Vector3(0, 20, 50)
    plAngleX = 0
    plAngleY = 0
    plWalk = 0
    plStrafe = 0
    plHealth = 100
    plState = "joined"
    
    hudHealX = scrWidth * 0.85
    hudHealY = scrHeight * 0.01
    hudAmmoX = scrWidth * 0.01
    hudAmmoY = scrHeight * 0.01
    
    Me.Show
End Sub
Private Sub Main_Loop()
    DoLoop = True
    Do
    DoEvents
    Check_Input
    Check_Movement
    Update_Weapon
    If zbState <> "dead" Then
    Zombie_AI
    End If
    Minor_Checks
    Render_Objects
    Loop Until DoLoop = False
    Main_Quit
End Sub
Private Sub Check_Input()
        If InputEngine.IsKeyPressed(TV_KEY_W) = True Then
            If InputEngine.IsKeyPressed(TV_KEY_LEFTSHIFT) = True Then
                plWalk = 2
            Else
                plWalk = 1
            End If
        ElseIf InputEngine.IsKeyPressed(TV_KEY_S) = True Then
            plWalk = -1
        End If
        If InputEngine.IsKeyPressed(TV_KEY_A) = True Then
            plStrafe = 1
        ElseIf InputEngine.IsKeyPressed(TV_KEY_D) = True Then
            plStrafe = -1
        End If
        If InputEngine.IsKeyPressed(TV_KEY_ESCAPE) = True Then
            DoLoop = False
        End If
            
        tmpMouseScrollOld = tmpMouseScrollNew
        InputEngine.GetMouseState tmpMouseX, tmpMouseY, tmpMouseB1, tmpMouseB2, tmpMouseB3, tmpMouseScrollNew
        
        If tmpMouseB1 <> 0 Then
        Fire_Weapon
        End If
        
        Select Case tmpMouseScrollNew
        Case Is > tmpMouseScrollOld
        If wpNo = wpMax Then
        wpNo = 0
        Else
        wpNo = wpNo + 1
        End If
        Change_Weapon
        Case Is < tmpMouseScrollOld
        If wpNo = 0 Then
        wpNo = wpMax
        Else
        wpNo = wpNo - 1
        End If
        Change_Weapon
        End Select


        plAngleX = plAngleX - (tmpMouseY * 0.001 * TV.TimeElapsed)
        plAngleY = plAngleY - (tmpMouseX * 0.001 * TV.TimeElapsed)
End Sub

Private Sub Check_Movement()
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
Private Sub Update_Weapon()
    Weapon(wpNo).SetPosition plPos.x, plPos.y, plPos.z
    Weapon(wpNo).SetRotation 0, (180 - Rad2Deg(plAngleY)), -Rad2Deg(plAngleX)
End Sub
Private Sub Change_Weapon()
Weapon(wpNo).SetAnimationByName wpData(wpNo).anim(0)
Weapon(wpNo).PlayAnimation 30
Weapon(wpNo).SetAnimationLoop False
plState = "weapChange"
End Sub
Private Sub Fire_Weapon()
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
Private Sub Minor_Checks()
'This block deals with testing action completion(mainly)
'Weapon check
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
'Zombie check
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
End Sub
Private Sub Render_Objects()
    TV.Clear

    Atmosphere.Atmosphere_Render
    Land.Render
    Scene.RenderAllMeshes
    Weapon(wpNo).Render
    Zombie.Render
    Screen2d.ACTION_Begin2D
    Screen2d.DRAW_Texture GetTex("Cross"), chX1, chY1, chX2, chY2, , , , , 0.2, 0, 0.4, 0.2
    Screen2d.DRAW_TextureText hudHealX, hudHealY, hudFont, plHealth & "@", 1, 1, 1, 2, 0, TV_TEXT_DIRECTION_LEFTRIGHT
    Screen2d.DRAW_TextureText hudAmmoX, hudAmmoY, hudFont, wpAmmo(wpNo).mags & " - " & wpAmmo(wpNo).bull, 1.2, 1.2, 1, 2, 0, TV_TEXT_DIRECTION_LEFTRIGHT
    Screen2d.ACTION_End2D
    
    TV.RenderToScreen
End Sub
Private Sub Form_Unload(Cancel As Integer)
DoLoop = False
End Sub

