# informationhidding

### matlab实现的信息隐藏

***在安装了matlab的前提下  运行目录下面的main.m文件***

- new.bmp是用于初始化界面显示中的图片显示区域
- main.m和main.fig主界面的显示函数
- about.txt是本次实验更多信息(原理性）
- help.txt为程序的使用说明

### BMP

[message.txt](resources/hide/message.txt) 需要隐藏的文本信息

lsbhide.m和lsbget.m分别为BMP为载体的信息隐藏和提取函数

bmp.fig和bmp.m为bmp为载体的信息隐藏的界面函数

hallo.bmp

### JPG

randinterval.m是JPG为载体的DCT信息隐藏的随机函数

jpg.m和jpg.fig为载体为jpg的信息隐藏界面

hidedctadv.m和extractdctadv.m是jpg为载体的信息隐藏和提取函数

1.txt为jpg为载体的隐藏文本

hallo.jpg

### WAV

wavhiding.m音频（wav）隐藏函数

wavextract.m音频（wav）提取函数

wav.m和wav.fig是音频为载体的信息隐藏界面

Vector2Matrix.m是音频中数据提取过程中的格式转化函数

bupt.bmp为音频水印图像

1.wav和2.wav为测试的音频


### YUV

YUVFormat.m是YUV视频的格式转换（读取的时候需要用到的函数）

yuv.m和yuv.fig是视频为载体的信息隐藏界面

YD（18-22）视频水印图片

suzie.yuv是YUV视频载体

PSNR.m是视频信息隐藏中的信噪比函数

NC.m归一化函数（用于比较原始水印和提取出来的水印）

main_DCT_3D_extract_yuv.m和main_DCT_3D_embed_yuv.m分别为视频信息隐藏的提取和隐藏函数

loadyuv.m和loadFileYUV.m为YUV视频的读取函数

extract_3DDCT_5frame_YUV.m和embed_3DDCT_5frame_YUV.m为视频信息隐藏中提取和隐藏要调用的函数

average------psnr.m为平均信噪比函数用以比较原始和提取函数的信噪比的


