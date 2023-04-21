function A = ATensorUnfoldings(n,m,r)
% A is a tensor 2 by 3 by 4 with elements 1 to the number of elements. 
%n=3;
%m=2;
%r=4;
A = zeros(n,m,r);

for i=1:n
    for j=1:m
        for k=1:r
            A(i,j,k) = j+m*(i-1)+n*m*(k-1);
        end
    end
end
%A1=[[A(:,1,1),A(:,1,2),A(:,1,3),A(:,1,4)],[A(:,2,1),A(:,2,2),A(:,2,3),A(:,2,4)]];
%A2=[A(:,:,1)',A(:,:,2)',A(:,:,3)'];
%A3=[[A(1,:,1);A(1,:,2);A(1,:,3);A(1,:,4)],[A(2,:,1);A(2,:,2);A(2,:,3);A(2,:,4)],[A(3,:,1);A(3,:,2);A(3,:,3);A(3,:,4)]];


for i1=1:I1
    for i2=1:I2
        for i3=1:I3
            A1(I1,I1= A(i,j,k)
end