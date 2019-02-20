close;
clear;
clc;
load data_16d.mat;
%% ��ȡ���ݣ�������ά����ά���ֱ����minute��day��sensor
% �����ӣ�5����һ�����ݣ���������16�죩�ʹ�����������50����
data=flow_50link;
[minute,day,sensor]=size(data);
N=14;%ѵ������С
%% ���ƶ�ƽ����������Ԥ�������ò���Ϊ15
step=10;
for i=step+1:minute
    data(i,:,:)=sum(flow_50link(i-step:i-1,:,:))./step;
end
%% Ԥ��
m=1;
y_predict=zeros(minute-m,sensor,2);
y=zeros(minute-m,sensor,2);
for n=1:minute-m
    y_predict(n,:,:)=linear_predict(n,m,data);
    y(n,:,:)=squeeze(flow_50link(n+m,N+1:16,:))';
end
%% ��ͼ
plot(y_predict(:,1,2),'r');
hold on
plot(y(:,1,2),'b');
xlabel('ʱ��/5min');
legend('Ԥ��ֵ','ʵ��ֵ');
abs_err=y_predict-y;
rlv_err=abs_err./y;
total_err1=0;
for i=1:50
total_err1=total_err1+mean(abs(rlv_err(:,i,1)));
end
meanerr1=total_err1/50;
total_err2=0;
for i=1:50
total_err2=total_err2+mean(abs(rlv_err(:,i,2)));
end
meanerr2=total_err2/50;