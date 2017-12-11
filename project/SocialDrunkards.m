% /////////////////////////////// Parameters //////////////////////////////

s = 100; % Size of lattice.
n = 1000; % Number of agents.
T = 1000; % Max time.
d = 0.3; % Diffusion rate.
v0 = -500.; % Big potential strength.
u0 = -20.; % Small potential strength.
std = 20.; % Big potential standard deviation.
std2 = 5.; % Small potential standard deviation.
mn = [0 50; 0 -50]; % Big potential mean.
l = 0.002; % Decay constant.


% \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

% ////////////////////////// Initialize variables /////////////////////////

% Initial coordinates.
x = randi([-s/2,s/2],n,1);
y = randi([-s/2,s/2],n,1);

N = sparse(zeros(n)); % Network matrix.

T0 = zeros(n); % Time reference for decay rate.

figure;
h = plot(x,y,'.');
axis([-s/2 s/2 -s/2 s/2])
hold on;
set(h,'XDataSource','x');
set(h,'YDataSource','y');
% ///////////////////////////// Initialize measurements  ///////7//////////
num_meas = 10;
degrees = zeros(n, num_meas);
friend_tol = 0.1;
clust_coef = zeros(1, num_meas);
av_path = zeros(1, num_meas);
modularity = zeros(1, num_meas);
clusters = zeros(n, num_meas);

tmod = T/num_meas;
meas = 1;
% /////////////////////////////// Main loop ///////////////////////////////

t = 0;
while (t < T)
    
    E = reshape([x,y],1,n,2) - reshape([x,y],n,1,2); % Euclidian distances.
    U = triu(sparse((sum(abs(E),3) == 0)),1); % Find agents that share location.
    A = U + U'; % Adjency matrix.
    
    T0(A == 1) = t; % Update time reference.
    
    N = N.*dec(t,l,T0) + A; % Update network.
    N(N>10) = 10; %Cap how good friends people can be
    
    % Calculate energies.
    energy_x_minus = pot(x - 1,y,s,v0,u0,std,std2,mn,N,[x,y]);
    energy_x_plus = pot(x + 1,y,s,v0,u0,std,std2,mn,N,[x,y]);
    energy_y_minus = pot(x,y - 1,s,v0,u0,std,std2,mn,N,[x,y]);
    energy_y_plus = pot(x,y + 1,s,v0,u0,std,std2,mn,N,[x,y]);
    
    p_x_minus = 1./(1+exp(energy_x_minus - energy_x_plus));
    p_y_minus = 1./(1+exp(energy_y_minus - energy_y_plus));
    %statX = [exp(- energy_x_minus/e), ...
     %   exp(- energy_x_plus/e)];
    %statY = [exp(- energy_y_minus/e), ...
     %   exp(- energy_y_plus/e)];
    % disp(statX(1,:))
    % Normalized probabilities.
    %statX = statX./sum(statX,2);
    %statY = statY./sum(statY,2);
    
    % Update coordinates.
    x = x + (rand(n,1) < d).*(2 * (rand(n,1) > p_x_minus) - 1);
    y = y + (rand(n,1) < d).*(2 * (rand(n,1) > p_y_minus) - 1);
    refreshdata(h)
    drawnow
    
    if mod(t, tmod) == 0
        disp(t)        
        %unweightN = double(N>friend_tol);
        degrees(:, meas) = sum(unweightN, 2);
        %clust_coef(1, meas) = ClustCoeff(unweightN);
        %av_path(1,meas) = Average_PL(unweightN);
        %[modularity(1, meas), clusters(:, meas)] = modularity(unweightN);
        meas = meas + 1;
    end
    
    t = t + 1;
end

% \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

hold off
