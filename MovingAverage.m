function newdata=MovingAverage(data,n)
%% 移动平均法预处理数据
    [m,~]=size(data);
    newdata(1:n)=data(1:n);
    for i=n+1:m
        newdata(i)=sum(data(i-n:i-1))/n;%i时刻的预测值等于其前n个时刻的数据的平均值
    end
end