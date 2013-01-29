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
//nom = "carre-80.txt";
//cont = rdfChargeFichierContour (nom);

cont = rdfContour(im2double(imread ("rdf-patate.png")));
//cont = rdfContour(im2double(imread ("rdf-croix.png")));
//cont = rdfContour(im2double(imread ("rdf-triangle-20.png")));
// Afficher, fenetre 1, contour en noir "k"

//descFour((size(descFour,1)/2)) = 7;

//rdfValeurDescFourier(descFour,1)
//int(1.1)

//descFour = rdfAnnuleDescFourier(descFour,0.9);
//cont = rdfAlgorithmeCorde (cont, 1);
//descFour(41:48)

descFour = rdfDescFourier(cont);
cont1 = rdfInverseDescFourier(rdfAnnuleDescFourier(descFour,0.6))


//cont2 = rdfInverseDescFourier(rdfAnnuleDescFourier(descFour,0.3))
//cont3 = rdfInverseDescFourier(rdfAnnuleDescFourier(descFour,0.1));

cont2 = rdfAlgorithmeCorde (cont, 1);
//cont2 = rdfAlgorithmeCorde (cont, 0.5);
//cont3 = rdfAlgorithmeCorde (cont, 1);

rdfAfficheContour(cont, 1, "r");
rdfAfficheContour(cont1, 1, "g");
//rdfAfficheContour(cont2, 1, "b");
//rdfAfficheContour(cont3, 1, "b");

//rdfAfficheContour(contour, 2, "r");

//rdfAfficheContour(rdfAlgorithmeCorde (cont, 1), 1, "r");
//rdfAfficheContour(rdfAlgorithmeCorde (cont, 5), 1, "r");
