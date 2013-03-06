//loadmatfile('mnist_all.mat');

n=200;//nombre des exemplaires d'entrainement
 
k=1; //nombre des voisins

function err = calculateError(y_estim, y_test)
    
    m = size(y_estim,2);
    
    err = 0;
    
    for i = 1 : m
        if (y_estim(1,i) <> y_test(i)) then
            err = err +1;
        end
    end
    
    err = err / m;
    
endfunction


function index = mostPresentIndex(liste)
    
    counting_list = zeros(size(liste,1));
    
    for i = 1 : size(liste,1)
        counting_list(liste(i)) = counting_list(liste(i))+1;
    end
    
    index = max(counting_list);
endfunction



function liste = indexsOf(a, b)
    
    ind = 1;
    l = size(b,1);
    
    for i = 1 : size(a,1)
        while (ind < l & a(i) <> b(ind))
            ind = ind + 1;
        end
        liste(i) = ind;
        ind = 1;
    end
    
endfunction


function m = distance(a, b)
    m = abs(a-b)
endfunction

//x_train = double([  train0(1:n,:); train1(1:n,:); train2(1:n,:); train3(1:n,:);
//                    train4(1:n,:); train5(1:n,:); train6(1:n,:); train7(1:n,:);
//                    train8(1:n,:); train9(1:n,:)]);
//                    
//y_train = [ ones(n, 1); ones(n, 1)*2; ones(n, 1)*3; ones(n, 1)*4; 
//            ones(n, 1)*5; ones(n, 1)*6; ones(n, 1)*7; ones(n, 1)*8; 
//            ones(n, 1)*9; ones(n, 1)*10];
//            
//x_test = double([   test0; test1; test2; test3; test4; 
//                    test5; test6; test7; test8; test9]);
//                    
//y_test = [  ones(size(test0,1), 1); ones(size(test1,1),1)*2;
//            ones(size(test2,1), 1)*3; ones(size(test3,1), 1)*4; 
//            ones(size(test4,1), 1)*5; ones(size(test5,1), 1)*6; 
//            ones(size(test6,1), 1)*7; ones(size(test7,1), 1)*8; 
//            ones(size(test8,1), 1)*9; ones(size(test9,1), 1)*10];


x_train = double([  train0(1:n,:); 
                    train1(1:n,:); 
                    train2(1:n,:)]);

y_train = [ones(n, 1); ones(n, 1)*2; ones(n, 1)*3];

x_test = double([test0; test1; test2]);

y_test = [  ones(size(test0,1), 1); 
            ones(size(test1,1),1)*2; 
            ones(size(test0,1), 1)*3];
            
            
//train0(1:n,:)

//y=matrix(train0(1,:),28,28)';
//Matplot(y);

y_estim = zeros(1,size(y_test,1));

//Trouver les k plus proche voisins pour chaque ligne de x_test 
// et estimer sa classe
//Sauvegarder les classes dans un vecteur y_estim (de la meme taille que y_test )
//Calculer l'erreur en utilisant l'equation (1)

distances = zeros(size(x_test,1));

for i = 1 : n
    for j = 1 : size(x_test,1)
        distances(j) = distance(x_train(i), x_test(j));
    end
    
    // on trie les distances 
    sorted_distances = gsort(distances,'g','i');
    
    indexes = indexsOf(sorted_distances(1:k),distances);
    
    y_estim(i) = mostPresentIndex(indexes);
    
    
end

errorCalculated = calculateError(y_estim, y_test)

// on prend une ligne de x_train
//La ligne numero i de la matrice x_train corresponde a la i'eme image, 
// et l'element i de y_train est sa vrai classe





