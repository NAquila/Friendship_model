function friendship_matrix = update_network(agents, prev_friends)

%agents= [1,2;1,2;1,2;2,2;2,3;3,5;2,2;2,3];
%prev_friends = zeros(size(agents,1),size(agents,1));

%Friendship decays
matrix = prev_friends*0.9;
unique_positions = unique(agents,'rows');
for i=1:size(unique_positions,1)
    agents_at_pos=double(ismember(agents, unique_positions(i,:),'rows'));
    where_update=agents_at_pos*agents_at_pos';
    matrix = matrix + where_update;
end

matrix = triu(matrix);
friendship_matrix = matrix + matrix';
friendship_matrix(logical(eye(length(friendship_matrix)))) = 0;




