function ModParaNew = updataPara(Y,gamma,kersi,options,ModPara)
% pi,A,mu,sigma are all updated with new gamma and new kersi
T = options.T;% eg. 1000*ones(100,1)
t0 = T(1);% t0 is number of time points of each subject, eg. 1000 time points of each sub
tN = length(T);% tN is the subject number, eg.100 subjects
K = options.K;
D = options.D;
ModParaNew = struct();
ModParaNew.Pi = zeros(1,K);
ModParaNew.A = zeros(K,K);

if options.updaterest == 1
    % Pi
    sPi = zeros(tN,K);
    for n = 1:tN
        for i = 1:K
            sPi(n,i) = gamma((n-1)*t0+1,i);
        end   
    end  
    if tN == 1
        ModParaNew.Pi = sPi;
    else
        ModParaNew.Pi = mean(sPi);
    end
    % A
    for i = 1:K
        for j = 1:K
            ModParaNew.A(i,j) = sum(kersi(i,j,:))/sum(gamma(:,i));
        end
    end
    % mu
    for i = 1:K
        ModParaNew.state(i).mu = (gamma(:,i)'*Y)/sum(gamma(:,i));
    end

else
    ModParaNew.Pi = ModPara.Pi;
    ModParaNew.A = ModPara.A;
    for i = 1:K
        ModParaNew.state(i).mu = ModPara.state(i).mu;
    end
end

% sigma
if options.updatesigma == 1
   for i = 1:K
        mu = ModParaNew.state(i).mu;   
        sigmaT = zeros(D,D);
        for t = 1:t0*tN
            midsigmaT = (Y(t,:)-mu)'*(Y(t,:)-mu);
            sigmaT = sigmaT + gamma(t,i)*midsigmaT;
        end
        ModParaNew.state(i).sigma = sigmaT/sum(gamma(:,i));% + 0.01*eye(D);
    end

elseif options.updatesigma == 0
    % sigma don't update
    for i = 1:K
        ModParaNew.state(i).sigma = ModPara.state(i).sigma;
    end

end

end


