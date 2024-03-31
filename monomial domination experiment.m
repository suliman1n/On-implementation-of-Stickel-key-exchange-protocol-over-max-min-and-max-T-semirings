success_count = 0;
num_iterations = 100;

for i = 1:num_iterations

    w = randi([-10000, 10000], 10, 10);
    coefficients = randi([-1000, 10000], 1, 10);
    powers = 1:10;
    
  
    if isequal(TropPoly([powers; coefficients], w), TropPoly([powers(end); coefficients(end)], w))
        success_count = success_count + 1;
    end
end

success_rate = (success_count / num_iterations) * 100;
disp(['highest_monomial_dominates: ' num2str(success_rate) '% of times']);