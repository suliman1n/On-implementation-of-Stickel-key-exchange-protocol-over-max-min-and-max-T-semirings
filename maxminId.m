function A = maxminId(n)
%TropIdent - Creates a Tropical Identity matrix of size n 
%   Detailed explanation goes here
A = zeros(n);
A(1:n,1:n) = 0; %-inf
for i=1:n
    A(i,i)=10000; %inf
end


%min(B(A > B))
%find(A >= B & c >= B)