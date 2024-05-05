%%%matlab
%%Run the particle swarm algorithm and parameters
nVars = 10;  % Number of variables, corresponding to 10 types of detergents
lb = zeros(1, nVars);  % Nether
ub = [15,15,15,15,15,15,15,15,15,15];  % Upper bound

% Particle swarm parameters
%options = optimoptions('particleswarm', 'SwarmSize', 50, 'HybridFcn', @fmincon);
%options = optimoptions('particleswarm','Display','iter');
% Plot the optimal function value as a function of the number of iterations
options = optimoptions('particleswarm','PlotFcn','pswplotbestf');
[optimal_n, optimal_cost] = particleswarm(@objectiveFunction, nVars, lb, ub, options);
optimal_n
optimal_cost