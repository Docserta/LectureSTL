Attribute VB_Name = "LectBinaire"
Public Function lectureSTLBinaire(FicSTL) As c_Vertexs
'Trace les triangles d�fini dans un fichier STL au format binaire
Dim oVertexs As c_Vertexs
Dim oVertex As c_Vertex
Dim Comment() As Variant
Dim NbTriangle As Integer
Dim NoTriangle As Long
Dim Normale As Single
Dim Coord(1 To 3) As Single
Dim tempCoord As c_Coord

Dim i As Long, CurOctet As Long

On Error GoTo err
'Les 80 premiers octets sont un commentaire.
'Les 4 octets suivants forment un entier sur 32 bits qui repr�sente le nombre de triangles pr�sents dans le fichier.
'Ensuite, pour chaque triangle, on a une description sur 50 octets qui se d�compose comme suit :
'3 fois 4 octets, chaque paquet de 4 octets repr�sentant un flottant :
'     les coordonn�es (x,y,z) de la direction normale au triangle
'     cette information est importante si on veut un rendu r�aliste de l�objet
'    (elle conditionne la fa�on dont le triangle refl�teles rayons lumineux),
'     mais est inutile pour nous dans le cadre de ce projet.
'3 paquets de 3 fois fois 4 octets, chaque groupe de 4 octets repr�sentant un flottant
'    les coordonn�es (x,y,z) de chacun des sommets du triangle.
'Deux octets repr�sentant un octet de contr�le (inutile dans le cadre ce projet).

'Initialisation des classes
    Set oVertexs = New c_Vertexs
    Set oVertex = New c_Vertex
    Set tempCoord = New c_Coord
    
'charge le fichier slt
    'FicSTL = "C:\CFR\Dropbox\Macros\Lecture_STL\Bat52-part1-Export.STL"
    NoTriangle = 0
    Open FicSTL For Binary As #1

    'R�cup�re le commentaire (80 premiers octets)
    'For CurOctet = 1 To 80
        'Get #1, CurOctet, Comment
    'Next
    CurOctet = 80
    'Recup�re le Nombre de triangle
    CurOctet = 81
        Get #1, CurOctet, NbTriangle
    CurOctet = Seek(1)
    
    'r�cup�re les triangles
    Do While Not EOF(1)
        CurOctet = Seek(1) + 1
        NoTriangle = NoTriangle + 1
        'R�cup�re la normale au triangle '3*4 Octets
        For i = 1 To 3
            Get #1, CurOctet, Coord(i)
            CurOctet = Seek(1) + 1
        Next i
        
        'R�cup�re les 3 pts '3*3*4 Octets
        'Premier point
        For i = 1 To 3
            Get #1, CurOctet, Coord(i)
            CurOctet = Seek(1) + 1
        Next i
        tempCoord.X = Coord(1)
        tempCoord.Y = Coord(2)
        tempCoord.Z = Coord(3)
        oVertex.Pt1 = tempCoord
        
        'second point
        For i = 1 To 3
            Get #1, CurOctet, Coord(i)
            CurOctet = Seek(1) + 1
        Next i
        tempCoord.X = Coord(1)
        tempCoord.Y = Coord(2)
        tempCoord.Z = Coord(3)
        oVertex.Pt2 = tempCoord
        
        'Troisieme point
        For i = 1 To 3
            Get #1, CurOctet, Coord(i)
            CurOctet = Seek(1) + 1
        Next i
        tempCoord.X = Coord(1)
        tempCoord.Y = Coord(2)
        tempCoord.Z = Coord(3)
        oVertex.Pt3 = tempCoord

        oVertexs.Add oVertex.No, oVertex.Pt1, oVertex.Pt2, oVertex.Pt3
        
        'Passe les 2 octets de controle
        CurOctet = Seek(1) + 2
    Loop
  
err:
'Lib�ration des objets
    Close #1
    
    Set lectureSTLBinaire = oVertexs
End Function

Private Function ouvreSTL() As String
'Recupere le fichier STL
'Dim NomComplet As String

    'Ouverture du fichier de param�tres
    ouvreSTL = CATIA.FileSelectionBox("Selectionner le fichier STL", "*.stl", CatFileSelectionModeOpen)
    If ouvreSTL = "" Then Exit Function 'on v�rifie que qque chose a bien �t� selectionn�
   
End Function

