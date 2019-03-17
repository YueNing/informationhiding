%文件名：PSNR.m
%编  写：郭林庚
%编写时间：2005.11.01
%函数功能：本函数将完成对输入图像的峰值信噪比计算
%输入格式举例：psnr=PSNR('lena.jpg','lenawater.jpg');
%参数说明：
%original为原始图像
%test为加有水印的图像
%psnrvalue为两者峰值信噪比
%实际上也计算了MSE，SNR值

function psnrvalue=PSNR(original,test);

%计算原始图像的信号功率
A=imread(original);
%A=rgb2gray(A);
A=double(A);
B=imread(test);
%B=rgb2gray(B);
B=double(B);

%计算MSE
%判断输入图像是否有效
[m,n]=size(A);
[m2,n2]=size(B);
if m2~=m||n2~=n
    error('图像选择错误');
end

%计算MSE
msevalue=0;
for i=1:m
    for j=1:n
        msevalue=msevalue+(A(i,j)-B(i,j))^2;
    end
end
msevalue=msevalue/(m*n);
if msevalue==0
    error('图像选择错误');
end

%计算信噪比，峰值信噪比
signal=0;
for i=1:m
    for j=1:n
        signal=signal+A(i,j)^2;
    end
end
signal=signal/(m*n);
snrvalue=signal/msevalue;
snrvalue=10*log10(snrvalue);
psnrvalue=255^2/msevalue;
psnrvalue=10*log10(psnrvalue);