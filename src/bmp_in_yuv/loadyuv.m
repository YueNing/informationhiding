%读取i帧图像的数据，并将每一帧保存在[YUV(:,:,:,i),Y(:,:,i),U(:,:,i),V(:,:,i)]中，[yuv,y,u,v]为全局变量
function [yuv,y,u,v]=loadyuv(filename,w,h,num_f)
%     w=176;
%     h=144;
%     %num_f=100;
%     %num_f=num_Frame(filename,w*h*1.5);
    for i=1:num_f
 [YUV(:,:,:,i),Y(:,:,i),U(:,:,i),V(:,:,i)]=loadFileYUV(w,h,i,filename,'420');
    end
  yuv=YUV;
  y=Y;
  u=U;
  v=V;
