function sil = silhouette(data,count,cmemorize,k)
% 本函数通过求取轮廓系数来评估聚类效果
% data为样本数据；count为k行1列矩阵，记录每一类元素的个数；
% cmenmorize为1行N列矩阵，记录每一个元素所属的类别；
% k为指定的类别数；
% sil代表在划分为k类的情况下的轮廓系数
[N , ~] = size(data);
sil_all = zeros(N,1);
for i = 1:N
    cluster = cmemorize(i);
    cohesion_sum = 0;   % 凝聚度
    separation_sum = zeros(k,1); % 分离度
    separation_tmp = zeros(k,1);
    for j = 1:N
        if(cmemorize(j) == cluster)
            % 同一类元素
            cohesion_sum = cohesion_sum + norm(data(i,:)-data(j,:));
        else
            % 非同类元素
            separation_sum(cmemorize(j)) = separation_sum(cmemorize(j)) + norm(data(i,:)-data(j,:));
        end
    end
    % 第i个数据点的凝聚度
    cohesion = cohesion_sum/(count(cluster)-1);
    % 第i个数据点的分离度,取最小值
    for p = 1:k
        separation_tmp(p) =  separation_sum(p)/count(p);
    end
    [separation_order,~] = sort(separation_tmp,'descend'); 
    separation = separation_order(k-1);
    % 第i个数据点的轮廓系数
    sil_all(i) = (separation-cohesion)/max(separation,cohesion);
end
sil = mean(sil_all);