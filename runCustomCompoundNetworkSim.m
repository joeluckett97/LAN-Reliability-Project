%% Function runCustomCompoundNetworkSim()
% Parameters
% K - the number of packets in the application message
% p1 - the probability of failure over first link
% p2 - the probability of failure over second link
% p3 - the probability of failure over third link
% N - the number of simulations to run
%
% Returns: the average numeric result across the total simulations
function result = runCustomCompoundNetworkSim(K,p1, p2, p3,N)
    simResults = ones(1,N); % a place to store the result of each simulation

    for i=1:N % iterates N amount of times
        txAttemptCount = 0; % transmission count
        pktSuccessCount = 0; % number of packets that have made it across

        % loops until all packets are successfully transmitted
        while pktSuccessCount < K
            r1 = rand; % gen random num to determine if first packet is successful (r > p1)
            r2 = rand; % gen random num to determine if second packet is successful (r > p2)
            txAttemptCount = txAttemptCount + 1; % count 1st attempt

            % while packet transmissions is not successful (r < p1 && r < p2)
            while r1 < p1 && r2 < p2
                r1 = rand; % get new check value
                r2 = rand; % get new check value
                txAttemptCount = txAttemptCount + 1; % add attempt to transmit
            end

            r3 = rand; % gen random num to determine if first packet is successful (r3 > p3)
            txAttemptCount = txAttemptCount + 1; % count 1st attempt over 2nd link

            % while packet transmissions is not successful (r3 < p3)
            while r3 < p3
                r3 = rand; % transmit again, generate new success check value r3
                txAttemptCount = txAttemptCount + 1; % count additional attempt
            end
            
            pktSuccessCount = pktSuccessCount + 1; % increase success count
                                                   % after success (r > p3)
         end

        simResults(i) = txAttemptCount; % record total number of attempted 
                                        % transmissions before entire application 
                                        % msg (K successful packets) transmitted
    end
    
    result = mean(simResults);
end