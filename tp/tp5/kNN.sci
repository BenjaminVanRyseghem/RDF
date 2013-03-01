loadmatfile('mnist_all.mat');

n=200;//nombre des exemplaires d'entrainement
 
k=1; //nombre des voisins

x_train = double([  train0(1:n,:); train1(1:n,:); train2(1:n,:); train3(1:n,:); 
                    train4(1:n,:); train5(1:n,:); train6(1:n,:); train7(1:n,:); 
                    train8(1:n,:); train9(1:n,:)]);
                    
y_train = [ ones(n, 1); ones(n, 1)*2; ones(n, 1)*3; ones(n, 1)*4; 
            ones(n, 1)*5; ones(n, 1)*6; ones(n, 1)*7; ones(n, 1)*8; 
            ones(n, 1)*9; ones(n, 1)*10];
            
x_test = double([   test0; test1; test2; test3; test4; 
                    test5; test6; test7; test8; test9]);
                    
y_test = [  ones(size(test0,1), 1); ones(size(test1,1),1)*2;
            ones(size(test2,1), 1)*3; ones(size(test3,1), 1)*4; 
            ones(size(test4,1), 1)*5; ones(size(test5,1), 1)*6; 
            ones(size(test6,1), 1)*7; ones(size(test7,1), 1)*8; 
            ones(size(test8,1), 1)*9; ones(size(test9,1), 1)*10];
            

train0(1:n,:);

y_estim = zeros(size(y_test,1), size(y_test,2));

//Trouver les k plus proche voisins pour chaque ligne de x_test et estimer sa classe
//Sauvegarder les classes dans un vecteur y_estim (de la meme taille que y_test )
//Calculer l'erreur en utilisant l'equation (1)

sizeLine = size(x_train,1);

for i = 1 : n
    for j = 1 : sizeLine
        y_estim[i][j] = y_estim[i][j] + (x_train[i][j] - x_test[i][j])^2;
    end
    y_estim[i] = sqrt(y_estim[i]);
end

y_estim


// on prend une ligne de x_train


//La ligne numero i de la matrice x_train corresponde a la i'eme image, et l'element i de y_train est sa vrai classe
