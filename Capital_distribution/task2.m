function varargout = task2(varargin)
% TASK2 MATLAB code for task2.fig
%      TASK2, by itself, creates a new TASK2 or raises the existing
%      singleton*.
%
%      H = TASK2 returns the handle to a new TASK2 or the handle to
%      the existing singleton*.
%
%      TASK2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TASK2.M with the given input arguments.
%
%      TASK2('Property','Value',...) creates a new TASK2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before task2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to task2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help task2

% Last Modified by GUIDE v2.5 25-Apr-2024 18:40:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @task2_OpeningFcn, ...
                   'gui_OutputFcn',  @task2_OutputFcn, ...
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


% --- Executes just before task2 is made visible.
function task2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to task2 (see VARARGIN)

% Choose default command line output for task2
msg = 'GUI is opening...';
warndlg(msg, 'Information');
handles.output = hObject;

% Initialize default values
handles.L_h = 50;
handles.lam_h = 0.5;
handles.mu_h = 0.9;
handles.eps_h = 1.3;
handles.del_h = 1.2;
handles.gam_h = 0.8;
handles.r_h = 0.5;
handles.A_h = 4;
handles.B_h = 3;
handles.C_h = 5;
handles.alp_h = 0.3;
handles.bet_h = 2;
handles.T_h = 8;
handles.K0_h = 30;
handles.M_h = 200;
handles.N_h = 100;
guidata(hObject, handles);
% Update handles structure

global K
global P
global u1
global u2
global psi_1
global psi_2
global t
global K_opt
global P_opt
global u1_opt
global u2_opt
global psi1_opt
global psi2_opt
global t_opt
global g_all
global g_opt
g_all = zeros(1, 6);
g_opt = zeros(1, 6);
K = [];
P = [];
u1 = [];
u2 = [];
psi_1 = [];
psi_2 = [];
t = [];
K_opt = [];
P_opt = [];
u1_opt = [];
u2_opt = [];
psi1_opt = [];
psi2_opt = [];
t_opt = [];





% UIWAIT makes task2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = task2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function Llab_Callback(hObject, eventdata, handles) 
    L = str2double(get(hObject, 'string'));
    if L <= 0
        msgbox('Error!!! L must be > 0!!!');
    else
        handles.L_h = L;
    end
    guidata(hObject, handles);
    
% hObject    handle to Llab (see GCB
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Llab as text
%        str2double(get(hObject,'String')) returns contents of Llab as a double


% --- Executes during object creation, after setting all properties.
function Llab_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Llab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function eps_lab_Callback(hObject, eventdata, handles)
    eps = str2double(get(hObject, 'string'));
    if eps < handles.del_h
        msgbox('Error!!! Epsillon must be > delta!!!');
    else
        handles.eps_h = eps;
    end
    guidata(hObject, handles);
% hObject    handle to eps_lab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eps_lab as text
%        str2double(get(hObject,'String')) returns contents of eps_lab as a double


% --- Executes during object creation, after setting all properties.
function eps_lab_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eps_lab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mu_lab_Callback(hObject, eventdata, handles)
    mu = str2double(get(hObject, 'string'));
    if mu < handles.gam_h
        msgbox('Error!!! Mu must be >= gamma!!!');
    else
        handles.mu_h = mu;
    end
    guidata(hObject, handles);
% hObject    handle to mu_lab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mu_lab as text
%        str2double(get(hObject,'String')) returns contents of mu_lab as a double


% --- Executes during object creation, after setting all properties.
function mu_lab_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mu_lab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lam_lab_Callback(hObject, eventdata, handles)
    lam = str2double(get(hObject, 'string'));
    if lam <= 0
        msgbox('Error!!! Lambda must be > 0!!!');
    else
        handles.lam_h = lam;
    end
    guidata(hObject, handles);
% hObject    handle to lam_lab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lam_lab as text
%        str2double(get(hObject,'String')) returns contents of lam_lab as a double


% --- Executes during object creation, after setting all properties.
function lam_lab_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lam_lab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function B_lab_Callback(hObject, eventdata, handles)
    B = str2double(get(hObject, 'string'));
    if B <= 0
        msgbox('Error!!! B must be > 0!!!');
    else
        handles.B_h = B;
    end
    guidata(hObject, handles);
% hObject    handle to B_lab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of B_lab as text
%        str2double(get(hObject,'String')) returns contents of B_lab as a double


% --- Executes during object creation, after setting all properties.
function B_lab_CreateFcn(hObject, eventdata, handles)
% hObject    handle to B_lab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function A_lab_Callback(hObject, eventdata, handles)
    A = str2double(get(hObject, 'string'));
    if A <= 0
        msgbox('Error!!! A must be > 0!!!');
    else
        handles.A_h = A;
    end
    guidata(hObject, handles);
% hObject    handle to A_lab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of A_lab as text
%        str2double(get(hObject,'String')) returns contents of A_lab as a double


% --- Executes during object creation, after setting all properties.
function A_lab_CreateFcn(hObject, eventdata, handles)
% hObject    handle to A_lab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function r_lab_Callback(hObject, eventdata, handles)
    r = str2double(get(hObject, 'string'));
    if r <= 0
        msgbox('Error!!! r must be > 0!!!');
    else
        handles.r_h = r;
    end
    guidata(hObject, handles);
% hObject    handle to r_lab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of r_lab as text
%        str2double(get(hObject,'String')) returns contents of r_lab as a double


% --- Executes during object creation, after setting all properties.
function r_lab_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r_lab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gam_lab_Callback(hObject, eventdata, handles)
    gam = str2double(get(hObject, 'string'));
    if gam <= 0
        msgbox('Error!!! Gamma must be > 0!!!');
    elseif gam > handles.mu_h
        msgbox('Error!!! Gamma must be <= mu!!!');
    else
        handles.gam_h = gam;
    end
    guidata(hObject, handles);
% hObject    handle to gam_lab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gam_lab as text
%        str2double(get(hObject,'String')) returns contents of gam_lab as a double


% --- Executes during object creation, after setting all properties.
function gam_lab_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gam_lab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function del_lab_Callback(hObject, eventdata, handles)
    del = str2double(get(hObject, 'string'));
    if del <= 1
        msgbox('Error!!! Delta must be > 1!!!');
    elseif del > handles.eps_h
        msgbox('Error!!! Delta must be <= epsillon!!!');
    else
        handles.del_h = del;
    end
    guidata(hObject, handles);
% hObject    handle to del_lab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of del_lab as text
%        str2double(get(hObject,'String')) returns contents of del_lab as a double


% --- Executes during object creation, after setting all properties.
function del_lab_CreateFcn(hObject, eventdata, handles)
% hObject    handle to del_lab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function C_lab_Callback(hObject, eventdata, handles)
    C = str2double(get(hObject, 'string'));
    if C <= 0
        msgbox('Error!!! C must be > 0!!!');
    else
        handles.C_h = C;
    end
    guidata(hObject, handles);
% hObject    handle to C_lab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of C_lab as text
%        str2double(get(hObject,'String')) returns contents of C_lab as a double


% --- Executes during object creation, after setting all properties.
function C_lab_CreateFcn(hObject, eventdata, handles)
% hObject    handle to C_lab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function alp_lab_Callback(hObject, eventdata, handles)
    alp = str2double(get(hObject, 'string'));
    if alp <= 0
        msgbox('Error!!! Alpha must be > 0!!!');
    elseif alp >= 1
        msgbox('Error!!! Alpha must be < 1!!!');
        handles.alp_h = alp;
    end
    guidata(hObject, handles);
% hObject    handle to alp_lab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alp_lab as text
%        str2double(get(hObject,'String')) returns contents of alp_lab as a double


% --- Executes during object creation, after setting all properties.
function alp_lab_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alp_lab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bet_lab_Callback(hObject, eventdata, handles)
    bet = str2double(get(hObject, 'string'));
    if bet <= 1
        msgbox('Error!!! Beta must be > 1!!!');
    else
        handles.bet_h = bet;
    end
    guidata(hObject, handles);
% hObject    handle to bet_lab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bet_lab as text
%        str2double(get(hObject,'String')) returns contents of bet_lab as a double


% --- Executes during object creation, after setting all properties.
function bet_lab_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bet_lab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in K_all.
function K_all_Callback(hObject, eventdata, handles)
    global g_all
    g_all(1) =  get(hObject,'Value');
% hObject    handle to K_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of K_all


% --- Executes on button press in u2_optim.
function u2_optim_Callback(hObject, eventdata, handles)
    global g_opt
    g_opt(4) =  get(hObject,'Value');
% hObject    handle to u2_optim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of u2_optim


% --- Executes on button press in eta1_optim.
function eta1_optim_Callback(hObject, eventdata, handles)
    global g_opt
    g_opt(5) =  get(hObject,'Value');
% hObject    handle to eta1_optim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of eta1_optim


% --- Executes on button press in eta2_optim.
function eta2_optim_Callback(hObject, eventdata, handles)
    global g_opt
    g_opt(6) =  get(hObject,'Value');
% hObject    handle to eta2_optim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of eta2_optim


% --- Executes on button press in eta2_all.
function eta2_all_Callback(hObject, eventdata, handles)
    global g_all
    g_all(6) =  get(hObject,'Value');
% hObject    handle to eta2_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of eta2_all


% --- Executes on button press in eta1_all.
function eta1_all_Callback(hObject, eventdata, handles)
    global g_all
    g_all(5) =  get(hObject,'Value');
% hObject    handle to eta1_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of eta1_all


% --- Executes on button press in u2_all.
function u2_all_Callback(hObject, eventdata, handles)
    global g_all
    g_all(4) =  get(hObject,'Value');
% hObject    handle to u2_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of u2_all


% --- Executes on button press in u1_all.
function u1_all_Callback(hObject, eventdata, handles)
    global g_all
    g_all(3) =  get(hObject,'Value');
% hObject    handle to u1_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of u1_all


% --- Executes on button press in P_all.
function P_all_Callback(hObject, eventdata, handles)
    global g_all
    g_all(2) =  get(hObject,'Value');
% hObject    handle to P_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of P_all


% --- Executes on button press in u1_optim.
function u1_optim_Callback(hObject, eventdata, handles)
    global g_opt
    g_opt(3) =  get(hObject,'Value');
% hObject    handle to u1_optim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of u1_optim


% --- Executes on button press in P_optim.
function P_optim_Callback(hObject, eventdata, handles)
    global g_opt
    g_opt(2) =  get(hObject,'Value');
% hObject    handle to P_optim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of P_optim


% --- Executes on button press in K_optim.
function K_optim_Callback(hObject, eventdata, handles)
    global g_opt
    g_opt(1) =  get(hObject,'Value');
% hObject    handle to K_optim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of K_optim



function time_Callback(hObject, eventdata, handles)
    T = str2double(get(hObject, 'string'));
    if T <= 0
        msgbox('Error!!! Time must be > 0!!!');
    else
        handles.T_h = T;
    end
    guidata(hObject, handles);
% hObject    handle to time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of time as text
%        str2double(get(hObject,'String')) returns contents of time as a double


% --- Executes during object creation, after setting all properties.
function time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function K0_lab_Callback(hObject, eventdata, handles)
    K0 = str2double(get(hObject, 'string'));
    if K0 <= 0
        msgbox('Error!!! Volume of production assets must be > 0!!!');
    else
        handles.K0_h = K0;
    end
    guidata(hObject, handles);
% hObject    handle to K0_lab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of K0_lab as text
%        str2double(get(hObject,'String')) returns contents of K0_lab as a double


% --- Executes during object creation, after setting all properties.
function K0_lab_CreateFcn(hObject, eventdata, handles)
% hObject    handle to K0_lab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function M_it_Callback(hObject, eventdata, handles)
    M = str2double(get(hObject, 'string'));
    if M <= 0
        msgbox('Error!!! M must be > 0!!!');
    else
        handles.M_h = M;
    end
    guidata(hObject, handles);
% hObject    handle to M_it (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of M_it as text
%        str2double(get(hObject,'String')) returns contents of M_it as a double


% --- Executes during object creation, after setting all properties.
function M_it_CreateFcn(hObject, eventdata, handles)
% hObject    handle to M_it (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function N_it_Callback(hObject, eventdata, handles)
    N = str2double(get(hObject, 'string'));
    if N <= 0
        msgbox('Error!!! N must be > 0!!!');
    else
        handles.N_h = N;
    end
    guidata(hObject, handles);
% hObject    handle to N_it (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of N_it as text
%        str2double(get(hObject,'String')) returns contents of N_it as a double


% --- Executes during object creation, after setting all properties.
function N_it_CreateFcn(hObject, eventdata, handles)
% hObject    handle to N_it (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SOLVE.
function SOLVE_Callback(hObject, eventdata, handles)
    global K
    global P
    global u1
    global u2
    global psi_1
    global psi_2
    global t
    global K_opt
    global P_opt
    global u1_opt
    global u2_opt
    global psi1_opt
    global psi2_opt
    global t_opt
    L = handles.L_h; %обьём трудовых ресурсов
    lam = handles.lam_h; % прверка на (0, 1)
    F = @(x) x.^lam .* L^(1 - lam); %на шаге итерации необходима проверка на > 0
    Fk = @(x) lam.*(L ./ x).^(1 - lam);
    mu = handles.mu_h;% коэф.аморт > 0
    eps = handles.eps_h; % доля загрязнений >0, >= del
    del = handles.del_h; % коэф. уменьшения загр > 1
    gam = handles.gam_h; %коэфю естественной убыли загр > 0
    T = handles.T_h;
    r = handles.r_h; %коэф.дисконт > 0
    c = @(u, x) u.*F(x);
    A = handles.A_h;
    B = handles.B_h;
    Ce = handles.C_h;
    K0 = handles.K0_h;
    P0 = eps*F(K0);
    N = handles.N_h; % разбиение для пси
    M = handles.M_h; % разбиение по времени
    u1 = zeros(N, M);
    u2 = zeros(N, M);
    u1_opt = zeros(1, M);
    u2_opt = zeros(1, M);
    K_opt = zeros(1, M);
    P_opt = zeros(1, M);
    psi1_opt = zeros(1, M);
    psi2_opt = zeros(1, M);
    K = zeros(N, M);
    P = zeros(N, M);
    psi_1 = zeros(N, M);
    psi_2 = zeros(N, M);
    t = linspace(0, T, M);
    t_opt = zeros(1, M); % моменты переключений для оптимальной траектории
    alp = handles.alp_h; % <1 >0
    bet = handles.bet_h; %>1
    utility = @(u, x, y) Ce - A.*exp(-alp .* c(u, x)) + B.*exp(-bet.*y); % функция полезности для вычисления интеграла
    psi0 = gen_psi(N);
    opt = 0; % значение функции полезности для оптимальной траектории
    int = zeros(1, M);
for i = 1:N
    psi_0 = psi0(:, 1);
    psi_1(i, 1) = psi0(i, 2);
    psi_2(i, 1) = psi0(i, 3);
    K(i, 1) = K0;
    P(i, 1) = P0;
    int(1) = 0;
    t_per = zeros(1, M); % моменты переключений
    ch = zeros(1, M); % массив для хранения максимумов
    ch(1) = 0; % до начала подсчёта
    for j = 1: (M-1)
        f = F(K(i, j));
        pi_0 = psi_0(i);
        pi_1 = psi_1(i, j);
        pi_2 = psi_2(i, j);
        Gg = zeros(1, 3);
        if (pi_2/pi_0 > A*alp / del * exp(-r * t(j) - alp*f))&&(pi_2/pi_0 < A*alp / del * exp(-r * t(j)))
            Gg(1) = pi_2*del*(1/alp + f*(eps/del - 1) - 1/alp * log(pi_2* del / pi_0 / A / alp) - r*t(j)/alp);
        else
            Gg(1) = 0;
        end
        if pi_1 + del*pi_2 < 0
            Gg(2) = pi_0*A*exp(-r*t(j)) + pi_2*f*(del + eps);
        else
            Gg(2) =  pi_0*A*exp(-r*t(j))+ f*(pi_1 + pi_2*eps);
        end
        if (pi_1 / pi_0 > -alp*A*exp(-r*t(j))) && (pi_1 / pi_0 < -alp*A*exp(-r*t(j)- alp*f))
            Gg(3) = pi_2*(-1/alp + f + log(-pi_1 / alp / pi_0 / A)/alp + r*t(j)/ alp);
        else
            Gg(3) = 0;
        end
        maxo = max(Gg,[], 2);
        maxo = maxo(1);
        switch maxo
            case Gg(1)
                u1(i, j) = - 1/alp/f* (log(del* pi_2 / pi_0 / A/ alp) + r*t(j));
                u2(i, j) = 1 + 1/alp/f* (log(del* pi_2 / pi_0 / A/ alp) + r*t(j));
                ch(j + 1) = 1;
            case Gg(2)
                u1(i, j) = 0;
                if pi_1 + del*pi_2 < 0 
                    u2(i, j) = 1;
                else
                    u2(i, j) = 0;
                end
                ch(j+1) = 2;
            otherwise
                u1(i, j) = - log(-pi_1/ alp / pi_0 / A) / alp / f - r*t(j)/ alp/ f;
                u2(i, j) = 0;
                ch(j + 1) = 3;
        end
        if (ch(j+1) ~= ch(j))&&(ch(j) ~= 0) % исследование моментов переключения
            t_per(j) = t(j);
        end
        y0 = [K(i, j); P(i, j); psi_1(i, j); psi_2(i, j); int(j)];
        tspan = [t(j) t(j + 1)];
        [~, y] =  ode45(@(t, y) ode2(t, y, mu, eps, del, gam, alp, r, bet, u1(i, j), u2(i, j), L, B, A,Ce,lam, pi_0), tspan, y0);
        last = real(y(end, :));
        K(i, j+1) = last(1);
        P(i, j+1) = last(2);
        psi_1(i, j+1) = last(3);
        psi_2(i, j+1) = last(4);
        int(j+1) = abs(last(5));
        if (K(i, j+1) <= 0)||(P(i, j+1) <= 0) || (psi_2(i, j+1) > 0)
            K(i, :) = zeros(1, M);
            P(i, :) = zeros(1, M);
            u1(i, :) = zeros(1, M);
            u2(i, :) = zeros(1, M);
            psi_1(i, :) = zeros(1, M);
            psi_2(i, :) = zeros(1, M);
            continue;
        end 
    end
        f = F(K(i, M));
        pi_0 = psi_0(i);
        pi_1 = psi_1(i, M);
        pi_2 = psi_2(i, M);
        Gg = zeros(1, 3);
        if (pi_2/pi_0 > A*alp / del * exp(-r * t(j) - alp*f))&&(pi_2/pi_0 < A*alp / del * exp(-r * t(j)))
            Gg(1) = pi_2*del*(1/alp + f*(eps/del - 1) - 1/alp * log(pi_2* del / pi_0 / A / alp) - r*t(j)/alp);
        else
            Gg(1) = 0;
        end
        if pi_1 + del*pi_2 < 0
            Gg(2) = pi_0*A*exp(-r*t(j)) + pi_2*f*(del + eps);
        else
            Gg(2) =  pi_0*A*exp(-r*t(j))+ f*(pi_1 + pi_2*eps);
        end
        if (pi_1 / pi_0 > -alp*A*exp(-r*t(j))) && (pi_1 / pi_0 < -alp*A*exp(-r*t(j)- alp*f))
            Gg(3) = pi_2*(-1/alp + f + log(-pi_1 / alp / pi_0 / A)/alp + r*t(j)/ alp);
        else
            Gg(3) = 0;
        end
        maxo = max(Gg,[], 2);
        maxo = maxo(1);
        switch maxo
            case Gg(1)
                u1(i, M) = - 1/alp/f* (log(del* pi_2 / pi_0 / A/ alp) + r*t(j));
                u2(i, M) = 1 + 1/alp/f* (log(del* pi_2 / pi_0 / A/ alp) + r*t(j));
            case Gg(2)
                u1(i, M) = 0;
                if pi_1 + del*pi_2 < 0 
                    u2(i, M) = 1;
                else
                    u2(i, M) = 0;
                end
            otherwise
                u1(i, M) = - log(-pi_1/ alp / pi_0 / A) / alp / f - r*t(j)/ alp/ f;
                u2(i, M) = 0;
        end
    zero_vect = zeros(1, M);
    if (opt < int(M))&& ~isequal(K(i,:), zero_vect)
        opt = int(M);
        u1_opt = u1(i, :);
        u2_opt = u2(i, :);
        K_opt = K(i, :);
        P_opt = P(i, :);
        psi1_opt = psi_1(i, :);
        psi2_opt = psi_2(i, :);
        t_opt = t_per;
    end
end
    err = norm([abs(psi1_opt(end)), abs(psi2_opt(end))]);
    msgbox(['Value of quality function: ' num2str(opt) '    Bias: ' num2str(err)]);
    guidata(hObject, handles);
% hObject    handle to SOLVE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_PLOT.
function pushbutton_PLOT_Callback(hObject, eventdata, handles)
    global K
    global P
    global u1
    global u2
    global psi_1
    global psi_2
    global t
    global K_opt
    global P_opt
    global u1_opt
    global u2_opt
    global psi1_opt
    global psi2_opt
    global t_opt
    global g_all
    global g_opt
    N = handles.N_h;
    M = handles.M_h;
    T = handles.T_h;
    if g_all(1)
        figure('Name', 'G');
        hold on;    
        grid on;
        xlabel('$t$', 'Interpreter', 'latex','FontSize', 20);
        ylabel('$K$', 'Interpreter', 'latex', 'FontSize', 20);
        for i = 1:N
            plot(t, K(i,:), '-b');
        end
        h = plot(t, K_opt, '-m');
        for i = 1:M
            if t_opt(i) ~= 0
                plot( t_opt(i),K_opt(i), 'ok');
            end
        end
        hold off; 
        legend(h, {'Optimal trajectory'},'FontSize', 20, 'Interpreter', 'latex');
    end
    if g_all(2)
        figure('Name', 'G');
        hold on;    
        grid on;
        xlabel('$t$', 'Interpreter', 'latex','FontSize', 20);
        ylabel('$P$', 'Interpreter', 'latex', 'FontSize', 20);
        for i = 1:N
            plot(t, P(i,:), '-b');
        end
        h = plot(t, P_opt, '-m');
        for i = 1:M
            if t_opt(i) ~= 0
                plot( t_opt(i),P_opt(i), 'ok');
            end
        end
        hold off; 
        legend(h, {'Optimal trajectory'},'FontSize', 20, 'Interpreter', 'latex');
    end
    if g_all(3)
        figure('Name', 'G');
        hold on;
        grid on;
        xlabel('$t$', 'Interpreter', 'latex','FontSize', 20);
        ylabel('$u_{1}$', 'Interpreter', 'latex', 'FontSize', 20);
        for i = 1:N
            plot(t, u1(i,:), '-b');
        end
        h = plot(t, u1_opt, '-m');
        for i = 1:M
            if t_opt(i) ~= 0
                plot( t_opt(i),u1_opt(i), 'ok');
            end
        end
        hold off;
        legend(h, {'Optimal'},'FontSize', 20, 'Interpreter', 'latex');
    end
    if g_all(4)
        figure('Name', 'G');
        hold on;
        grid on;
        xlabel('$t$', 'Interpreter', 'latex','FontSize', 20);
        ylabel('$u_{2}$', 'Interpreter', 'latex', 'FontSize', 20);
        for i = 1:N
            plot(t, u2(i,:), '-b');
        end
        h = plot(t, u2_opt, '-m');
        for i = 1:M
            if t_opt(i) ~= 0
                plot( t_opt(i),u2_opt(i), 'ok');
            end
        end
        hold off;
        legend(h, {'Optimal'},'FontSize', 20, 'Interpreter', 'latex');
    end
    if g_all(5)
        figure('Name', 'G');
        hold on;
        grid on;
        xlabel('$t$', 'Interpreter', 'latex','FontSize', 20);
        ylabel('$\eta_{1}$', 'Interpreter', 'latex', 'FontSize', 20);
        for i = 1:N
            plot(t, psi_1(i,:), '-b');
        end
        h = plot(t, psi1_opt, '-m');
        h2 = plot(T, 0, '*r');
        hold off;
        legend([h, h2], {'Optimal', 'Desired value'},'FontSize', 20, 'Interpreter', 'latex');
    end
    if g_all(6)
        figure('Name', 'G');
        hold on;
        grid on;
        xlabel('$t$', 'Interpreter', 'latex','FontSize', 20);
        ylabel('$\eta_{2}$', 'Interpreter', 'latex', 'FontSize', 20);
        for i = 1:N
            plot(t, psi_2(i,:), '-b');
        end
        h = plot(t, psi2_opt, '-m');
        h2 = plot(T, 0, '*r');
        hold off;
        legend([h, h2], {'Optimal', 'Desired value'},'FontSize', 20, 'Interpreter', 'latex');
    end
    if g_opt(1)
        figure('Name', 'G');
        hold on;    
        grid on;
        xlabel('$t$', 'Interpreter', 'latex','FontSize', 20);
        ylabel('$K$', 'Interpreter', 'latex', 'FontSize', 20);
        plot(t, K_opt, '-m');
        for i = 1:M
            if t_opt(i) ~= 0
                plot( t_opt(i), K_opt(i), 'ok');
            end
        end
        hold off;
    end
    if g_opt(2)
        figure('Name', 'G');
        hold on;    
        grid on;
        xlabel('$t$', 'Interpreter', 'latex','FontSize', 20);
        ylabel('$P$', 'Interpreter', 'latex', 'FontSize', 20);
        plot(t, P_opt, '-m');
        for i = 1:M
            if t_opt(i) ~= 0
                plot( t_opt(i), P_opt(i), 'ok');
            end
        end
        hold off;
    end
    if g_opt(3)
        figure('Name', 'G');
        hold on;    
        grid on;
        xlabel('$t$', 'Interpreter', 'latex','FontSize', 20);
        ylabel('$u_{1}$', 'Interpreter', 'latex', 'FontSize', 20);
        plot(t, u1_opt, '-m');
        for i = 1:M
            if t_opt(i) ~= 0
                plot( t_opt(i), u1_opt(i), 'ok');
            end
        end
        hold off;
    end
    if g_opt(4)
        figure('Name', 'G');
        hold on;    
        grid on;
        xlabel('$t$', 'Interpreter', 'latex','FontSize', 20);
        ylabel('$u_{2}$', 'Interpreter', 'latex', 'FontSize', 20);
        plot(t, u2_opt, '-m');
        for i = 1:M
            if t_opt(i) ~= 0
                plot( t_opt(i), u2_opt(i), 'ok');
            end
        end
        hold off;
    end
    if g_opt(5)
        figure('Name', 'G');
        hold on;    
        grid on;
        xlabel('$t$', 'Interpreter', 'latex','FontSize', 20);
        ylabel('$\eta_{1}$', 'Interpreter', 'latex', 'FontSize', 20);
        plot(t, psi1_opt, '-m');
        plot(T, 0, '*r');
        hold off;
    end
    if g_opt(6)
        figure('Name', 'G');
        hold on;    
        grid on;
        xlabel('$t$', 'Interpreter', 'latex','FontSize', 20);
        ylabel('$\eta_{2}$', 'Interpreter', 'latex', 'FontSize', 20);
        plot(t, psi2_opt, '-m');
        plot(T, 0, '*r');
        hold off;
    end

% hObject    handle to pushbutton_PLOT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
