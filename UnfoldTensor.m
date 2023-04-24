function [X1,X2,X3] = UnfoldTensor(X)
% Unfolds 3D tensor X.
% if X is a 3,2,2 tensor such that X(:,:,1) = [x1 x2; x3 x4; x5 x6],
% X(:,:,2) = [x7 x9; x10 x11; x12 x13] then vector x is define x=[x1 x2 ...
% x12 x13].
[n,m,~] = size(X);

x = reshape(permute(X, [2 1 3]),1,[]);

% Vertical slices (cols are z fibres)
X1 = reshape(reshape(x,m,[])',n,[]);

% Frontal Slices (cols are x fibres)
X2 = reshape(x,m,[]);

% Horizontal slices (cols are y fibres)
X3 = reshape(x,n*m,[])';
end