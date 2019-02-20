function [pcs, cprs_data, cprs_c] = pca_compress(data, rerr)
[~,n]=size(data);
%% 归一化
cprs_c(1,:)=mean(data);
cprs_c(2,:)=std(data);
for i=1:n
    X(:,i)=(data(:,i)-cprs_c(1,i))/cprs_c(2,i);
end
X=X';
%% 寻找特征值和特征向量
A=X*X';
[eig_vector,eig_value]=eig(A);
lamda=diag(eig_value);
threshold=rerr*sum(lamda);

%% 寻找主成分
sum_lamda=0;
for i=1:n
    sum_lamda=sum_lamda+lamda(i);
    if sum_lamda>threshold
        break;
    end
end
m=n-i+1;
for i=1:m
    pcs(:,i)=eig_vector(:,n-i+1);
end

%% 压缩
cprs_data=pcs'*X;
