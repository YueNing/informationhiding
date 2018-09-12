% width:每一帧的宽度； heigth:每一帧的高度；  Frame:当前load的那一帧；
% filename:文件名；    Teil_h:垂直比例参数；  Teil_b:水平比例参数
% YUV：返回值，返回YUV分量，是一个三维变量，U、V分量的宽度和高度设成与Y一样的了，因此UV分量中有重复的
% YUV(:,:,1)存放Y分量；YUV(:,:,2)存放U分量；YUV(:,:,3)存放V分量
% Y,U,V是三个分量的实际值，二维矩阵，没有重复，他们的长度可能不一样
function [YUV,Y,U,V] = loadFileYUV(width,heigth,Frame,fileName,format)
    [Teil_h,Teil_b]=YUVFormat(format);
    % get size of U and V
    fileId = fopen(fileName,'r');
    width_h = width*Teil_b;  %U和V的实际宽度；【注】：4种格式下，每种格式中U和V的个数是相等的
    heigth_h = heigth*Teil_h;%U和V的实际高度；【注】：4种格式下，每种格式中U和V的个数是相等的
    % compute factor for framesize
    factor = 1+(Teil_h*Teil_b)*2;
    % compute framesize
    framesize = width*heigth;
    %将file position indicator定位到当前帧的起始位置，factor*framesize：一帧中的字节数
    fseek(fileId,(Frame-1)*factor*framesize, 'bof');
    % create Y-Matrix
    YMatrix = fread(fileId, width * heigth, 'uchar');
    %将一维序列YMatrix转换成width*heigth的二维矩阵，然后转置，再int16
    %reshape(x,m,n)是按列重新组织的，m表示每列的元素个数，n表示每行的元素个数，所以最后需要转置
    YMatrix = int16(reshape(YMatrix,width,heigth)');
    Y=uint8(YMatrix);
    % create U- and V- Matrix
    if Teil_h == 0
        UMatrix = 0;
        VMatrix = 0;
    else
        %file position indicator不用重新定位，matlab记着呢
        UMatrix = fread(fileId,width_h * heigth_h, 'uchar');
        UMatrix = int16(UMatrix);
        UMatrix = reshape(UMatrix,width_h, heigth_h).';%U的二维矩阵
        U=uint8(UMatrix);
        
        VMatrix = fread(fileId,width_h * heigth_h, 'uchar');
        VMatrix = int16(VMatrix);
        VMatrix = reshape(VMatrix,width_h, heigth_h).'; %V的二维矩阵  
        V=uint8(VMatrix);
    end
    % compose the YUV-matrix:（YUV是此函数的返回值,
    % YUV是一个三维变量：YUV(:,:,1)存放Y,YUV(:,:,2)存放U,YUV(:,:,3)存放V）
    YUV(1:heigth,1:width,1) = YMatrix;%Y
    
    if Teil_h == 0
        YUV(:,:,2) = 127;%U
        YUV(:,:,3) = 127;%V
    end
    % consideration of the subsampling of U and V
    if Teil_b == 1
        UMatrix1(:,:) = UMatrix(:,:);%UMatrix(:,:)：已经从文件中读出来的U
        VMatrix1(:,:) = VMatrix(:,:);%VMatrix(:,:)：已经从文件中读出来的V
    
    elseif Teil_b == 0.5     % heigth_h：UMatrix(:,:)矩阵的实际高度  
        UMatrix1(1:heigth_h,1:width) = int16(0);% width是帧的宽度，和Y的宽度一样
        UMatrix1(1:heigth_h,1:2:end) = UMatrix(:,1:1:end);
        UMatrix1(1:heigth_h,2:2:end) = UMatrix(:,1:1:end);%到此：U1U1U2U2U3U3......；水平方向重复2次
                                                          %      ..................
        VMatrix1(1:heigth_h,1:width) = int16(0);
        VMatrix1(1:heigth_h,1:2:end) = VMatrix(:,1:1:end);
        VMatrix1(1:heigth_h,2:2:end) = VMatrix(:,1:1:end);
    
    elseif Teil_b == 0.25
        UMatrix1(1:heigth_h,1:width) = int16(0);
        UMatrix1(1:heigth_h,1:4:end) = UMatrix(:,1:1:end);
        UMatrix1(1:heigth_h,2:4:end) = UMatrix(:,1:1:end);
        UMatrix1(1:heigth_h,3:4:end) = UMatrix(:,1:1:end);
        UMatrix1(1:heigth_h,4:4:end) = UMatrix(:,1:1:end);%水平方向重复4次
        
        VMatrix1(1:heigth_h,1:width) = int16(0);
        VMatrix1(1:heigth_h,1:4:end) = VMatrix(:,1:1:end);
        VMatrix1(1:heigth_h,2:4:end) = VMatrix(:,1:1:end);
        VMatrix1(1:heigth_h,3:4:end) = VMatrix(:,1:1:end);
        VMatrix1(1:heigth_h,4:4:end) = VMatrix(:,1:1:end);%水平方向重复4次
    end
    
    if Teil_h == 1
        YUV(:,:,2) = UMatrix1(:,:);
        YUV(:,:,3) = VMatrix1(:,:);
        
    elseif Teil_h == 0.5        
        YUV(1:heigth,1:width,2) = int16(0);
        YUV(1:2:end,:,2) = UMatrix1(:,:);
        YUV(2:2:end,:,2) = UMatrix1(:,:);%垂直方向重复2次
        
        YUV(1:heigth,1:width,3) = int16(0);
        YUV(1:2:end,:,3) = VMatrix1(:,:);
        YUV(2:2:end,:,3) = VMatrix1(:,:);%垂直方向重复2次
        
    elseif Teil_h == 0.25
        YUV(1:heigth,1:width,2) = int16(0);
        YUV(1:4:end,:,2) = UMatrix1(:,:);
        YUV(2:4:end,:,2) = UMatrix1(:,:);
        YUV(3:4:end,:,2) = UMatrix1(:,:);
        YUV(4:4:end,:,2) = UMatrix1(:,:);%垂直方向重复4次
        
        YUV(1:heigth,1:width) = int16(0);
        YUV(1:4:end,:,3) = VMatrix1(:,:);
        YUV(2:4:end,:,3) = VMatrix1(:,:);
        YUV(3:4:end,:,3) = VMatrix1(:,:);
        YUV(4:4:end,:,3) = VMatrix1(:,:);%垂直方向重复4次
    end
    YUV = uint8(YUV);
fclose(fileId);
