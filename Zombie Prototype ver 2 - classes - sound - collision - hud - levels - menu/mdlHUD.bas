Attribute VB_Name = "mdlHUD"
Option Explicit
Public Screen2d As TVScreen2DImmediate
Public hudEffects As TVGraphicEffect
Public hudText As TVScreen2DText
Public hudFont As TVBitmapParts
Public lvlSFX(3) As TVSoundWaveStereo
Public chX1, chY1, chX2, chY2, chMX, chMY, scrHeight, scrWidth, hudHealX, hudHealY, hudAmmoX, hudAmmoY, hudKilledX, hudKilledY As Integer
Public chDX1, chDZ1, chDX2, chDZ2 As Single 'i don't know why i named these this way xD. it's used to find the points on the crosshair file
Public escapeWait As Long
Public hudLvlWait As Long
Public Sub HUD_Initialize()
    scrHeight = frmTest.ScaleHeight
    scrWidth = frmTest.ScaleWidth
    chMX = scrWidth / 2
    chMY = scrHeight / 2
    hudHealX = scrWidth * 0.85
    hudHealY = scrHeight * 0.01
    hudAmmoX = scrWidth * 0.01
    hudAmmoY = scrHeight * 0.01
    hudKilledX = scrWidth * 0.4
    hudKilledY = scrHeight * 0.01
    
    Set Screen2d = New TVScreen2DImmediate
    Set hudFont = New TVBitmapParts
    Set hudEffects = New TVGraphicEffect
    Set hudText = New TVScreen2DText
    hudFont.LoadXML "GFX\nghthwk.xml"
    hudFont.textureid = TexFactory.LoadTexture("GFX\" & hudFont.Location, , , , hudFont.Colorkey, False)
    hudText.NormalFont_Create "escape", "Courier", 25, True, False, False
    
    Set lvlSFX(0) = New TVSoundWaveStereo
    Set lvlSFX(1) = New TVSoundWaveStereo
    Set lvlSFX(2) = New TVSoundWaveStereo
    lvlSFX(0).Load "SFX\lvl_fight.wav"
    lvlSFX(0).Volume = -1300
    lvlSFX(1).Load "SFX\lvl_clear.wav"
    lvlSFX(1).Volume = -1300
End Sub
Public Sub HUD_Render()
    Screen2d.ACTION_Begin2D
    Screen2d.DRAW_Texture GetTex("Cross"), chX1, chY1, chX2, chY2, , , , , chDX1, chDZ1, chDX2, chDZ2  '0.4, 0, 0.2, 0.2 '
    Screen2d.DRAW_TextureText hudHealX, hudHealY, hudFont, plHealth & "@", 1, 1, 1, 2, 0, TV_TEXT_DIRECTION_LEFTRIGHT
    Screen2d.DRAW_TextureText hudAmmoX, hudAmmoY, hudFont, Weapon(wpNo).mags & " - " & Weapon(wpNo).bull, 1.2, 1.2, 1, 2, 0, TV_TEXT_DIRECTION_LEFTRIGHT
    Screen2d.DRAW_TextureText hudKilledX, hudKilledY, hudFont, (lvlZbs + 1) & " # " & lvlKilled, 1.2, 1.2, 1, 2, 0, TV_TEXT_DIRECTION_LEFTRIGHT
    Screen2d.ACTION_End2D
    If TV.TickCount - escapeWait < 50 Then
    hudText.NormalFont_DrawText "T H E R E ' S  N O  E S C A P E ...", scrWidth * 0.25, scrHeight * 0.75, RGBA(1, 0, 0, 1), "escape"
    End If
    If lvlChange = True And TV.TickCount - hudLvlWait < 5000 Then '5sec
    Screen2d.DRAW_TextureText scrWidth * 0.4, scrHeight * 0.2, hudFont, "LEVEL " & lvlNo, 1.2, 1.2, 1, 2, 0, TV_TEXT_DIRECTION_LEFTRIGHT
    ElseIf lvlChange = True Then
    Atmosphere.SkyBox_SetTexture GetTex("Front"), GetTex("Back"), GetTex("Left"), GetTex("Right"), GetTex("Top"), GetTex("Bottom")
    lvlSFX(0).Play
    lvlChange = False ' this is where the level starts
    End If
    
End Sub
Public Sub HUD_Clear()
    Set hudFont = Nothing
    Set Screen2d = Nothing
    Set hudEffects = Nothing
    Set hudText = Nothing
    Set lvlSFX(0) = Nothing
    Set lvlSFX(1) = Nothing
    Set lvlSFX(2) = Nothing
End Sub
