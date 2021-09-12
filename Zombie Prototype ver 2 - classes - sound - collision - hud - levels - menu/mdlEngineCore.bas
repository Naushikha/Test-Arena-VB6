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
Public Sub EngineCore_Initialize()
'initialize
    Set TV = New TVEngine
    TV.Initialize frmTest.hWnd
    TV.DisplayFPS = True
    TV.SetAngleSystem TV_ANGLE_DEGREE
    TV.SetSearchDirectory App.Path & "\Data"
    
    TV.ShowWinCursor False 'WARNING CURSOR
    
    Set TexFactory = New TVTextureFactory
    Set InputEngine = New TVInputEngine
    Set Scene = New TVScene
    Set Atmosphere = New TVAtmosphere
    Set Land = New TVLandscape
    
    Load_Files
    Sound_Initialize 'Should come before loading sounds !
    HUD_Initialize
    Player_Initialize
    lvlNo = 1
    Level_Begin 'Zombies_Initialize
    frmTest.WindowState = 2
    
    Scene.SetViewFrustum 80, 2000
    Main_Loop
End Sub
Public Sub Load_Files()
    With TexFactory
        .LoadTexture "GFX\snow.bmp", "terrain"
        .LoadTexture "GFX\Top.jpg", "Top"
        .LoadTexture "GFX\Bottom.jpg", "Bottom"
        .LoadTexture "GFX\Left.jpg", "Left"
        .LoadTexture "GFX\Right.jpg", "Right"
        .LoadTexture "GFX\Front.jpg", "Front"
        .LoadTexture "GFX\Back.jpg", "Back"
        .LoadTexture "GFX\virtual.jpg", "virtual"
        .LoadTexture "GFX\crosshair.bmp", "Cross", , , TV_COLORKEY_BLACK
        .LoadTexture "GFX\pl_blood.bmp", "plBlood", , , TV_COLORKEY_BLACK
        .LoadTexture "GFX\zb_blood1.bmp", "zbBlood1", , , TV_COLORKEY_BLACK
        .LoadTexture "GFX\zb_blood2.bmp", "zbBlood2", , , TV_COLORKEY_BLACK
        .LoadTexture "GFX\zb_blood2.bmp", "zbBlood3", , , TV_COLORKEY_BLACK
    End With
    
    Atmosphere.SkyBox_SetTexture GetTex("Front"), GetTex("Back"), GetTex("Left"), GetTex("Right"), GetTex("Top"), GetTex("Bottom")
    Atmosphere.SkyBox_SetDistance 5
    Atmosphere.SkyBox_Enable True
    Atmosphere.Fog_SetColor 0.01, 0.01, 0.01, 2
    Atmosphere.Fog_SetParameters 1, 1000, 0.006
    Atmosphere.Fog_Enable True
    
    
    Land.SetFactorY 2
    Land.GenerateHugeTerrain "GFX\height.jpg", TV_PRECISION_AVERAGE, 8, 8, 0, 0, True
    Land.SetTexture GetTex("terrain")
    Land.SetTextureScale 1, 1
    
    
End Sub
Public Sub Render_Objects()
    TV.clear 'Clear previous frame

    Atmosphere.Atmosphere_Render
    Land.render
    Scene.RenderAllMeshes
    Weapon(wpNo).render
    For i = 0 To lvlZbs
        If Zombie(i).state <> "disabled" Then
        Zombie(i).render
        End If
    Next
    'HUD
    HUD_Render
    
    TV.RenderToScreen 'Draw new frame
End Sub
Public Sub Main_Loop()
    DoLoop = True
    Do
    DoEvents
    Check_Input
    Check_Movement
    Weapon(wpNo).Update
    For i = 0 To lvlZbs
        If Zombie(i).state <> "disabled" Then
        Zombie(i).AI
        End If
    Next
    Zombie_Collision
    Level_Check 'to see if player has completed level
    Render_Objects
    Loop Until DoLoop = False
    Main_Quit
    
End Sub
Public Sub Main_Quit()
    TV.ShowWinCursor True 'WARNING CURSOR
    Sound_Clear
    HUD_Clear

    For i = 0 To lvlZbs
    Zombie(i).clear
    Set Zombie(i) = Nothing
    Next
    Player_Clear
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
End Sub
