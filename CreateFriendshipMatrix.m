function friendshipMatrix = CreateFriendshipMatrix(agentPos)
    numberOfAgent = size(agentPos, 1);
    friendshipMatrix = zeros(numberOfAgent, numberOfAgent);


    uniquePos = unique(agentPos, 'rows');
    numberOfUniquePos = size(uniquePos, 1);

    for i = 1:numberOfUniquePos
        logical = ismember(agentPos, uniquePos(i, :), 'rows');
    
        if sum(logical) > 1
            index = find(logical==1);
            friendshipMatrix(index, index) = 1;
        end
    end

    friendshipMatrix(1:numberOfAgent+1:numberOfAgent^2) = 0;

end