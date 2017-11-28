clear, clc, close
N = 200;
lattice_size = 200;
walkers_pos = randi(lattice_size,N,2);
movability = 0.8;%rand(N,1); %probability to move each time step
T = 1000;
k_1 = 0.03;
k_2 = 0.01;

Friend_NetworkMatrix = zeros(N);

for t = 1:T
    
    
    moveatt = rand(N,1);
    logical_vector = moveatt<movability;
    
    c = rand(sum(logical_vector),1);
    
    dr = (2*(rand(sum((logical_vector)),2)<.5)-1) .*[c<0.5,c>0.5];
    dr_walk=dr - k_1*(walkers_pos(...
        logical_vector,:)-[20,20]) -k_2*(walkers_pos(logical_vector,:)...
        -[180,100]);
    
    norm_factor = sqrt((dr_walk(:,1).^2+dr_walk(:,2).^2));
    dr_walk_norm = dr_walk./norm_factor; %normalised position change
    prob_dirr = dr_walk_norm.^2;
    
    C = rand(length(dr_walk_norm),1); %apparently a stochastic term is needed
    A = abs(prob_dirr-C);
    closest = min(A,[],2);
    
    index = A == closest;
    

    
    dr_walk = sign(dr_walk_norm(index));
    
    
    if length(dr_walk) ~= length(index)
        
        c = rand;
        logic = A(:,1) == A(:,2);
        A(logic,:) = A(logic,1)*[c<0.5,c>0.5];
        
        index = A == closest;
   
    dr_walk = sign(dr_walk_norm(index));
    
    end
    
    dr_walk = index.*dr_walk;
    
    walkers_pos(logical_vector,:) =...
        mod(walkers_pos(logical_vector,:) +dr_walk ,lattice_size);
    
    scatter(walkers_pos(:,1),walkers_pos(:,2),'filled')
    axis([0 lattice_size 0 lattice_size])
    
    pause(0.01)
    clf
end