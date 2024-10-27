%% Function CustomCompoundProgram()
%
% This network has a set of parallel links followed by one link in series
%   The failure probability on all links is different
%
% Creates 6 graphs detailing transmission attempts against failure
% probability
%
function CustomCompoundProgram()
    kValues = [1, 5, 10]; % values of K
    n = 1000; % simulations to run

    % failure probabilities broken down per link and per figure
    figures = {
    %  P1   P2   P3
      0.1, 0.6, 0.01; % figure 1
      0.6, 0.1, 0.01; % figure 2
      0.1, 0.01, 0.6; % figure 3
      0.6, 0.01, 0.1; % figure 4
      0.01, 0.1, 0.6; % figure 5
      0.01, 0.6, 0.1  % figure 6
    };
    
    % iterates through all figures
    for figureCounter = 1:length(figures)
        figure; % creates the window for the graph
        hold on; % holds the current plot so multiple can be added
        colors = lines(length(kValues)); % sets the colors of the lines and dots on the graph
        legendEntries = {}; % creates an array for all entries into the legend

        p1 = figures{figureCounter, 1}; % fail probability for link 1
        p2 = figures{figureCounter, 2}; % fail probability for link 2

        % iterates through all values of K
        for kCounter = 1:length(kValues)
            k = kValues(kCounter); % selects K value
            pValues = linspace(0, 0.99, 100); % creates spectrum of fail probabilities

            % arrays for holding the results that will be graphed
            calculatedResults = zeros(length(kValues), length(pValues));
            simulatedResults = zeros(length(kValues), length(pValues));

            % iterates through all values of P
            for pCounter = 1:length(pValues)
                p3 = pValues(pCounter); % fail probability of link 3

                % simulates amount of transmissions needed to be successful
                simulatedResults(kCounter, pCounter) = runCustomCompoundNetworkSim(k, p1, p2, p3, n);
            end
            
            % iterates through all P values
            for pCounter = 1:length(pValues)
                p3 = pValues(pCounter); % fail probability of link 3

                % calculates expected amount of transmissions to be successful
                calculatedResults(kCounter, pCounter) = calculateTransmissions(k, p1, p2, p3); 
            end
            
            plot(pValues, calculatedResults(kCounter, :), 'Color', colors(kCounter, :), 'LineWidth', 2, ...
            'DisplayName', ['Calculated K = ', num2str(k)]); % plots the calulated results for the selected K value
        plot(pValues, simulatedResults(kCounter, :), 'o', 'Color', colors(kCounter, :), 'MarkerFaceColor', ... 
            colors(kCounter, :), 'DisplayName', ['Simulated K = ', num2str(k)]); % plots the simulated results for the selected K value

            legendEntries{end + 1} = ['Calculated K = ', num2str(k)]; % enters the K value into the legend
            legendEntries{end + 1} = ['Simulated K = ', num2str(k)]; % enters the K value intot the legend
        end

        set(gca, 'YScale', 'log'); % sets the Y-scale to be logrithmic
        title('Combined Results for All K Values'); % adds a title to the graph
        xlabel('Probability of Failure (p)'); % lables the X-axis
        ylabel('Average Number of Transmissions'); % labels the Y-axis
        legend(legendEntries, 'Location','best'); % adds the legend to the graph
        hold off; % all plots added, turns hold off
        grid on; % turns grid lines on the graph on
    end
end

%% Function calculateTransmissions(K, P)
% Parameters
% K - the number of packets in the application message
% P1 - the probability of failure on link 1
% P2 - the probability of failure on link 2
% P3 - the probability of failure on link 3
%
% Returns: the calculated average number of transmissions the network
%   should take to transmit all packets successfully
function calculatedResults = calculateTransmissions(K, P1, P2, P3)
    calculatedResults = K / (1 - P2 * P3) + K / (1 - P3);
end