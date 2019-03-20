function Constrains = getConstrains(Pre, C, m0, J, z)

[~,transitions_num] = size(C);

Constrains = [];

for i = 1:transitions_num
    for j = 1:J
        Constrains = [Constrains, z(i,j)];
    end
end

for i = 1:J+1
    if (i == 1)
        Constrains = [Constrains, m0 >= Pre * z(:,i)];
    elseif (i == J+1)
        Constrains = [Constrains, m0 + C * sum(z(:,1:i-1),2) >= 0];
    else
        Constrains = [Constrains, m0 + C * sum(z(:,1:i-1),2) >= Pre * z(:,i)];
    end
end

end
