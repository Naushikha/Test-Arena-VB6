VERSION 5.00
Begin VB.Form frmScore 
   BackColor       =   &H00000000&
   BorderStyle     =   0  'None
   Caption         =   "Score"
   ClientHeight    =   7005
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   10890
   LinkTopic       =   "Form1"
   ScaleHeight     =   7005
   ScaleWidth      =   10890
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.Label lbldes 
      BackStyle       =   0  'Transparent
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   855
      Left            =   720
      TabIndex        =   6
      Top             =   4440
      Width           =   10215
   End
   Begin VB.Label lblkill 
      BackStyle       =   0  'Transparent
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
      Height          =   735
      Left            =   5160
      TabIndex        =   5
      Top             =   2880
      Width           =   4815
   End
   Begin VB.Label lbllvl 
      BackStyle       =   0  'Transparent
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
      Height          =   735
      Left            =   5160
      TabIndex        =   4
      Top             =   1800
      Width           =   4815
   End
   Begin VB.Label lbl2 
      BackStyle       =   0  'Transparent
      Caption         =   "Zombies killed :"
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
      Height          =   735
      Left            =   720
      TabIndex        =   3
      Top             =   2880
      Width           =   4815
   End
   Begin VB.Label lblmenu 
      BackStyle       =   0  'Transparent
      Caption         =   "Main Menu"
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
      Height          =   735
      Left            =   3960
      TabIndex        =   2
      Top             =   6240
      Width           =   2655
   End
   Begin VB.Label lbl1 
      BackStyle       =   0  'Transparent
      Caption         =   "Last level cleared :"
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
      Height          =   735
      Left            =   720
      TabIndex        =   1
      Top             =   1800
      Width           =   4815
   End
   Begin VB.Label lblStatus 
      BackStyle       =   0  'Transparent
      Caption         =   "Test Arena"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   48.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   975
      Left            =   2160
      TabIndex        =   0
      Top             =   0
      Width           =   7095
   End
End
Attribute VB_Name = "frmScore"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
Dim i, total As Integer
For i = 1 To (lvlNo - 1)
total = total + 2 ^ i
Next
total = total + lvlKilled
lblkill.Caption = total

If lvlNo = 5 And total >= 62 Then
lbllvl.Caption = 5
Else
lbllvl.Caption = lvlNo - 1
End If

'Funny thoughts from game :p
'lvl zbs - 2,4,8,16,32
'2,6,14,30,62
Select Case total
Case Is < 3
lbldes.Caption = "You must be a grandma who should be doing..... dishes !. Quit playing this game before you get a heart attack."
Case Is < 6
lbldes.Caption = "Change difficulty to 'Just born' if you want to survive."
Case Is < 14
lbldes.Caption = "Not bad for starters. If this is your second or third go, you are not test material."
Case Is < 30
lbldes.Caption = "On your way to saving your butt."
Case Is < 62
lbldes.Caption = "Almost god-like. Not quite, but close."
Case Is < 64
lbldes.Caption = "Oh god, marry me."
End Select
End Sub
Private Sub lblmenu_Click()
Shell App.Path + "\Launcher.exe", vbNormal
End
End Sub
Private Sub lblmenu_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
lblmenu.ForeColor = vbGreen
End Sub
Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
lblmenu.ForeColor = vbWhite
End Sub

