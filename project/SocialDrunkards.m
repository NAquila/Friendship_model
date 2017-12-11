% /////////////////////////////// Parameters //////////////////////////////

s = 100; % Size of lattice.
n = 1000; % Number of agents.
T = 1000; % Max time.
d = 0.3; % Diffusion rate.
v0 = -0.; % Big potential strength.
u0 = -20.; % Small potential strength.
std = 20.; % Big potential standard deviation.
std2 = 5.; % Small potential standard deviation.
mn = [0,0]; % Big potential mean.
l = 0.002; % Decay constant.
e = 10; 

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

% /////////////////////////////// Main loop ///////////////////////////////

t = 0;
while (t < T)
    
    E = reshape([x,y],1,n,2) - reshape([x,y],n,1,2); % Euclidian distances.
    U = triu(sparse((sum(abs(E),3) == 0)),1); % Find agents that share location.
    A = U + U'; % Adjency matrix.
    
    T0(A == 1) = t; % Update time reference.
    
    N = N.*dec(t,l,T0) + A; % Update network.
    
    % Calculate energies.
    statX = [exp(- pot(x - 1,y,s,v0,u0,std,std2,mn,N,[x,y])/e),exp(- pot(x + 1,y,s,v0,u0,std,std2,mn,N,[x,y])/e)];
    statY = [exp(- pot(x,y - 1,s,v0,u0,std,std2,mn,N,[x,y])/e),exp(- pot(x,y + 1,s,v0,u0,std,std2,mn,N,[x,y])/e)];
    
    % Normalized probabilities.
    statX = statX./sum(statX,2);
    statY = statY./sum(statY,2);
    
    disp(statX(1,:))
    
    % Update coordinates.
    x = x + (rand(n,1) < d).*(2 * (rand(n,1) > statX(:,1)) - 1);
    y = y + (rand(n,1) < d).*(2 * (rand(n,1) > statY(:,1)) - 1);
    refreshdata(h)
    drawnow
    
    t = t + 1;
end

% \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

hold off
