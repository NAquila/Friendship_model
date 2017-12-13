function [fig1, fig2, fig3, fig4] = visualize_data(filename)
% Load the data
load(filename);
n = n1 + n2;
% Degree distribution
fig1 = figure('Name', 'Degree distribution', ...
    'Units' , 'Normalized', 'Position', [0 0 1 1]);
% Assumes num_meas = 40
for i = 1:num_meas
    subplot(4, 10, i)
    histogram(degrees(:,i))
end
% Clustering coef
fig2 = figure('Name', 'Clustering coefficient of the network');
plot(clust_coef)
% Modularity
fig3 = figure('Name', 'Modularity');
plot(modularity_save)
%Clusters
%Clustersize distribution

fig4 = figure('Name', 'Size distribution of clusters', ...
    'Units' , 'Normalized', 'Position', [0 0 1 1]);
for j = 1:num_meas
    subplot(4, 10, j)
    histogram(clusters(:, j));
%     clusters = unique(clusters(:,j));
%     cluster_size = zeros(size(clusters));
%     for clust = clusters
%         
%     end
end



end