function success_rate = MaxminHeuristicSuccessRateWithDegreeCirculant(max_degree, mm, mM,trials)
    success_count = zeros(1, max_degree - 1); 
    for d = 2:max_degree
        success = 0;
        for trial = 1:trials
            s=randi([-1000 1000]);
            t=randi([-1000 1000]);
            [key,U,V] = MaxminGenerateKeyStickelsCirculant(d, mm, mM, s, t);
            [c, d_,N] = MaxminFind_max_min_solution_Circulant(maxminId(d), maxminId(d), U,s,t);
            [x, y, ~, ~] = MaxminSolveSystemGivenCovertestn1(c, d_);
            if ~isempty(x)
                K_attack = MaxMinMulti(MaxminApplygeneratorcell([0:d-1; x'], maxminId(d),s), MaxMinMulti(V, MaxminApplygeneratorcell([0:d-1; y'], maxminId(d),t)));
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
    title('Success Rate vs Dimension');
end