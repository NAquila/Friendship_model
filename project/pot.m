function v = pot(x,y,s,v0,u0,std,std2,mn,N,C, pref)

% Wij = potential from j acting on i
W = u0 * exp(- ((x - C(:,1)').^2 + (y - C(:,2)').^2) / (2 * std2 * std2));

v = sum(v0 * exp(- ((x - mn(:,1)').^2 + (y - mn(:,2)').^2) / (2 * std * std)).*pref, 2) ...
    + sum(N.* W,2) ...
    + (x < -s/2 | y < -s/2 | x > s/2 | y > s/2) * realmax;
% disp(v(1))
end
