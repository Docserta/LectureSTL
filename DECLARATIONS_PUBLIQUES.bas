Attribute VB_Name = "DECLARATIONS_PUBLIQUES"


Public FicSTL As String
Public Const PathFicStl As String = "c:\temp\"
Public NbItemDecoup As Long 'Nombre de points a partir duquel on change de fichier de r�sultat
Public Const RadNameFile As String = "RemontSTLpart"
Public Const RadNameFileIsol As String = "RemontIsolpart"

Public Const ForReading  As Integer = 1

Public ValSeuil As Double 'Seuil de discrimination des g�om�tries
Public DecoupFic As Boolean 'Choix de d�couper les r�sultat en plusieur fichiers

Public noVertex As Long
Public cptItem As Long 'Compteur d'items pour d�coupage des parts
