function varargout = yuv(varargin)
% YUV MATLAB code for yuv.fig
%      YUV, by itself, creates a new YUV or raises the existing
%      singleton*.
%
%      H = YUV returns the handle to a new YUV or the handle to
%      the existing singleton*.
%
%      YUV('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in YUV.M with the given input arguments.
%
%      YUV('Property','Value',...) creates a new YUV or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before yuv_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to yuv_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help yuv

% Last Modified by GUIDE v2.5 18-Dec-2014 22:20:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @yuv_OpeningFcn, ...
                   'gui_OutputFcn',  @yuv_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before yuv is made visible.
function yuv_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to yuv (see VARARGIN)

% Choose default command line output for yuv
handles.output = hObject;
im=imread('resources/new.bmp');
axes(handles.axes1);
imshow(im);
axes(handles.axes4);
imshow(im);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes yuv wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = yuv_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filenamebmpy
pathnow=pwd;
path='resources/hide';
cd (path);
[filenamebmpy pathnamebmpy] = uigetfile('YD(18_22).bmp','原始水印图像');
cd (pathnow);
im=imread(filenamebmpy);
axes(handles.axes1);
imshow(im);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global FILENAME
global PATHNAME
global FILEINDEX
pathnow=pwd;
path='resources/carrier';
cd (path);
[FILENAME,PATHNAME,FILEINDEX]=uigetfile('suzie.yuv','选择一个yuv文件');
cd (pathnow);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
clear;
fclose('all');
close(gcf);
run('main');


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fclose('all');
delete output/hidden/yuv/suzie_w.yuv;
delete output/hidden/yuv/keysuzie.yuv;
delete output/hidden/yuv/wmk_keyframe_suzie.yuv;
delete output/hidden/yuv/00020.bmp;
delete output/hidden/yuv/00000020.bmp;
fclose('all');
im=imread('resources/new.bmp');
axes(handles.axes1);
imshow(im);
axes(handles.axes4);
imshow(im);
clc;
clear;

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filenamebmpy
global pathnamebmpy
global FILENAME
global PATHNAME
global FILEINDEX
h=waitbar(0,'隐藏开始，请等待');
[video_image1,video_image2, p,avr_psnr,psnrvalue]=main_DCT_3D_embed_yuv(filenamebmpy,pathnamebmpy,FILENAME,PATHNAME,FILEINDEX);
waitbar(1,h,'隐藏成功');
pause(1);
delete(h);
figure;
subplot(1,2,1);
imshow(video_image1);
title(['原视频第',int2str(p),'帧']);
xlabel(['此帧PSNR=',num2str(psnrvalue,'%4.2f'),'dB']);

subplot(1,2,2);
grid,imshow(video_image2);
title(['水印视频第',int2str(p),'帧']);
xlabel(['视频的平均PSNR=',num2str(avr_psnr,'%4.2f'),'dB']);


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filenamebmpy;
pathnow=pwd;
path='output/hidden/yuv';
cd (path);
[FILENAME,PATHNAME,FILEINDEX]=uigetfile('suzie_w.yuv','选择含有水印的yuv文件');
cd (pathnow);
im=imread(filenamebmpy);
axes(handles.axes1);
imshow(im);
h=waitbar(0,'提取中请等待');
[img,extractedimg]=main_DCT_3D_extract_yuv(FILENAME,PATHNAME,FILEINDEX);
waitbar(1,h,'提取成功');
pause(1);
delete(h);
nc=NC(img,extractedimg);
% subpolt(121);
axes(handles.axes4);
imshow(extractedimg);
title('提取的平均后的水印图像');
xlabel(['NC=',num2str(nc)]);


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_8_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
winopen('help.txt');

% --------------------------------------------------------------------
function Untitled_9_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('V1.1.0 作者：胡俊熙、倪力烽、陈家骅、宁跃 2014.12.18');

% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);
run('bmp');

% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);
run('jpg');

% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);
run('wav');

% --------------------------------------------------------------------
function Untitled_6_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);
run('yuv');

% --------------------------------------------------------------------
function Untitled_7_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fclose('all');
close(gcf);
clc;
clear;
