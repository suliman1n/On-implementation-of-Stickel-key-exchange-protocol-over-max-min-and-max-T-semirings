function Maxmin_full_attack_stats_circulant(max_degree, mm, mM,trials)
    avg_minimal_solutions = zeros(1, max_degree - 1); % Array to store average number of minimal solutions
    avg_tested_solutions = zeros(1, max_degree - 1); % Array to store average number of tested minimal solutions
    for d = 2:max_degree
        d
        total_minimal_solutions = 0;
        total_tested_solutions = 0;
        for trial = 1:trials
            s=randi([0 1000]);
            t=randi([0 1000]);
            [key, U, V] = MaxminGenerateKeyStickelsCirculant(d, mm, mM, s, t);
            [A_result,B_result]=Prepare_A_b_Circulant(maxminId(d),maxminId(d),U,s,t);
            A_result = fuzzyMatrix(A_result);
            B_result = fuzzyMatrix(B_result);
            S = fuzzySystem('maxmin', A_result, B_result, fuzzyMatrix(), true);
            S.solve_inverse();
            S.x;
            S.x.gr;
            S.x.low;
            c = reshape(S.x.gr, d , d )';
            c = double(c);
            num_minimal_solutions = size(S.x.low, 2);
            total_minimal_solutions = total_minimal_solutions + num_minimal_solutions;
            tested_solutions = 0;
            for co = 1:num_minimal_solutions
                min_solu = reshape(S.x.low(:, co), d , d )';
                min_solu = double(min_solu);
                [x, ~, ~, ~] = MaxminSolveSystemGivenCovertestn1(c, min_solu);
                tested_solutions = tested_solutions + 1;
                if ~isempty(x)
                    break
                end
            end
            total_tested_solutions = total_tested_solutions + tested_solutions;
        end
        avg_minimal_solutions(d - 1) = total_minimal_solutions / trials;
        avg_tested_solutions(d - 1) = total_tested_solutions / trials;
    end
    
    % Plotting
    figure;
    
    % Plot for avg_minimal_solutions
    subplot(2,1,1);
    bar(2:max_degree, avg_minimal_solutions, 'b');
    xlabel('Dimension');
    ylabel('Average Number of Minimal Solutions');
    title('Average Number of Minimal Solutions vs Dimension');
    
    % Plot for avg_tested_solutions
    subplot(2,1,2);
    bar(2:max_degree, avg_tested_solutions, 'r');
    xlabel('Dimension');
    ylabel('Average Number of Tested Minimal Solutions');
    title('Average Number of Tested Minimal Solutions vs Dimension');
    
    % Adjust figure size if needed
    set(gcf, 'Position', [100, 100, 800, 600]); % Adjust width and height as needed
end
