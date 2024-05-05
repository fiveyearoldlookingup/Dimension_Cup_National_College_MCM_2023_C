function cost = objectiveFunction(n, D_j)
    % Parameter definition
    m = 10*[0.25, 0.09, 0.11, 0.19, 0.08, 0.1, 0.12, 0.11, 0.18, 0.22]; % Detergent unit price array
    A = 1;   % Detergent dosage coefficient
    a_ij = [0.54, 0.75, 0.78, 0.69, 0.8, 0.66, 0.55, 0.73;
            0.77, 0.67, 0.59, 0.58, 0.71, 0.48, 0.45, 0.66;
            0.7, 0.64, 0.62, 0.71, 0.63, 0.78, 0.5, 0.8;
            0.51, 0.54, 0.66, 0.82, 0.7, 0.6, 0.46, 0.55;
            0.39, 0.72, 0.43, 0.57, 0.46, 0.53, 0.4, 0.6;
            0.45, 0.6, 0.53, 0.48, 0.55, 0.45, 0.49, 0.77;
            0.69, 0.55, 0.62, 0.56, 0.47, 0.38, 0.44, 0.64;
            0.52, 0.44, 0.63, 0.71, 0.56, 0.68, 0.36, 0.66;
            0.8, 0.65, 0.56, 0.49, 0.73, 0.55, 0.47, 0.61;
            0.47, 0.81, 0.77, 0.53, 0.64, 0.59, 0.53, 0.42]; % foul solubility matrix

    % Calculate the total number of washes N
    N = sum(n);

    % Calculate the total water volume M
    M = 50 * N / 1000;

    % Computing costs
    cost = A * sum(m .* n) + 3.8 * M;
    large_penalty = 10000; % Penalty value

    % Calculate the remaining amount for each dirt
    for j = 1:length(D_j)
        D_jN = D_j(j);
        for i = 1:10
            for k = 1:n(i)
                D_jN = D_jN * (1 - a_ij(i, j) * 0.5^(k-1));
            end
        end

        % Add penalties to satisfy constraints
        if D_jN > D_j(j)/1000
            cost = cost + large_penalty;
        end
    end
end
