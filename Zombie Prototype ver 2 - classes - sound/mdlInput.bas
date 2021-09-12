Attribute VB_Name = "mdlInput"
Option Explicit
Public InputEngine As TVInputEngine

Public tmpMouseX As Long, tmpMouseY As Long
Public tmpMouseB1 As Integer, tmpMouseB2 As Integer, tmpMouseB3 As Integer
Public tmpMouseScrollOld As Long, tmpMouseScrollNew As Long
Public Sub Check_Input()
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
        Weapon(wpNo).Fire
        End If
        
        If plState <> "weapChange" Then 'Don't want to change weapons in the middle of changing weapons huh !
        Select Case tmpMouseScrollNew
        Case Is > tmpMouseScrollOld
        If wpNo = wpMax Then
        wpNo = 0
        Else
        wpNo = wpNo + 1
        End If
        Weapon(wpNo).Change
        Case Is < tmpMouseScrollOld
        If wpNo = 0 Then
        wpNo = wpMax
        Else
        wpNo = wpNo - 1
        End If
        Weapon(wpNo).Change
        End Select
        End If


        plAngleX = plAngleX - (tmpMouseY * 0.001 * TV.TimeElapsed)
        plAngleY = plAngleY - (tmpMouseX * 0.001 * TV.TimeElapsed)
End Sub
