function y_predict=linear_predict(n,m,flow_50link)

alpha=0.05;
N=14; %Number of Training Samples
for i=1:50
    [flow_nol,flow_avg,flow_std]=Normalization(flow_50link(:,:,i));
    %% ½¨Ä£
    PHi=flow_nol(1:n,1:N);
    Y=flow_nol(n+m,1:N);
    % X=[PHi];
    % X=[PHi;PHi.^2;PHi.^3];
    % X=[PHi;PHi.^2;PHi.^3;PHi.^4];
    for j=1:n
        for k=1:N
            X(j,k)=Sigmoid(PHi(j,k));
            %X(j,k)=GaussRBF(PHi(j,k));
        end
    end
    [a,b]=linear_regression2(Y', X', alpha);
    %% Ô¤²â
    phi=flow_nol(1:n,N+1:16);
    %y(i,:)=flow_50link(n+m,N+1:16,i);
    % x=[phi];
    for j=1:n
        for k=1:16-N
            x(j,k)=Sigmoid(phi(j,k));
            %x(j,k)=GaussRBF(phi(j,k));
        end
    end
    y_predict(i,:)=(b*x+a).*flow_std(N+1:16)+flow_avg(N+1:16);
end