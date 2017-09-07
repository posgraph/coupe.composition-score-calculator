function varargout = CompositionDemo(varargin)
% COMPOSITIONDEMO MATLAB code for CompositionDemo.fig
%      COMPOSITIONDEMO, by itself, creates a new COMPOSITIONDEMO or raises the existing
%      singleton*.
%
%      H = COMPOSITIONDEMO returns the handle to a new COMPOSITIONDEMO or the handle to
%      the existing singleton*.
%
%      COMPOSITIONDEMO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COMPOSITIONDEMO.M with the given input arguments.
%
%      COMPOSITIONDEMO('Property','Value',...) creates a new COMPOSITIONDEMO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CompositionDemo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CompositionDemo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CompositionDemo

% Last Modified by GUIDE v2.5 10-Nov-2016 22:12:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CompositionDemo_OpeningFcn, ...
                   'gui_OutputFcn',  @CompositionDemo_OutputFcn, ...
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


% --- Executes just before CompositionDemo is made visible.
function CompositionDemo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CompositionDemo (see VARARGIN)

% Choose default command line output for CompositionDemo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CompositionDemo wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(handles.axes3, 'visible','off');

% --- Outputs from this function are returned to the command line.
function varargout = CompositionDemo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load_image.
function load_image_Callback(hObject, eventdata, handles)
% hObject    handle to load_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uigetfile({'*.jpg';'*.bmp'},'File Selector');
image = strcat(pathname, filename);
axes(handles.axes3);
imshow(image);
handles.image = image;
guidata(hObject, handles);
% set(handles.ROT, 'string', filename);


% --- Executes on button press in compute_score.
function compute_score_Callback(hObject, eventdata, handles)
% hObject    handle to compute_score (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = handles.image;
im = imread(input);
tic;
[ROT_score, VB_score, Diag_score, Size_score, Total_score, Result] = getCompScore_demo(im);
toc;
set(handles.ROT, 'string', ROT_score, 'FontSize', 13);
set(handles.VB, 'string', VB_score, 'FontSize', 13);
set(handles.Diag, 'string', Diag_score, 'FontSize', 13);
set(handles.Size, 'string', Size_score, 'FontSize', 13);
set(handles.Total, 'string', Total_score, 'FontSize', 13);
set(handles.result, 'string', Result, 'FontSize', 13, 'Foregroundcolor',[1 0 0]);

function ROT_Callback(hObject, eventdata, handles)
% hObject    handle to ROT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ROT as text
%        str2double(get(hObject,'String')) returns contents of ROT as a double


% --- Executes during object creation, after setting all properties.
function ROT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ROT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Total_Callback(hObject, eventdata, handles)
% hObject    handle to Total (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Total as text
%        str2double(get(hObject,'String')) returns contents of Total as a double


% --- Executes during object creation, after setting all properties.
function Total_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Total (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function result_Callback(hObject, eventdata, handles)
% hObject    handle to result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of result as text
%        str2double(get(hObject,'String')) returns contents of result as a double


% --- Executes during object creation, after setting all properties.
function result_CreateFcn(hObject, eventdata, handles)
% hObject    handle to result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Diag_Callback(hObject, eventdata, handles)
% hObject    handle to Diag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Diag as text
%        str2double(get(hObject,'String')) returns contents of Diag as a double


% --- Executes during object creation, after setting all properties.
function Diag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Diag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Size_Callback(hObject, eventdata, handles)
% hObject    handle to Size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Size as text
%        str2double(get(hObject,'String')) returns contents of Size as a double


% --- Executes during object creation, after setting all properties.
function Size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function VB_Callback(hObject, eventdata, handles)
% hObject    handle to VB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of VB as text
%        str2double(get(hObject,'String')) returns contents of VB as a double


% --- Executes during object creation, after setting all properties.
function VB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to VB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
