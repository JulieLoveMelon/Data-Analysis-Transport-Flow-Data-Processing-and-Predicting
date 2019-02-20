function sil = silhouette(data,count,cmemorize,k)
% ������ͨ����ȡ����ϵ������������Ч��
% dataΪ�������ݣ�countΪk��1�о��󣬼�¼ÿһ��Ԫ�صĸ�����
% cmenmorizeΪ1��N�о��󣬼�¼ÿһ��Ԫ�����������
% kΪָ�����������
% sil�����ڻ���Ϊk�������µ�����ϵ��
[N , ~] = size(data);
sil_all = zeros(N,1);
for i = 1:N
    cluster = cmemorize(i);
    cohesion_sum = 0;   % ���۶�
    separation_sum = zeros(k,1); % �����
    separation_tmp = zeros(k,1);
    for j = 1:N
        if(cmemorize(j) == cluster)
            % ͬһ��Ԫ��
            cohesion_sum = cohesion_sum + norm(data(i,:)-data(j,:));
        else
            % ��ͬ��Ԫ��
            separation_sum(cmemorize(j)) = separation_sum(cmemorize(j)) + norm(data(i,:)-data(j,:));
        end
    end
    % ��i�����ݵ�����۶�
    cohesion = cohesion_sum/(count(cluster)-1);
    % ��i�����ݵ�ķ����,ȡ��Сֵ
    for p = 1:k
        separation_tmp(p) =  separation_sum(p)/count(p);
    end
    [separation_order,~] = sort(separation_tmp,'descend'); 
    separation = separation_order(k-1);
    % ��i�����ݵ������ϵ��
    sil_all(i) = (separation-cohesion)/max(separation,cohesion);
end
sil = mean(sil_all);