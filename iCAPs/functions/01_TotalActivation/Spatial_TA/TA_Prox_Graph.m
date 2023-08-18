function x_out = TA_Prox_Graph(y,param)

% This function computes the TV regularization
%
% F(x) = min ||y - x ||^2 + lambda * ||TV{x}||_1
%
% using the 3D extension of the FISTA:

%Beck, A., & Teboulle, M. (2009). A fast iterative shrinkage-thresholding algorithm for linear inverse problems. 
%SIAM journal on imaging sciences, 2(1), 183-202.





%%%%%%---INPUTS---%%%%%%

% y : 3D or 4D volume % If y is 4D, a 3D algorithm is applied to the first 3 compenenets in parallel

% param : Structure should contain the following parameters 


%param.NitSpat 
%param.LambdaSpat : The spatial regularization parameter
%param.lmax : maximum laplacian eigenvalue  
%param.tol  : tolerance between iterations for the stopping criteria
%param.nu = 1; gradient descent step



%%%%%---OUTPUTS---%%%%%%
% x_out : denoised output
%%%%%%%%%%%%%%%%%%%%%%%%%

% Written by Younes, 10.03.2016
% graph version,     02.03.2019


x_out = zeros(size(y)); % out


p=gcp;
fprintf('There are %d workers in pool.\n', p.NumWorkers);

param_tv.maxit = param.NitSpat;
yy=y';

parfor t=1:param.Dimension(4)
x_out(t,:) = gsp_prox_tv(yy(:,t),param.LambdaSpat,param.G,param_tv);
%x_out(t,:) = gsp_prox_tik(yy(:,t),param.LambdaSpat,param.G,param_tv);
%x_out(t,:) = MyProx_graph(y(t,:),param);
end

end
