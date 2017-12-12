function [Q, Comunity_indx] = modularity(A)

k = sum(A,2);

two_m = sum(k);

B = A-k*k'/two_m; %modularity matrix

N = length(A); %number of verticies

Comunity_indx = ones(N,1);
No_comunities = 1;                                   %number of communities
Unexamined = [1 0];                                %array of unexamined communites

indx = 1:N;
Bg = B;
Ng = N;

while Unexamined(1)
    
    [eig_vec, eig_val] = eigs(Bg,1);
%     eig_val_vec = eig_val(logical(eye(Ng)));
%     [~,maxeig_idx] = max(eig_val_vec);
    
    s = sign(eig_vec);%(:,maxeig_idx));
    
    dQ = s'*Bg*s; %/(2*two_m);
    
    if dQ > 1e-10
        
        Qmax = dQ;
        
        Bg(logical(eye(Ng))) = 0;
        
        unmoved_indx = ones(Ng,1);
        s_it = s;
        
        while any(unmoved_indx)
         
            Q_it = Qmax - 4*s_it.*(Bg*s_it);
            Qmax=max(Q_it.*unmoved_indx);
            indx_max=(Q_it==Qmax); 
            
            s_it(indx_max) = -s_it(indx_max);
            
            unmoved_indx(indx_max) = nan;
            
            if Qmax > dQ
                
                dQ = Qmax;
                s = s_it;
            end
        end
        
        if abs(sum(s)) == Ng
            
            Unexamined(1) = [];
            
        else
            
            No_comunities = No_comunities+1;
            
            Comunity_indx(indx(s==1)) = Unexamined(1);
            Comunity_indx(indx(s==-1)) = No_comunities;
            
            Unexamined = [No_comunities, Unexamined];
        end
        
    else
        
        Unexamined(1) = [];
        
    end
    
    indx = find(Comunity_indx==Unexamined(1));
    
    bg = B(indx,indx);
    Bg = bg - diag(sum(bg));
    Ng = length(indx);
    
end

s = Comunity_indx(:,ones(1,N));
Q = ~(s-s.').*B/(two_m);
Q = sum(Q(:));
            
end

%credit to:  Mika Rubinov, UNSW
%            Jonathan Power, WUSTL
