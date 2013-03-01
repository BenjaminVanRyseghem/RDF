//loadmatfile('mnist_all.mat');

n=200; 

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

allFeatureVals = 0:255;


// visualisation d'autre chiffres chager 0 en autre.
y=matrix(train3(1,:),28,28)';

Matplot(y);

//1. entrainer le model Naive Bayes: 
//i.e. calculer les frequences conditionelles des chiffres manuscrits en utilisant la matrice x_train et y_train). 
//La ligne numero i de la matrice x_train corresponde a la i'eme image, et l'element i de y_train est sa vrai classe

//2. tester: estimer une classe pour chaque ligne de la matrice x_test et sauvegarder les classes 
//dans un vecteur y_estim (de la meme taille que y_test )

//3. calculer l'erreur en utilisant l'equation (1)
