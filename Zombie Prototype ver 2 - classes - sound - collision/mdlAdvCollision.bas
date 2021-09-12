Attribute VB_Name = "mdlAdvCollision"
Option Explicit
Private i1, i2, j As Integer
Public Sub Escape_Collision()
        If plPos.x < 20 Then
        plEscape = True
        plPos.x = 21
        ElseIf plPos.x > 2000 Then
        plEscape = True
        plPos.x = 1999
        End If
        If plPos.z < 20 Then
        plEscape = True
        plPos.z = 21
        ElseIf plPos.z > 2000 Then
        plEscape = True
        plPos.z = 1999
        End If
        If plEscape = True Then
        If ((20 < plPos.x) And (plPos.x < 2000)) And ((20 < plPos.z) And (plPos.z < 2000)) Then
        plEscape = False
        End If
        End If
End Sub
Public Sub Zombie_Collision()
        j = -1 'keeps track of no. in the array, -1 becuase arrays start with 0
        Dim zbList() As Integer
        'filter the enabled zbs and on "seenPlayer"/"furiousEscape" zbs and put them into an array
        For i1 = 0 To zbMax
        If Zombie(i1).state = "seenPlayer" Or Zombie(i1).state = "furiousEscape" Then
        If Zombie(i1).state <> "lackInterest" Then ' Can we design a better contruct ?
        j = j + 1
        ReDim Preserve zbList(j)
        zbList(j) = i1 'this array accumulates target zombies
        End If
        End If
        Next
        For i1 = 0 To j ' zb1,zb2,zb3,zb4 <--- who need to be checked for collision
        For i2 = i1 + 1 To j ' (zb1) against ---> others
        If GetDistance2D(Zombie(zbList(i1)).GetPos.x, Zombie(zbList(i1)).GetPos.z, Zombie(zbList(i2)).GetPos.x, Zombie(zbList(i2)).GetPos.z) < 100 Then
        Zombie(zbList(i1)).back_off
        frmTest.Caption = "I Collided"
        Exit For
        End If
        Next
        Next
End Sub
