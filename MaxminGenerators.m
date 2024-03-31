function powers = MaxminGenerators(A, d)
    powers = cell(1, d+1);

    for i = 0:d
        powers{i+1} = MaxMinpMatPower(A, i);
    end
end


