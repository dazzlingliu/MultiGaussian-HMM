function [ModPara,gamma] = hmmTrainModel(Y,ModPara,options)
cyc = 1;
change = 1;
while abs(change) > 1e-4 && cyc < options.cycmax
    % E step
    [log_Obs,ModPara] = mgs(Y,ModPara,options); 
    log_alpha = Foward(ModPara,log_Obs,options);%alpha = T*K
    log_beta = Backward(ModPara,log_Obs,options);
    [gamma,kersi,~] = gammakersi(log_alpha,log_beta,ModPara,log_Obs,options);

    % P(Y|para) loglikelihood
    LL(cyc) = lossfunction(log_alpha,options); 

    % M step
    if (options.Initflag == 1) && (options.trainEM == 1)%(rem(cyc,2)) % SW initial, cyc = odd number
        options.updatesigma = 0;options.updaterest = 1;
    elseif (options.Initflag == 1) && (options.trainEM == 2)%(~(rem(cyc,2))) % SW initial, cyc = even number
        options.updatesigma = 1;options.updaterest = 0;
    else % random initial
        options.updatesigma = 1;options.updaterest = 1;
    end
    ModParaNew = updataPara(Y,gamma,kersi,options,ModPara);
    if cyc == 1    
        disp(['cycle = 1; loglikelihood = ',num2str(LL(1))]);
    else
        change = (LL(cyc) - LL(cyc-1))/LL(cyc-1);
        disp(['cycle = ',num2str(cyc),'; loglikelihood = ',num2str(LL(cyc)),...
            '; relative change = ',num2str(change)]);
    end
    cyc = cyc + 1;  
    ModPara = ModParaNew;    
end
end

