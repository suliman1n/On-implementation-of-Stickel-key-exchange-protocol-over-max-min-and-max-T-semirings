function AvgTime = MaxminKU_TimeWithDegree(n,max_degree,mm,mM,pm,pM,trials)
    AvgTime = zeros(1, max_degree);
    for d = 2:max_degree
        time_sum = 0;
        for trial = 1:trials
            tic;
            [key,U,V,A,B] = GenerateKeyStickelsmaxmin(n, mm, mM, d, pm, pM);
            [A_result,B_result] = Prepare_A_b(A,B,U,d);
            A_result = fuzzyMatrix(A_result);
            B_result = fuzzyMatrix(B_result);
            S = fuzzySystem('maxmin',A_result,B_result,fuzzyMatrix(), true);
            S.solve_inverse();
            S.x;
            S.x.gr;
            S.x.low;
            c = reshape(S.x.gr, d+1, d+1)';
            c = double(c);
            for co = 1:size(S.x.low,2)
                min_solu = reshape(S.x.low(:,co),d+1,d+1)';
                min_solu = double(min_solu);
                [x, y, w1, w2] = MaxminSolveSystemGivenCovertestn1(c, min_solu);
                if ~isempty(x)
                    break
                end
                disp("no x")
                disp(co)
            end
            K_attack = MaxMinMulti(Applypolynomialmaxmincell([0:d; x'], A), MaxMinMulti(V, Applypolynomialmaxmincell([0:d; y'], B)));
            time_sum = time_sum + toc;
        end
        AvgTime(d) = time_sum / trials;
    end
    plot(1:max_degree, AvgTime);
    xlabel('Degree');
    ylabel('Average Execution Time');
    title('Average Execution Time vs Degree');
end
