function KeyStickelsMaxMinRandomness(MaxDegree, no_trials, n, mm, mM, pm, pM)
    % Initialize arrays to store results
    D_values = 2:MaxDegree;
    average_unique_count = zeros(size(D_values));

    % Perform trials for each D value
    for i = 1:length(D_values)
        D = D_values(i);
        unique_counts = zeros(1, no_trials);

        for trial = 1:no_trials
            % Generate the matrix
            matrix = GenerateKeyStickelsmaxmin(n, mm, mM, D, pm, pM);

            % Count the number of unique elements
            unique_counts(trial) = numel(unique(matrix));
        end

        % Compute the average for the current D
        average_unique_count(i) = mean(unique_counts);
    end

    % Plot the results
    plot(D_values, average_unique_count, '-o');
    xlabel('Polynomial Degree');
    ylabel('Average Number of Unique Elements');
    title('Average Unique Elements vs. Polynomial Degree');
    grid on;
end
