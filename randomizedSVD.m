function [U,S,V] = randomizedSVD(A,r)
% Function that calculates the rank-r approximation of matrix A using the
% HMT Randomised SVD Algorithm. 
% Inputs (Matrices):
% - A in Real^(m,n)
% - r from a rank-r approximation usually r << n 
% Outputs:
% - U orthonormal matrix of left singular vectors (cols)
% - S diagonal matrix of singular values
% - V orthogonal matrix of right singular vectors
%
% The algorithm steps are numbered below:
    

    % Find the number of columns in A
    n = size(A,2);

    % 1. Generate a Gaussian matrix X in N(0,1)
    X = randn(n,r);
    
    % 2. Compute AX
    AX = A*X;

    % 3. Calculate the QR decomposition of AX=QR
    [Q,~] = qr(AX,'econ');
    
    % 4. Find rank-r approximation of the SVD. A \approx QQ'A.
    [U0,S,V] = svd(Q'*A,'econ');

    U = Q*U0;
end