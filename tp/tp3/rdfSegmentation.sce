// -----------------------------------------------------------------------
// Extraction d'attributs de pixels pour la classification,
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
exec ("rdfSegmentation.sci", -1);

//nom = "rdf-masque-ronds.png";
//imgReference = im2double (imread (nom));

nom = "rdf-2-classes-texture-1-text.png";
img_text = im2double (imread (nom));

// Chargement d'une image
nom = "rdf-2-classes-texture-0.png";
image = im2double (imread (nom));

nom = "rdf-2-classes-texture-1.png";
image1 = im2double (imread (nom));

nom = "rdf-2-classes-texture-2.png";
image2 = im2double (imread (nom));

nom = "rdf-2-classes-texture-3.png";
image3 = im2double (imread (nom));

nom = "rdf-2-classes-texture-4.png";
image4 = im2double (imread (nom));


//imageNT = rdfTextureEcartType(image,5);
//imageNT1 = rdfTextureEcartType(image,5);
//imageNT2 = rdfTextureEcartType(image2,5);
//imageNT3 = rdfTextureEcartType(image3,5);
//imageNT4 = rdfTextureEcartType(image4,5);


// Calcul et affichage de son histogramme
hist = rdfCalculeHistogramme2D (image, 256, img_text, 256);
hist1 = rdfCalculeHistogramme2D (image1, 256, img_text, 256);
hist2 = rdfCalculeHistogramme2D (image2, 256, img_text, 256);
hist3 = rdfCalculeHistogramme2D (image3, 256, img_text, 256);
hist4 = rdfCalculeHistogramme2D (image4, 256, img_text, 256);

//hist1 = rdfCalculeHistogramme1D (img_text, 256);
//hist2 = rdfCalculeHistogramme1D (imageNT2, 256);
//hist3 = rdfCalculeHistogramme1D (imageNT3, 256);
//hist4 = rdfCalculeHistogramme1D (imageNT4, 256);

sep = ones(size(hist1,1),2);
sep1 = ones(size(hist1,1),size(hist1,2));
sep2 = sep';

line1 = [hist, sep, hist1, sep, sep1];
line2 = [sep2, [1,1;1,1],sep2, [1,1;1,1],sep2];
line3 = [hist2 sep hist3 sep hist4];

//imshow ([line1;line2;line3]); 

//rdfAfficheHistogramme1D (hist1, 1, "b");
//rdfAfficheHistogramme1D (hist2, 3, "g");
//rdfAfficheHistogramme1D (hist3, 4, "k");
//rdfAfficheHistogramme1D (hist4, 5, "c");


// Binarisation de l'image

seuil = 0.86;
binaire = rdfClassifieurLineaire2D (image, imageNT, 1,1, -seuil);

seuil = 0.9;
binaire1 = rdfClassifieurLineaire2D (image1, imageNT, 1,1, -seuil);

seuil = 1;
binaire2 = rdfClassifieurLineaire2D (image2, imageNT, 1,1, -seuil);

seuil = 1;
binaire3 = rdfClassifieurLineaire2D (image3, imageNT, 1,1, -seuil);

seuil = 1;
binaire4 = rdfClassifieurLineaire2D (image4, imageNT, 1,1, -seuil);

//seuil = 0.56;
//binaire1 = rdfClassifieurLineaire1D (imageNT1, -1, seuil);

//seuil = 0.57;
//binaire2 = rdfClassifieurLineaire1D (imageNT2, -1, seuil);

//seuil = 0.6;
//binaire3 = rdfClassifieurLineaire1D (imageNT3, -1, seuil);

//seuil = 0.55;
//binaire4 = rdfClassifieurLineaire1D (imageNT4, -1, seuil);

resultat = abs(binaire-imgReference);
resultat1 = abs(binaire1-imgReference);
resultat2 = abs(binaire2-imgReference);
resultat3 = abs(binaire3-imgReference);
resultat4 = abs(binaire4-imgReference);

//imshow ([binaire,binaire1,binaire2,binaire3,binaire4]);


// Affichage des images
imshow ([imgReference,binaire,resultat;
         imgReference,binaire1,resultat1;
         imgReference,binaire2,resultat2;
         imgReference,binaire3,resultat3;
         imgReference,binaire4,resultat4]); 
