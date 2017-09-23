function varargout = proto1(varargin)
% PROTO1 MATLAB code for proto1.fig
%      PROTO1, by itself, creates a new PROTO1 or raises the existing
%      singleton*.
%
%      H = PROTO1 returns the handle to a new PROTO1 or the handle to
%      the existing singleton*.
%
%      PROTO1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROTO1.M with the given input arguments.
%
%      PROTO1('Property','Value',...) creates a new PROTO1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before proto1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to proto1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help proto1

% Last Modified by GUIDE v2.5 14-Nov-2016 22:29:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @proto1_OpeningFcn, ...
                   'gui_OutputFcn',  @proto1_OutputFcn, ...
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


% --- Executes just before proto1 is made visible.
function proto1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to proto1 (see VARARGIN)

% Choose default command line output for proto1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes proto1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = proto1_OutputFcn(hObject, eventdata, handles) 
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
global im 
global im2
[path,user_cance] = imgetfile(); % loading the image
if user_cance
    msgbox(sprintf('Error'),'Error','Error');
    return 
end
im = imread(path);
im2 = im;
%axes(handles.axes1);
imshow(im);
%guidata(hObject,path);
%guidata(hObject,im);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im2
global im
global imgsnr
%data = guidata(hObject);
%im = data;
figure
subplot(2,2,1); % show the image to the user 
imshow(im);
title('Input Image');
[circleiris, circlepupil, imagewithnoise] = segmentiris(im);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% will now draw  circles on the images to identify irir and pupil  boundary
subplot(2,2,2), imshow(im);
title('Segmented Image');
hold on;
rowi = circleiris(1);
coli = circleiris(2);
ri = circleiris(3);
rowp = circlepupil(1); % all this to enable multiplication 
colp = circlepupil(2);% for drawing circles
rp = circlepupil(3);

rowi = round(double(rowi));
coli = round(double(coli));
ri = round(double(ri));

rowp = round(double(rowp));
colp = round(double(colp));
rp = round(double(rp));

theta = 0 : (2 * pi / 10000) : (2 * pi);
pline_x = rp * cos(theta) + colp; % col gives x co-ordinate
iline_x = ri * cos(theta) + coli;
pline_y = rp * sin(theta) + rowp; % row gives y co-ordinate
iline_y = ri * sin(theta) + rowi;
plot(pline_x, pline_y, '-');
hold on;
plot(iline_x, iline_y, '-');
hold off;
hold off;
%%%%%%%
% apply a transform to convert the annulus to a rectangular sheet i.e is a polar array  
[polar_array, noise_array] = normaliseiris1(imagewithnoise, circleiris(2), circleiris(1), circleiris(3), circlepupil(2), circlepupil(1), circlepupil(3), 'C:\Users\Aditya\Pictures\Images_Database\001\L\S1001L01.jpg', 20, 240);
subplot(2,2,3), imshow(polar_array);
title('Normalised Image');
% now perform encoding on the image using gabor log transform and get a
% encoded image pattern
[template1, mask1] = encode1(polar_array, noise_array,1 ,18, 1, 0.5); 
%template3 = template1;
% the template contains the final encoded pattern that is to be matched
subplot(2,2,4), imshow(template1); title('encoded image');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%CODE TO ITIRATE OVER THE IMAGE%%%%%%%%%%%%%%%%%%%%%%%%%
dataSize = input('What is your database size  ');
min = 99; % store the hamming distance of the subject
name = 'none'; % store the name of the subject 
for i=1:dataSize
 z = ['S',int2str(i),'_Temp'];
 y = ['S',int2str(i),'_Mask'];
%  display(z);
%  display(y);
 
 %%%%%%%%%%%%%%%%%%%%%%FINDING SNR%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %imgsnr = snr(imcopy,im-imcopy); 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 eyeDestination = ['C:\Users\Aditya\Pictures\MATLABCreatedDatabase\',z,'.jpg'];
 template2 = load(eyeDestination,z,'-ascii');
 eyeDestination = ['C:\Users\Aditya\Pictures\MATLABCreatedDatabase\',y,'.jpg'];
 mask2 = load(eyeDestination,y,'-ascii');
 % now calculate hamming distance
 hd = gethammingdistance(template1, mask1, template2, mask2, 1);
 if(hd<=min)
     min = hd;
     %name = z; 
     name = int2str(i);
 end
 i = i + 1;
end
 if (min <= 0.38) % you can play with thois threshold 
      %display('Match found and Match is');display(name(1,1:3));
      %display('with a hamming distance of'); display(min)
Message = 'Match found... Subject is ';
Message = horzcat(Message,'S',name);
%Message = [Message,' snr of image is ',imgsnr];
 else 
  %  display('No match Found');
    Message = 'No Match Found';
 end
 h = msgbox(Message);
 disp(['Hamming distance is ']);
 disp(min);
 
 

% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im
im = imread('C:\Users\Aditya\Pictures\Camera Roll\white.jpg');
imshow(im); % reset the image


% --- Executes on button press in gauss.
function gauss_Callback(hObject, eventdata, handles)
% hObject    handle to gauss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im
global im2
global imgsnr
%data = guidata(hObject);
%im = data;
im = imnoise(im,'gaussian',0,0.001);
imgsnr = snr(im2,im-im2);
disp(imgsnr)
imshow(im);
guidata(hObject,im);


% --- Executes on button press in saltAndPepper.
function saltAndPepper_Callback(hObject, eventdata, handles)
% hObject    handle to saltAndPepper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im
global im2
global imgsnr
%data = guidata(hObject);
%im = data;
im = imnoise(im,'salt & pepper',0.01);
imgsnr = snr(im2,im-im2);
disp(imgsnr)
imshow(im);
guidata(hObject,im);
