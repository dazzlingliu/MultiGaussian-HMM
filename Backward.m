function log_beta = Backward(ModPara,log_Obs,options)
% beta is backward probability ;T*K
% recursive T to 1
T = options.T;% eg. 1000*ones(100,1)
t0 = T(1);% t0 is number of time points of each subject, eg. 1000 time points of each sub
tN = length(T);% tN is the subject number, eg.100 subjects
K = options.K;
A = ModPara.A;

log_beta = zeros(t0*tN,K);
for n = 0:tN-1
    log_beta((n+1)*t0,:) = zeros(1,K);

    for t = t0-1:-1:1
        ts = t + n*t0; % time slice for one subject
        for k = 1:K
            log_beta(ts,k) = logsumexp(log(A(k,:)) + (log_Obs(ts+1,:)) + (log_beta(ts+1,:)));        
        end
    end

end
