function success_rate = MaxminHeuristicSuccessRateWithDegree(n, max_degree, mm, mM, pm, pM, trials)
    success_count = zeros(1, max_degree - 1); 
    for d = 2:max_degree
        d
        success = 0;
        for trial = 1:trials
            trial
            [key, U, V, A, B] = GenerateKeyStickelsmaxmin(n, mm, mM, d, pm, pM);
            [c, d_, ~] = MaxminFind_max_min_solution(A, B, U, d);
            [x, y, ~, ~] = MaxminSolveSystemGivenCovertestn1(c, d_);
            if ~isempty(x)
                K_attack = MaxMinMulti(Applypolynomialmaxmincell([0:d; x'], A), MaxMinMulti(V, Applypolynomialmaxmincell([0:d; y'], B))); 
                if isequal(K_attack, key)
                    success = success + 1;
                end
            end
        end
        success_rate(d-1) = success / trials;
    end
    % Plotting
    figure;
    plot(2:max_degree, success_rate, '-o');
    xlabel('Degree');
    ylabel('Success Rate');
    title('Success Rate vs Degree');
end
