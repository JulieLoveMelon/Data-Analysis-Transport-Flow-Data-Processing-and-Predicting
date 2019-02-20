function [X,X_avg,X_std]=Normalization(data)
    [N,n]=size(data);
    X=zeros(N,n);
    X_avg=mean(data);
    X_std=std(data);
    for i=1:n
        X(:,i)=(data(:,i)-X_avg(i))/X_std(i);
    end
end