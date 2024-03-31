function KeyStickelsMaxMinRandomnessdetails(MaxDegree, no_trials, n, mm, mM, pm, pM)
    % Initialize arrays to store results
    D_values = 2:MaxDegree;
    unique_counts_matrix = cell(1, length(D_values));
    average_unique_count = zeros(size(D_values));

    % Perform trials for each D value
    for i = 1:length(D_values)
        D = D_values(i);
        unique_counts = zeros(no_trials, 1);

        for trial = 1:no_trials
            % Generate the matrix
            matrix = GenerateKeyStickelsmaxmin(n, mm, mM, D, pm, pM);

            % Count the number of unique elements
            unique_counts(trial) = numel(unique(matrix));
        end

        % Store unique counts for each trial
        unique_counts_matrix{i} = unique_counts;

        % Calculate average for each polynomial degree
        average_unique_count(i) = mean(unique_counts);
    end

    % Plot the results using a single figure with boxplots and averages
    figure;

    % Create boxplots for each polynomial degree
    boxplot(cell2mat(unique_counts_matrix), 'Labels', cellstr(num2str(D_values')));

    % Highlight median (average) with red color
    h = findobj(gca, 'Tag', 'Median');
    set(h, 'Color', 'r');

    % Plot the average as a line at the correct positions
    hold on;
    plot(1:length(D_values), average_unique_count, '-o', 'LineWidth', 2, 'DisplayName', 'Average', 'Color', 'k');
    hold off;

    xlabel('Polynomial Degree');
    ylabel('Number of Unique Elements');
    title('Distribution of Unique Elements and Average for Each Polynomial Degree');
    legend('Location', 'Best');
    grid on;
end
