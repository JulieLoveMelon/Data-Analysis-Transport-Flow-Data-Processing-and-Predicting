%% 多元回归函数
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   输入：
%      原始数据-X( N*n )   n变量数，N数据组数
%              -Y( N*1 )
%      显著性水平-alpha
%   输出：
%      判断是否病态；
%      自适应回归曲线； 
%	   F检验；
%      置信区间
%   调用方式：
%      linear_regression(X,Y,0.05)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [c0,c] = linear_regression(X_origin,Y_origin,alpha)
%% Step0 读入原始数据并打印
    % height变量个数 width数据个数
    X_origin = X_origin';
    [height,width] = size(X_origin);  
    Y_origin = Y_origin';
    
    if( alpha <=0 || alpha>=1)
        disp('Please note 0 < alpha < 1 !');
        return;
    end
    disp('The data has been successfully loaded!');

    
    %% Step1 计算重要参数并打印
    
    for i = 1:height
        X_mean(i) = mean(X_origin(i,:));
        X_var(i) = sum((X_origin(i,:)-X_mean(i)).^2)/width;
    end
    Y_mean = mean(Y_origin);
    Y_var = sum((Y_origin(1,:)-Y_mean).^2)/width;

    for i = 1:height
        X(i,:) = ( X_origin(i,:)-X_mean(i) )./sqrt( X_var(i) );
    end
    Y = ( Y_origin-Y_mean)./sqrt( Y_var );

    X_XT = X*X';
    [Q,Lambda,QT] = svd(X_XT);
    

    %% Step2 进行多元线性回归并打印
    % 只挑选特征值大于1的输入变量，防止病态问题
    [index,~] = find(Lambda > 1);
    [m,~] = size(index);
    Qm = zeros(height,m);
    Lambda_m = zeros(m,m);
    fprintf('We only select the eigenvalues greater than 1');
    fprintf('\n');
    if( m == height)
        fprintf('Luckily, there is no morbid linear problem! ');
    end
    fprintf('\n');
    for i = 1:m
        Qm(:,i) = Q( :,index(i,1) );
        Lambda_m(i,i) = Lambda(index(i,1),index(i,1));
    end

    d = (inv(Lambda_m)*Qm'*X*Y');
    % 计算回归系数
    c = (Qm*d); 

    % 解除归一化
    % height_c有效变量数
    [height_c,~] = size(c);
    c0 = 0;

    for i = 1:height_c
        % 计算系数
        c(i,1) = c(i,1).*sqrt( Y_var )./sqrt( X_var(i) );
        % 计算常数
        c0 = c0 - c(i,1)*X_mean(i);
    end
    c0 = c0+Y_mean;

    Y_conjection = zeros(size(Y_origin));
    for i = 1:width 
        for j = 1:height_c
            Y_conjection(1,i) = Y_conjection(1,i)+c(j,1)*X_origin(j,i);
        end
    end
    Y_conjection = Y_conjection+c0;
    fprintf('So the regression curve:  y = %f',c0);
    for i = 1:height_c
        fprintf(' + (%f)x%d',c(i),i);
    end
    fprintf('\n');
    fprintf('\n');
    
    %% Step3 进行F检验并打印
    disp('The following is the F text: ');
    disp('The significance level you chose is ');
    str = ['alpha = ',num2str(alpha)];
    disp(str);
    TSS = 0;
    ESS = 0;
    RSS = 0;
    for i = 1:width
        TSS = TSS+(Y_origin(1,i)-Y_mean)^2;
        ESS = ESS+(Y_conjection(1,i)-Y_mean)^2;
        RSS = RSS+(Y_conjection(1,i)-Y_origin(1,i))^2;
    end
    fT = width-1;
    fE = height;
    fR = width-1-height;
    F = (ESS/fE)/(RSS/fR);
    F_alpha = finv(1-alpha,fE,fR);
    disp('The F_alpha in the F distribution form is ');
    str = ['F_alpha = ',num2str(F_alpha)];
    disp(str);
    disp('The calculating F is ');
    str = ['F = ',num2str(F)];
    disp(str);
    fprintf('\n');

    %% Step4 计算置信区间并绘制图像
    if (F>F_alpha)
    %% 否定原假设，即X与Y呈线性关系
        disp('F > F_alpha, so Y has a linear relationship with X !');
        S_sigma = sqrt(RSS/(width-1-height));
        Z_alpha = norminv(alpha/2,0,1);
        range = abs(Z_alpha*S_sigma);
        
        str = ['Confidence interval: ',  num2str(range)];
        disp(str);
    else
        disp('F <= F_alpha, so there is no linear relationship with X !');
    end
end