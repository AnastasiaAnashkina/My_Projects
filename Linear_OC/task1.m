function varargout = task1(varargin)
% TASK1 MATLAB code for task1.fig
%      TASK1, by itself, creates a new TASK1 or raises the existing
%      singleton*.
%
%      H = TASK1 returns the handle to a new TASK1 or the handle to
%      the existing singleton*.
%
%      TASK1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TASK1.M with the given input arguments.
%
%      TASK1('Property','Value',...) creates a new TASK1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before task1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to task1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help task1

% Last Modified by GUIDE v2.5 05-Mar-2024 16:59:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @task1_OpeningFcn, ...
                   'gui_OutputFcn',  @task1_OutputFcn, ...
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


% --- Executes just before task1 is made visible.
function task1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to task1 (see VARARGIN)
% Choose default command line output for task1
msg = 'GUI is opening...';
warndlg(msg, 'Information');
handles.output = hObject;
%guidata(hObject, handles);
% cla;
% axes(handles.axes);

% handles.P = [1, 1];
% %guidata(hObject, handles);
% disp('pip');
% set(handles.eta, 'String', num2str(handles.P(1)));
% set(handles.sig, 'String', num2str(handles.P(2)));
% %guidata(hObject, handles);
% handles.X1 = [2, 2, 1];
% set(handles.a, 'string', num2str(handles.X1(1)));
% set(handles.b, 'string', num2str(handles.X1(2)));
% set(handles.c, 'string', num2str(handles.X1(3)));
% 
% handles.X0 = [0; 1];
% set(handles.x0, 'string', num2str(handles.X0(1)));
% set(handles.x02, 'string', num2str(handles.X0(2)));
% 
% handles.T = [0; 200];
% set(handles.t0, 'string', num2str(handles.T(1)));
% set(handles.time, 'string', num2str(handles.T(2)));
% 
% handles.A = @inputA;
% handles.B = @inputB;
% handles.f = @inputF;
% 
% handles.step = 100;
% set(handles.N, 'string', num2str(handles.step));
% 
% guidata(hObject, handles);

% --- Executes just before task1 is made visible


% Initialize default values
handles.P = [1, 1];
handles.X1 = [2, 2, 1];
handles.X0 = [0; 1];
handles.T = [0; 200];
handles.A = inputA();
handles.B = inputB();
handles.f = inputF();
handles.step = 100;

% Set default values to GUI components
set(handles.eta, 'String', num2str(handles.P(1)));
set(handles.sig, 'String', num2str(handles.P(2)));

set(handles.a, 'string', num2str(handles.X1(1)));
set(handles.b, 'string', num2str(handles.X1(2)));
set(handles.c, 'string', num2str(handles.X1(3)));

set(handles.x0, 'string', num2str(handles.X0(1)));
set(handles.x02, 'string', num2str(handles.X0(2)));

set(handles.t0, 'string', num2str(handles.T(1)));
set(handles.time, 'string', num2str(handles.T(2)));

set(handles.N, 'string', num2str(handles.step));

% Update handles structure
guidata(hObject, handles);
%disp('GUI')
% ВОЗМОЖНО ТУТ ЧТО ТО ЕЩЕ
% Update handles structure

global Xii 
global u_opti 
global x_opti 
global tvec_opti
global Tii
global erri
global Li
global graph
global psi_fin
global no
no = 0;
psi_fin = zeros(2, 1);
graph = zeros(1, 6);
Li = [];
Xii = [];
u_opti = [];
x_opti = [];
tvec_opti = [];
Tii = [];
erri = 0;
% UIWAIT makes task1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = task1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function t0_Callback(hObject, eventdata, handles)
    t0 = str2double(get(hObject, 'string'));
    handles.T(1) = t0;
    guidata(hObject, handles);
% hObject    handle to t0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t0 as text
%        str2double(get(hObject,'String')) returns contents of t0 as a double


% --- Executes during object creation, after setting all properties.
function t0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function time_Callback(hObject, eventdata, handles)
    time = str2double(get(hObject, 'string'));
    handles.T(2) = time;
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



function x0_Callback(hObject, eventdata, handles)
    handles.X0(1) = 0;
    x01 = str2double(get(hObject, 'string'));
    handles.X0(1) = x01;
    guidata(hObject, handles);
% hObject    handle to x0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x0 as text
%        str2double(get(hObject,'String')) returns contents of x0 as a double


% --- Executes during object creation, after setting all properties.
function x0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a_Callback(hObject, eventdata, handles)
    a = str2double(get(hObject, 'string'));
    handles.X1(1) = a;
    guidata(hObject, handles);
% hObject    handle to a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a as text
%        str2double(get(hObject,'String')) returns contents of a as a double


% --- Executes during object creation, after setting all properties.
function a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b_Callback(hObject, eventdata, handles)
    b = str2double(get(hObject, 'string'));
    handles.X1(2) = b;
    guidata(hObject, handles);
% hObject    handle to b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b as text
%        str2double(get(hObject,'String')) returns contents of b as a double


% --- Executes during object creation, after setting all properties.
function b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c_Callback(hObject, eventdata, handles)
    c = str2double(get(hObject, 'string'));
    handles.X1(3) = c;
    guidata(hObject, handles);
% hObject    handle to c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c as text
%        str2double(get(hObject,'String')) returns contents of c as a double


% --- Executes during object creation, after setting all properties.
function c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function eta_Callback(hObject, eventdata, handles)
    eta = str2double(get(hObject, 'string'));
    handles.P(1) = eta;
    guidata(hObject, handles);
% hObject    handle to eta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eta as text
%        str2double(get(hObject,'String')) returns contents of eta as a double


% --- Executes during object creation, after setting all properties.
function eta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sig_Callback(hObject, eventdata, handles)
    sig = str2double(get(hObject, 'string'));
    handles.P(2) = sig;
    guidata(hObject, handles);
% hObject    handle to sig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sig as text
%        str2double(get(hObject,'String')) returns contents of sig as a double


% --- Executes during object creation, after setting all properties.
function sig_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles) %A
open('inputA.m');
guidata(hObject, handles);
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
%disp(get(handles.pushbutton4));
global Xii
%Xii = [];
global u_opti
global x_opti
global tvec_opti
global Tii
%global erri
global Li
global psi_fin
global no
%handles
%disp(V);
%disp(handles.A);
%L = [];
% [Xii, u_opti, Tii, x_opti, tvec_opti, erri, N_up, psi0, L] = decition(handles.step,handles.step,[], handles.T(1), handles.T(2), ...
%       handles.P(2),handles.P(1), handles.X1(1), handles.X1(2),handles.X1(3),... 
%       [handles.X0(1),handles.X0(2)],  handles.A, handles.B, handles.f, 0);
N = handles.step;
t0 = handles.T(1);
time = handles.T(2);
sig = handles.P(2);
eta = handles.P(1);
a = handles.X1(1);
b = handles.X1(2);
c = handles.X1(3);
x0 = [handles.X0(1),handles.X0(2)];
A = handles.A;
B = handles.B;
f = handles.f;
stop_up = 0;
upgrade = 0;
err = 0;
s = 0;
eps = 1e-5; %для проверки на невырожденность
opts = odeset('Events', @(t, x)inset(t, x, a, b, c));
%прверка, что множества не пересекаются
if abs(x0(1) - a) + abs(x0(2) - b) <= c
    disp('Множества пересекаются');
    return;
end 
while stop_up == 0

    if upgrade == 1
        psi0_up = zeros(N_up, 2);
        for i = 1: size(psi0, 1) - 1
            psi0_up(i, :) = (psi0(i, :) + psi0(i + 1, :))./2;
        end
    %i = 1;
        psi0_tmp = zeros(2*N_up, 2);
        for i = 1: size(psi0, 1)
            psi0_tmp(i, :)= psi0(i, :);
            psi0_tmp(i + 1, :) = psi0_up(i, :);
        end
        psi0 = psi0_tmp;  
        disp(size(psi0, 1));
    %psi0 = [psi0; psi0_up]; % если больше одного улучшения надо сохранять
        for i = 1: N_up
            psi_0_up = psi0_up(i, :);
            [~, x_0_up] = X0_rho(psi_0_up, x0);
            tspan = [t0, time];
            [t, y, te, ye, ie] = ode45(@(t, y)sistem(t, y, A, B, f, sig, eta), tspan, [x_0_up, psi_0_up], opts);
            if size(y, 1) == 1 
                disp('множества пересекаются');
                break;
            end
            if isempty(ie) %не дошли до X1
                inX1 = 0;
                %break;
                % disp('pip');
                s = s+1;
            end
            %else 
                psi = transpose([y(:, 3), y(:, 4)]); %строка
                x = [y(:, 1), y(:, 2)];% столбец
%                 if x(1,1) == x(1, end)
%                     disp('Пересечение');
%                     break;
%                 end
                [~, u] = P_rho(transpose(B)*psi, sig, eta);%строка
                u = transpose(u); % строка
                %disp(t);
                Li = [Li, size(t, 1)] ;
                Xii = [Xii; x];
                %disp(i);
                Tii = [Tii; t];
                if te < t_opt
                    t_opt = te;
                    tvec_opti = t;
                    u_opti = u;
                    x_opti = x; % на какой итерации достигается
                    psi_fin = -psi(:,size(t, 1));
                    psi_fin = psi_fin .\2 .\ norm(psi_fin);
                    [val_pred, x_pred] = X1_rho(transpose(-psi(:,size(t, 1))), a, b, c);
                    scal = -x(size(t, 1), :)*psi(:, size(t, 1));
                    err = abs(scal - val_pred);
                    %err = norm(x(end) - x_pred);
                    % disp(err);
                end
            %end
        end
        N_up = N_up * 2;
    else
        psi0 = generate_psi0(N); % в else
        Xii = []; % для построение всех траекторий
        Tii = []; % для отрисовки всех траекторий
        Li = []; % число координат при каждой итерации, чтобы потом отличать их от всей матрицы
        t_opt = time;
%         x_opt = []; %
%         tvec_opt = [];%
%         u_opt = [];
        N_up = N;
        for i = 1: N %заменить на N
            inX1 = 1;
            psi_0 = psi0(i,:);
            %[t, psi] = psi_decition(A, psi_0, t0, time);
            %u_opt = opor_vec(P_rho(psi))
            %[~, u_opt] = P_rho(psi, sig, eta);
            %u_opt = transpose(u_opt) % строка
            [~, x_0] = X0_rho(psi_0, x0);
            tspan = [t0, time];
            % необходимо добиться невырожденности матрицы B
            [U, S, V] = svd(B);
            S(find(abs(S)) < eps) = 1e-2;
            B = U*S*transpose(V);
            [t, y, te, ye, ie] = ode45(@(t, y)sistem(t, y, A, B, f, sig, eta), tspan, [x_0, psi_0], opts);
%             if size(y, 1) == 1 
%                 disp('множества пересекаются');
%                 break;
%             end
            if isempty(ie) %не дошли до X1
                inX1 = 0;
                % disp('pip');
                s = s+1;
                %no = 1;
            end 
                psi = transpose([y(:, 3), y(:, 4)]); %строка
                x = [y(:, 1), y(:, 2)];% столбец
%                 if x(1,1) == x(1, end)
%                     disp('Пересечение');
%                     break;
%                 end
                [~, u] = P_rho(transpose(B)*psi, sig, eta);%строка
                u = transpose(u); % строка
                %disp(t);
                Li = [Li, size(t, 1)] ;
                Xii = [Xii; x];
                %disp(i);
                Tii = [Tii; t];
                if te < t_opt
                    tvec_opti = t;
                    t_opt = te;
                    u_opti = u;
                    x_opti = x; % на какой итерации достигается
                    psi_fin = -psi(:,size(t, 1));
                    psi_fin = psi_fin .\2 .\ norm(psi_fin);
                    [val_pred, ~] = X1_rho(transpose(-psi(:,size(t, 1))), a, b, c);
                    scal = -x(size(t, 1), :)*psi(:, size(t, 1));
                    err = abs(scal - val_pred);
                    %err = norm(x(end) - x_pred);
                    % disp(err);
                end
           % end
        end
    end
    disp('The error: ');
    disp(err);
    choice = questdlg('Do you want to upgrade solution?','weeee', 'Yes', 'No', 'Yes');

    % Обработка ответа
    switch choice
        case 'Yes'
            disp('Пользователь ответил Да');
            upgrade = 1;
        case 'No'
            disp('Пользователь ответил Нет');
            stop_up = 1;
            upgrade = 0;
        otherwise
            disp('Пользователь закрыл окно без ответа');
    end
%     [Xii, u_opti, Tii, x_opti, tvec_opti, erri, N_up, psi0, L] = decition(handles.step,N_up,psi0, handles.T(1), handles.T(2), ...
%       handles.P(2),handles.P(1), handles.X1(1), handles.X1(2),handles.X1(3),... 
%       [handles.X0(1),handles.X0(2)],  handles.A, handles.B, handles.f, upgrade);
end
disp(t_opt);
 % disp(handles.A);
%[X, u_opt, Ti, x_opt, tvec_opt, err] = decition(10, 1, 200, 1, 1, 1, 1, 1, [0, 1], [1, 2; 1, 1], [1, 1; 1, 1], [0, 0], 0);
%guidata(hObject,handles);
% A = [1, 2; 1, 1];
% B = [1, 1; 1, 1];
% f = [0 ; 0];
guidata(hObject, handles);
%Xii
%disp(Ti);
%[Xii, u_opti, Tii, x_opti, tvec_opti, erri] = decition(10, 0, 20, 1, 1, 1, 1, 1, [0, 1], A, B, f, 0);
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
open('inputB.m');
guidata(hObject, handles);
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
open('inputF.m');
guidata(hObject, handles);
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function N_Callback(hObject, eventdata, handles)
    N = str2double(get(hObject, 'string'));
    handles.step = N;
    guidata(hObject, handles);
% hObject    handle to N (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of N as text
%        str2double(get(hObject,'String')) returns contents of N as a double


% --- Executes during object creation, after setting all properties.
function N_CreateFcn(hObject, eventdata, handles)
% hObject    handle to N (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x02_Callback(hObject, eventdata, handles)
    x02 = str2double(get(hObject, 'string'));
    handles.X0(2) = x02;
    guidata(hObject, handles);
% hObject    handle to x02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x02 as text
%        str2double(get(hObject,'String')) returns contents of x02 as a double


% --- Executes during object creation, after setting all properties.
function x02_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% global X
% global u_opt
% global x_opt
% global tvec_opt
% global Ti
% global err
% [X, u_opt, Ti, x_opt, tvec_opt, err] = decition(handles.step, handles.T(1), handles.T(2), ...
%     handles.P(2),handles.P(1), handles.X1(1), handles.X1(2),handles.X1(3), ...
%     [handles.X0(1),handles.X0(2)], handles.A, handles.B, handles.f, 1);
%  guidata(hObject,handles);
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in xx.
function xx_Callback(hObject, eventdata, handles)
% hObject    handle to xx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global graph
graph(1) = get(hObject,'Value');
% Hint: get(hObject,'Value') returns toggle state of xx


% --- Executes on button press in uu.
function uu_Callback(hObject, eventdata, handles)
% hObject    handle to uu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global graph
graph(4) = get(hObject,'Value');
% Hint: get(hObject,'Value') returns toggle state of uu


% --- Executes on button press in u1t.
function u1t_Callback(hObject, eventdata, handles)
% hObject    handle to u1t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global graph
graph(5) = get(hObject,'Value');
% Hint: get(hObject,'Value') returns toggle state of u1t


% --- Executes on button press in x1t.
function x1t_Callback(hObject, eventdata, handles)
% hObject    handle to x1t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global graph
graph(2) = get(hObject,'Value');
% Hint: get(hObject,'Value') returns toggle state of x1t


% --- Executes on button press in u2t.
function u2t_Callback(hObject, eventdata, handles)
% hObject    handle to u2t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global graph
graph(6) = get(hObject,'Value');
% Hint: get(hObject,'Value') returns toggle state of u2t


% --- Executes on button press in x2t.
function x2t_Callback(hObject, eventdata, handles)
% hObject    handle to x2t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global graph
graph(3) = get(hObject,'Value');
% Hint: get(hObject,'Value') returns toggle state of x2t


% --- Executes on button press in graph_button.
function graph_button_Callback(hObject, eventdata, handles)
% hObject    handle to graph_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Xii 
global u_opti 
global x_opti 
global tvec_opti
global Tii
global erri
global Li
global graph
global psi_fin
global no
sig = handles.P(2);
eta = handles.P(1);
a = handles.X1(1);
b = handles.X1(2);
c = handles.X1(3);
x0 = [handles.X0(1),handles.X0(2)];
if graph(1)
    ex1 = DrawSet(@(x)X1_rho(x, a , b, c), 100);
   % disp(ex1);
    ex0 = DrawSet(@(x)X0_rho(x, x0), 100);
    figure('Name', 'Graph1');
    hold on;
    axis equal;
   % title('Dependence of x1 on x2', 'Interpreter', 'latex');
    xlabel('$x_{1}$', 'Interpreter', 'latex', 'FontSize', 20);
    ylabel('$x_{2}$', 'Interpreter', 'latex', 'FontSize', 20); %нельзя повернуть горизонтально с 2019
    h1 = plot(ex1(:, 1), ex1(:, 2), 'r');
    h2 = plot(ex0(:, 1), ex0(:, 2), 'og');
    start = 1;
    for i = 1: length(Li)
        plot(Xii(start:start + Li(i) - 1, 1), Xii(start: start + Li(i) - 1, 2), 'b');
        % disp('pic');
        start = Li(i) + start;
    end
    if ~isempty(x_opti)
        h3 = plot(x_opti(:,1), x_opti(:,2), '-m', 'LineWidth', 1.5);
    end
    if size(x_opti, 1) > 1
        fin = draw_perpend(a, b, c, x_opti(end, 1), x_opti(end, 2));
        h4 = quiver(x_opti(end, 1),x_opti(end, 2),-fin(1) + x_opti(end, 1), -fin(2) + x_opti(end, 2), '-r', 'LineWidth', 1.75, 'ShowArrowHead', 'off');
        h5 = quiver(x_opti(end, 1),x_opti(end, 2), psi_fin(1) ,  psi_fin(2), '-g', 'LineWidth', 1.75, 'ShowArrowHead', 'off');
    end
    legend([h1, h2, h3, h4, h5],{'$X_{1}$', '$X_{0}$', '$Optimal \  trajectory$', '$Perpendicular$', '$\psi ( t_{1} )$'}, 'FontSize', 20, 'Interpreter', 'latex');
    hold off
end
if graph(2)
    figure('Name', 'Graph2');
    hold on;
    %title('Optimal trajectory for (x1, t)', 'Interpreter', 'latex');
    xlabel('$t$', 'Interpreter', 'latex','FontSize', 20);
    ylabel('$x_{1}$', 'Interpreter', 'latex', 'FontSize', 20);
    start = 1;
    for i = 1: length(Li)
        plot(Tii(start:start + Li(i) - 1), Xii(start:start + Li(i) - 1, 1), 'b');
        % disp('pic');
        start = Li(i) + start;
    end
    plot(tvec_opti, x_opti(:, 1), '-m','LineWidth', 1.5);
    hold off;
end
if graph(3)
    figure('Name', 'Graph3');
    hold on;
    %title('Optimal trajectory for (x2, t)', 'Interpreter', 'latex');
    xlabel('$t$', 'Interpreter', 'latex', 'FontSize', 20);
    ylabel('$x_{1}$', 'Interpreter', 'latex', 'FontSize', 20);
    start = 1;
    for i = 1: length(Li)
        plot(Tii(start:start + Li(i) - 1), Xii(start:start + Li(i) - 1, 2), 'b');
        % disp('pic');
        start = Li(i) + start;
    end
     plot(tvec_opti, x_opti(:, 2),  '-m','LineWidth', 1.5);
    %legend('Optimal trajectory','Trial trajectory');
    hold off;
end
if graph(4)
    ex = DrawP(@(x)P_rho(x, sig, eta), 100);
    figure('Name', 'Graph4');
    hold on;
    %title('Dependence of u2 on u1', 'Interpreter', 'latex');
    xlabel('$u_{1}$', 'Interpreter', 'latex', 'FontSize', 20);
    ylabel('$u_{2}$', 'Interpreter', 'latex', 'FontSize', 20);
    plot(ex(:, 1), ex(:, 2), 'b');
    plot(u_opti(:, 1), u_opti(:, 2), 'or');
    legend({'$P$', '$Optimal\  u$'}, 'FontSize', 20, 'Interpreter', 'latex');
    hold off;
end
if graph(5)
    figure('Name', 'Graph5');
    hold on;
    %title('Optimal trajectory for (u1, t)', 'Interpreter', 'latex');
    xlabel('$t$', 'Interpreter', 'latex', 'FontSize', 20);
    ylabel('$u_{1}$', 'Interpreter', 'latex', 'FontSize', 20);
    %disp(u_opti(1, :))
    plot(transpose(tvec_opti), u_opti(:, 1), '-r');
    hold off;
end
if graph(6)
    figure('Name', 'Graph5');
    hold on;
    %title('Optimal trajectory for (u2, t)', 'Interpreter', 'latex');
    xlabel('$t$', 'Interpreter', 'latex', 'FontSize', 20);
    ylabel('$u_{2}$', 'Interpreter', 'latex', 'FontSize', 20);
    %disp(u_opti(1, :))
    plot(transpose(tvec_opti), u_opti(:, 2), '-r');
    hold off;
end
Xii = [];
u_opti = [];
x_opti = [];
tvec_opti = [];
Tii = [];
erri = 0;
Li = [];
graph = zeros(1, 6);


