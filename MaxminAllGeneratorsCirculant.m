function powers = MaxminAllGeneratorsCirculant(A, d,s)
    powers = cell(1, d);

    for i = 0:d
        powers{i+1} = MaxminGeneratorsCirculant(A, i,s);
    end
end


