clear, clc
% Get average
file_list = {'Resultat\no_attr_2017_12_13_15_46.mat'; 'Resultat\no_attr_2017_12_13_16_31.mat'; ...
    'Resultat\no_attr_2017_12_13_16_50.mat'; 'Resultat\no_attr_2017_12_13_17_0.mat'};
degree_distrib_final = zeros(1000, 40); %Row is number of nodes with this degree, column is measuretime
clust_coef_final = zeros(1, 40);

edges = 0:1000;
for i=1:length(file_list)
   load(file_list{i});
   clust_coef_final = clust_coef_final + clust_coef/length(file_list);
   for j=1:40
       degree_distrib_final(:,j) = histcounts(degrees(:,j), edges)/length(file_list);
   end
end
cCDF_deg = sum(degree_distrib_final, 1) - cumsum(degree_distrib_final, 1);
cCDF_deg = cCDF_deg./cCDF_deg(1,:);
loglog(cCDF_deg(:, 30))