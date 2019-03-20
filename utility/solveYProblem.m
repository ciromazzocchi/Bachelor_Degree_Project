function [y,solution] = solveYProblem (Pre, C, m0, J, sigma_t, sum_set, t)

settings = sdpsettings('solver', 'glpk');

[~, transitions_num] = size(C);

y = intvar(transitions_num,J);

f_y = sum(sum(y(sum_set,:)));

Constrains = getConstrains(Pre, C, m0, J, y);
Constrains = [Constrains, sum(y(t,:),2) >= sigma_t(t)];

solution = optimize(Constrains, f_y, settings);

y = value(y);

end

