function varargout = AssignmentOne_SYDE252(varargin)
% ASSIGNMENTONE_SYDE252 MATLAB code for AssignmentOne_SYDE252.fig
%      ASSIGNMENTONE_SYDE252, by itself, creates a new ASSIGNMENTONE_SYDE252 or raises the existing
%      singleton*.
%
%      H = ASSIGNMENTONE_SYDE252 returns the handle to a new ASSIGNMENTONE_SYDE252 or the handle to
%      the existing singleton*.
%
%      ASSIGNMENTONE_SYDE252('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ASSIGNMENTONE_SYDE252.M with the given input arguments.
%
%      ASSIGNMENTONE_SYDE252('Property','Value',...) creates a new ASSIGNMENTONE_SYDE252 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AssignmentOne_SYDE252_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AssignmentOne_SYDE252_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AssignmentOne_SYDE252

% Last Modified by GUIDE v2.5 22-Oct-2015 20:27:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AssignmentOne_SYDE252_OpeningFcn, ...
                   'gui_OutputFcn',  @AssignmentOne_SYDE252_OutputFcn, ...
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


% --- Executes just before AssignmentOne_SYDE252 is made visible.
function AssignmentOne_SYDE252_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AssignmentOne_SYDE252 (see VARARGIN)

% Choose default command line output for AssignmentOne_SYDE252
handles.output = hObject;
dummy = daqhwinfo('winsound');
% get the ananlogy input object of the system sound card
handles.h_soundCard = eval(dummy.ObjectConstructorName{1});
addchannel(handles.h_soundCard,1:2);
handles.h_soundCard.SamplesPerTrigger = Inf;
% the refresh rate of the signal view (3 per second)
handles.h_soundCard.TimerPeriod = 0.3;
% only view the signal in the last 1 second
handles.dataTimeSpan = 1;

% creating the line objects, which are to be updated on the fly as data
% coming in
handles.signalLines(1) = line([0,1],[0,0]);
handles.signalLines(2) = line([0,1],[0,0]);
% don't show the lines yet
set(handles.signalLines,'Visible','off');

% set the color of the lines
set(handles.signalLines(1),'Color','r');
set(handles.signalLines(2),'Color','g');

% time span of the signal to view
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AssignmentOne_SYDE252 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% timer function, will be executed at every TimerPeriod
handles.h_soundCard.TimerFcn = {@updateAxes, handles};


% --- Outputs from this function are returned to the command line.
function varargout = AssignmentOne_SYDE252_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_Start.
function pushbutton_Start_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
% set the plotting axes in focus


% start the acquisition object if it is not running
if strcmp(handles.h_soundCard.Running,'Off')
    start(handles.h_soundCard);
    onFlag = 0;
    while onFlag == 0
        onFlag = handles.h_soundCard.Running;
    end
    disp('Winsound started!');
    set(handles.signalLines,'Visible','On');
    guidata(hObject, handles);
end

% --- Executes on button press in pushbutton_Stop.
function pushbutton_Stop_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% stop the acquisition if object is running
if strcmp(handles.h_soundCard.Running,'On')
    handles = guidata(hObject);
    % stop the ai object
    stop(handles.h_soundCard);
    disp('Winsound stopped!');
    guidata(hObject, handles);
end

% add annotation to the figure here


% --- Executes on button press in togglebutton_View.
function togglebutton_View_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton_View (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton_View

if get(hObject,'Value') == 1
    % set the string of the toggle button to 'View TD'
    set(hObject,'String','View TD');
else
    % set the string of the toggle button to 'View FD'
    set(hObject,'String','View FD');
end
guidata(hObject, handles);


% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(handles.h_soundCard.Running,'On')
    stop(handles.h_soundCard);
end
delete(handles.h_soundCard);


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if handles.h_soundCard.SamplesAvailable > 0
    
    [FileName,PathName] = uiputfile('*.mat','Save acquired data file');
    
    if FileName == 0
        disp('Data not saved!');
    else
        acqData = getdata(handles.h_soundCard,handles.h_soundCard.SamplesAcquired);
        save(fullpath(PathName,FileName),'acqData');
        disp([num2str(size(acqData,1)/handles.h_soundCard.SampleRate),' seconds of data acquired!']);
        disp(['Data file: ',FileName,', under directory: ',PathName,'.']);
        
    end
else
    disp('No data avilable!');
end


function  updateAxes(obj,event,handles)
% updating the data view

% get the sampling rate
fs = obj.SampleRate;


if obj.SamplesAvailable > 0
    % if there data is already acquired
    if obj.SamplesAvailable < handles.dataTimeSpan*fs
        % if acquired data is not yet long enough to fill the axes, fill
        % the rest with zeros
        acqData = peekdata(obj,obj.SamplesAvailable);
        acqData = [acqData;zeros(handles.dataTimeSpan*fs-obj.SamplesAvailable,2)];
    else
        % get the data (but without taking them out of the acquisition
        % object
        acqData = peekdata(obj,handles.dataTimeSpan*fs);
    end
else
    % if no data is available, use zeros to fill the place
    acqData = zeros(handles.dataTimeSpan*fs,2);
end

% plotting data dependoing on the value of the toggle button
switch get(handles.togglebutton_View,'Value')
    case 0
        % plot the signals in time domain (note the preferred way of manipulating matrix in Matlab is
        % used here.
        % preparing the data to be view (add vertical offsets to the two
        % channels for easier view
        data2View = acqData + ones(size(acqData,1),1)*[1,-1]/2;
        % assign proper xdata and ydata values to the two line objects
        set(handles.signalLines(1),'xdata',linspace(0,handles.dataTimeSpan,size(data2View,1)),'ydata', data2View(:,1));
        set(handles.signalLines(2),'xdata',linspace(0,handles.dataTimeSpan,size(data2View,1)),'ydata', data2View(:,2));
        % set the proper limits to the two axis, and add annotation
        set(handles.axes1,'ylim',[-1.5,1.5],'ytick',[-0.5,0.5],'yticklabel',{'L','R'});
    case 1
        % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % plot the signal in freq. domain
        % Calculate the spectrum of the acquired signal. You should not use the
        % built-in fft function. Rather you should write your own Fourier
        % transform function, such as myFourierTransform.m
        % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
end
