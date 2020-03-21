function ModParaInit = initPara(options)
%Hidden markov model parameters
% D is the dimention of fmri data
% K is the state number
% randam initialization
ModParaInit = struct();
D = options.D;
K = options.K;

AInit = rand(K,K);
for k = 1:K
    AInit(k,k) = AInit(k,k) + 100;
end
for k = 1:K
    AInit(k,:) = AInit(k,:)./sum(AInit(k,:));
end
ModParaInit.A = AInit;

PiInit = rand(1,K);
PiInit = PiInit./sum(PiInit);
ModParaInit.Pi = PiInit;

disp('random Initial');
for k = 1:K
    ModParaInit.state(k).mu = rand(1,D) - 0.5;
    M = diag(rand(D,1));
    Z = orth(rand(D,D));
    ModParaInit.state(k).sigma = Z*M*Z';%sigma is Symmetric positive definite matrix
end

end
