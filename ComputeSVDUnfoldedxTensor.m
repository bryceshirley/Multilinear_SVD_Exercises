function [Un,Sn,Vn] = ComputeSVDUnfoldedxTensor(I1,I2,I3,n,r)
%Input: Tensor dimensions I1,I2,I3. r columns of randomized svd matrix

% Compute tensor X defined as X(i,j,k) = 1/(i+j+k)
X = xTensor(I1,I2,I3);

% Unfold tensor X into its vertical, frontral and horizontal matrix slice
% forms.
Xn = UnfoldTensor(X,n);

% Compute the randomized SVD of mode-n unfolded matrix form
[Un,Sn,Vn] = randomizedSVD(Xn,r);

% [U2,S2,V2] = randomizedSVD(X2,r);
% 
% [U3,S3,V3] = randomizedSVD(X3,r);

%% Qu2 Compute G= X*X1*U1'*X2*U2'*X3*U3'
G = X*X1*U1'*X2*U2'*X3*U3';
%% Qu3 Compute Y= G*X1*U1*X2*U2*X3*U3
Y = G*X1*U1*X2*U2*X3*U3;
%% Qu3 Compute X-Y
frobeniusNorm = norm(X-Y, 'fro');
end