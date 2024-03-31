function [c, d_,N] = MaxminFind_max_min_solution_Circulant(A, B, U,s,t)
    
    n = size(A, 1);
    d=n-1;

    
    A_generators = MaxminAllGeneratorsCirculant(A, d,s);
    B_generators = MaxminAllGeneratorsCirculant(B, d,t);


    I = cell(d + 1, d + 1);
    K = cell(d + 1, d + 1);
    S = cell(d + 1, d + 1);
    c = zeros(d + 1, d + 1);
    N=cell(d + 1, d + 1);
    d_ = zeros(d + 1, d + 1);

    for alpha = 0:d
        for beta = 0:d
            T = MaxMinMulti(A_generators{alpha + 1}, B_generators{beta + 1});

            
            
            c_ab = min(U(T > U));
            if isempty(c_ab)
                c_ab = 10000; %inf
            end

            %S_ab = find(T >= U & c_ab >= U);
            I_ab=(T >= U & c_ab == U);
            K_ab=(T == U & c_ab > U);
            S_ab=or(I_ab,K_ab);


            I{alpha+1,beta+1} = I_ab;
            K{alpha+1,beta+1} = K_ab;
            S{alpha+1,beta+1} = S_ab;
            c(alpha+1,beta+1) = c_ab;
        end
    end



    I_total=or(sum(cat(n,I{:}),n),sum(cat(n,I{:}),n));
    K_total=or(sum(cat(n,K{:}),n),sum(cat(n,K{:}),n));


    for alpha = 0:d
        for beta = 0:d
            N_ab=S{alpha+1,beta+1}-(or(I_total-I{alpha+1,beta+1},K_total-K{alpha+1,beta+1}));
            N_ab(N_ab == -1) = 0;

            d_ab=max(U(or(N_ab,N_ab)));
            if isempty(d_ab)
                d_ab = -10000; %-inf
            end

            N{alpha+1,beta+1} = N_ab;
            d_(alpha+1,beta+1) = d_ab;
        end
    end



end


