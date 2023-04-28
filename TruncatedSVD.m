function [Ut,St,Vt]=TruncatedSVD(A,tau)
[U,S,V]=svd(A,'econ');

% norm(A,'fro') == norm(S,'fro')
% Vector of singular values
s=diag(S);

r=sum(cumsum(flip(s).^2) > (tau*norm(s,'fro'))^2);

Ut = U(:,1:r);
St = diag(s(1:r));
Vt = V(:,1:r);
end