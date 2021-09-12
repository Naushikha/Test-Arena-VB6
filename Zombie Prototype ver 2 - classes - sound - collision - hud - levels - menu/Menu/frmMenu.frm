VERSION 5.00
Object = "{22D6F304-B0F6-11D0-94AB-0080C74C7E95}#1.0#0"; "msdxm.ocx"
Begin VB.Form frmMenu 
   BackColor       =   &H00000000&
   BorderStyle     =   0  'None
   Caption         =   "Menu"
   ClientHeight    =   12045
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   10965
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   12045
   ScaleWidth      =   10965
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
   Begin VB.Timer tmrTitleAct 
      Interval        =   2000
      Left            =   4080
      Top             =   2040
   End
   Begin VB.Timer tmrTitleAnim 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   4680
      Top             =   2040
   End
   Begin VB.Timer tmrGifAnim 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   6360
      Top             =   9600
   End
   Begin VB.Timer tmrGifAct 
      Interval        =   5000
      Left            =   5760
      Top             =   9600
   End
   Begin VB.Timer tmrMain 
      Interval        =   1
      Left            =   10200
      Top             =   2160
   End
   Begin MediaPlayerCtl.MediaPlayer glitch 
      Height          =   615
      Index           =   4
      Left            =   9840
      TabIndex        =   9
      Top             =   5280
      Visible         =   0   'False
      Width           =   735
      AudioStream     =   -1
      AutoSize        =   0   'False
      AutoStart       =   0   'False
      AnimationAtStart=   -1  'True
      AllowScan       =   -1  'True
      AllowChangeDisplaySize=   -1  'True
      AutoRewind      =   0   'False
      Balance         =   0
      BaseURL         =   ""
      BufferingTime   =   5
      CaptioningID    =   ""
      ClickToPlay     =   -1  'True
      CursorType      =   0
      CurrentPosition =   -1
      CurrentMarker   =   0
      DefaultFrame    =   ""
      DisplayBackColor=   0
      DisplayForeColor=   16777215
      DisplayMode     =   0
      DisplaySize     =   4
      Enabled         =   -1  'True
      EnableContextMenu=   -1  'True
      EnablePositionControls=   -1  'True
      EnableFullScreenControls=   0   'False
      EnableTracker   =   -1  'True
      Filename        =   ""
      InvokeURLs      =   -1  'True
      Language        =   -1
      Mute            =   0   'False
      PlayCount       =   1
      PreviewMode     =   0   'False
      Rate            =   1
      SAMILang        =   ""
      SAMIStyle       =   ""
      SAMIFileName    =   ""
      SelectionStart  =   -1
      SelectionEnd    =   -1
      SendOpenStateChangeEvents=   -1  'True
      SendWarningEvents=   -1  'True
      SendErrorEvents =   -1  'True
      SendKeyboardEvents=   0   'False
      SendMouseClickEvents=   0   'False
      SendMouseMoveEvents=   0   'False
      SendPlayStateChangeEvents=   -1  'True
      ShowCaptioning  =   0   'False
      ShowControls    =   -1  'True
      ShowAudioControls=   -1  'True
      ShowDisplay     =   0   'False
      ShowGotoBar     =   0   'False
      ShowPositionControls=   -1  'True
      ShowStatusBar   =   0   'False
      ShowTracker     =   -1  'True
      TransparentAtStart=   0   'False
      VideoBorderWidth=   0
      VideoBorderColor=   0
      VideoBorder3D   =   0   'False
      Volume          =   -600
      WindowlessVideo =   0   'False
   End
   Begin MediaPlayerCtl.MediaPlayer glitch 
      Height          =   615
      Index           =   3
      Left            =   9840
      TabIndex        =   8
      Top             =   5280
      Visible         =   0   'False
      Width           =   735
      AudioStream     =   -1
      AutoSize        =   0   'False
      AutoStart       =   0   'False
      AnimationAtStart=   -1  'True
      AllowScan       =   -1  'True
      AllowChangeDisplaySize=   -1  'True
      AutoRewind      =   0   'False
      Balance         =   0
      BaseURL         =   ""
      BufferingTime   =   5
      CaptioningID    =   ""
      ClickToPlay     =   -1  'True
      CursorType      =   0
      CurrentPosition =   -1
      CurrentMarker   =   0
      DefaultFrame    =   ""
      DisplayBackColor=   0
      DisplayForeColor=   16777215
      DisplayMode     =   0
      DisplaySize     =   4
      Enabled         =   -1  'True
      EnableContextMenu=   -1  'True
      EnablePositionControls=   -1  'True
      EnableFullScreenControls=   0   'False
      EnableTracker   =   -1  'True
      Filename        =   ""
      InvokeURLs      =   -1  'True
      Language        =   -1
      Mute            =   0   'False
      PlayCount       =   1
      PreviewMode     =   0   'False
      Rate            =   1
      SAMILang        =   ""
      SAMIStyle       =   ""
      SAMIFileName    =   ""
      SelectionStart  =   -1
      SelectionEnd    =   -1
      SendOpenStateChangeEvents=   -1  'True
      SendWarningEvents=   -1  'True
      SendErrorEvents =   -1  'True
      SendKeyboardEvents=   0   'False
      SendMouseClickEvents=   0   'False
      SendMouseMoveEvents=   0   'False
      SendPlayStateChangeEvents=   -1  'True
      ShowCaptioning  =   0   'False
      ShowControls    =   -1  'True
      ShowAudioControls=   -1  'True
      ShowDisplay     =   0   'False
      ShowGotoBar     =   0   'False
      ShowPositionControls=   -1  'True
      ShowStatusBar   =   0   'False
      ShowTracker     =   -1  'True
      TransparentAtStart=   0   'False
      VideoBorderWidth=   0
      VideoBorderColor=   0
      VideoBorder3D   =   0   'False
      Volume          =   -600
      WindowlessVideo =   0   'False
   End
   Begin MediaPlayerCtl.MediaPlayer glitch 
      Height          =   615
      Index           =   2
      Left            =   9840
      TabIndex        =   7
      Top             =   5280
      Visible         =   0   'False
      Width           =   735
      AudioStream     =   -1
      AutoSize        =   0   'False
      AutoStart       =   0   'False
      AnimationAtStart=   -1  'True
      AllowScan       =   -1  'True
      AllowChangeDisplaySize=   -1  'True
      AutoRewind      =   0   'False
      Balance         =   0
      BaseURL         =   ""
      BufferingTime   =   5
      CaptioningID    =   ""
      ClickToPlay     =   -1  'True
      CursorType      =   0
      CurrentPosition =   -1
      CurrentMarker   =   0
      DefaultFrame    =   ""
      DisplayBackColor=   0
      DisplayForeColor=   16777215
      DisplayMode     =   0
      DisplaySize     =   4
      Enabled         =   -1  'True
      EnableContextMenu=   -1  'True
      EnablePositionControls=   -1  'True
      EnableFullScreenControls=   0   'False
      EnableTracker   =   -1  'True
      Filename        =   ""
      InvokeURLs      =   -1  'True
      Language        =   -1
      Mute            =   0   'False
      PlayCount       =   1
      PreviewMode     =   0   'False
      Rate            =   1
      SAMILang        =   ""
      SAMIStyle       =   ""
      SAMIFileName    =   ""
      SelectionStart  =   -1
      SelectionEnd    =   -1
      SendOpenStateChangeEvents=   -1  'True
      SendWarningEvents=   -1  'True
      SendErrorEvents =   -1  'True
      SendKeyboardEvents=   0   'False
      SendMouseClickEvents=   0   'False
      SendMouseMoveEvents=   0   'False
      SendPlayStateChangeEvents=   -1  'True
      ShowCaptioning  =   0   'False
      ShowControls    =   -1  'True
      ShowAudioControls=   -1  'True
      ShowDisplay     =   0   'False
      ShowGotoBar     =   0   'False
      ShowPositionControls=   -1  'True
      ShowStatusBar   =   0   'False
      ShowTracker     =   -1  'True
      TransparentAtStart=   0   'False
      VideoBorderWidth=   0
      VideoBorderColor=   0
      VideoBorder3D   =   0   'False
      Volume          =   -600
      WindowlessVideo =   0   'False
   End
   Begin MediaPlayerCtl.MediaPlayer glitch 
      Height          =   615
      Index           =   1
      Left            =   9840
      TabIndex        =   6
      Top             =   5280
      Visible         =   0   'False
      Width           =   735
      AudioStream     =   -1
      AutoSize        =   0   'False
      AutoStart       =   0   'False
      AnimationAtStart=   -1  'True
      AllowScan       =   -1  'True
      AllowChangeDisplaySize=   -1  'True
      AutoRewind      =   0   'False
      Balance         =   0
      BaseURL         =   ""
      BufferingTime   =   5
      CaptioningID    =   ""
      ClickToPlay     =   -1  'True
      CursorType      =   0
      CurrentPosition =   -1
      CurrentMarker   =   0
      DefaultFrame    =   ""
      DisplayBackColor=   0
      DisplayForeColor=   16777215
      DisplayMode     =   0
      DisplaySize     =   4
      Enabled         =   -1  'True
      EnableContextMenu=   -1  'True
      EnablePositionControls=   -1  'True
      EnableFullScreenControls=   0   'False
      EnableTracker   =   -1  'True
      Filename        =   ""
      InvokeURLs      =   -1  'True
      Language        =   -1
      Mute            =   0   'False
      PlayCount       =   1
      PreviewMode     =   0   'False
      Rate            =   1
      SAMILang        =   ""
      SAMIStyle       =   ""
      SAMIFileName    =   ""
      SelectionStart  =   -1
      SelectionEnd    =   -1
      SendOpenStateChangeEvents=   -1  'True
      SendWarningEvents=   -1  'True
      SendErrorEvents =   -1  'True
      SendKeyboardEvents=   0   'False
      SendMouseClickEvents=   0   'False
      SendMouseMoveEvents=   0   'False
      SendPlayStateChangeEvents=   -1  'True
      ShowCaptioning  =   0   'False
      ShowControls    =   -1  'True
      ShowAudioControls=   -1  'True
      ShowDisplay     =   0   'False
      ShowGotoBar     =   0   'False
      ShowPositionControls=   -1  'True
      ShowStatusBar   =   0   'False
      ShowTracker     =   -1  'True
      TransparentAtStart=   0   'False
      VideoBorderWidth=   0
      VideoBorderColor=   0
      VideoBorder3D   =   0   'False
      Volume          =   -600
      WindowlessVideo =   0   'False
   End
   Begin MediaPlayerCtl.MediaPlayer glitch 
      Height          =   615
      Index           =   0
      Left            =   9840
      TabIndex        =   5
      Top             =   5280
      Visible         =   0   'False
      Width           =   735
      AudioStream     =   -1
      AutoSize        =   0   'False
      AutoStart       =   0   'False
      AnimationAtStart=   -1  'True
      AllowScan       =   -1  'True
      AllowChangeDisplaySize=   -1  'True
      AutoRewind      =   0   'False
      Balance         =   0
      BaseURL         =   ""
      BufferingTime   =   5
      CaptioningID    =   ""
      ClickToPlay     =   -1  'True
      CursorType      =   0
      CurrentPosition =   -1
      CurrentMarker   =   0
      DefaultFrame    =   ""
      DisplayBackColor=   0
      DisplayForeColor=   16777215
      DisplayMode     =   0
      DisplaySize     =   4
      Enabled         =   -1  'True
      EnableContextMenu=   -1  'True
      EnablePositionControls=   -1  'True
      EnableFullScreenControls=   0   'False
      EnableTracker   =   -1  'True
      Filename        =   ""
      InvokeURLs      =   -1  'True
      Language        =   -1
      Mute            =   0   'False
      PlayCount       =   1
      PreviewMode     =   0   'False
      Rate            =   1
      SAMILang        =   ""
      SAMIStyle       =   ""
      SAMIFileName    =   ""
      SelectionStart  =   -1
      SelectionEnd    =   -1
      SendOpenStateChangeEvents=   -1  'True
      SendWarningEvents=   -1  'True
      SendErrorEvents =   -1  'True
      SendKeyboardEvents=   0   'False
      SendMouseClickEvents=   0   'False
      SendMouseMoveEvents=   0   'False
      SendPlayStateChangeEvents=   -1  'True
      ShowCaptioning  =   0   'False
      ShowControls    =   -1  'True
      ShowAudioControls=   -1  'True
      ShowDisplay     =   0   'False
      ShowGotoBar     =   0   'False
      ShowPositionControls=   -1  'True
      ShowStatusBar   =   0   'False
      ShowTracker     =   -1  'True
      TransparentAtStart=   0   'False
      VideoBorderWidth=   0
      VideoBorderColor=   0
      VideoBorder3D   =   0   'False
      Volume          =   -600
      WindowlessVideo =   0   'False
   End
   Begin VB.Image imgTitleAnim 
      Height          =   735
      Left            =   7560
      Stretch         =   -1  'True
      Top             =   1200
      Width           =   1935
   End
   Begin VB.Image imgTitle 
      BorderStyle     =   1  'Fixed Single
      Height          =   1335
      Index           =   5
      Left            =   5640
      Top             =   1800
      Visible         =   0   'False
      Width           =   1575
   End
   Begin VB.Image imgTitle 
      BorderStyle     =   1  'Fixed Single
      Height          =   1335
      Index           =   4
      Left            =   5640
      Top             =   1800
      Visible         =   0   'False
      Width           =   1575
   End
   Begin VB.Image imgTitle 
      BorderStyle     =   1  'Fixed Single
      Height          =   1335
      Index           =   3
      Left            =   5640
      Top             =   1800
      Visible         =   0   'False
      Width           =   1575
   End
   Begin VB.Image imgTitle 
      BorderStyle     =   1  'Fixed Single
      Height          =   1335
      Index           =   2
      Left            =   5640
      Top             =   1800
      Visible         =   0   'False
      Width           =   1575
   End
   Begin VB.Image imgTitle 
      BorderStyle     =   1  'Fixed Single
      Height          =   1335
      Index           =   1
      Left            =   5640
      Top             =   1800
      Visible         =   0   'False
      Width           =   1575
   End
   Begin VB.Image imgTitle 
      BorderStyle     =   1  'Fixed Single
      Height          =   1335
      Index           =   0
      Left            =   5640
      Top             =   1800
      Visible         =   0   'False
      Width           =   1575
   End
   Begin VB.Image imgGif 
      BorderStyle     =   1  'Fixed Single
      Height          =   1455
      Index           =   25
      Left            =   1080
      Top             =   7800
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.Image imgGif 
      BorderStyle     =   1  'Fixed Single
      Height          =   1455
      Index           =   24
      Left            =   1080
      Top             =   7800
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.Image imgGif 
      BorderStyle     =   1  'Fixed Single
      Height          =   1455
      Index           =   23
      Left            =   1080
      Top             =   7800
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.Image imgGif 
      BorderStyle     =   1  'Fixed Single
      Height          =   1455
      Index           =   22
      Left            =   1080
      Top             =   7800
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.Image imgGif 
      BorderStyle     =   1  'Fixed Single
      Height          =   1455
      Index           =   21
      Left            =   1080
      Top             =   7800
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.Image imgGif 
      BorderStyle     =   1  'Fixed Single
      Height          =   1455
      Index           =   20
      Left            =   1080
      Top             =   7800
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.Image imgGif 
      BorderStyle     =   1  'Fixed Single
      Height          =   1455
      Index           =   19
      Left            =   1080
      Top             =   7800
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.Image imgGif 
      BorderStyle     =   1  'Fixed Single
      Height          =   1455
      Index           =   18
      Left            =   1080
      Top             =   7800
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.Image imgGif 
      BorderStyle     =   1  'Fixed Single
      Height          =   1455
      Index           =   17
      Left            =   1080
      Top             =   7800
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.Image imgGif 
      BorderStyle     =   1  'Fixed Single
      Height          =   1455
      Index           =   16
      Left            =   1080
      Top             =   7800
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.Image imgGif 
      BorderStyle     =   1  'Fixed Single
      Height          =   1455
      Index           =   15
      Left            =   1080
      Top             =   7800
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.Image imgGif 
      BorderStyle     =   1  'Fixed Single
      Height          =   1455
      Index           =   14
      Left            =   1080
      Top             =   7800
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.Image imgGif 
      BorderStyle     =   1  'Fixed Single
      Height          =   1455
      Index           =   13
      Left            =   1080
      Top             =   7800
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.Image imgGif 
      BorderStyle     =   1  'Fixed Single
      Height          =   1455
      Index           =   12
      Left            =   1080
      Top             =   7800
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.Image imgGif 
      BorderStyle     =   1  'Fixed Single
      Height          =   1455
      Index           =   11
      Left            =   1080
      Top             =   7800
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.Image imgGif 
      BorderStyle     =   1  'Fixed Single
      Height          =   1455
      Index           =   10
      Left            =   1080
      Top             =   7800
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.Image imgGif 
      BorderStyle     =   1  'Fixed Single
      Height          =   1455
      Index           =   9
      Left            =   1080
      Top             =   7800
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.Image imgGif 
      BorderStyle     =   1  'Fixed Single
      Height          =   1455
      Index           =   8
      Left            =   1080
      Top             =   7800
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.Image imgGif 
      BorderStyle     =   1  'Fixed Single
      Height          =   1455
      Index           =   7
      Left            =   1080
      Top             =   7800
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.Image imgGif 
      BorderStyle     =   1  'Fixed Single
      Height          =   1455
      Index           =   6
      Left            =   1080
      Top             =   7800
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.Image imgGif 
      BorderStyle     =   1  'Fixed Single
      Height          =   1455
      Index           =   5
      Left            =   1080
      Top             =   7800
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.Image imgGif 
      BorderStyle     =   1  'Fixed Single
      Height          =   1455
      Index           =   4
      Left            =   1080
      Top             =   7800
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.Image imgGif 
      BorderStyle     =   1  'Fixed Single
      Height          =   1455
      Index           =   3
      Left            =   1080
      Top             =   7800
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.Image imgGif 
      BorderStyle     =   1  'Fixed Single
      Height          =   1455
      Index           =   2
      Left            =   1080
      Top             =   7800
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.Image imgGif 
      BorderStyle     =   1  'Fixed Single
      Height          =   1455
      Index           =   1
      Left            =   1080
      Top             =   7800
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.Image imgGif 
      BorderStyle     =   1  'Fixed Single
      Height          =   1455
      Index           =   0
      Left            =   1080
      Top             =   7800
      Visible         =   0   'False
      Width           =   1935
   End
   Begin MediaPlayerCtl.MediaPlayer wmp 
      Height          =   2295
      Left            =   7680
      TabIndex        =   4
      Top             =   2400
      Visible         =   0   'False
      Width           =   2295
      AudioStream     =   -1
      AutoSize        =   0   'False
      AutoStart       =   -1  'True
      AnimationAtStart=   -1  'True
      AllowScan       =   -1  'True
      AllowChangeDisplaySize=   -1  'True
      AutoRewind      =   0   'False
      Balance         =   0
      BaseURL         =   ""
      BufferingTime   =   5
      CaptioningID    =   ""
      ClickToPlay     =   -1  'True
      CursorType      =   0
      CurrentPosition =   -1
      CurrentMarker   =   0
      DefaultFrame    =   ""
      DisplayBackColor=   0
      DisplayForeColor=   16777215
      DisplayMode     =   0
      DisplaySize     =   4
      Enabled         =   -1  'True
      EnableContextMenu=   -1  'True
      EnablePositionControls=   -1  'True
      EnableFullScreenControls=   0   'False
      EnableTracker   =   -1  'True
      Filename        =   ""
      InvokeURLs      =   -1  'True
      Language        =   -1
      Mute            =   0   'False
      PlayCount       =   1
      PreviewMode     =   0   'False
      Rate            =   1
      SAMILang        =   ""
      SAMIStyle       =   ""
      SAMIFileName    =   ""
      SelectionStart  =   -1
      SelectionEnd    =   -1
      SendOpenStateChangeEvents=   -1  'True
      SendWarningEvents=   -1  'True
      SendErrorEvents =   -1  'True
      SendKeyboardEvents=   0   'False
      SendMouseClickEvents=   0   'False
      SendMouseMoveEvents=   0   'False
      SendPlayStateChangeEvents=   -1  'True
      ShowCaptioning  =   0   'False
      ShowControls    =   -1  'True
      ShowAudioControls=   -1  'True
      ShowDisplay     =   0   'False
      ShowGotoBar     =   0   'False
      ShowPositionControls=   -1  'True
      ShowStatusBar   =   0   'False
      ShowTracker     =   -1  'True
      TransparentAtStart=   0   'False
      VideoBorderWidth=   0
      VideoBorderColor=   0
      VideoBorder3D   =   0   'False
      Volume          =   -600
      WindowlessVideo =   0   'False
   End
   Begin VB.Label lblTitle 
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
      Left            =   3960
      TabIndex        =   2
      Top             =   0
      Visible         =   0   'False
      Width           =   6375
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
      Left            =   960
      TabIndex        =   3
      Top             =   2040
      Width           =   4815
   End
   Begin VB.Label lblExit 
      BackStyle       =   0  'Transparent
      Caption         =   "Exit"
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
      Height          =   1335
      Left            =   960
      TabIndex        =   1
      Top             =   2880
      Width           =   3975
   End
   Begin VB.Label lblNew 
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
      Left            =   960
      TabIndex        =   0
      Top             =   1080
      Width           =   4815
   End
   Begin VB.Line l 
      BorderColor     =   &H00C0FFC0&
      BorderWidth     =   8
      Index           =   8
      Visible         =   0   'False
      X1              =   8880
      X2              =   8880
      Y1              =   5160
      Y2              =   7440
   End
   Begin VB.Line l 
      BorderColor     =   &H0080FF80&
      BorderWidth     =   5
      Index           =   4
      Visible         =   0   'False
      X1              =   5160
      X2              =   9480
      Y1              =   6240
      Y2              =   6240
   End
   Begin VB.Line l 
      BorderColor     =   &H00008000&
      BorderWidth     =   5
      Index           =   3
      Visible         =   0   'False
      X1              =   5400
      X2              =   9240
      Y1              =   5760
      Y2              =   5760
   End
   Begin VB.Line l 
      BorderColor     =   &H00C0FFC0&
      BorderWidth     =   8
      Index           =   2
      Visible         =   0   'False
      X1              =   5280
      X2              =   9120
      Y1              =   6120
      Y2              =   6120
   End
   Begin VB.Line l 
      BorderColor     =   &H0000C000&
      BorderWidth     =   5
      Index           =   1
      Visible         =   0   'False
      X1              =   5400
      X2              =   9840
      Y1              =   7080
      Y2              =   7080
   End
   Begin VB.Line l 
      BorderColor     =   &H0080FF80&
      BorderWidth     =   10
      Index           =   0
      Visible         =   0   'False
      X1              =   5520
      X2              =   9840
      Y1              =   6480
      Y2              =   6480
   End
   Begin VB.Image imgGifAnim 
      Height          =   1215
      Left            =   120
      Stretch         =   -1  'True
      Top             =   0
      Visible         =   0   'False
      Width           =   1695
   End
End
Attribute VB_Name = "frmMenu"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private waitFlash, waitTitle, waitLine As Integer
Private gifFrames(7) As Integer
Private currFrame As Integer
Private gifNo As Integer
Private i, j As Integer
Private titleStatus As Integer
Private Sub Form_Activate()
lblTitle.Top = Me.Height * 0.01: lblTitle.Left = Me.Width * 0.3
lblNew.Top = Me.Height * 0.2: lblNew.Left = Me.Width * 0.01
lblSet.Top = Me.Height * 0.3: lblSet.Left = Me.Width * 0.01
lblExit.Top = Me.Height * 0.4: lblExit.Left = Me.Width * 0.01
imgGifAnim.Width = Me.Width: imgGifAnim.Height = Me.Height
imgTitleAnim.Top = Me.Height * 0.01: imgTitleAnim.Left = Me.Width * 0.3
imgTitleAnim.Height = Me.Height * 0.25: imgTitleAnim.Width = Me.Width * 0.4

For i = 0 To 4
l(i).X1 = 0
l(i).X2 = Me.Width
Next
l(8).Y1 = 0: l(8).Y2 = Me.Height
l(8).X1 = -10: l(8).X2 = -10
End Sub
Private Sub Form_Load()
wmp.FileName = App.Path & "\Data\SFX\menu_music.mp3"
wmp.AutoRewind = True
wmp.Volume = -1600
resWidth = 800
resHeight = 600
For i = 0 To 5
imgTitle(i).Picture = LoadPicture(App.Path & "\Data\GFX\Menu_Anim\title" & i & ".gif")
Next
imgTitleAnim.Picture = imgTitle(0).Picture
titleStatus = 0
gifFrames(0) = 3
gifFrames(1) = 5
gifFrames(2) = 13 '13
gifFrames(3) = 10 '22
gifFrames(4) = 10 '18
gifFrames(5) = 6
gifFrames(6) = 8
gifFrames(7) = 4
gifNo = 0
currFrame = 1
Load_Gif
imgGifAnim.Top = 0
imgGifAnim.Left = 0
For i = 0 To 4
glitch(i).FileName = App.Path & "\Data\SFX\glitch" & (i + 1) & ".wav"
glitch(i).Volume = -1200
Next
End Sub
Private Sub imgGifAnim_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
lblNew.ForeColor = vbWhite
lblSet.ForeColor = vbWhite
lblExit.ForeColor = vbWhite
End Sub

Private Sub lblnew_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
lblNew.ForeColor = vbGreen
End Sub
Private Sub lblset_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
lblSet.ForeColor = vbGreen
End Sub
Private Sub lblexit_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
lblExit.ForeColor = vbGreen
End Sub
Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
lblNew.ForeColor = vbWhite
lblSet.ForeColor = vbWhite
lblExit.ForeColor = vbWhite
End Sub
Private Sub lblExit_Click()
End
End Sub
Private Sub lblNew_Click()
frmNew.Show
End Sub
Private Sub lblSet_Click()
frmSet.Show
End Sub
Private Sub tmrMain_Timer()
'For i = 0 To 4
'If l(i).Y1 > Me.Height Then
'l(i).Y1 = 0: l(i).Y2 = 0
'Else
'l(i).Y1 = l(i).Y1 + 50 * (i * 0.5 + 1)
'l(i).Y2 = l(i).Y2 + 50 * (i * 0.5 + 1)
'End If
'Next

If Me.BackColor = vbBlack And waitFlash > 200 Then
Me.BackColor = &H4000&
waitFlash = 0
End If
If Me.BackColor = &H4000& And waitFlash > 5 Then
Me.BackColor = vbBlack
waitFlash = 0
End If

'If lblTitle.FontItalic = False And waitTitle > 300 Then
'lblTitle.FontItalic = True
'waitTitle = 0
'End If
'If lblTitle.FontItalic = True And waitTitle > 5 Then
'lblTitle.FontItalic = False
'waitTitle = 0
'End If

'If l(8).X1 > Me.Width Then
'l(8).X1 = -10: l(8).X2 = -10
'waitLine = 0
'ElseIf waitLine > 500 Then
'l(8).X1 = l(8).X1 + 200
'l(8).X2 = l(8).X2 + 200
'End If

waitFlash = waitFlash + 1
'waitTitle = waitTitle + 1
'waitLine = waitLine + 1
End Sub
Private Sub tmrGifAct_Timer()
tmrGifAnim.Enabled = True
imgGifAnim.Visible = True
tmrGifAct.Enabled = False
End Sub
Private Sub tmrGifAnim_Timer()
If currFrame < gifFrames(gifNo) Then
    imgGifAnim.Picture = imgGif(currFrame).Picture
    currFrame = currFrame + 1
Else
    currFrame = 1
    If gifNo < 7 Then
    gifNo = gifNo + 1
    Load_Gif
    Else
    gifNo = 0
    Load_Gif
    End If
    imgGifAnim.Picture = Nothing
    imgGifAnim.Visible = False
    tmrGifAct.Enabled = True
    tmrGifAnim.Enabled = False
End If
End Sub
Private Sub tmrTitleAct_Timer()
tmrTitleAnim.Enabled = True
tmrTitleAct.Enabled = False
End Sub
Private Sub tmrTitleAnim_Timer()
Randomize
If titleStatus = 0 Then
    Dim magicNo As Integer
    magicNo = Int(Rnd * 5 + 1)
    imgTitleAnim.Picture = imgTitle(magicNo).Picture
    glitch(magicNo - 1).Play
    titleStatus = 1
Else
    titleStatus = 0
    imgTitleAnim.Picture = imgTitle(0).Picture
    tmrTitleAct.Interval = Int(Rnd * 5000 + 2000)
    tmrTitleAct.Enabled = True
    tmrTitleAnim.Enabled = False
End If
End Sub
Private Sub Load_Gif()
For j = 1 To gifFrames(gifNo)
imgGif(j).Picture = LoadPicture(App.Path & "\Data\GFX\Menu_Anim\anim" & (gifNo + 1) & "_" & j & ".gif")
Next
End Sub
