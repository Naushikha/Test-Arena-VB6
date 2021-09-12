VERSION 5.00
Begin VB.Form frmTest 
   BackColor       =   &H00000000&
   BorderStyle     =   0  'None
   Caption         =   "Test FPS"
   ClientHeight    =   11340
   ClientLeft      =   2595
   ClientTop       =   2340
   ClientWidth     =   14595
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   756
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   973
   ShowInTaskbar   =   0   'False
End
Attribute VB_Name = "frmTest"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Load()
Dim tmpLine As String
Dim tmpFile As Integer
Dim tmpStrInt() As String
tmpFile = FreeFile
Open App.Path + "\Data\game_data.txt" For Input As #tmpFile
Line Input #tmpFile, tmpLine
tmpStrInt = Split(tmpLine, ",")
Line Input #tmpFile, tmpLine
plDifficulty = Int(tmpLine)
Close #1
frmTest.Width = Screen.TwipsPerPixelX * Int(tmpStrInt(0))
frmTest.Height = Screen.TwipsPerPixelY * Int(tmpStrInt(1))

EngineCore_Initialize
End Sub

Private Sub Form_Unload(Cancel As Integer)
DoLoop = False
End Sub

