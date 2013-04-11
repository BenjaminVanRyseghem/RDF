// This function returns the index of the line in clusters
// for which the distance between the current pixel and this line
// is the smallest.
function index = getIndexFor(pixel, clusters, k)
    // duplicate the line of 'pixel' (ex: [0.4,0.5,0.3]) k times
    mat =  repmat(pixel,k,1);
    
    // calculate the distance between each line of clusters and the pixel
    // the *[1,1,1] will do the sum of the 3 colors
    distances = ((mat - clusters).^2)*[1,1,1]';
    
    // retrieve the index of the smallest distance (between 1 and k)
    [val,index] = min(distances);
endfunction


// retrieve the indexes for all of the pixel of the image
function indexes = getIndexes(X,clusters,k)
    
    indexes = zeros(1,size(X,1))
    
    for i = 1 : size(X,1);
        indexes(i) = getIndexFor(X(i,:),clusters,k);
    end
    
endfunction


// refresh the new clusters value with the average of the 
// nearest points of the image for each cluster.
function clusters = processClustering(X, indexes, k)
    
    for i = 1 : k
        
        // retrieve the indexes in 'indexes' that have the value i
        ind = find(indexes == i);
        
        // compute the average of the values of pixels at 'ind' 
        // in the image 'X'
        avg = mean(X(ind,:),'r');
        
        // put the new value at line i
        clusters(i,:) = avg;
    end
endfunction


// apply the new values of the clusters on the image and return it.
function newX = compressImage(X, indexes, clusters, k)
    
    newX = X;
    
   for i = 1 : k
        
        // retrieve the indexes in 'indexes' that have the value i
        ind = find(indexes == i);

        // duplicate the line i of 'clusters' (ex: [0.4,0.5,0.3]) 
        // size of 'ind' times
        newValues = repmat(clusters(i,:),size(ind,2),1);

        newX(ind,:) = newValues;
    end
    
endfunction

//Charger l'image
A = imread('bird_small.png');

//Diviser par 255 pour avoir les valeurs entre 0 et 1
A = im2double(A);

img_size = size(A);

// Transformer la matrice A en une matrice de Nx3 où
// N = nombre des pixels et chaque ligne contient les valeurs 
// R G et B du pixel.
// Ceci donne les donnee à clustere:
X = matrix(A, img_size(1) * img_size(2), 3);

//Clusterer les pixels en K=16 clusters (i.e. 16 couleurs)
k = 16;

// initialisation des tableaux d index
indexes = [];
previousIndexes = [1];

//Fixer le maximum nombre d'iterations de k-means à 10
max_iter = 10;

// N'oubliez pas d'initialiser les premiers centres aléatoirement
clusters = (grand(1,'prm',[1:k]')/k)*size(X,1);
clusters = X(clusters,:);

// Remplacer chaque pixel dans l'image original par le centre de son cluster
// et creer X_compressed
i = 1;
while max_iter >= i & mean(bool2s(previousIndexes == indexes)) ~= 1,
    
    disp(i, '====================== i = ');
    
    previousIndexes = indexes;
    
    indexes = getIndexes(X, clusters, k);

    clusters = processClustering(X, indexes, k);
    
   i = i+1;
end

X_compressed = compressImage(X, indexes, clusters, k);

//Apres avoir creer X_compressed retransformer le 
//par le code suivant
X_compressed=matrix(X_compressed, img_size(1),img_size(2),3);

//imagesc(X_compressed);

imshow(X_compressed);
