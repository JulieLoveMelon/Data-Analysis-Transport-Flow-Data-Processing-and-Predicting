function c = initial_point(data,k,i)
% ����������������data��ʹ�õ�i�ַ���ȷ��k����ʼ��
% ����ֵcΪk��n�еĳ�ʼ����Ϣ

switch i
    case 1
        % ȡdata�е�ǰk����Ϊ���ĵ�
        for i = 1:k
            c(i,:) = data(i,:);
        end
    case 2
        % ���ȡk������Ϊ���ĵ�
        [N , ~]=size(data);
        randindex = randperm(N);%����1��N���������
        for i=1:k
            c(i,:) = data(randindex(i),:);
        end
    case 3
        % ѡ��˴˾��뾡����Զ��k����
        [N , ~]=size(data);
        randindex = randperm(N);
        c(1,:) = data(randindex(1),:);
        for i = 2:k
            for j = 1:N
                % �����㵽��ȷ�����ĵ�ľ���(ȡ��С)
                for p = 1:i-1
                    distance(p) = norm(data(j,:)-c(p,:));
                end
                min_dis(j) = min(distance);
            end
            [~, index] = max(min_dis);
            c(i,:) = data(index,:);
        end
end
end