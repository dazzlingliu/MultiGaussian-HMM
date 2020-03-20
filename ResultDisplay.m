function [assig,stateCorr,gammaCorr] = ResultDisplay(ModPara,gamma,options,figdisplay)
% plot state FC figure and tranP figure
K = length(ModPara.Pi);
if figdisplay == 1
    figure(1)
    for k = 1:K
        subplot(1,K,k);
        imagesc(ModPara.state(k).sigma);
    end

    figure(2)
    imagesc(ModPara.A);
end

simf = load('/Users/liu/Documents/MATLAB/MultiGuassian-HMM/simdataTBnC40-0.1noi1000tp30sub.mat');
T = options.T;
tN = length(T);t0 = T(1);
gCorr = zeros(tN,K);
[assig,stateCorr] = matchState(ModPara.state,simf.gtFC(1:40,1:40,:));

% figure(3)
if any(~isnan(gamma))
%     hmmstate = stateSeries(gamma);
%     plot(hmmstate(1:500));    
    for n = 0:tN-1
        for k = 1:K
            gtGamma = double(simf.state(1+n*t0:t0+n*t0) == assig(k));
            CorrR = corrcoef(gamma(1+n*t0:t0+n*t0,k),gtGamma');
            gCorr(n+1,k) = CorrR(1,2);
        end
    end
    gammaCorr = mean(gCorr);
    disp(['state corr = ',num2str(stateCorr),'; mean = ',num2str(mean(stateCorr))]);
    disp(['gamma corr = ',num2str(gammaCorr),'; mean = ',num2str(mean(gammaCorr))]);
else
    disp('hmmlearn failed! there are NaN value in gamma');
end

end

