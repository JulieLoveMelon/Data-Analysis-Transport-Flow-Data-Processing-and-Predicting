function newdata=MovingAverage(data,n)
%% �ƶ�ƽ����Ԥ��������
    [m,~]=size(data);
    newdata(1:n)=data(1:n);
    for i=n+1:m
        newdata(i)=sum(data(i-n:i-1))/n;%iʱ�̵�Ԥ��ֵ������ǰn��ʱ�̵����ݵ�ƽ��ֵ
    end
end