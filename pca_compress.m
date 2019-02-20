function [pcs, cprs_data, cprs_c] = pca_compress(data, rerr)
[~,n]=size(data);
%% ��һ��
cprs_c(1,:)=mean(data);
cprs_c(2,:)=std(data);
for i=1:n
    X(:,i)=(data(:,i)-cprs_c(1,i))/cprs_c(2,i);
end
X=X';
%% Ѱ������ֵ����������
A=X*X';
[eig_vector,eig_value]=eig(A);
lamda=diag(eig_value);
threshold=rerr*sum(lamda);

%% Ѱ�����ɷ�
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

%% ѹ��
cprs_data=pcs'*X;
