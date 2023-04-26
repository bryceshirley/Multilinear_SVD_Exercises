function Y=TensorMatrixProduct(X,x)
% X is a tensor in Real(I1,I2,I3) and x is a matrix in 
% real(J,In) where In is I1, I2 or I3.

[J,In] = shape(x);

[I1,I2,I3] = shape(X);

if In == I1
    % Use Mode-1 unfolding
    % Xn = X1 in Real(I1,I3*I2)
    Xn = UnfoldTensor(X,1);
    XnCols = I3*I2; 
    % Note: mode-1 product will be Y in real(J,I2,I3)
elseif In == I2
    % Use Mode-2 unfolding
    % Xn = X2 in Real(I2,I1*I3) 
    Xn = UnfoldTensor(X,2);
    XnCols = I1*I3; 
    % Note: mode-2 product will be Y in real(I1,J,I3)
else 
    % Use Mode-3 unfolding
    % Xn = X3 in Real(I3,I2*I1) 
    Xn = UnfoldTensor(X,3);
    XnCols = I2*I1; 
    % Note: mode-3 product will be Y in real(I1,I2,J)
end

for i = 1:XnCols
    Ycols(:,i)=x*Xn(:,i); 
    % x in real(J,In) * Xn in real(In,I(n-1)*I(n+1))
    % Hence Ycols in real(J,I(n-1)*I(n+1)) which needs to be reshaped
    % Y in real(I1,...,I(n-1),J,I(n+1),...,IN).
end

end



