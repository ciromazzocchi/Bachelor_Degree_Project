function Constrains = getSigmaConstrains(PreL, CL, m0, J, sigma)

[~, transitions_num] = size(CL);

Constrains = [];

for i = 1:transitions_num
    for j = 1:J
        Constrains = [Constrains, sigma(i,j) >= 0];
    end
end

for i = 1:J+1
    if (i == 1)
        Constrains = [Constrains, m0 >= PreL * sigma(:,i)];
    elseif (i == J+1)
        Constrains = [Constrains, m0 + CL * sum(sigma(:,1:i-1),2) >= 0];
    else
        Constrains = [Constrains, m0 + CL * sum(sigma(:,1:i-1),2) >= PreL * sigma(:,i)];
    end
end

end
