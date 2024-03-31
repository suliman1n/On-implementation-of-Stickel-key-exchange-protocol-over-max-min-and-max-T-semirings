function circulant_matrix = MaxminCreateModifiedSCirculant(column, s)
    n = length(column);
    circulant_matrix = zeros(n);

    for i = 1:n
        for j = 1:n
            circulant_matrix(i, j) = column(mod((i - j), n) + 1);
        end
    end

    for i = 1:n
        for j = (i + 1):n
            circulant_matrix(i, j) = min(circulant_matrix(i, j),s);
        end
    end
end
