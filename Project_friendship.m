clear, clc
N = 200;
lattice_size = 1000;
walkers_pos = randi(lattice_size,N,2);
movability = 0.8;%rand(N,1); %probability to move each time step
T = 100;
k_1 = 0.06;
k_2 = 0.06;

Friend_NetworkMatrix = zeros(N);

for t = 1:T
    
    
    moveatt = rand(N,1);
    logical_vector = moveatt<movability;
    
    c = rand(sum(logical_vector),1);
    
    dr = (2*(rand(sum((logical_vector)),2)<.5)-1) .*[c<0.5,c>0.5];
    dr_walk=dr - k_1*(walkers_pos(...
        logical_vector,:)-[200,200]) -k_2*(walkers_pos(logical_vector,:)...
        -[554,920]);
    
    dr_walk = dr_walk
    
    walkers_pos(logical_vector,:) =...
        mod(walkers_pos(logical_vector,:) +dr_walk ,lattice_size);
    
    scatter(walkers_pos(:,1),walkers_pos(:,2),'filled')
     axis([0 lattice_size 0 lattice_size])

 pause(0.1)
   clf
end