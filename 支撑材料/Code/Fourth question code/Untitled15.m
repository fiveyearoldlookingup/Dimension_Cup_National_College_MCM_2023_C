% Import Data
[~,~,rawData] = xlsread('garments.xlsx');
garmentsData = rawData(2:end, :); % Assume the second line is the title

% Set the number of Monte Carlo simulations
numSimulations = 1000;

% Set a maximum number of items per group
maxPerGroup = 36;

% Parameter settings of particle swarm algorithm
nVars = 10; % Number of variables, corresponding to 10 types of detergents
lb = zeros(1, nVars); % lower bound of variable
ub = ones(1, nVars) * 15; % upper bound of variable
options = optimoptions('particleswarm','MaxIterations',10000);

% Initialize storage variables for best simulation results
bestSimulation = struct();
bestTotalCost = inf; % Initialize optimal total cost to infinity
% Initialize an array storing total costs for visualization
totalCosts = zeros(numSimulations, 1);
% Perform a Monte Carlo simulation
for sim = 1:numSimulations
    % Initialize four groups
    group1 = []; group2 = []; group3 = []; group4 = [];

    % Shuffle the order of garmentsData to achieve random distribution
    shuffledIndices = randperm(size(garmentsData, 1));
    shuffledData = garmentsData(shuffledIndices, :);

    % Assign fixed material to clothing
    for i = 1:size(shuffledData, 1)
        garment = shuffledData(i, :);
        material = garment{2}; % Use curly braces to extract data from cells

        % allocation logic
        if material == 1 && size(group1, 1) < maxPerGroup
            group1 = [group1; garment];
        elseif material == 7 && size(group3, 1) < maxPerGroup
            group3 = [group3; garment];
        elseif material == 2 && size(group4, 1) < maxPerGroup
            group4 = [group4; garment];
        end
    end

    % Assign clothing with optional materials
    for i = 1:size(shuffledData, 1)
        garment = shuffledData(i, :);
        material = garment{2};

        %Check if this item of clothing has been assigned
        if any(cellfun(@(x) isequal(x, garment), [group1; group2; group3; group4]))
            continue;
        end

        % Try randomly assigning items of clothing into a qualifying group
        if ismember(material, [3,4,5,6]) && size(group1, 1) < maxPerGroup
            group1 = [group1; garment];
        elseif ismember(material, [3,4,5,6,8]) && size(group2, 1) < maxPerGroup
            group2 = [group2; garment];
        elseif ismember(material, [6,8]) && size(group3, 1) < maxPerGroup
            group3 = [group3; garment];
        elseif material == 8 && size(group4, 1) < maxPerGroup
            group4 = [group4; garment];
        end
    end

    % Assume contaminantsData starts at column 3 and ends at column 10
    contaminantColumns = 3:10;

    % Calculate the total amount of dirt in each group
    totalContaminantsGroup1 = sum(cell2mat(group1(:, contaminantColumns)), 1);
    totalContaminantsGroup2 = sum(cell2mat(group2(:, contaminantColumns)), 1);
    totalContaminantsGroup3 = sum(cell2mat(group3(:, contaminantColumns)), 1);
    totalContaminantsGroup4 = sum(cell2mat(group4(:, contaminantColumns)), 1);

    % Perform particle swarm optimization on each group
    [optimal_n1, optimal_cost1] = particleswarm(@(n) objectiveFunction(n, totalContaminantsGroup1), nVars, lb, ub, options);
    [optimal_n2, optimal_cost2] = particleswarm(@(n) objectiveFunction(n, totalContaminantsGroup2), nVars, lb, ub, options);
    [optimal_n3, optimal_cost3] = particleswarm(@(n) objectiveFunction(n, totalContaminantsGroup3), nVars, lb, ub, options);
    [optimal_n4, optimal_cost4] = particleswarm(@(n) objectiveFunction(n, totalContaminantsGroup4), nVars, lb, ub, options);

     % Calculate the total cost of the current simulation and store it
    currentTotalCost = optimal_cost1 + optimal_cost2 + optimal_cost3 + optimal_cost4;
    totalCosts(sim) = currentTotalCost;


    % Check if it is the best simulation
    if currentTotalCost < bestTotalCost
        bestTotalCost = currentTotalCost;
        bestSimulation.Group1 = group1;
        bestSimulation.Group2 = group2;
        bestSimulation.Group3 = group3;
        bestSimulation.Group4 = group4;
        bestSimulation.OptimalCosts = [optimal_cost1, optimal_cost2, optimal_cost3, optimal_cost4];
        bestSimulation.OptimalSolutions = [optimal_n1; optimal_n2; optimal_n3; optimal_n4];
        bestSimulation.SimulationNumber = sim;
    end
     % Visualize the total cost of the current simulation
    figure(1); % Make sure you draw in the same window every time
    plot(1:sim, totalCosts(1:sim), 'b-o');
    title('Total Cost per Simulation');
    xlabel('Simulation Number');
    ylabel('Total Cost');
    drawnow; % Update charts in real time
end

% Show best simulation results
disp('Best Simulation Result:');
disp(['Simulation Number: ', num2str(bestSimulation.SimulationNumber)]);
disp('Group 1:');
disp(bestSimulation.Group1);
disp('Group 2:');
disp(bestSimulation.Group2);
disp('Group 3:');
disp(bestSimulation.Group3);
disp('Group 4:');
disp(bestSimulation.Group4);
disp('Optimal Costs:');
disp(bestSimulation.OptimalCosts);
disp('Optimal Solutions:');
disp(bestSimulation.OptimalSolutions);
