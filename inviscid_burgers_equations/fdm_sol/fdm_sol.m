% Parameters
L = pi; % length of the domain
N = 50; % number of basis functions
T = pi; % total simulation time
dt = 0.001; % time step


% Initialize x and t
x = linspace(0,L,N)';
tspan = 0:dt:T;

% Initialize u
u = zeros(N,1);
x = linspace(0,L,N)';
u = sin(pi*x/L); % initial condition