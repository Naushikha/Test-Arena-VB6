VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsWeapon"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
'Weapons
Private Weapon(2) As TVActor2 'WARNING edit to add more weapons
Private Type weaponData
  anim() As String
  ammo() As String 'contains fire mode, range, mags & bullets
End Type
Private Type currentAmmo
  mags As Integer
  bull As Integer
End Type
Private wpData(2) As weaponData
Private wpAmmo(2) As currentAmmo

