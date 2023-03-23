clc
clear all
close all

A = [[1, 0, 0, 0, 0, 0, 0, 0]; [1, 2, 4, 8, 0, 0, 0, 0]; [0, 0, 2, 0, 0, 0, 0, 0]; [0, 0, 0, 0, 0, 0, 2, 12]; [0, 0, 0, 0, 1, 0, 0, 0]; [0, 0, 0, 0, 1, 2, 4, 8]; [0, 1, 4, 12, 0, -1, 0, 0]; [0, 0, 2, 12, 0, 0, -2, 0]];  % system Ax = b
b = [6; -2; 0; 0; -2; 4; 0; 0];
x_ref = A\b;    % x reference 
[m, n] = size(A); 
L=eye(n); 
P=eye(n);       % permutation matrix
U=A;
   
for k=1:m-1
% find pivot
   [ pivot ind]=max(abs(U(k:m,k)));
   ind = ind+k-1;
   
% interchange rows
   U([k,ind],k:m)=U([ind,k],k:m);
   L([k,ind],1:k-1)=L([ind,k],1:k-1);
   P([k,ind],:)=P([ind,k],:);
   
% standard LU
   for j=k+1:m
       L(j,k)=U(j,k)/U(k,k);
       U(j,k:m)=U(j,k:m)-L(j,k)*U(k,k:m);
   end
end
z = P * b;
x = (U \ (L\(P * b)));  % LU after pivot, note the Permutation matrix
norm(x - x_ref)		    % error 