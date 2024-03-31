function avg_time = MaxminHeuristicTimeWithDegree(n, max_degree, mm, mM, pm, pM, trials)
    avg_time = zeros(1, max_degree - 1); 
    for d = 2:max_degree
        total_time = 0;
        for trial = 1:trials
             
            [key, U, V, A, B] = GenerateKeyStickelsmaxmin(n, mm, mM, d, pm, pM);
            tic;
            [c, d_, ~] = MaxminFind_max_min_solution(A, B, U, d);
            [x, y, ~, ~] = MaxminSolveSystemGivenCovertestn1(c, d_);
            total_time = total_time + toc;
            
        end
        avg_time(d-1) = total_time / trials;
    end
    % Plotting
    figure;
    plot(2:max_degree, avg_time, '-o');
    xlabel('Degree');
    ylabel('Average Time (seconds)');
    title('Average Time vs Degree');
end
