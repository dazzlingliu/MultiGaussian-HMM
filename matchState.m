function [assig,stateCorr] = matchState(ModAstate,ModBstate)
% each state from Model A can find a matched state from Model B
K = size(ModAstate,2);
c = zeros(1,K);
assig = zeros(1,K);
stateCorr = zeros(1,K);
for k1 = 1:K
    Afc = ModAstate(k1).sigma;
    for k2 = 1:K
        Bfc = ModBstate(:,:,k2);
        r = corrcoef(Afc,Bfc);
        c(k1,k2) = r(1,2);
    end
end

while sum(sum(c)) ~= 0
[x,y] = find(c == max(max(c)));
assig(x) = y;
stateCorr(x) = c(x,y);
c(:,y) = zeros(K,1);
c(x,:) = zeros(1,K);
end

end

