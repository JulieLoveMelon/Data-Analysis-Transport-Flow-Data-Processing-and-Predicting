function label = kmeans_clustering(data,num)
% data为样本数据；num为聚类数目
[N, n] = size(data);
err_T = 0.001;
%% 选取中心点
c = initial_point(data,num,2);
%% 开始迭代
tic
while 1
    sum = zeros(num,n);
    count = zeros(num,1);
    % 将样本点归入与其最近的中心点
    for i = 1:N
        for j = 1:num
            % 第i个样本点到第j个中心点的距离
            dis(j) = norm(data(i,:)-c(j,:));
        end
        % 第i个样本点归入第cmemorize(i)中心点
        [~,cmemorize(i)] = min(dis); 
        % 重新计算第cmemorize(i)中心点的样本总和及总权值
        sum(cmemorize(i),:) = sum(cmemorize(i),:) + data(i,:);
        count(cmemorize(i)) = count(cmemorize(i)) + 1;
    end
    % 重新计算k个重心以及与上一轮中心点的距离
    for i = 1:num
        core(i,:) = sum(i,:)/count(i);
        err(i) = norm(c(i)-core(i));
    end
    if(max(err) < err_T)
        % 误差小于阈值时跳出循环
        break;
    else
        c = core;
    end
end
label = cmemorize';
toc