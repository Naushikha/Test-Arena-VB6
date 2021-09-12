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
Private Sub Form_Load()
Initialize_EngineCore
End Sub
Private Sub Form_Unload(Cancel As Integer)
DoLoop = False
End Sub


