function watermarkimg=extract_3Ddwt_5frame_YUV(y_key_group)
D=35;
p=5;
for k=1:p
  eval(['im_y',int2str(k),'=','y_key_group(:,:,k)']);
end


for i=1:18
      for j=1:22
          
          BLOCK1=im_y1(1+(i-1)*8:i*8,1+(j-1)*8:j*8);
          BLOCK2=im_y2(1+(i-1)*8:i*8,1+(j-1)*8:j*8);
          BLOCK3=im_y3(1+(i-1)*8:i*8,1+(j-1)*8:j*8);
          BLOCK4=im_y4(1+(i-1)*8:i*8,1+(j-1)*8:j*8);
          BLOCK5=im_y5(1+(i-1)*8:i*8,1+(j-1)*8:j*8);
          
          [ca1,ch1,cv1,cd1]=dwt2(BLOCK1,'db1');
          [ca2,ch2,cv2,cd2]=dwt2(BLOCK2,'db1');
          [ca3,ch3,cv3,cd3]=dwt2(BLOCK3,'db1');
          [ca4,ch4,cv4,cd4]=dwt2(BLOCK4,'db1');
          [ca5,ch5,cv5,cd5]=dwt2(BLOCK5,'db1');
       
 CA=[ca1(1,1),ca2(1,1),ca3(1,1),ca4(1,1),ca5(1,1),];%取第一个近似系数，时间轴
 
  [cA,cD]=dwt(CA,'db1');%第二次dwt 
   avr=mean(cA);
         watermarkimg(i,j)=mod(floor(avr/D+0.5),2);

%  watermarkimg(i,j)=mod(floor(cA(1)/D),2);
                
    end
end

