function [fwidth,fheight]=YUVFormat(format)
    %set factor for UV-sampling
    fwidth = 0.5;
    fheight= 0.5;
    %注：以下4种格式下，每种格式中U和V的个数是相等的
    if strcmp(format,'400')
        fwidth = 0;  %U和V的个数在水平方向是0
        fheight= 0;  %U和V的个数在垂直方向是0
    elseif strcmp(format,'411')
        fwidth = 0.25;%U和V的个数在水平方向是Y个数的1/4
        fheight= 1;  %U和V的个数在垂直方向和Y个数相等
    elseif strcmp(format,'420')
        fwidth = 0.5;%U和V的个数在水平方向是Y个数的1/2
        fheight= 0.5;%U和V的个数在垂直方向是Y个数的1/2
    elseif strcmp(format,'422')
        fwidth = 0.5;%U和V的个数在水平方向是Y个数的1/2
        fheight= 1;  %U和V的个数在垂直方向和Y的个数相等
    elseif strcmp(format,'444')
        fwidth = 1;  %U和V的个数在水平方向和Y的个数相等
        fheight= 1;  %U和V的个数在垂直方向和Y的个数相等
    else
        display('Error: wrong format');
end
