function [L,d] = Average_PL(A) %A = adjecency matrix
n=length(A);
D = zeros(n);
for s = 1:n
    
l = inf*ones(1,n); % distance s-all nodes
l(s) = 0;    % s-s' distance
T = 1:n;    % node set with shortest paths not found

while not(isempty(T))
    
    [~,ind] = min(l(T));
    
    bool =  A(T(ind),T)>0 & l(T)>l(T(ind))+A(T(ind),T); %Djikstras algorithm
    l(T(bool))=l(T(ind))+A(T(ind),T(bool));
    
    T(T==T(ind))=[];
end
D(s,:) = l;
end
d = max(max(l));

L = sum(sum(D))/(n*(n-1));