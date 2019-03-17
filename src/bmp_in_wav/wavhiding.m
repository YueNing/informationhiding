function []=wavhiding(filenamebmpw,oa,n);
% fid=fopen('2.wav','rb');
% %[file,path] = uigetfile('2.wav','Open wav file');
% oa=fread(fid,inf,'uchar');
% n=length(oa)-44;%wav文件从文件头到数据前面共有44字节的格式说明
% fclose(fid);
io=imread(filenamebmpw);
[row,col]=size(io);
io=io';
wi=io(:);
if row*col>n
    error('载体太小，请更换载体');
end
markedaudio=oa;
marklength=row*col;
fprintf('嵌入图像的长度为：%.0d\n',marklength);
for k=1:row*col
    markedaudio(44+k)=bitset(markedaudio(44+k),1,wi(k));
end
figure;
subplot(2,1,1);plot(oa(1:1000));
subplot(2,1,2);plot(markedaudio(1:1000));
fid=fopen('output/hidden/wav/marked.wav','wb');
fwrite(fid,markedaudio,'uchar');
fclose(fid);

