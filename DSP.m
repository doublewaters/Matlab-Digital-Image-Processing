function varargout = DSP(varargin)
% DSP MATLAB code for DSP.fig
%      DSP, by itself, creates a new DSP or raises the existing
%      singleton*.
%
%      H = DSP returns the handle to a new DSP or the handle to
%      the existing singleton*.
%
%      DSP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DSP.M with the given input arguments.
%
%      DSP('Property','Value',...) creates a new DSP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DSP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DSP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DSP

% Last Modified by GUIDE v2.5 21-Jun-2020 15:16:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DSP_OpeningFcn, ...
                   'gui_OutputFcn',  @DSP_OutputFcn, ...
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


% --- Executes just before DSP is made visible.
function DSP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DSP (see VARARGIN)

% Choose default command line output for DSP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
clear all;

% UIWAIT makes DSP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DSP_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in openbutton.
function openbutton_Callback(hObject, eventdata, handles)
% hObject    handle to openbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename,pathname]=uigetfile({ '*.jpg' ; '*.bmp' ; '*.tif' ; '*.*' }, ' 载入图像' ); 
if isequal(filename,0)||isequal(pathname,0) 
    errordlg( ' 没有选中文件 ' , ' 出错' ); 
    return ; 
else
   file=[pathname,filename]; 
   global S;  % 设置一个全局变量 S，保存初始图像路径，以便之后的还原操作

   S=file; 
   x=imread(file); 
   axes(handles.axes1); 
   imshow(x); 
   handles.img=x; 
   guidata(hObject,handles); 
   h=rgb2gray(x);
   axes(handles.axes3); 
   imhist(h);

end 



% --- Executes on button press in savebutton.
function savebutton_Callback(hObject, eventdata, handles)
% hObject    handle to savebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 [sfilename ,sfilepath]=uiputfile({ '*.jpg' ; '*.bmp' ; '*.tif' ; '*.*' }, ' 保存图像文件 ' , 'untitled.jpg' ); 
if ~isequal([sfilename,sfilepath],[0,0]) 
      sfilefullname=[sfilepath ,sfilename];
      pix=getframe(handles.axes2);
     imwrite(pix.cdata,sfilefullname); 
else
      msgbox( '你按了取消键 ' , '保存失败 ' ); 
end 



% --- Executes on slider movement.

function light0_Callback(hObject, eventdata, handles)
% hObject    handle to light0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global L
light = get(handles.light0, 'String');
L = str2double(light);
set(handles.lightslider,'value',L);



% --- Executes during object creation, after setting all properties.
function light0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to light0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light0 gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.

function contrast0_Callback(hObject, eventdata, handles)
% hObject    handle to contrast0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of contrast0 as text
%        str2double(get(hObject,'String')) returns contents of contrast0 as a double
global C
contrast = get(handles.light0, 'String');
C = str2double(contrast);
set(handles.lightslider,'value',C);

% --- Executes during object creation, after setting all properties.
function contrast0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to contrast0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in oook.
function oook_Callback(hObject, eventdata, handles)
% hObject    handle to oook (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
global S;  % 设置一个全局变量 S，保存初始图像路径，以便之后的还原操作
x = imread(S);
C = get(handles.lightslider,'value');
L = get(handles.contrastslider,'value');


high_in = C*0.5+0.5;
low_in = 1 - high_in;

image1 = imadjust(x,[low_in,high_in],[]);
axes(handles.axes1);
image2 = L.*image1;

axes(handles.axes2); 
imshow(image2);
h=rgb2gray(image2);
axes(handles.axes4); 
imhist(h);
clear x;


% --- Executes on slider movement.
function lightslider_Callback(hObject, eventdata, handles)
% hObject    handle to lightslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% value = get(hObject,'value');
% global L;
set(handles.light0,'string',num2str(get(hObject,'value')));

% --- Executes during object creation, after setting all properties.
function lightslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lightslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a lightslider gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function contrastslider_Callback(hObject, eventdata, handles)
% hObject    handle to contrastslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% global C;
% contrast = num2str(C);
set(handles.contrast0,'string',num2str(get(hObject,'value')));

% --- Executes during object creation, after setting all properties.
function contrastslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to contrastslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in graypushbutton.
function graypushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to graypushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global S
x = imread(S);
h=rgb2gray(x);
axes(handles.axes2); 
imshow(h);

axes(handles.axes4); 
imhist(h);
clear x;


% --- Executes on button press in ROIbutton.
function ROIbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ROIbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global S
x = imread(S);
msgbox('请选择要裁剪的区域，并双击选定区域以显示', '提示信息'); 
waitforbuttonpress; 
clf; 
I2=imcrop(x); 
axes(handles.axes2),
imshow(I2); 
h=rgb2gray(I2);

axes(handles.axes4); 
imhist(h);
clear x;


% --- Executes on button press in histeqbutton.
function histeqbutton_Callback(hObject, eventdata, handles)
% hObject    handle to histeqbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global S
x = imread(S);
h=rgb2gray(x);
h_s = histeq(h);
axes(handles.axes2); 
imshow(h_s);
axes(handles.axes4); 
imhist(h_s);
clear x;

% --- Executes on button press in histeqbutton.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to histeqbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radiobutton1,'value',1);
set(handles.radiobutton2,'value',0);
set(handles.radiobutton3,'value',0);


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDA
% Hint: get(hObject,'Value') returns toggle state of radiobutton2
set(handles.radiobutton1,'value',0);
set(handles.radiobutton2,'value',1);
set(handles.radiobutton3,'value',0);


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3
set(handles.radiobutton1,'value',0);
set(handles.radiobutton2,'value',0);
set(handles.radiobutton3,'value',1);


% --- Executes on button press in noisybutton.
function noisybutton_Callback(hObject, eventdata, handles)
% hObject    handle to noisybutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global S

if get(handles.radiobutton1,'value')
    x = imread(S);
    N1=imnoise(x,'gaussian',0,0.02); 
    axes(handles.axes2);
    imshow(N1);
    h=rgb2gray(N1);
    axes(handles.axes4); 
    imhist(h);
    clear x;


elseif get(handles.radiobutton2,'value')
    x = imread(S);
	N2=imnoise(x,'speckle',0.02); 
    axes(handles.axes2);
    imshow(N2);
    h=rgb2gray(N2);
    axes(handles.axes4); 
    imhist(h);
    clear x;
    
elseif get(handles.radiobutton3,'value')
    x = imread(S);
    N3=imnoise(x,'salt & pepper',0.02); 
    axes(handles.axes2);
    imshow(N3);
    h=rgb2gray(N3);
    axes(handles.axes4); 
    imhist(h);
    clear x;
end



function radiobutton1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to contrastslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radiobutton5,'value',1);
set(handles.radiobutton6,'value',0);
% Hint: get(hObject,'Value') returns toggle state of radiobutton5


% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radiobutton5,'value',0);
set(handles.radiobutton6,'value',1);
% Hint: get(hObject,'Value') returns toggle state of radiobutton6


% --- Executes on button press in bigbutton.
function bigbutton_Callback(hObject, eventdata, handles)
% hObject    handle to bigbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global S
if get(handles.radiobutton5,'value')
    A=imread(S); 
    X2=imresize(A,2, 'bilinear');
    axes(handles.axes2);
    imshow(X2, []);
    clear A;

elseif get(handles.radiobutton6,'value')
    A=imread(S); 
    X2=imresize(A,2, 'nearest');
    axes(handles.axes2);
    imshow(X2, []);
    clear A;
end


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global S
if get(handles.radiobutton5,'value')
    A=imread(S); 
    X2=imresize(A,0.1, 'bilinear');
    axes(handles.axes2);
    imshow(X2, []);
    clear A;

elseif get(handles.radiobutton6,'value')
    A=imread(S); 
    X2=imresize(A,0.1, 'nearest');
    axes(handles.axes2);
    imshow(X2, []);
    clear A;
end


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%中值
global S
x = imread(S);
N = rgb2gray(x);

D=medfilt2(N,[3,3]);
axes(handles.axes2),
imshow(D);  
clear N;



% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%均值
global S
x = imread(S);
N = rgb2gray(x);

w=[1 1 1;1 1 1;1 1 1]/9;  
C=imfilter(N,w,'corr','replicate');
axes(handles.axes2);
imshow(C);
clear N;


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global S
x=imread(S); 
A=rgb2gray(x);
axes(handles.axes2); 
bw1=edge(A,'roberts');
imshow(bw1);
clear x;


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global S
x=imread(S); 
A=rgb2gray(x);
axes(handles.axes2); 
bw2=edge(A,'sobel');
imshow(bw2);
clear x;
% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global S
x=imread(S); 
A=rgb2gray(x);
axes(handles.axes2); 
bw3=edge(A,'prewitt');
imshow(bw3);
clear x;

% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global S
x=imread(S); 
A=rgb2gray(x);
axes(handles.axes2); 
bw4=edge(A,'log');
imshow(bw4);
clear x;
