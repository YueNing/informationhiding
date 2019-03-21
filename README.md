# informationhiding

### matlab实现的信息隐藏

***在安装了matlab的前提下  运行目录下面的main.m文件***

- main.m和main.fig主界面的显示函数
- about.txt是本次实验更多信息(原理性）***TODO***
- [help.txt](document/help.txt)为程序的使用说明

### TEXT_IN_BMP

- [lsbhide.m](src/text_in_bmp/lsbhide.m) 和 [lsbget.m](src/text_in_bmp/lsbget.m) 分别为BMP为载体的信息隐藏和提取函数
- [bmp.fig](gui/text_in_bmp/) 和 [bmp.m](gui/text_in_bmp/bmp.m)为bmp为载体的信息隐藏的界面函数
- [hallo.bmp](resources/carrier/hallo.bmp) bmp图片载体
- [message.txt](resources/hide/message.txt) 需要隐藏的文本信息

### TEXT_IN_JPG

- [hidedctadv.m](src/text_in_jpg/hidedctadv.m) 和 [extractdctadv.m](src/text_in_jpg/extractdctadv.m) 是jpg为载体的信息隐藏和提取函数
- [jpg.m](gui/text_in_jpg/jpg.m) 和 [jpg.fig](gui/text_in_jpg/) 为载体为jpg的信息隐藏界面
- [randinterval.m](src/text_in_jpg/randinterval.m) 是JPG为载体的DCT信息隐藏的随机函数
- [hallo.jpg](resouces/carrier/hallo.jpg) jpg 图片载体
- [1.txt](resources/hide/1.txt)为jpg为载体的隐藏文本

### BMP_IN_WAV

- [wavhiding.m](src/bmp_in_wav/wavhiding.m) 音频（wav）隐藏函数 [wavextract.m](src/bmp_in_wav/wavextract.m) 音频（wav）提取函数
- [wav.m](gui/bmp_in_wav/wav.m) 和 [wav.fig](gui/bmp_in_wav/)是音频为载体的信息隐藏界面
- [Vector2Matrix.m](src/bmp_in_wav/Vector2Matrix.m)是音频中数据提取过程中的格式转化函数
- [1.wav](resources/carrier/)和[2.wav](resources/carrier/)为测试的音频
- [bupt.bmp](resources/hide/bupt.bmp) 为音频水印图像


### BMP_IN_YUV

- [GUI](gui/bmp_in_yuv)
    - yuv.m 和 yuv.fig 是视频为载体的信息隐藏界面
- [SRC Files](src/bmp_in_yuv/)
    - main_DCT_3D_extract_yuv.m和main_DCT_3D_embed_yuv.m分别为视频信息隐藏的提取和隐藏函数
    - loadyuv.m和loadFileYUV.m为YUV视频的读取函数
    - YUVFormat.m] 是YUV视频的格式转换（读取的时候需要用到的函数）
    - extract_3DDCT_5frame_YUV.m和embed_3DDCT_5frame_YUV.m为视频信息隐藏中提取和隐藏要调用的函数
    - PSNR.m 是视频信息隐藏中的信噪比函数
    - NC.m 归一化函数（用于比较原始水印和提取出来的水印）
    - average------psnr.m为平均信噪比函数用以比较原始和提取函数的信噪比的
- RESOURCES FILES
    - [YD（18-22）](resources/hide/) 视频水印图片
    - [suzie.yuv](resources/carrier) 是YUV视频载体


