function [v1,v2,p,a1,psnrvalue]=main_DCT_3D_embed_yuv(file,path,FILENAME,PATHNAME,FILEINDEX);
%读入水印图片
%[file,path] = uigetfile('YD(18_22).bmp','原始水印图像');
inputimg = strcat(path,file);
img = imread( inputimg );
img=im2bw(img);
img=imresize(img,[18 22]);
%imshow(img);


%读入原始视频文件
num_f=100;
%[FILENAME,PATHNAME,FILEINDEX]=uigetfile('suzie.yuv','选择一个yuv文件');
[yuv,y,u,v]=loadyuv(FILENAME,176,144,num_f);
%num_f帧数
 num=0;
 y=double(y);
k=4;%关键帧间隔
for i=1:k:num_f
    Y_keyframe(:,:,num+1)=y(:,:,i);%Y_keyframe为所有隔4帧取一帧的帧集合
    U_keyframe(:,:,num+1)=u(:,:,i);
    V_keyframe(:,:,num+1)=v(:,:,i);
    num=num+1;
end


%只含关键帧的视频文件
fileId = fopen('keysuzie.yuv','wb');%
for i=1:num
fwrite(fileId,Y_keyframe(:,:,i)' , 'uchar');
fwrite(fileId,U_keyframe(:,:,i)' , 'uchar');
fwrite(fileId,V_keyframe(:,:,i)' , 'uchar');
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

%记录Y_key_group
% YKG=Y_key_group;

i=1;


%%嵌入过程
for n=1:group_num
    
     y_key_group=Y_key_group(:,:,:,n);%取出分好的每一组进行处理，保存到y_key_group中
     y_key_group=embed_3DDCT_5frame_YUV(y_key_group,img);
%      watermarkimg=extract_3DDCT_5frame_YUV(y_key_group);
%      imshow(watermarkimg);
     
     Y_key_group(:,:,:,n)=y_key_group;%把处理好的组进行替换
     
end


%处理后只含关键帧的视频文件
i=1;
for n=1:group_num
    Y_WMK_keyframe(:,:,1+(i-1)*p:i*p)=Y_key_group(:,:,:,n);
    i=i+1;
end
    
fileId = fopen('WMK_keyframe_suzie.yuv','wb');%
for i=1:num
fwrite(fileId,Y_WMK_keyframe(:,:,i)' , 'uchar');
fwrite(fileId,U_keyframe(:,:,i)' , 'uchar');
fwrite(fileId,V_keyframe(:,:,i)' , 'uchar');
end




%%放入并替换原视频帧
i=1;
    for x=1:num
y(:,:,i)=Y_WMK_keyframe(:,:,x);
i=i+p-1;
   
    end


    
%写含有水印的视频文件
fileId = fopen('suzie_w.yuv','wb');%
for i=1:100
fwrite(fileId,y(:,:,i)' , 'uchar');
fwrite(fileId,u(:,:,i)' , 'uchar');
fwrite(fileId,v(:,:,i)' , 'uchar');
end



p=20;
%%平均PSNR
[v1,v2,a1,psnrvalue]=average_psnr(p);
fclose('all');
