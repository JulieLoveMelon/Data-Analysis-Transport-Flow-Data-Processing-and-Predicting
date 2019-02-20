close;
clear;
clc;
load data_16d.mat;
load location.mat;
%% clustering
img=imread('link分布示意图.Jpeg');
classes=2;

index=zeros(classes,50);

for i=1:50
    for j=1:16
        data(i,24*j-23:24*j) =squeeze( flow_50link(84:107,j,i));
    end
end
label = kmeans_clustering(data, classes);
    class1=find(label==1);
    class2=find(label==2);
%     class3=find(label==3);
%     class4=find(label==4);
%     class5=find(label==5);
%     class6=find(label==6);
%     class7=find(label==7);
%     class8=find(label==8);
%     class9=find(label==9);
%     class10=find(label==10);
%     class11=find(label==11);
%     class12=find(label==12);
figure;imshow(img);hold on;
plot(location(class1,1),location(class1,2),'.r','MarkerSize',30);
plot(location(class2,1),location(class2,2),'.b','MarkerSize',30);
% plot(location(class3,1),location(class3,2),'.y','MarkerSize',30);
% plot(location(class4,1),location(class4,2),'.g','MarkerSize',30);
% plot(location(class5,1),location(class5,2),'.m','MarkerSize',30);
% plot(location(class6,1),location(class6,2),'.k','MarkerSize',30);
% plot(location(class7,1),location(class7,2),'pr','MarkerSize',10,'LineWidth',5);
% plot(location(class8,1),location(class8,2),'pb','MarkerSize',10,'LineWidth',5);
% plot(location(class9,1),location(class9,2),'py','MarkerSize',10,'LineWidth',5);
% plot(location(class10,1),location(class10,2),'pg','MarkerSize',10,'LineWidth',5);
% plot(location(class11,1),location(class11,2),'pm','MarkerSize',10,'LineWidth',5);
% plot(location(class12,1),location(class12,2),'pk','MarkerSize',10,'LineWidth',5);