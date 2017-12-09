clear, clc, close
N = 1000;
lattice_size = 100;
agent_x = randi(lattice_size, N, 1);
agent_y = randi(lattice_size, N, 1);
movability = 0.8;%rand(N,1); %probability to move each time step
T = 20000;
Tmod = 500;

Friend_NetworkMatrix = zeros(N);
%allowed_directions = [1, 0; -1, 0; 0, 1; 0, -1];

really_big = 1e30;
E_mat_0 = ones(lattice_size+2);
%Bound the guys by an infinite potential wall
E_mat_0(:, 1) = really_big;
E_mat_0(1, :) = really_big;
E_mat_0(:, end) = really_big;
E_mat_0(end, :) = really_big;
d = 0.5;  %Diffusion rate

%Attractorpoints
a_1_x = 50;
a_1_y = 50;
sigma_1 = 100;
k_1 = 0.6;
a_1_pot = k_1*gauss_potential(lattice_size+2, a_1_x, a_1_y, sigma_1);

a_2_x = 150;
a_2_y = 150;
sigma_2 = 100;
k_2 = 8;
a_2_pot = k_2*gauss_potential(lattice_size+2, a_2_x, a_2_y, sigma_2);

E_mat_0 = E_mat_0 + a_1_pot + a_2_pot;

i = 1; %Index for out parameters

Q = zeros(T/Tmod,1); %memory allocation for parameter values.
L = zeros(T/Tmod,1); %might want to consider calculating the 
dm = zeros(T/Tmod,1); %average PL after the full simulation.
C = zeros(T/Tmod,1); %The calculations are computation heavy.
                     %=> L = zeros(T/Tmod,1),dm = zeros(T/Tmod,1) -> L,dm 1x1

for t = 1:T
    
  Friend_NetworkMatrix = update_network([agent_x, agent_y], Friend_NetworkMatrix);

    
    %Update potential landscape from friendship matrix
    E_mat = E_mat_0;
    
    tmp_x = diag(E_mat(1 + agent_y, 1+agent_x+1) - E_mat(1+agent_y, 1+agent_x-1));
    tmp_y = diag(E_mat(1+agent_y+1, 1+agent_x) - E_mat(1+agent_y-1, 1+agent_x));
   
    p_right = 1./(1+exp(tmp_x));
    p_up = 1./(1+exp(tmp_y));
    
    rand_move_x = rand(N, 1);
    rand_dir_x = rand(N, 1);  
    dx = (rand_move_x < d).*((rand_dir_x < p_right) - 0.5)*2;
    agent_x = agent_x + dx;
    
    rand_move_y = rand(N, 1);
    rand_dir_y =rand(N, 1);
    dy = (rand_move_y < d).*((rand_dir_y < p_up) - 0.5)*2;
    agent_y = agent_y + dy;
    
% Scatter plot movie over simulation.    
%     scatter(agent_x,agent_y,'filled')
%     axis([0 lattice_size 0 lattice_size])
%     
%     pause(0.001)
%     clf
    
    if mod(t,Tmod) == 0
        
        A = Friend_NetworkMatrix>0; %Create a binary Adjecency matrix
        
        Q(i) = modularity(A); %modularity of Adjecency matrix
                                                 
       [L(i),dm(i)] = Average_PL(A); %average path length and diameter
                                    
       C(i) = ClustCoeff(A);        %Clustering Coefficient
       
       i = i+1;

    end
end