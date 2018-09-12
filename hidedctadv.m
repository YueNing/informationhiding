%函数功能:本函数用于DCT域的信息隐藏
%输入格式举例:[count,msg,result]=hidedctadv('lenna.jpg','DCTcover.jpg','1.txt',1988,1)
%参数说明：
%image为载体图像
%imagegoal为藏有秘密信息的载体，即隐蔽载体
%msg为待隐藏的信息
%key为密钥，用来控制随机选块
%alpha为控制量，用来保证编码的正确性
%count为待隐藏信息的长度
%result为隐藏结果
function [count,msg,result]=hidedctadv(image,imagegoal,msg,key,alpha)
%按位读取秘密信息
frr=fopen(msg,'r');
[msg,count]=fread(frr,'ubit1');
fclose(frr);
data0=imread(image);
%将图像矩阵转为double型
data0=double(data0)/255;
%取图像的一层做隐藏
data=data0(:,:,1);
%对图像分块
T=dctmtx(8);
%对分块图像做DCT变换
DCTrgb=blkproc(data,[8 8],'P1*x*P2',T,T');
%产生随机的块选择，确定图像块的首地址
[row,col]=size(DCTrgb);
row=floor(row/8);
col=floor(col/8);
a=zeros([row col]);
[k1,k2]=randinterval(a,count,key);
for i=1:count
    k1(1,i)=(k1(1,i)-1)*8+1;
    k2(1,i)=(k2(1,i)-1)*8+1;
end

%信息嵌入
for i=1:count 
    if msg(i,1)==0
       if DCTrgb(k1(i)+4,k2(i)+1)>DCTrgb(k1(i)+3,k2(i)+2)
           temp=DCTrgb(k1(i)+4,k2(i)+1); 
           DCTrgb(k1(i)+4,k2(i)+1)=DCTrgb(k1(i)+3,k2(i)+2); 
           DCTrgb(k1(i)+3,k2(i)+2)=temp; 
       end
    else
       if DCTrgb(k1(i)+4,k2(i)+1)<DCTrgb(k1(i)+3,k2(i)+2)
            temp=DCTrgb(k1(i)+4,k2(i)+1);
            DCTrgb(k1(i)+4,k2(i)+1)=DCTrgb(k1(i)+3,k2(i)+2); 
            DCTrgb(k1(i)+3,k2(i)+2)=temp; 
       end 
    end 
    if (DCTrgb(k1(i)+4,k2(i)+1)>DCTrgb(k1(i)+3,k2(i)+2)) 
        DCTrgb(k1(i)+3,k2(i)+2)=DCTrgb(k1(i)+3,k2(i)+2)-alpha; 
%将原本小的系数调整到更小 
    else 
        DCTrgb(k1(i)+4,k2(i)+1)= DCTrgb(k1(i)+4,k2(i)+1)-alpha; 
    end 
end
%信息写回保存
data=blkproc(DCTrgb,[8 8],'P1*x*P2',T',T); 
result=data0; 
result(:,:,1)=data; 
imwrite(result,imagegoal);
%显示实验结果
%subplot(1,2,1);imshow(data0);title('原始图像');
%subplot(1,2,2);imshow(imagegoal);title('隐藏信息的图像');

