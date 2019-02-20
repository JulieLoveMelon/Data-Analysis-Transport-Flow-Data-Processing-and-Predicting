function newdata=ExponentialSmoothing(data,a)
%% ָ��ƽ����
    [m,~]=size(data);
    newdata=zeros(1,m);
    newdata(1)=data(1);
    for i=2:m
        newdata(i)=a*data(i)+(1-a)*newdata(i-1);
    end
end