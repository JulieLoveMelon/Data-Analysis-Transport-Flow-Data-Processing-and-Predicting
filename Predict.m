close;
clear;
clc;
load data_16d.mat;
%% 读取数据，并把三维数据维数分别存入minute、day和sensor
% 即分钟（5分钟一个数据）、天数（16天）和传感器数量（50个）
data=flow_50link;
[minute,day,sensor]=size(data);
N=14;%训练集大小
%% 用移动平均法对数据预处理，设置步长为15
step=10;
for i=step+1:minute
    data(i,:,:)=sum(flow_50link(i-step:i-1,:,:))./step;
end
%% 预测
m=1;
y_predict=zeros(minute-m,sensor,2);
y=zeros(minute-m,sensor,2);
for n=1:minute-m
    y_predict(n,:,:)=linear_predict(n,m,data);
    y(n,:,:)=squeeze(flow_50link(n+m,N+1:16,:))';
end
%% 绘图
plot(y_predict(:,1,2),'r');
hold on
plot(y(:,1,2),'b');
xlabel('时间/5min');
legend('预测值','实际值');
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