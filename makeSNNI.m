function [ D ] = makeSNNI(Pre, Post, m0, L, J, PS)
addpath(genpath('utility'));

C = Post - Pre;

[T,sigma_t] = isSNNI(Pre, C, m0, L, J);

if(isempty(T))
    D = [];
else
    D = getSNNI(Pre, C, m0, L, J, PS, T, sigma_t);
end
end
