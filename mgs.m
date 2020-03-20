function [log_Obs,ModPara] = mgs(Y,ModPara,options)
% multivate gaussian distribution function
T = options.T;% eg. 1000*ones(100,1)
t0 = T(1);% t0 is number of time points of each subject, eg. 1000 time points of each sub
tN = length(T);% tN is the subject number, eg.100 subjects
K = options.K;
d = options.D;
log_Obs = zeros(t0*tN,K);

for n = 0:tN-1

    for t = 1:t0
        ts = t + n*t0;
        y = Y(ts,:);    
        for k = 1:K
            mu = ModPara.state(k).mu;
            FCcov = ModPara.state(k).sigma;

            % to avoid underflow, use logObs
            lastwarn('');
            
%             % cholesky decomposition
%             [r,p] = chol(FCcov);
%             if p ~= 0
%                 disp('covariance is not positive definete');
%             end
%             yEy = (det((inv(r)).*y))^2;
%             log_Obs(ts,k) = -0.5*yEy - 0.5*log(det(FCcov)) ...
%                  -0.5*d*log(2*pi);

            log_Obs(ts,k) = -0.5*(y-mu)*(inv(FCcov))*(y-mu)' - 0.5*log(det(FCcov)) ...
                -0.5*d*log(2*pi);
            % catch warning
            [warnMsg, ~] = lastwarn;
            % pertube covariance by add tiny value to diag parameters
            if ~isempty(warnMsg)
                FCcov = FCcov + 0.001*eye(d);% pertube FC
                log_Obs(ts,k) = -0.5*(y-mu)*(inv(FCcov))*(y-mu)' - 0.5*log(det(FCcov)) ...
                    -0.5*d*log(2*pi);
            end
            ModPara.state(k).sigma = FCcov;
        end
    end

end

end

