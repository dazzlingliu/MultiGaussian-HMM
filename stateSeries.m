function state = stateSeries(gamma)
% state time series 
% approximation algorithm 
T = length(gamma);
state = zeros(T,1);
for t = 1:T
    state(t) = find(gamma(t,:) == max(gamma(t,:)));
end

end

