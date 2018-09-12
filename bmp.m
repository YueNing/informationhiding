function varargout = bmp(varargin)
% BMP MATLAB code for bmp.fig
%      BMP, by itself, creates a new BMP or raises the existing
%      singleton*.
%
%      H = BMP returns the handle to a new BMP or the handle to
%      the existing singleton*.
%
%      BMP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BMP.M with the given input arguments.
%
%      BMP('Property','Value',...) creates a new BMP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before bmp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to bmp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help bmp

% Last Modified by GUIDE v2.5 18-Dec-2014 22:16:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @bmp_OpeningFcn, ...
                   'gui_OutputFcn',  @bmp_OutputFcn, ...
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


% --- Executes just before bmp is made visible.
function bmp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to bmp (see VARARGIN)

% Choose default command line output for bmp\
global imn
handles.output = hObject;
imn=imread('new.bmp');
axes(handles.axes1);
imshow(imn);
axes(handles.axes2);
imshow(imn);
% Update handles structure
guidata(hObject, handles);
clc
% UIWAIT makes bmp wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = bmp_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filenametxt

[filenametxt pathnametxt]=uigetfile({'*.txt','txt files ';'*.*',' alles file'},'choose a file ');
L=length(filenametxt);
if L<5
   msgbox('Wrong File','File Open Error');
 return;
end
test=filenametxt(1,L-3:L);
switch test
    case '.txt'
       str=[pathnametxt filenametxt];
       set(handles.edit1,'string',str);
        fin=fopen(str,'r');
        str1=fgetl(fin);
        set(handles.edit5,'string',str1);
        %open(filenametxt);
        %handles.filenametxt=filenametxt;
       % guidata(hObject,handles);
       % [str1 str2 str3 str4]=strread(str,'%s %s %s %s','delimiter',' ');
%         xingming(1)=str1;
% 
%         counter=2;
%         h=waitbar(0,'请稍等，正在开始读取文件...');
%         while feof(fin)==0
%         str=fgetl(fin);
%         [name yuwen shuxue yingyu]=strread(str,'%s %d %d %d','delimiter',' ');
%         xingming(counter)=name;
%         chengji(counter-1,:)=[yuwen shuxue yingyu];
%         counter=counter+1;
%         waitbar(counter/counter+1,h,'请等待...');
%         end;
%         waitbar(1,h,'已完成');
%         pause(2);
%         set(handles.listbox1,'string',xingming);
%         handles.chengji=chengji;
%         fclose(fin);
%         delete(h);
%         guidata(hObject,handles);
%         case '.xls'
%         str=[pathname filename];
% 
%         set(handles.edit2,'string',str);
%         h=waitbar(0,'请等待，正在开始读取文件');
%         [chengji xingming]=xlsread(str);
%         
%         waitbar(1,h,'完成');
%         pause(2);
%         delete(h);
%         
%         set(handles.listbox1,'string',xingming(:,1));
%         
%         handles.chengji=chengji;
%         guidata(hObject,handles);
       otherwise
        msgbox('Wrong File','File Open Error');
        return;
end
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname]=uigetfile({'*.txt','txt files ';'*.*',' alles file'},'choose a file ');
L=length(filename);
if L<5
   msgbox('Wrong File','File Open Error');
 return;
end
test=filename(1,L-3:L);
switch test
    case '.txt'
       str=[pathname filename];
       set(handles.edit2,'string',str);
        fin=fopen(str,'r');
        str1=fgetl(fin);
        set(handles.edit6,'string',str1);
       otherwise
        msgbox('Wrong File','File Open Error');
        return;
end


function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im  %使用全局变量im
global filenamebmp
[filenamebmp,pathnamebmp]=...
    uigetfile({'*.bmp'},'选择图片');
%合成路径+文件名
str=[pathnamebmp filenamebmp];
%读取图片
L=length(filenamebmp);
if L<5
   msgbox('Wrong File','File Open Error');
 return;
end;
 test=filenamebmp(1,L-3:L);
%switch test
    %case '.bmp'
      im=imread(str);
      %使用第一个axes
      axes(handles.axes1);
      %显示图片
      imshow(im);
      % otherwise
        %msgbox('Wrong File','File Open Error');
       % return;
%end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
clear
close(gcf);
run('main');



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA
global im
global filenametxt
global filenamebmp
h=waitbar(0,'请稍等，合成中...');
[steco,lento]=lsbhide(filenamebmp,filenametxt,'out.bmp');
 waitbar(1,h,'已完成');
 pause(1);
 delete(h);
axes(handles.axes2);
im2=imread('out.bmp');
imshow(im2);


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
number=str2num(get(handles.edit4,'string'));   
    h=waitbar(0,'请稍等，提取中...');
    lsbget('out.bmp',number,'secret.txt');
    waitbar(1,h,'提取成功');
    pause(1);
    delete(h);
% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imn
%fopen('secret.txt','w');
axes(handles.axes1);
imshow(imn);
axes(handles.axes2);
imshow(imn);
set(handles.edit1,'string','');
set(handles.edit2,'string','');
set(handles.edit4,'string','');
set(handles.edit5,'string','');
set(handles.edit6,'string','');
fclose('all');
delete out.bmp;
delete secret.txt;
clc
clear


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
