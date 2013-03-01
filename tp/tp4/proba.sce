// example 1: Gaussienne  "  '
//d = rand(1,10000,'normal');
//clf();
// 20 baton 
//histplot(20,d,leg='rand(1,10000,''normal'')',style=16,rect=[-3,0,3,0.5]);

// example 2: Binomiale n = 6, p = 0.5
// fail 6 fois avant success et probabilite de success de 0.5
//d = grand(1000,1,"bin",6,0.5);
// creer un vector de -0.5 a 6.5 avec 8 element
//c = linspace(-0.5,6.5,8);
//clf();
//histplot(c,d,style=2);

// example 3: Exponentielle
lambda = 2;
x = grand(100000, 1, "exp", 1/lambda);
Xmax = max(x);
clf();
histplot(40, x, style=2);

x = linspace(0, max(Xmax), 100)';

plot2d(x,lambda*exp(-lamda*x), strf="000", style=5)
legend(["histogram" "la courbe exacte"]);

