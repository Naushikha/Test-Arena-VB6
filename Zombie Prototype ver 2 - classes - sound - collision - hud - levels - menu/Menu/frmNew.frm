VERSION 5.00
Begin VB.Form frmNew 
   BackColor       =   &H00000000&
   BorderStyle     =   0  'None
   Caption         =   "Settings"
   ClientHeight    =   5370
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   5940
   LinkTopic       =   "Form1"
   ScaleHeight     =   5370
   ScaleWidth      =   5940
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.OptionButton opt5 
      BackColor       =   &H00000000&
      Caption         =   "God"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   375
      Left            =   840
      TabIndex        =   8
      Top             =   3600
      Width           =   3255
   End
   Begin VB.OptionButton opt4 
      BackColor       =   &H00000000&
      Caption         =   "Pro"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   375
      Left            =   840
      TabIndex        =   7
      Top             =   3120
      Width           =   3255
   End
   Begin VB.OptionButton opt2 
      BackColor       =   &H00000000&
      Caption         =   "N00b"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   375
      Left            =   840
      TabIndex        =   4
      Top             =   2160
      Width           =   3255
   End
   Begin VB.OptionButton opt3 
      BackColor       =   &H00000000&
      Caption         =   "Moderate"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   375
      Left            =   840
      TabIndex        =   3
      Top             =   2640
      Width           =   3255
   End
   Begin VB.OptionButton opt1 
      BackColor       =   &H00000000&
      Caption         =   "Just born"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   375
      Left            =   840
      TabIndex        =   1
      Top             =   1680
      Width           =   3255
   End
   Begin VB.Label lbldes 
      BackStyle       =   0  'Transparent
      Caption         =   "  "
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   615
      Left            =   0
      TabIndex        =   9
      Top             =   4080
      Width           =   6255
   End
   Begin VB.Label lblcan 
      BackStyle       =   0  'Transparent
      Caption         =   "< Back"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   24
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   975
      Left            =   4200
      TabIndex        =   6
      Top             =   4680
      Width           =   2655
   End
   Begin VB.Label lblapp 
      BackStyle       =   0  'Transparent
      Caption         =   "Play !"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   24
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   975
      Left            =   120
      TabIndex        =   5
      Top             =   4680
      Width           =   2655
   End
   Begin VB.Label lbl1 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Caption         =   "  Difficulty"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   18
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   615
      Left            =   -240
      TabIndex        =   2
      Top             =   840
      Width           =   6255
   End
   Begin VB.Label lblSet 
      BackStyle       =   0  'Transparent
      Caption         =   "Play"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   24
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   975
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   4815
   End
End
Attribute VB_Name = "frmNew"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
lbldes.Caption = ""
lblapp.ForeColor = vbWhite
lblcan.ForeColor = vbWhite
End Sub
Private Sub lblapp_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
lblapp.ForeColor = vbGreen
End Sub
Private Sub lblcan_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
lblcan.ForeColor = vbGreen
End Sub
Private Sub opt1_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
lbldes.Caption = "Grandmas and babies choose this."
End Sub
Private Sub opt2_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
lbldes.Caption = "Go ahead you'll learn something new."
End Sub
Private Sub opt3_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
lbldes.Caption = "The average joe."
End Sub
Private Sub opt4_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
lbldes.Caption = "This is gonna be fun."
End Sub
Private Sub opt5_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
lbldes.Caption = "If you are one, you'll survive... maybe."
End Sub
Private Sub opt1_Click()
opt1.ForeColor = vbGreen
opt2.ForeColor = vbWhite
opt3.ForeColor = vbWhite
opt4.ForeColor = vbWhite
opt5.ForeColor = vbWhite
zbHealth = 20
End Sub
Private Sub opt2_Click()
opt2.ForeColor = vbGreen
opt3.ForeColor = vbWhite
opt4.ForeColor = vbWhite
opt5.ForeColor = vbWhite
opt1.ForeColor = vbWhite
zbHealth = 50
End Sub
Private Sub opt3_Click()
opt3.ForeColor = vbGreen
opt4.ForeColor = vbWhite
opt5.ForeColor = vbWhite
opt1.ForeColor = vbWhite
opt2.ForeColor = vbWhite
zbHealth = 100
End Sub
Private Sub opt4_Click()
opt4.ForeColor = vbGreen
opt5.ForeColor = vbWhite
opt1.ForeColor = vbWhite
opt2.ForeColor = vbWhite
opt3.ForeColor = vbWhite
zbHealth = 170
End Sub
Private Sub opt5_Click()
opt5.ForeColor = vbGreen
opt1.ForeColor = vbWhite
opt2.ForeColor = vbWhite
opt3.ForeColor = vbWhite
opt4.ForeColor = vbWhite
zbHealth = 300
End Sub
Private Sub lblapp_Click()
Dim tmpFile As Integer
tmpFile = FreeFile
If resChange = False Then
Open App.Path & "\Data\game_data.txt" For Input As #tmpFile
Line Input #tmpFile, tmpLine
tmparr = Split(tmpLine, ",")
resWidth = Int(tmparr(0))
resHeight = Int(tmparr(1))
Close #tmpFile
End If
Open App.Path & "\Data\game_data.txt" For Output As #tmpFile
Print #tmpFile, resWidth & "," & resHeight
Print #tmpFile, zbHealth
Close #tmpFile
Shell App.Path & "\TestArena.exe", vbNormalFocus
End
End Sub
Private Sub lblcan_Click()
Unload Me
End Sub
