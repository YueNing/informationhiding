%函数功能本函数将完成提取隐秘于LSB上的秘密消息
%输入格式举例:result=lsbget('LSBcover.bmp',320,'secret.txt')
%参数说明:
%output是信息隐秘后的图像
%len_total是秘密消息的长度
%goalfile是提取出的秘密消息文件
%result是提取的消息


function result=lsbget(output,len_total,goalfile)
ste_cover=imread(output);
ste_cover=double(ste_cover);


%判断嵌入消息量是否过大
[m,n]=size(ste_cover);
frr=fopen(goalfile,'a');


%p作为消息嵌入位数计数器,将消息序列写回文本文件
p=1;
for f2=1:n
    for f1=1:m
          if bitand(ste_cover(f1,f2),1)==1%得到图像矩阵的最后一位为文本的信息（因为图像矩阵是以8为一整体，例如第一行第一列为8位的数据）
              fwrite(frr,1,'ubit1');
              result(p,1)=1;
          else
              fwrite(frr,0,'ubit1');
              result(p,1)=0;
          end 
          
          if p==len_total
               break;
          end
          
          p=p+1;
    end
          if p==len_total 
              break;
          end    
end  
fclose(frr);
  