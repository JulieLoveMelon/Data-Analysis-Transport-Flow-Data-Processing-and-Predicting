function label = kmeans_clustering(data,num)
% dataΪ�������ݣ�numΪ������Ŀ
[N, n] = size(data);
err_T = 0.001;
%% ѡȡ���ĵ�
c = initial_point(data,num,2);
%% ��ʼ����
tic
while 1
    sum = zeros(num,n);
    count = zeros(num,1);
    % �����������������������ĵ�
    for i = 1:N
        for j = 1:num
            % ��i�������㵽��j�����ĵ�ľ���
            dis(j) = norm(data(i,:)-c(j,:));
        end
        % ��i������������cmemorize(i)���ĵ�
        [~,cmemorize(i)] = min(dis); 
        % ���¼����cmemorize(i)���ĵ�������ܺͼ���Ȩֵ
        sum(cmemorize(i),:) = sum(cmemorize(i),:) + data(i,:);
        count(cmemorize(i)) = count(cmemorize(i)) + 1;
    end
    % ���¼���k�������Լ�����һ�����ĵ�ľ���
    for i = 1:num
        core(i,:) = sum(i,:)/count(i);
        err(i) = norm(c(i)-core(i));
    end
    if(max(err) < err_T)
        % ���С����ֵʱ����ѭ��
        break;
    else
        c = core;
    end
end
label = cmemorize';
toc