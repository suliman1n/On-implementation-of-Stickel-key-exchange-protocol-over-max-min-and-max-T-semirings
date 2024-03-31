function AvgTime = MaxminKU_TimeWithDegreeCirculant(max_degree,mm,mM,trials)
    AvgTime = zeros(1, max_degree);
    for d = 2:max_degree
        time_sum = 0;
        for trial = 1:trials
            tic;
            s=randi([0 1000]);
            t=randi([0 1000]);
            [key, U, V] = MaxminGenerateKeyStickelsCirculant(d, mm, mM, s, t);
            [A_result,B_result]=Prepare_A_b_Circulant(maxminId(d),maxminId(d),U,s,t);
            A_result = fuzzyMatrix(A_result);
            B_result = fuzzyMatrix(B_result);
            S = fuzzySystem('maxmin',A_result,B_result,fuzzyMatrix(), true);
            S.solve_inverse();
            S.x;
            S.x.gr;
            S.x.low;
            c = reshape(S.x.gr, d, d)';
            c = double(c);
            for co = 1:size(S.x.low,2)
                min_solu = reshape(S.x.low(:,co),d,d)';
                min_solu = double(min_solu);
                [x, y, w1, w2] = MaxminSolveSystemGivenCovertestn1(c, min_solu);
                if ~isempty(x)
                    break
                end
                disp("no x")
                disp(co)
            end
            K_attack = MaxMinMulti(MaxminApplygeneratorcell([0:d-1; x'], maxminId(d),s), MaxMinMulti(V, MaxminApplygeneratorcell([0:d-1; y'], maxminId(d),t)));
            time_sum = time_sum + toc;
        end
        AvgTime(d) = time_sum / trials;
    end
    plot(1:max_degree, AvgTime);
    xlabel('Degree');
    ylabel('Average Execution Time');
    title('Average Execution Time vs Degree');
end
