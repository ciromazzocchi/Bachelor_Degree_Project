function [ D ] = getSNNI(Pre, C, m0, L, J, PS, T, sigma_t)

[~, transitions_num] = size(C);

H = setxor(1:transitions_num, L);
NS = setxor(union(L,H),PS);
D = [];
CS = PS;

for i = T
    [y,~] =  solveYProblem(Pre, C, m0, J, sigma_t, union(L,PS), i);
    if( sum( sum( y(intersect(NS,H),1:J) ) ,2) > 0 )
        error('Problem does not admin solution')
    end

    [x,~] = solveXProblem(Pre, C, m0, J, sigma_t, PS, i);
    if( sum( sum( x(intersect(NS,H),1:J) ) ,2) > 0 )
        error('Problem does not admin solution')
    end
end

for i = T
    Dt = [];
    [y,~] =  solveYProblem(Pre, C, m0, J, sigma_t, union(L,Dt), i);
    if( sum( sum( y(CS,:) ) ) > 0 )
        for j = CS
            if ( sum( y(j,:) ) > 0 )
                Dt = union(Dt,j);
                CS = setxor(CS,j);
            end
            if ( isempty(CS) )
                D = PS;
                return;
            end
        end
    end
    [x,~] = solveXProblem(Pre, C, m0, J, sigma_t, Dt, i);
    if( sum( sum( x(CS,:) ) ) > 0 )
        for j = CS
            if ( sum ( x(j,:) ) > 0 )
                Dt = union(Dt,j);
                CS = setxor(CS,j);
            end
            if ( isempty(CS) )
                D = PS;
                return;
            end
        end
    end
    D = union(D,Dt);
end
end

