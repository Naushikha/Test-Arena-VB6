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

Private i As Integer
Public Sub Initialize_EngineCore()
'initialize
    Set TV = New TVEngine
    TV.Initialize frmTest.hWnd
    TV.DisplayFPS = True
    TV.SetAngleSystem TV_ANGLE_DEGREE
    TV.SetSearchDirectory App.Path
    
    'TV.ShowWinCursor False 'WARNING CURSOR
    Initialize_HUD
    Set TexFactory = New TVTextureFactory
    Set InputEngine = New TVInputEngine
    Set Scene = New TVScene
    Set Atmosphere = New TVAtmosphere
    Set Land = New TVLandscape
    
    Load_Files
    Initialize_Sound 'Should come before loading sounds !
    Initialize_Player
    Initialize_Zombies
    frmTest.Show
    
    Scene.SetViewFrustum 80, 1000
    Main_Loop
End Sub
Public Sub Load_Files()
    With TexFactory
        .LoadTexture "snow.bmp", "terrain"
        .LoadTexture "Top.jpg", "Top"
        .LoadTexture "Bottom.jpg", "Bottom"
        .LoadTexture "Left.jpg", "Left"
        .LoadTexture "Right.jpg", "Right"
        .LoadTexture "Front.jpg", "Front"
        .LoadTexture "Back.jpg", "Back"
        .LoadTexture "crosshair.bmp", "Cross", , , TV_COLORKEY_BLACK
    End With
    
    Atmosphere.SkyBox_SetTexture GetTex("Front"), GetTex("Back"), GetTex("Left"), GetTex("Right"), GetTex("Top"), GetTex("Bottom")
    Atmosphere.SkyBox_SetDistance 5
    Atmosphere.SkyBox_Enable True
    Atmosphere.Fog_SetColor 0.01, 0.01, 0.01, 2
    Atmosphere.Fog_SetParameters 1, 1000, 0.003
    'Atmosphere.Fog_Enable True
    
    Land.SetFactorY 2
    Land.GenerateHugeTerrain "height.jpg", TV_PRECISION_AVERAGE, 8, 8, 0, 0, True
    Land.SetTexture GetTex("terrain")
    Land.SetTextureScale 1, 1
    
    hudFont.LoadXML "nghthwk.xml"
    hudFont.textureid = TexFactory.LoadTexture(hudFont.Location, , , , hudFont.Colorkey, False)
    
End Sub
Public Sub Render_Objects()
    TV.clear 'Clear previous frame

    Atmosphere.Atmosphere_Render
    Land.render
    Scene.RenderAllMeshes
    Weapon(wpNo).render
    For i = 0 To zbMax
        Zombie(i).render
    Next
    'HUD
    Screen2d.ACTION_Begin2D
    Screen2d.DRAW_Texture GetTex("Cross"), chX1, chY1, chX2, chY2, , , , , 0.2, 0, 0.4, 0.2
    Screen2d.DRAW_TextureText hudHealX, hudHealY, hudFont, plHealth & "@", 1, 1, 1, 2, 0, TV_TEXT_DIRECTION_LEFTRIGHT
    Screen2d.DRAW_TextureText hudAmmoX, hudAmmoY, hudFont, Weapon(wpNo).mags & " - " & Weapon(wpNo).bull, 1.2, 1.2, 1, 2, 0, TV_TEXT_DIRECTION_LEFTRIGHT
    Screen2d.ACTION_End2D
    
    TV.RenderToScreen 'Draw new frame
End Sub
Public Sub Main_Loop()
    DoLoop = True
    Do
    DoEvents
    Check_Input
    Check_Movement
    Weapon(wpNo).Update
    For i = 0 To zbMax
        If Zombie(i).state <> "dead" Then
        Zombie(i).AI
        End If
    Next
    Render_Objects
    Loop Until DoLoop = False
    Main_Quit
End Sub
Public Sub Main_Quit()
    TV.ShowWinCursor True 'WARNING CURSOR
    Sound_Clear
    Set hudFont = Nothing
    Set Screen2d = Nothing

    For i = 0 To zbMax
    Zombie(i).clear
    Set Zombie(i) = Nothing
    Next

    For i = 0 To wpMax
    Weapon(i).clear
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
