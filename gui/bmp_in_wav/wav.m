function varargout = wav(varargin)
% WAV MATLAB code for wav.fig
%      WAV, by itself, creates a new WAV or raises the existing
%      singleton*.
%
%      H = WAV returns the handle to a new WAV or the handle to
%      the existing singleton*.
%
%      WAV('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WAV.M with the given input arguments.
%
%      WAV('Property','Value',...) creates a new WAV or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before wav_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to wav_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help wav

% Last Modified by GUIDE v2.5 18-Dec-2014 23:27:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @wav_OpeningFcn, ...
                   'gui_OutputFcn',  @wav_OutputFcn, ...
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


% --- Executes just before wav is made visible.
function wav_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to wav (see VARARGIN)

% Choose default command line output for wav
handles.output = hObject;
im=imread('resources/new.bmp');
axes(handles.axes1);
imshow(im);
axes(handles.axes3);
imshow(im);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes wav wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = wav_OutputFcn(hObject, eventdata, handles) 
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
% sound=wavread('2.wav');
% wavplay(sound,44000);
global filenamewav
global oa
global n
pathnow=pwd;
path='resources/carrier';
cd (path);
[filenamewav pathnamewav]=uigetfile('*.wav','选择一个wav文件');
cd (pathnow);
fid=fopen(filenamewav,'rb');
%[file,path] = uigetfile('2.wav','Open wav file');
oa=fread(fid,inf,'uchar');
n=length(oa)-44;%wav文件从文件头到数据前面共有44字节的格式说明
fclose(fid);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filenamebmpw
pathnow=pwd;
path='resources/hide';
cd (path);
[filenamebmpw pathnamebmpw]=uigetfile('bupt.bmp','选择一个水印图片');
cd (pathnow);
axes(handles.axes1);
imshow(filenamebmpw);
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA) 
% select wav file to play
pathnow=pwd;
path='resources/carrier';
cd (path);
[filenamewav pathnamewav]=uigetfile('*.wav','选择一个音频播放');
cd (pathnow);
[y,Fs]=audioread(filenamewav);
sound(y,Fs);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global oa
global filenamebmpw
global n
h=waitbar(0,'开始隐藏');
wavhiding(filenamebmpw,oa,n);
waitbar(1,h,'隐藏成功');
pause(1);
delete(h);



% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clc;
clear;
fclose('all');
close(gcf);
run('main');
% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fclose('all');
delete output/hidden/wav/marked.wav;
delete output/get/wav/markedbupt.bmp;
im=imread('resources/new.bmp');
axes(handles.axes1);
imshow(im);
axes(handles.axes3);
imshow(im);



clc
clear


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=waitbar(0,'开始提取');
wavextract();
waitbar(1,h,'提取成功');
pause(1);
delete(h);
im=imread('bupt.bmp');
axes(handles.axes1);
imshow(im);
im2=imread('output/get/wav/markedbupt.bmp');
axes(handles.axes3);
imshow(im2);
% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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
