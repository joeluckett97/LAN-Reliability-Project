%% Function runSingleLinkSim()
% Parameters
% K - the number of packets in the application message
% p - the probability of failure
% N - the number of simulations to run
%
% Returns: the average numeric result across the total simulations
function result = runSingleLinkSim(K,p,N)
    simResults = ones(1,N); % a place to store the result of each simulation

    for i=1:N % runs N amount of times
        txAttemptCount = 0; % transmission count
        pktSuccessCount = 0; % number of packets that have made it across

        while pktSuccessCount < K % while there are still packets that need to be transmitted

            r = rand; % gen random num to determine if packet is successful (r > p)
            txAttemptCount = txAttemptCount + 1; % count 1st attempt

            % while packet transmissions is not successful (r < p)
            while r < p
                r = rand; % transmit again, generate new success check value r
                txAttemptCount = txAttemptCount + 1; % count additional attempt
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