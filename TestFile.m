%% Question 1 - part 1
disp('~~~~~~~')
disp('Qu1) i.')
disp('~~~~~~~')
disp(' ')
n=10^5;
m=50;
r=5;
A = randn(m,n);
B = randn(m,n);

disp('Standard SVD - calculate AB^T directly.')
tic;
[U1,S1,V1]=svd(A*B','econ');
toc;
size(U1)
disp('SVD with QR - calculate AB^T not directly.')
tic;
[U2,S2,V2]=svdABTranspose(A,B);
toc;
size(U2)
disp('Frobenius Norm of U')
norm(U2-U1, 'fro')
disp('Frobenius Norm of S')
norm(S2-S1, 'fro')
disp('Frobenius Norm of V')
norm(V2-V1, 'fro')

%% Question 1 -part 2
disp('~~~~~~~~')
disp('Qu1) ii.')
disp('~~~~~~~~')
disp(' ')
disp('Standard SVD of A')
tic;
[U1,S1,V1]=svd(A,'econ');
toc;
size(U1)
disp('Randomized SVD of matrix A.')
tic;
[U2,S2,V2] = randomizedSVD(A,r);
toc;
size(U2)
disp('Frobenius Norm of U')
norm(U2-U1, 'fro')
disp('Frobenius Norm of S')
norm(S2-S1, 'fro')
disp('Frobenius Norm of V')
norm(V2-V1, 'fro')

%% Question 1 -part 3
disp('~~~~~~~~~')
disp('Qu1) iii.')
disp('~~~~~~~~~')

disp('Standard SVD - calculate AB^T directly.')
tic;
[U1,S1,V1]=svd(A*B','econ');
toc;
size(U1)
disp('Randomized SVD of matrix AB^T.')
tic;
[U2,S2,V2] = randomizedSvdABTranspose(A,B,r);
toc;
size(U2)
disp('Frobenius Norm of U')
norm(U2-U1, 'fro')
disp('Frobenius Norm of S')
norm(S2-S1, 'fro')
disp('Frobenius Norm of V')
norm(V2-V1, 'fro')