function log_alpha = Foward(ModPara,log_Obs,options)
% alpha is forward probability ;T*K
% recursive 1 to T
T = options.T;% eg. 1000*ones(100,1)
t0 = T(1);% t0 is number of time points of each subject, eg. 1000 time points of each sub
tN = length(T);% tN is the subject number, eg.100 subjects
K = options.K;
Pi = ModPara.Pi;
A = ModPara.A;

log_alpha = zeros(t0*tN,K);
for n = 0:tN-1

    for k = 1:K       
        log_alpha(1+n*t0,k) = log(Pi(k)) + log_Obs(1+n*t0,k);
    end

    for t = 1:t0-1
        ts = t + n*t0; % time slice for one subject
        for k = 1:K
    %       alpha(t+1,k) = (sum(alpha(t,:)*A(:,k)))*ObsProb(t+1,k);
            log_alpha(ts+1,k) = logsumexp(log_alpha(ts,:) + log(A(:,k)')) + ...
                log_Obs(ts,k);
        end
    end

end

end

