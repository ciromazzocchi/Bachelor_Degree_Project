function [x,solution] = solveXProblem (Pre, C, m0, J, sigma_t, sum_set, t)

settings = sdpsettings('solver', 'glpk');

[~, transitions_num] = size(C);

x = intvar(transitions_num,J);

f_x = sum(sum(x(sum_set,:)));

Constrains = getConstrains(Pre, C, m0, J, x);
Constrains = [Constrains, sum(x(t,:),2) >= sigma_t(t) + 1];

solution = optimize(Constrains, f_x, settings);

x = value(x);

end