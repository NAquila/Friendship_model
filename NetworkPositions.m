function [a_network_x,a_network_y] = NetworkPositions(Adj_matrix,agent_x, agent_y)

A = sparse(triu(Adj_matrix));

[List_1, List_2] = find(A);

a_network_x = [agent_x(List_1);agent_x(List_2)];
a_network_y = [agent_y(List_2);agent_y(List_1)];