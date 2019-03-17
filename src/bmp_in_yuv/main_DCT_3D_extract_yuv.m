function [img,extractedimg]=main_DCT_3D_extract_yuv(FILENAME,PATHNAME,FILEINDEX)
num_f=100;
%[FILENAME,PATHNAME,FILEINDEX]=uigetfile('foreman_w.yuv','选择含有水印的yuv文件');
[yuv,y,u,v]=loadyuv(FILENAME,176,144,num_f);
 num=0;
 y=double(y);
k=4;%关键帧间隔

for i=1:k:num_f
    Y_keyframe(:,:,num+1)=y(:,:,i);%Y_keyframe为所有隔4帧取一帧的帧集合
    
    num=num+1;
end

%%分组
p=5;
q=0;
group_num=num/p;
for i=1:group_num
  for n=1:p
Y_key_group(:,:,n,i)=Y_keyframe(:,:,q+1);%把每P帧的Y分为一组，存入到Y_key_group四维数组中
             q=q+1;                                    %其中共4组，每组5个二维数组
  end
end
watermarkimgs=zeros(18,22);
%提取过程

for n=1:group_num
    
     y_key_group=Y_key_group(:,:,:,n);%取出分好的每一组进行处理，保存到y_key_group中
     watermarkimg=extract_3DDCT_5frame_YUV(y_key_group);
     watermarkimgs=watermarkimgs+watermarkimg;
     
end
%imshow(watermarkimg);
extractedimg=watermarkimgs/(group_num);%水印取平均


% [file,path] = uigetfile('*.jpg','原始水印图像');
[file,path] = uigetfile('YD(18_22).bmp','原始水印图像');
inputimg = strcat(path,file);
img = imread( inputimg );
% img=rgb2gray(img);
img=im2bw(img);
% img=imresize(img,[18 22]);

% nc=NC(img,extractedimg);
% % subpolt(121);
% imshow(extractedimg);
% title('提取的平均后的水印图像');
% xlabel(['NC=',num2str(nc)]);