// -----------------------------------------------------------------------
// Extraction d'attributs de forme,
// Module RdF, reconnaissance de formes
// Copyright (C) 2010  Universite Lille 1
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
// -----------------------------------------------------------------------

// Chargement des fonctions externes
exec ("rdfContours.sci", -1);

// Chargement d'un contour
nom = "carre-80.txt";
cont = rdfChargeFichierContour (nom);


// Afficher, fenetre 1, contour en noir "k"
descFour = rdfDescFourier(cont)

rdfValeurDescFourier(descFour,1)

//rdfAfficheContour (rdfInverseDescFourier(descFour), 1, "k");
