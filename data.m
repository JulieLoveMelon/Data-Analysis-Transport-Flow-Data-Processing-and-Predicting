 load('data_16d.mat');
 newdata = zeros(800,288);
 k = 1;
 for i=1:16
     for j=1:50
         newdata(k,:) = flow_50link(:,i,j)';
         k = k+1;
     end
 end

fid=fopen('newdata.txt','w');%写入文件路径
[m,n]=size(newdata);
 for i=1:m
    for j=1:n
       if j==n
         fprintf(fid,'%g\r\n',newdata(i,j));
      else
        fprintf(fid,'%g\t',newdata(i,j));
       end
    end
end
fclose(fid);
