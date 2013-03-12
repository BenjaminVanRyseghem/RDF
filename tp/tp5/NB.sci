//stacksize('max')
//loadmatfile('mnist_all.mat');

function frequences = frequencesMatrix(x_train)
    frequences = ones(10, 256)
    for i = 0 : 9
        sub = x_train((i*n+1):(i+1)*n,:)
        sorted = (tabul(sub,'i'))
        sub = sorted(:,2)
        tsub = sub'
        frequences(i+1,:) = tsub
    end
    frequences = frequences / (n*size(x_train,2))
endfunction

<<<<<<< HEAD
t = tabul(sub,'i');

frequences(i+1,:) = t(:,2)'
=======
function classe=estimate(f, fs)
    sz = size(fs,1)
    post = ones(sz,1)
    for i=1:sz
        fsi = fs(i,:)
        p = 1/10
        sz2 = size(fsi,2)
        for j=1:(sz2)
            p = p * fsi(j)
        end
        post(i)=p
    end
    //evidence est ignore car cst > 0
    [foo, indice] =max(post)
    classe = indice
endfunction
>>>>>>> 3bff6f2be77234d4c66d4ef60bfac094cd7b4a45

function y_estim=populateEstim(x_test, frequences)
    sz = size(x_test,1)
    for i = 1 : sz
        line=x_test(i,:)
        ff = tabul(line,'i')
        f = ff(:,2)
        tf = f'
        y_estim(i) = estimate(tf, frequences)
    end
endfunction

function err = calculateError(y_estim, y_test)
    // y_estim ~= y_test create a matrix made of True and False 
    // True if elements at the same places are equals
    // False otherwise
    // bool2s change True in 1 and False in 0
    errors = bool2s(y_estim ~= y_test)
    
    // then get the average of the errors
    err = mean(errors)
endfunction

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


//1. entrainer le model Naive Bayes: 
//  i.e. calculer les frequences conditionelles des chiffres manuscrits en 
//      utilisant la matrice x_train et y_train). 
//  La ligne numero i de la matrice x_train correspond a la i'eme image, 
//      et l'element i de y_train est sa vrai classe

matriceFrequence = frequencesMatrix(x_train);



//2. tester: estimer une classe pour chaque ligne de la matrice x_test 
//  et sauvegarder les classes dans un vecteur y_estim 
//  (de la meme taille que y_test )
y_estim=populateEstim(x_test,matriceFrequence);


//3. calculer l'erreur en utilisant l'equation (1)

// Calculer l'erreur en utilisant l'equation (1)
errorCalculated = calculateError(y_estim, y_test);
errorCalculated
