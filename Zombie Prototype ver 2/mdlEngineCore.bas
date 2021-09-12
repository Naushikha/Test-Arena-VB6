Attribute VB_Name = "mdlEngineCore"
Option Explicit
'TVEngine
Public TV As TVEngine
Public Scene As TVScene
Public TexFactory As TVTextureFactory

'Environment
Public Land As TVLandscape ' For now placed in the engine core as a seperate module is not required
Public Atmosphere As TVAtmosphere

Public DoLoop As Boolean
Public Sub Initialize_EngineCore()
'initialize
    Set TV = New TVEngine
    TV.Initialize frmTest.hWnd
    TV.DisplayFPS = True
    TV.SetAngleSystem TV_ANGLE_DEGREE
    TV.SetSearchDirectory App.Path
    TV.ShowWinCursor False 'WARNING CURSOR
    Initialize_HUD
    Set TexFactory = New TVTextureFactory
    Set InputEngine = New TVInputEngine
    Set Scene = New TVScene
    Set Atmosphere = New TVAtmosphere
    Set Land = New TVLandscape
    
    Load_Files
    Initialize_Player
    frmTest.Show
    
    Scene.SetViewFrustum 80, 1000
    
    Main_Loop
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
    
    hudFont.LoadXML "nghthwk.xml"
    hudFont.textureid = TexFactory.LoadTexture(hudFont.Location, , , , hudFont.Colorkey, False)
    
    Dim i As Integer
    For i = 0 To wpMax
    Set Weapon(i) = New TVActor2
    Next
    Set Zombie = New TVActor2
    
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

End Sub
Public Sub Render_Objects()
    TV.Clear 'Clear previous frame

    Atmosphere.Atmosphere_Render
    Land.Render
    Scene.RenderAllMeshes
    Weapon(wpNo).Render
    Zombie.Render
    'HUD
    Screen2d.ACTION_Begin2D
    Screen2d.DRAW_Texture GetTex("Cross"), chX1, chY1, chX2, chY2, , , , , 0.2, 0, 0.4, 0.2
    Screen2d.DRAW_TextureText hudHealX, hudHealY, hudFont, plHealth & "@", 1, 1, 1, 2, 0, TV_TEXT_DIRECTION_LEFTRIGHT
    Screen2d.DRAW_TextureText hudAmmoX, hudAmmoY, hudFont, wpAmmo(wpNo).mags & " - " & wpAmmo(wpNo).bull, 1.2, 1.2, 1, 2, 0, TV_TEXT_DIRECTION_LEFTRIGHT
    Screen2d.ACTION_End2D
    
    TV.RenderToScreen 'Draw new frame
End Sub
Public Sub Main_Loop()
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
Public Sub Main_Quit()
    TV.ShowWinCursor True 'WARNING CURSOR

    Set hudFont = Nothing
    Set Screen2d = Nothing

    Set Zombie = Nothing

    Dim i As Integer
    For i = 0 To wpMax
    Set Weapon(i) = Nothing
    Next
    
    Set Land = Nothing
    Set Atmosphere = Nothing
    
    Set InputEngine = Nothing
    Set TexFactory = Nothing
    Set Scene = Nothing
    Set TV = Nothing
    
    End
    
End Sub
