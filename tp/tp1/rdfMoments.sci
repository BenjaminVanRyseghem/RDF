// -----------------------------------------------------------------------
// Extraction d'attributs de forme,
// Module RdF, reconnaissance de formes
// Copyright (C) 2009  Universite Lille 1
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
// Calcul de la surface d'une forme
function s = rdfSurface (im)
  // Surface = somme des valeurs
  s = sum (im);
endfunction

// Calcul d'un moment geometrique
function m = rdfMoment (im, p, q)
  // Initialiser les vecteurs x et y
  x = (0 : size (im, 2) - 1)' ^ p;
  y = (0 : size (im, 1) - 1) ^ q;
  // Calcul du moment
  m = y * im * x;
endfunction

// Calcul d'un moment centre
function m = rdfMomentCentre (im, p, q)
  // Barycentre
  s = rdfSurface (im);
  cx = rdfMoment (im, 1, 0) / s;
  cy = rdfMoment (im, 0, 1) / s;
  // Initialiser les vecteurs x et y
  x = ((0 : size (im, 2) - 1) - cx)' ^ p;
  y = ((0 : size (im, 1) - 1) - cy) ^ q;
  // Calcul du moment centre
  m = y * im * x;
endfunction

// Calcule de la matrice d'inertie

function result = mu(im, p, q)
  xBarre = rdfMoment (im,1,0) / rdfMoment (im,0,0);
  yBarre = rdfMoment (im,0,1) / rdfMoment (im,0,0);
  
  x = ((0 : size (im, 2) - 1)' - xBarre) ^ p;
  y = ((0 : size (im, 1) - 1) -  yBarre) ^ q;
  result = y * im * x;
endfunction

function m = inertiaMatrix(im)
  ad = mu(im,1,1);
  m = [ mu(im,2,0) ad ; ad mu(im,0,2) ]
endfunction

function vect = valVecProp (inertialM)
  [vec,val] = spec(inertialM);
  vect = [vec, val];
endfunction

function val = valP (m)
  val = spec(m);
endfunction

function vec = vecP(m)
  tmp = valVecProp(m);
  sz = size(m,1);
  vec = tmp(:,1:sz);
endfunction

function axe = main_axe(m)
  val = valP(m);
  [max,index]=max(val);
  vect = vecP(m);
  axe = vect(:,index);
endfunction

function matrice = momentumMatrix(m)
    matrice = bdiag(m);
endfunction

function vect = momentums(m)
    vect = diag(momentumMatrix(m));
endfunction

function matrix = eta(m, p, q)
    matrix = mu(m,p,q) * ( mu(m,0,0).^(-(1+((p+q)/(2)))));
endfunction

function m = inertiaMatrixCentered(im)
  ad = eta(im,1,1);
  m = [ eta(im,2,0) ad ; ad eta(im,0,2) ]
endfunction

function m = Hu5(m)
    firstPac = (eta(m,3,0) - 3*eta(m,1,2)) * (eta(m, 3,0) + eta(m,1,2))
    
    secondPac = ((eta(m, 3,0) + eta(m,1,2)).^2) - (3*( eta(m,2,1) +  eta(m,0,3)).^2)
    
    thirdPac = (3*eta(m, 2, 1) - eta(m, 0, 3)) * ( eta(m, 2, 1) + eta(m, 0, 3))
    
    fourthPac = (3*(eta(m, 3,0) + eta(m, 1,2)).^2) - ((eta(m, 2,1) + eta(m, 0,3).^2))
    
    m = firstPac*secondPac + thirdPac*fourthPac
    endfunction
