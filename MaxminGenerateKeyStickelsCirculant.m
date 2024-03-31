function [key,U,V] = MaxminGenerateKeyStickelsCirculant(n, mm, mM, s, t)
    A1 = MaxminCreateModifiedSCirculant(RandomColumnVector(n, mm, mM), s);
    A2 = MaxminCreateModifiedSCirculant(RandomColumnVector(n, mm, mM), t);

    B1 = MaxminCreateModifiedSCirculant(RandomColumnVector(n, mm, mM), s);
    B2 = MaxminCreateModifiedSCirculant(RandomColumnVector(n, mm, mM), t);

    U = MaxMinMulti(A1, A2);
    V = MaxMinMulti(B1, B2);

    KA = MaxMinMulti(A1, MaxMinMulti(V, A2));
    KB = MaxMinMulti(B1, MaxMinMulti(U, B2));

   if isequal(KA, KB)
        key = KA;
    else
        key = [];
    end
end
