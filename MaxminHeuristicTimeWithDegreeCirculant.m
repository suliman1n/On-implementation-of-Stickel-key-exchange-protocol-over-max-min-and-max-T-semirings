function avg_time = MaxminHeuristicTimeWithDegreeCirculant(max_degree, mm, mM, trials)
    avg_time = zeros(1, max_degree - 1); 
    for d = 2:max_degree
        total_time = 0;
        for trial = 1:trials
             
            s=randi([-1000 1000]);
            t=randi([-1000 1000]);
            [key,U,V] = MaxminGenerateKeyStickelsCirculant(d, mm, mM, s, t);
            tic;
            [c, d_,N] = MaxminFind_max_min_solution_Circulant(maxminId(d), maxminId(d), U,s,t);
            [x, y, ~, ~] = MaxminSolveSystemGivenCovertestn1(c, d_);
            total_time = total_time + toc;
            
        end
        avg_time(d-1) = total_time / trials;
    end
    
    figure;
    plot(2:max_degree, avg_time, '-o');
    xlabel('Degree');
    ylabel('Average Time (seconds)');
    title('Average Time vs Dimension');
end
