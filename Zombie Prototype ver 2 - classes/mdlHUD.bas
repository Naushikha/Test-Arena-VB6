Attribute VB_Name = "mdlHUD"
Option Explicit

Public Screen2d As TVScreen2DImmediate

Public hudFont As TVBitmapParts
Public chX1, chY1, chX2, chY2, chMX, chMY, scrHeight, scrWidth, hudHealX, hudHealY, hudAmmoX, hudAmmoY As Integer
Public Sub Initialize_HUD()
    scrHeight = frmTest.ScaleHeight
    scrWidth = frmTest.ScaleWidth
    chX1 = scrWidth / 2 - 35
    chY1 = scrHeight / 2 - 35
    chX2 = scrWidth / 2 + 35
    chY2 = scrHeight / 2 + 35
    chMX = scrWidth / 2
    chMY = scrHeight / 2
    hudHealX = scrWidth * 0.85
    hudHealY = scrHeight * 0.01
    hudAmmoX = scrWidth * 0.01
    hudAmmoY = scrHeight * 0.01
    Set Screen2d = New TVScreen2DImmediate
    Set hudFont = New TVBitmapParts
End Sub
