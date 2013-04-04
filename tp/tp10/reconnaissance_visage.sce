// On construi le tableau de classe pour les images
// (10 premieres images pour la classe 1, 
//  les 10 suivantes pour la classe 2, etc )
function m = buildClassTab()
    m = int((0:399)/10) + 1;
endfunction

// On recupere une face parmis toutes celles proposees
function [face, index] = getOneFaceOf(stackedFace)
    index = grand(1,1,'uin',0,400)
    face = stackedFace(:,:,index)
endfunction

// Cette fonction verifie si il ne reste plus qu'une seule classe
// parmis celles proposer dans tabClasses grace a la fonction tabul
function index = onlyOneClass(tabClasses)
    // stock les elements de cette facon
    //      classe ocurrence
    //ex:     1     3
    //        3     1
    //        4     1
    //        5     2
    t = tabul(tabClasses)
    
    // Donc si il ne reste plus qu'une ligne
    // il ne reste plus qu'une classe et on la retourne
    if (size(t,1) == 1) then
         index = t(1);
    // sinon on retourne -1
    else
        index = -1;
    end
endfunction

// cree un tableau de 40*33*400
// a partir d'un tableau de 660*800 
function sf = stackedFaces(allFaces)
    sf=zeros(40,33,400); // numLignes, numColonnes, numFaces
    
    for i=0:19
        for j=0:19
            sf(:,:, (i*20 + j + 1) ) = allFaces( 1+i*40 : (i+1)*40 , 1+j*33 : (j+1)*33 );
        end
    end
    
endfunction

// calcul de l'entropie pour les images contenu dans stackedFace
function m = entropie(stackedFace)
    // on fait la moyenne des valeurs des pixels
    // pour toutes les images
    m = mean(stackedFace,3);
    
    // calcul de l'entropie
    m = - log2(m.^m) - log2((1 - m).^(1 - m));
    
endfunction


// fonction de partage
function [A,B,i] = partage(I,stackedFace)
    
    // recupere les visages significatifs
    significatif = stackedFace(:,:,I);
    
    // calcul l'entropie de ces images et 
    entrop = entropie(significatif);
    
    // recupere l'indice du pixels le plus significatif
    [m,i] = max(entrop);
    
    x = i(1);
    y = i(2);
    
    // on met la 3eme dimension dans la premiere
    stckedFace(1,:) = stackedFace(x,y,:);
    
    // partage les visages significatifs en deux sous-ensembles
    // ceux qui possede ce pixel a 1
    A = I & (stckedFace == 1);
    
    // ceux qui ne le possede pas
    B = I & (stckedFace == 0);
    
endfunction

// fonction principale
//      - trouve a quel classe corespond aFace
//      - utilise stackedFace comme base d'apprantissage
//      - tabClasses sert a savoir si dans le noeud courant 
//        il reste plus d'une classe
function ind = findClass(stackedFace, aFace, tabClasses)
    
    // initialisation du vecteur de booleen pour le partage
    n = size(stackedFace,3);
    I = ([1:n]>0)
    
    index = -1;
    
    // tant qu'ill reste plus d'une classe dans un noeud
    // voir fonction onlyOneClass
    while (index == -1) do
        
        // on partage en deux sous-ensembles
        [A,B,i]=partage(I)
        
        x = i(1);
        y = i(2);
        
        // si l'image contient le pixel en x y
        // on va en A
        if aFace(x,y) == 1 then
            // Est-ce qu'il reste une seule classe ?
            index = onlyOneClass(tabClasses(A));
            I=A;

        // sinon on va en B
        else 
            index = onlyOneClass(tabClasses(B));
            I=B;
        end
    end
    
    ind = index;
endfunction

// fonction d'impression du resultat
function printResult(a, b)
    printf("la classe trouve est %d\n",a)
    if a == b then
        printf("c''est celle de base: %d \n",b)
    else
        printf("il aurait fallut trouver: %d \n",b)
    end
endfunction


stacksize('max');
allFacesName = "allFaces.png";

// convertie l'image en binaire
// la seconde valeur est le seuil
allFaces=im2bw(imread(allFacesName), 0.5);

// On construit le tableau de classe de taille 400
classTab = buildClassTab();

// On recupere les images empiller
//
// a commenter lorsque c'est charge une fois 
// car long a s'executer
stackedFace = stackedFaces(allFaces);

// On recupere une figure au hasard
// ainsi que l'indice de celle-ci afin de recuperer
// sa classe dans le tableau classTab
[oneFace, ind] = getOneFaceOf(stackedFace);

// On recherche la classe de l'image
index = findClass(stackedFace, oneFace, classTab);

// On affiche le resultat
printResult(index,classTab(ind));


