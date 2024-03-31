function [A_result,B_result]=Prepare_A_b(A,B,U,d)
    A_generators = MaxminGenerators(A, d);
    B_generators = MaxminGenerators(B, d);

    A_result = zeros(size(A, 1)*size(A, 1), (d+1)*(d+1));
    B_result = zeros(size(U, 1)*size(U, 1), 1);
    col_index = 1;
    for alpha = 0:d
        for beta = 0:d
            T = MaxMinMulti(A_generators{alpha + 1}, B_generators{beta + 1});
            A_result(:, col_index) = reshape(T, [], 1);
            col_index = col_index + 1;
        end
    end
    B_result(:, 1) = reshape(U, [], 1);
end