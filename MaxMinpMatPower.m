function [C] = MaxMinpMatPower(A,p)
%TropMatPower - Completes Tropical matrix multiplication p times (to the
%power of p)
%   Detailed explanation goes here
[n,m] = size(A);
if (n~=m)
    error("Dimension Error! Not a square matrix")
end 
if p ==0
    C = maxminId(n);
    return
end 
temp = A;
for i =2:p
    temp = MaxMinMulti(A,temp);
end
C = temp;
end