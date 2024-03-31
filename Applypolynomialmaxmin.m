function V_X = Applypolynomialmaxmin(V, X)
    
    [n, m] = size(X);
    [p, q] = size(V);
    %D = zeros(n, m) + (inf);
    %temp = D;
    D=zeros(n, m) + (inf);
    for i = 2:q
        %if V(1, i) == 0
            %temp = min(maxminId(n),V(2, i));
            %D = min(D, temp);
        %else
            c = MaxMinpMatPower(X, V(1, i));
            temp = min(V(2, i),c);
            D = min(temp,D);
        %end
    end
    
    V_X = D;
end