function [key,U,V,A,B] = GenerateKeyStickelsmaxmin(n, mm, mM, D, pm, pM)
    
    A = randi([mm, mM], n);
    B = randi([mm, mM], n);

    
    p1 = GenerateRandomPolynomial(D, pm, pM);
    p2 = GenerateRandomPolynomial(D, pm, pM);
    q1 = GenerateRandomPolynomial(D, pm, pM);
    q2 = GenerateRandomPolynomial(D, pm, pM);

    
    U = MaxMinMulti(Applypolynomialmaxmincell(p1, A), Applypolynomialmaxmincell(p2, B));
    V = MaxMinMulti(Applypolynomialmaxmincell(q1, A), Applypolynomialmaxmincell(q2, B));

    
    KA = MaxMinMulti(Applypolynomialmaxmincell(p1, A), MaxMinMulti(V, Applypolynomialmaxmincell(p2, B)));
    KB = MaxMinMulti(Applypolynomialmaxmincell(q1, A), MaxMinMulti(U, Applypolynomialmaxmincell(q2, B)));

    
    if isequal(KA, KB)
        key = KA;
    else
        key = [];
    end
end
