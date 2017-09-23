function varargout = datbase(varargin)
% DATBASE MATLAB code for datbase.fig
%      DATBASE, by itself, creates a new DATBASE or raises the existing
%      singleton*.
%
%      H = DATBASE returns the handle to a new DATBASE or the handle to
%      the existing singleton*.
%
%      DATBASE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DATBASE.M with the given input arguments.
%
%      DATBASE('Property','Value',...) creates a new DATBASE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before datbase_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to datbase_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help datbase

% Last Modified by GUIDE v2.5 14-Nov-2016 12:56:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @datbase_OpeningFcn, ...
                   'gui_OutputFcn',  @datbase_OutputFcn, ...
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


% --- Executes just before datbase is made visible.
function datbase_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to datbase (see VARARGIN)

% Choose default command line output for datbase
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes datbase wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = datbase_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im2
[path,user_cance] = imgetfile();
if user_cance
    msgbox(sprintf('Error'),'Error','Error');
    return 
end
im = imread(path);
%axes(handles.axes1);
imshow(im);
guidata(hObject,im);
guidata(hObject,path);



% --- Executes on button press in run.
function run_Callback(hObject, eventdata, handles)
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = guidata(hObject);
path = data;
data = guidata(hObject);
xG = imread(path); % input image given by user
eyeimage_filename = path; % filename with path 
%subplot(2,2,1); % show the image to the user 
imshow(xG);
%title('Input Image');
[circleiris, circlepupil, imagewithnoise] = segmentiris(xG);

[polar_array, noise_array] = normaliseiris1(imagewithnoise, circleiris(2), circleiris(1), circleiris(3), circlepupil(2), circlepupil(1), circlepupil(3), path, 20, 240);
%subplot(2,2,3), imshow(polar_array);
%title('Normalised Image');
index = input('enter data number ');
[template1, mask1] = encode1(polar_array, noise_array,1 ,18, 1, 0.5);
%dataSize = load(path,dataSize,'-ascii');
eyeDestination = ['C:\Users\Aditya\Pictures\MATLABCreatedDatabase\S',int2str(index),'_Temp.jpg'];
save(eyeDestination,'template1','-ascii');
eyeDestination = ['C:\Users\Aditya\Pictures\MATLABCreatedDatabase\S',int2str(index),'_Mask.jpg'];
save(eyeDestination,'mask1','-ascii');



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
