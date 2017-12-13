function [fig1, fig2, fig3, fig4, fig5] = visualize_data(filename)
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
fig2 = figure('Name', 'Complementary cumulative degree distribution', ...
    'Units' , 'Normalized', 'Position', [0 0 1 1]);
for i = 1:num_meas
    subplot(4, 10, i);
    [num_neigh, edges] = histcounts(degrees(:,i));
    comp_df = sum(num_neigh) - cumsum(num_neigh);
    comp_df = comp_df./comp_df(1);
    loglog(edges(2:end), comp_df)
end
% Clustering coef
fig3 = figure('Name', 'Clustering coefficient of the network');
plot(clust_coef)
% Modularity
fig4 = figure('Name', 'Modularity');
plot(modularity_save)
%Clusters
%Clustersize distribution

fig5 = figure('Name', 'Size distribution of clusters', ...
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