%% Function CompoundNetworkProgram()
%
% This network has a set of parallel links followed by one link in series
%
% Creates 6 graphs detailing transmission attempts against failure
% probability
%
function CompoundNetworkProgram()

    kValues = [1, 5, 15, 50, 100]; % amount of packets to send 
    pValues = linspace(0,0.99,100); % failure probability
    n = 1000; % simulations to run
    
    % arrays for holding the results that will be graphed
    calculatedResults = zeros(length(kValues), length(pValues));
    simulatedResults = zeros(length(kValues), length(pValues));
    
    for kCounter = 1:length(kValues) % runs through all iterations for the amount of packets
        k = kValues(kCounter); % selects the amount of packets
    
        for pCounter = 1:length(pValues) % runs through all iterations for all probabilities of failure
            p = pValues(pCounter); % selects probability
            calculatedResults(kCounter, pCounter) = calculateTransmissions(k, p); % calculates amount of transmissions 
                                                                                  % needed to be successfull
        end
    
        for pCounter = 1:length(pValues) 
            p = pValues(pCounter);
            simulatedResults(kCounter, pCounter) = runCompoundNetworkSim(k, p, n); % simulates amount of transmissions
                                                                                   % needed to be successful
        end
    
        figure; % creates the window for the graph
        hold on; % holds the current plot so multiple can be added
        plot(pValues, calculatedResults(kCounter, :), 'b-', 'LineWidth', 2); % plots the calculated results
        plot(pValues, simulatedResults(kCounter, :), 'ro', 'MarkerFaceColor', 'r'); % plots the simulated results
        hold off; % all plots added, turns hold off
        set(gca, 'YScale', 'log'); % sets the Y-scale to be logrithmic
        title(['K = ', num2str(k)]); % adds a title to the graph
        xlabel('Probability of Failure (p)'); % lables the X-axis
        ylabel('Average Number of Transmissions'); % labels the Y-axis
        legend('Calculated', 'Simulated'); % creates a legend for the graph
        grid on; % turns grid lines on the graph on
    end
    
    figure; % creates the window for the grap
    hold on; % holds the current plot so multiple can be added
    colors = lines(length(kValues)); % sets the colors of the lines and dots on the graph
    legendEntries = {}; % creates an array for all entries into the legend
    for kCounter = 1:length(kValues) % iterates through all values of K
        k = kValues(kCounter); % selects K value
        plot(pValues, calculatedResults(kCounter, :), 'Color', colors(kCounter, :), 'LineWidth', 2, ...
            'DisplayName', ['Calculated K = ', num2str(k)]); % plots the calulated results for the selected K value
        plot(pValues, simulatedResults(kCounter, :), 'o', 'Color', colors(kCounter, :), 'MarkerFaceColor', ... 
            colors(kCounter, :), 'DisplayName', ['Simulated K = ', num2str(k)]); % plots the simulated results for the selected K value

        legendEntries{end + 1} = ['Calculated K = ', num2str(k)]; % enters the K value into the legend
        legendEntries{end + 1} = ['Simulated K = ', num2str(k)]; % enters the K value intot the legend
    end
    hold off; % all plots added, turns hold off
    set(gca, 'YScale', 'log'); % sets the Y-scale to be logrithmic
    title('Combined Results for All K Values'); % adds a title to the graph
    xlabel('Probability of Failure (p)'); % lables the X-axis
    ylabel('Average Number of Transmissions'); % labels the Y-axis
    legend(legendEntries, 'Location','best'); % adds the legend to the graph
    grid on; % turns grid lines on the graph on
end


%% Function calculateTransmissions(K, P)
% Parameters
% K - the number of packets in the application message
% P - the probability of failure
%
% Returns: the calculated average number of transmissions the network
%   should take to transmit all packets successfully
function calculatedResults = calculateTransmissions(K, P)
    calculatedResults = K / (1 - P * P) + K / (1 - P);
end