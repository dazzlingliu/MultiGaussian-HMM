function [gamma,kersi,log_gamma,log_kersi] = gammakersi(log_alpha,log_beta,ModPara,log_Obs,options)
% gamma(t,k): the occurance probability of state k in time t
% kerse(t,i,j): the transition probability of state i to state j in time t
T = options.T;% eg. 1000*ones(100,1)
t0 = T(1);% t0 is number of time points of each subject, eg. 1000 time points of each sub
tN = length(T);% tN is the subject number, eg.100 subjects
K = options.K;
A = ModPara.A;

gamma = zeros(t0*tN,K);
log_gamma = zeros(t0*tN,K);
kersi = zeros(K,K,t0*tN-tN);
log_kersi = zeros(K,K,t0*tN-tN);

for n = 0:tN-1 % time slice of each subject

    for t = 1:t0
        ts = t + n*t0;
        log_OP = logsumexp(log_alpha(ts,:)+log_beta(ts,:));
        for k = 1:K
             log_gamma(ts,k) = log_alpha(ts,k) + log_beta(ts,k) - log_OP;
             gamma(ts,k) = exp(log_gamma(ts,k));
        end
    end

    for t = 1:t0-1
        ts = t + n*t0;
        midlog_OP = zeros(1,K);
        for i = 1:K
            midlog_OP(i) = logsumexp(log(A(i,:))+log_Obs(ts+1,:)+log_beta(ts+1,:));
        end
        log_OP = logsumexp(log_alpha(ts,:)+midlog_OP);
        for i = 1:K
            for j = 1:K          
                log_kersi(i,j,ts) = log_alpha(ts,i) + log(A(i,j))+ log_Obs(ts+1,j)...
                    + log_beta(ts+1,j) - log_OP;
                kersi(i,j,ts) = exp(log_kersi(i,j,ts));
            end
        end
    end

end

end

