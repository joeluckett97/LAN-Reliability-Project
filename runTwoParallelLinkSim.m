%% Function runTwoParallelLinkSim()
% Parameters
% K - the number of packets in the application message
% p - the probability of failure
% N - the number of simulations to run
%
% Returns: the average numeric result across the total simulations
function result = runTwoParallelLinkSim(K,p,N)
    simResults = ones(1,N); % a place to store the result of each simulation

    for i=1:N % runs N amount of times
        txAttemptCount = 0; % transmission count
        pktSuccessCount = 0; % number of packets that have made it across

        % loops until all packets are transmitted successfully
        while pktSuccessCount < K
            r1 = rand; % gen random num to determine if first packet is successful (r > p)
            r2 = rand; % gen random num to determine if second packet is successful (r > p)
            txAttemptCount = txAttemptCount + 1; % count 1st attempt
            
            % while first packet transmissions is not successful (r < p)
            while r1 < p && r2 < p
                r1 = rand; % get new check value
                r2 = rand; % get new check value
                txAttemptCount = txAttemptCount + 1; % add attempted transmissions
            end

            pktSuccessCount = pktSuccessCount + 1; % increase success count
                                                   % after success (r > p)
         end

        simResults(i) = txAttemptCount; % record total number of attempted 
                                        % transmissions before entire application 
                                        % msg (K successful packets) transmitted
    end
    
    result = mean(simResults);
end