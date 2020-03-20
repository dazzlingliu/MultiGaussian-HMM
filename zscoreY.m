function Y = zscoreY(Yin,options)
% zscore  for each subject by data dimension
T = options.T;% eg. 1000*ones(100,1)
t0 = T(1);% t0 is number of time points of each subject, eg. 1000 time points of each sub
tN = length(T);% tN is the subject number, eg.100 subjects

for n = 0:tN-1
    Y(1+n*t0:t0+n*t0,:) = zscore(Yin(1+n*t0:t0+n*t0,:));
end

end

