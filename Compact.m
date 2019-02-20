close;
clear;
clc;
load data_16d.mat;
%% ѹ��
rerr=0.02;
data=zeros(288,16*50);
for i=1:288
    for j=1:16
        data(i,50*j-49:50*j)=flow_50link(i,j,:);
    end
end
[pcs, cprs_data, cprs_c] = pca_compress(data', rerr);

%% ��ѹ��
recon_flow=zeros(288,16,50);
recon_data = pca_reconstruct(pcs, cprs_data, cprs_c)';
for i=1:288
    for j=1:16
        recon_flow(i,j,:)=recon_data(i,50*j-49:50*j);
    end
end

%% ����������
err=sqrt(sum(sum(sum((flow_50link-recon_flow).^2)))/(288*16*50));
error=sum(sum(sum(abs(flow_50link-recon_flow))))/(288*16*50);
disp(error);

%% ����ͼ��
figure;
hold on
plot(flow_50link(:,1,1),'r');
plot(recon_flow(:,1,1),'b');
legend('ѹ��ǰ','ѹ����');
title('��15��1�ż����ѹ��ǰ�����ݶԱ�');
xlabel('ʱ��/5min');
abs_err=y_predict-y;
rlv_err=abs_err./y;