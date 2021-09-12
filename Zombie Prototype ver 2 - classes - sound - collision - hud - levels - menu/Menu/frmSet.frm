VERSION 5.00
Begin VB.Form frmSet 
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
   Begin VB.OptionButton opt2 
      BackColor       =   &H00000000&
      Caption         =   "1024 x 768"
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
      Top             =   2520
      Width           =   3255
   End
   Begin VB.OptionButton opt3 
      BackColor       =   &H00000000&
      Caption         =   "1280 x 1024"
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
      Top             =   3000
      Width           =   3255
   End
   Begin VB.OptionButton opt1 
      BackColor       =   &H00000000&
      Caption         =   "800 x 600"
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
      Top             =   2040
      Width           =   3255
   End
   Begin VB.Label lblcan 
      BackStyle       =   0  'Transparent
      Caption         =   "Cancel"
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
      Left            =   3840
      TabIndex        =   6
      Top             =   4680
      Width           =   2655
   End
   Begin VB.Label lblapp 
      BackStyle       =   0  'Transparent
      Caption         =   "Apply"
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
      Caption         =   "  Resolution"
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
      Caption         =   "Settings"
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
Attribute VB_Name = "frmSet"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub lblapp_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
lblapp.ForeColor = vbGreen
End Sub
Private Sub lblcan_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
lblcan.ForeColor = vbGreen
End Sub
Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
lblapp.ForeColor = vbWhite
lblcan.ForeColor = vbWhite
End Sub
Private Sub lblapp_Click()
resChange = True
Unload Me
End Sub
Private Sub lblcan_Click()
resChange = False
Unload Me
End Sub
Private Sub opt1_Click()
opt1.ForeColor = vbGreen
opt2.ForeColor = vbWhite
opt3.ForeColor = vbWhite
resWidth = 800
resHeight = 600
End Sub
Private Sub opt2_Click()
opt2.ForeColor = vbGreen
opt3.ForeColor = vbWhite
opt1.ForeColor = vbWhite
resWidth = 1024
resHeight = 768
End Sub
Private Sub opt3_Click()
opt3.ForeColor = vbGreen
opt1.ForeColor = vbWhite
opt2.ForeColor = vbWhite
resWidth = 1280
resHeight = 1024
End Sub
