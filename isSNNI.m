function [T, sigma_t] = isSNNI(Pre, C, m0, L, J)
settings = sdpsettings('solver', 'glpk');

T = [];

PreL = Pre(:,L);
CL = C(:,L);

[~,num_L_transitions] = size(CL);
[~,num_transitions] = size(C);

H = setxor(1:num_transitions, L);

sigma_t = [];

for i = 1:num_L_transitions
    sigma = intvar(num_L_transitions,J);

    temp = sum(sigma,2);
    temp = temp(i);

    Constrains = getSigmaConstrains(PreL, CL, m0, J, sigma);

    optimize(Constrains, -temp, settings);

    sigma_t = [sigma_t,value(temp)];
end

for i = L
     [x,solution_x] =  solveXProblem(Pre, C, m0, J, sigma_t, H, i);
     [y,~] =  solveYProblem(Pre, C, m0, J, sigma_t, L, i);
    
    if((solution_x.problem == 0 && sum(sum(x(H,:)),2) ~= 0) ||  sum(sum(y(H,:)),2) ~= 0)
        T = [T,i];
    end
end
end

