function y_key_group=embed_3Ddwt_5frame_YUV(y_key_group,watermarkimg)


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
       
 CA=[ca1(1,1),ca2(1,1),ca3(1,1),ca4(1,1),ca5(1,1)];%取第一个近似系数，时间轴
 
  [cA,cD]=dwt(CA,'db1');%第二次dwt 
    avr=mean(cA);
    temp=floor(avr/D+0.5);
    T=floor(avr/D);
    
        if(mod(temp,2)==watermarkimg(i,j))
            X=temp*D;
       end
         if(mod(temp,2)~=watermarkimg(i,j)&&temp==T)
            X=(temp+1)*D;
        end    
        if(mod(temp,2)~=watermarkimg(i,j)&&temp~=T)
            X=(temp-1)*D;
        end    
        deta=X-avr;
         cA=cA+deta;


% temp=floor(cA(1)/D);
 %        if(mod(temp,2)==watermarkimg(i,j))
 %            cA(1)=temp*D+D/2;
%         else
%             cA(1)=temp*D-D/2;
 %        end    




     CA=idwt(cA,cD,'db1');

    ca1(1,1)=CA(1);
    ca2(1,1)=CA(2);
    ca3(1,1)=CA(3);
    ca4(1,1)=CA(4);
    ca5(1,1)=CA(5);
     
    
    BLOCK1=idwt2(ca1,ch1,cv1,cd1,'db1');
    BLOCK2=idwt2(ca2,ch2,cv2,cd2,'db1');
    BLOCK3=idwt2(ca3,ch3,cv3,cd3,'db1');
    BLOCK4=idwt2(ca4,ch4,cv4,cd4,'db1');
    BLOCK5=idwt2(ca5,ch5,cv5,cd5,'db1');
    
     
     
   im_y1(1+(i-1)*8:i*8,1+(j-1)*8:j*8)= BLOCK1;
   im_y2(1+(i-1)*8:i*8,1+(j-1)*8:j*8)= BLOCK2;
   im_y3(1+(i-1)*8:i*8,1+(j-1)*8:j*8)= BLOCK3;
   im_y4(1+(i-1)*8:i*8,1+(j-1)*8:j*8)= BLOCK4;
   im_y5(1+(i-1)*8:i*8,1+(j-1)*8:j*8)= BLOCK5;
    
    end
  end

for k=1:p
  eval(['y_key_group(:,:,k)','=',strcat('im_y',int2str(k))]);
end
    
   