%% ~~~ Multilinear SVD Exercise Function Test File ~~~

% Various comments have been added to provided an explanation of the theory
% with in this file and the functions accossiated with it.

% These Questions were designed by Hussam Al Daas and implementented by Bryce 
% Shirley with help from Hussam Al Daas.

% Question 1 - various implementations of the SVD is used to compute the SVD 
% of the matrix product AB^T and a function is created to find the mode-n 
% unfoldings of a 3D tensors.

% Question 2-4 - An implenetation of the Multilinear SVD outlined in "A 
% MULTILINEAR SINGULAR VALUE DECOMPOSITION" by LIEVEN DE LATHAUWER, BART DE 
% MOOR and JOOS VANDEWALLE.

% Question 5 - An implementation of Questions 2-4 Multilinear SVD with the 
% the extension of Truncated SVDs.

% Question 6 - An implementation of Questions 2-4 Multilinear SVD with the 
% the extension of Randomized Truncated SVDs.

%% Question 1 - part 1
disp('~~~~~~~')
disp('Qu1) i.')
disp('~~~~~~~')
disp(' ')

m=1000;
n=100;

A = randn(m,n);
B = randn(m,n);

disp('Time to Compute Classic SVD - calculate AB^T directly.')
tic;
X = A*B';
[U,S,V]=svd(X,'econ');
toc;

disp('Time to Compute SVD with QR - calculate AB^T not directly.')
tic;
[U,S,V]=SvdABTranspose(A,B);
toc;

% Computing the standard SVD by first computing A*B' directly cost
% considerably more computational time and takes much more memory. Matlab
% is unable to store a matrix if the number of columns m are a couple of
% orders of magnitude larger.
% The computation of A*B' is also numerically unstable due to round off
% error.
% For these reasons A*B' should never be computed.
% Using the QR method as seen in function [U,S,V]=svdABTranspose(A,B)
% drastically improves these properties.


m=10^5;
n=100;

A = randn(m,n);
B = randn(m,n);

disp('Time to Compute SVD with QR - calculate AB^T not directly. Much larger A and B.')
QRstart=tic;
[Uqr,Sqr,Vqr]=SvdABTranspose(A,B);
QRtime=toc(QRstart);
disp(['Elapsed time is ', num2str(QRtime) ,' seconds.'])
% There m was too large for MATLABs memory when computing AB' directly,
% however, the svd was computed in approx 0.25s when using the QR
% decomposition.
%% Question 1 -part 2
disp('~~~~~~~~')
disp('Qu1) ii.')
disp('~~~~~~~~')
disp(' ')

disp('Time to Compute Classic SVD of A.')
tic;
[U,S,V]=svd(A,'econ');
toc;

% When using the random svd we want to choose parameter r so that we can
% approximate a rank-r matrix. This will later be down by introduceing
% another parameter p where we use r+p to generate a guassian matrix, which
% is called over sampling. For now we will just pick r << n.

% Random matrix columns parameter r:
r = 10;  % r<<n
disp('Time to Compute Randomized SVD of matrix A.')
tic;
[Ur,Sr,Vr] = RandomizedSVD(A,r);
toc;

% Relative Frobenius Norm of randomized approximation of A. 
% Approximation of A 
Ar = Ur*(Sr*Vr');

disp('Relative Frobenius norm of randomized svd approximation of A')
relativeFrobeniusNorm = norm(A-Ar, 'fro')/norm(A,'fro');
disp(relativeFrobeniusNorm);
%% Question 1 -part 3
disp('~~~~~~~~~')
disp('Qu1) iii.')
disp('~~~~~~~~~')

disp('Recall the time to compute the SVD using QR Method of AB^T:')
disp(['Elapsed time was ', num2str(QRtime) ,' seconds.'])


disp('Time to Compute randomized SVD of matrix AB^T.')
tic;
[Ur,Sr,Vr] = RandomizedSvdABTranspose(A,B,r);
toc;

% I know this is wrong but what is the alternative?
% Recall: ||A||_fro equals ||S||_fro where ||.||_fro is the Frobenius Norm.
% relativeFrobeniusNorm = norm(diag(Sr)-diag(Sqr), 'fro')/norm(diag(Sqr),'fro'); 
% disp(relativeFrobeniusNorm);

%% Construct Matrix X for Questions 2 to 6
I1=100; I2=200; I3=300;

X = xTensor(I1,I2,I3);

%% Question 2-5 Multilinear SVD
disp(' ')
disp('~~~~~~~')
disp('Qu2-5) ')
disp('~~~~~~~')
disp(' ')
disp('Computation time for Multilinear SVD:')
% Qu2 Compute G= X *_1 U1' *_2 U2' *_3 U3'

% Using Classic svd
tic;
[U1,S1,V1] = ComputeSVDUnfoldedxTensor(X,1); % mode-1
[U2,S2,V2] = ComputeSVDUnfoldedxTensor(X,2); % mode-2
[U3,S3,V3] = ComputeSVDUnfoldedxTensor(X,3); % mode-3

% Compute G
G1 = TensorMatrixProduct(X,U1',1);
G2 = TensorMatrixProduct(G1,U2',2);
G = TensorMatrixProduct(G2,U3',3);

% Qu3 Compute Y= G *_1 U1 *_2 U2 _3 U3

% Compute Y
Y1 = TensorMatrixProduct(G,U1,1);
Y2 = TensorMatrixProduct(Y1,U2,2);
Y = TensorMatrixProduct(Y2,U3,3);
toc;

% Qu4 Compute X-Y
disp(' ')
disp('Relative Frobenius Norm:')
relativeFrobeniusNorm = norm(X-Y, 'fro')/norm(X,'fro');
disp(relativeFrobeniusNorm)
%% Qu5
% Define tau
tau = 1e-10;
disp(' ')
disp('~~~~~~~')
disp('Qu5)')
disp('~~~~~~~')
disp(' ')
disp('Computation time for trunctated Multilinear SVD:')
tic;
% Using truncated svd
[Ut1,St1,Vt1] = ComputeTruncatedSVDUnfoldedxTensor(X,tau,1); % mode-1
[Ut2,St2,Vt2] = ComputeTruncatedSVDUnfoldedxTensor(X,tau,2); % mode-2
[Ut3,St3,Vt3] = ComputeTruncatedSVDUnfoldedxTensor(X,tau,3); % mode-3

% Compute G
G1 = TensorMatrixProduct(X,Ut1',1);
G2 = TensorMatrixProduct(G1,Ut2',2);
G = TensorMatrixProduct(G2,Ut3',3);

% Compute Y
Y1 = TensorMatrixProduct(G,Ut1,1);
Y2 = TensorMatrixProduct(Y1,Ut2,2);
Y = TensorMatrixProduct(Y2,Ut3,3);
toc;
disp(' ')
% Compute the relative Frobenius Norm between X and truncated Y
disp('Relative Frobenius Norm:')
relativeFrobeniusNorm = norm(X-Y, 'fro')/norm(X,'fro');
disp(relativeFrobeniusNorm)
disp('Tolerence tau:')
disp(tau)
%% Question 6: Randomized Truncated SVD
tau = 1e-10;
r = 19; % Guess what the truncated r-rank will be based on Tau.

disp(' ')
disp('~~~~~~~')
disp('Qu6)')
disp('~~~~~~~')
disp(' ')
disp('Computation time for Randomized Trunctated Multilinear SVD:')
tic;
% Using truncated svd
[Ut1,St1,Vt1] = ComputeRandomizedTruncatedSVDUnfoldedxTensor(X,tau,1,r); % mode-1
[Ut2,St2,Vt2] = ComputeRandomizedTruncatedSVDUnfoldedxTensor(X,tau,2,r); % mode-2
[Ut3,St3,Vt3] = ComputeRandomizedTruncatedSVDUnfoldedxTensor(X,tau,3,r); % mode-3

% Compute G
G1 = TensorMatrixProduct(X,Ut1',1);
G2 = TensorMatrixProduct(G1,Ut2',2);
G = TensorMatrixProduct(G2,Ut3',3);

% Compute Y
Y1 = TensorMatrixProduct(G,Ut1,1);
Y2 = TensorMatrixProduct(Y1,Ut2,2);
Y = TensorMatrixProduct(Y2,Ut3,3);
toc;
disp(' ')

% Compute the relative Frobenius Norm between X and truncated Y
disp('Relative Frobenius Norm:')
relativeFrobeniusNorm = norm(X-Y, 'fro')/norm(X,'fro');
disp(relativeFrobeniusNorm)
disp(' ')
disp('Tolerence tau:')
disp(tau)
