function V_X = TropPoly(V,X)
%TropPoly - This computes the tropical polynomial V of the variable X
%   Detailed explanation goes here
% deg = the deg of the polynomial
%V is the vector corresponding the polynomial, it will be in the form of a 2 by deg+1 vector,
% the first row will be the power , the second row is the coefficent
% of the degree (i.e in tropical this gets added onto it)
[n,m] = size(X);
[p,q]  =size(V);
D = zeros(n,m)+ (-inf);
temp = D;
for i =1:q
    if V(1,i)==0
        temp = zeros(n,m)+V(2,i);
        D = max(D,temp);
    else 
        c = TropMatPower(X,V(1,i));
        temp = V(2,i)+c;
        D = max(D,temp);
    end
end
%We consider the degree of 0 separately. 
V_X = D;
end


