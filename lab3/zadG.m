clc
clear all
close all
stop = 10^(-14);
iterationsJ = 0;
iterationsGS = 0;
load("Dane_Filtr_Dielektryczny_lab3_MN.mat")

tic
r = M\b;
czas_Gaussa = toc;

sizeM = size(M); 
r = ones(sizeM(1), 1);
L = tril(M, -1);
U = triu(M, 1);
D = diag(diag(M));

counting = true;

comp1 = -D\(L+U);
comp2 = D\b;

tic
while counting == true
  iterationsJ = iterationsJ + 1;
  r = comp1*r + comp2;
  res = M*r - b;
  if(norm(res) <= stop || isnan(norm(res)))
    counting = false;
  end
end
czas_Jacobi = toc;


r = ones(sizeM(1), 1);
L = tril(M, -1);
U = triu(M, 1);
D = diag(diag(M));
counting = true;

comp1 = -(D+L);
comp2 = (D+L)\b;

tic
while counting == true
  iterationsGS = iterationsGS + 1;
  r = comp1\(U*r) + comp2;
  res = M*r - b;
  if (norm(res) <= stop || isnan(norm(res)))
    counting = false;
  end
end
czas_Gauss_Seidl = toc;

