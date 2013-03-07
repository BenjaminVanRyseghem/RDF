// calculate the distances between a line and a x_train
function distances = getDistances(line,x_train, x)
    // we put in mat the line reapeated x times
    mat =  repmat(line,x,1);
    // then we get the distances of each line
    distances = (mat - x_train).^2;
endfunction


// calculate the error between y_estim and y_test
function err = calculateError(y_estim, y_test)
    // y_estim ~= y_test create a matrix made of True and False 
    // True if elements at the same places are equals
    // False otherwise
    // bool2s change True in 1 and False in 0
    errors = bool2s(y_estim ~= y_test)
    
    // then get the average of the errors
    err = mean(errors)
endfunction

// get the most recurrent index of the list
function index = mostRecurrentIndex(liste)
    // store the elements this way :
    //      index ocurrence
    //ex:     1     3
    //        3     1
    //        4     1
    //        5     2
    m = tabul(liste,'i');
    
    // we retrieve the index of the max value of ocurrence in m
    [val,index] =  max(m(:,2))
    
    // We get the good index in case there is no occurence for one index
    // see example of tabul (there is no 2)
    index = m(index,1);
    
endfunction


// get the k indexes of the k smallest distances
function index_list = getKIndex(distances, k)
    // we sort the distances increasingly with their indexes
    // in the list distances
    [sorted_distances, indexes] = gsort(distances,'g','i');
    
    // we get the k smallest distances
    index_list = indexes(1:k);
endfunction


function estim = kNN(x_test, x_train, y_test, y_train, k)
    
    estimation = zeros(size(y_test,1),1);
    
    for i = 1 : size(x_test,1)
        // calculate the distances between a line of x_test and a x_train
        distances = getDistances(x_test(i,:),x_train, size(x_train,1));
        
        // get the k indexes of the k smallest distances
        index_list = getKIndex(distances,k);
        
        // get the most recurrent index of the list
        mostRecurIndex = mostRecurrentIndex(index_list);
        
        // then we put in estim the y_train at the most recurrent index
        estimation(i) = y_train(mostRecurIndex);
    end
    
    estim = estimation;
endfunction

//x_train = double([  train0(1:n,:); train1(1:n,:); train2(1:n,:); train3(1:n,:);
//                    train4(1:n,:); train5(1:n,:); train6(1:n,:); train7(1:n,:);
//                    train8(1:n,:); train9(1:n,:)]);
//                    
//y_train = [ ones(n, 1); ones(n, 1)*2; ones(n, 1)*3; ones(n, 1)*4; 
//            ones(n, 1)*5; ones(n, 1)*6; ones(n, 1)*7; ones(n, 1)*8; 
//            ones(n, 1)*9; ones(n, 1)*10];
//            |
//x_test = double([   test0; test1; test2; test3; test4; 
//                    test5; test6; test7; test8; test9]);
//                    
//y_test = [  ones(size(test0,1), 1); ones(size(test1,1),1)*2;
//            ones(size(test2,1), 1)*3; ones(size(test3,1), 1)*4; 
//            ones(size(test4,1), 1)*5; ones(size(test5,1), 1)*6; 
//            ones(size(test6,1), 1)*7; ones(size(test7,1), 1)*8; 
//            ones(size(test8,1), 1)*9; ones(size(test9,1), 1)*10];



//stacksize('max');
//loadmatfile('mnist_all.mat');


n=200;//nombre des exemplaires d'entrainement
 
k=1; //nombre des voisins

x_train = double([  train0(1:n,:); 
                    train1(1:n,:); 
                    train2(1:n,:)]);

y_train = [ones(n, 1); ones(n, 1)*2; ones(n, 1)*3];

x_test = double([test0; test1; test2]);

y_test = [  ones(size(test0,1), 1); 
            ones(size(test1,1),1)*2; 
            ones(size(test2,1), 1)*3];
            
// affiche l'image train0 -> 0
//y=matrix(train0(1,:),28,28)';
//Matplot(y);


//Trouver les k plus proche voisins pour chaque ligne de x_test 
// et estimer sa classe
//Sauvegarder les classes dans un vecteur y_estim (de la meme taille que y_test )
y_estim = kNN(x_test, x_train, y_test, y_train, k);
//Calculer l'erreur en utilisant l'equation (1)
errorCalculated = calculateError(y_estim, y_test);




