// calculate the distances between a line and a x_train
function distances = getDistances(line,x_train, x_train_size)
    
    // we put in mat the line reapeated x_train_size times
    mat =  repmat(line,x_train_size,1);
    
    // then we get the distances of each line
    distances = (mat - x_train).^2;
endfunction


// get the k indexes of the k smallest distances
function index_list = getKIndex(distances, k)
    
    // we sort the distances increasingly with their indexes
    // in the list distances
    [sorted_distances, indexes] = gsort(distances,'g','i');

    // we get the k smallest distances
    index_list = indexes(1:k);
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
    [val,ind] =  max(m(:,2))
    
    // We get the good index in case there is no occurence for one index
    // see example of tabul (there is no 2)
    index = m(ind,1);
endfunction


// the kNN algorithm
function estim = kNN(x_test, x_train, y_test, y_train, k)
    
    estimation = zeros(size(y_test,1),1);
    
    for i = 1 : size(x_test,1)
        
        print(%io(2),i);
        
        // calculate the distances between a line of x_test and a x_train
        distances = getDistances(x_test(i,:),x_train, size(x_train,1));
        
        // get the k indexes of the k smallest distances
        indexList = getKIndex(distances,k);
        
        // get the most recurrent index of the list
        mostRecurIndex = mostRecurrentIndex(indexList);
        
        // then we put in estim the y_train at the most recurrent index
        estimation(i,1) = y_train(mostRecurIndex);
    end
    
    estim = estimation;
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


// ------------------------------------------------------------------------- //
// ------------------------------------------------------------------------- //

stacksize('max');
loadmatfile('mnist_all.mat');


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
// y = matrix(train0(1,:),28,28)';
// Matplot(y);


// Trouver les k plus proche voisins pour chaque ligne de x_test 
// et estimer sa classe
// Sauvegarder les classes dans un vecteur y_estim (de la meme taille que y_test )
y_estim = kNN(x_test, x_train, y_test ,y_train, k);

// Calculer l'erreur en utilisant l'equation (1)
errorCalculated = calculateError(y_estim, y_test)

