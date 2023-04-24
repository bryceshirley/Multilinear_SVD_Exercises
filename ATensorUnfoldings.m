function [A,A1,A2,A3] = ATensorUnfoldings(n,m,r)
% A is a tensor n by m by r with elements 1 to the number of elements.
% THIS FUNCTION WORKS FOR A TENSOR OF THE FORM A(:,:,1)=[1 2 3; 4 5 6; 7 8
% 9], A(:,:,2) = [10 11 12; 13 14 15; 16 17 18], .... Constucted from a
% vector a = (1,2,3,4,...)


% The tensor in 3D form Note permute is needed since matlab is column major
for i=1:n
    for j=1:m
        for k=1:r
            A(i,j,k) = (j-1)+(i-1)*m+(k-1)*m*n +1;
        end
    end
end

a =1:n*m*r;

% Vertical slices (cols are z fibres)
A1 = reshape(reshape(a,m,[])',n,[]);

% Frontal Slices (cols are x fibres)
A2 = reshape(a,m,[]);

% Horizontal slices (cols are y fibres)
A3 = reshape(a,n*m,[])';
end