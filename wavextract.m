function []=wavextract();
marklength=5394;%提取的水印图像大小，已知
row=58;                    %row是水印图像行数，已知
fid=fopen('marked.wav','r');
oa=fread(fid,inf,'uint8');
status=fseek(fid,44,'bof');
a=fread(fid,marklength,'uint8');
for i=1:marklength
    w1(i)=bitget(a(i),1);
end
w1=w1';
m=Vector2Matrix(w1,row);
imwrite(m,'markedbupt.bmp','bmp');
% figure;
% imshow('markedbupt.bmp');title('extracted watermark');
%归一化相关系数
% ImageA=imread('bupt.bmp');
% ImageB=imread('markedbupt.bmp');
% % nc=nc(ImageA,ImageB);
% fprintf('嵌入水印图像与提取水印图像的归一化相关系数nc=%.3f\n',nc);