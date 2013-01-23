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
exec ("rdfMoments.sci", -1);

// Noms de toutes les images
nom = "rdf-carre-6.png";
image = im2double(imread (nom));
//imshow (image);
nom1 = "rdf-carre-10.png";
image1 = im2double(imread (nom1));

nom2 = "rdf-carre-10-30deg.png";
image2 = im2double(imread (nom2));

nom3 = "rdf-carre-10-45deg.png";
image3 = im2double(imread (nom3));

nom4 = "rdf-carre-20.png";
image4 = im2double(imread (nom4));

nom5 = "rdf-triangle-10.png";
image5 = im2double(imread (nom5));

nom6 = "rdf-triangle-10-15deg.png";
image6 = im2double(imread (nom6));

nom7 = "rdf-triangle-10-45deg.png";
image7 = im2double(imread (nom7));

nom8 = "rdf-triangle-10-60deg.png";
image8 = im2double(imread (nom8));

// Calcul de la surface
//surface = rdfSurface (image);

m = inertiaMatrixCentered(image);
m1 = inertiaMatrixCentered(image1);
m2 = inertiaMatrixCentered(image2);
m3 = inertiaMatrixCentered(image3);
m4 = inertiaMatrixCentered(image4);
m5 = inertiaMatrixCentered(image5);
m6 = inertiaMatrixCentered(image6);
m7 = inertiaMatrixCentered(image7);
m8 = inertiaMatrixCentered(image8);

m = Hu5(image)
m1 = Hu5(image1)
m2 = Hu5(image2)
m3 = Hu5(image3) 
m4 = Hu5(image4)
m5 = Hu5(image5)
m6 = Hu5(image6)
m7 = Hu5(image7)
m8 = Hu5(image8)
