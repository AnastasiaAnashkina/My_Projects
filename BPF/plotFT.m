function Fres = plotFT(hFigure, fHandle, fFTHandle, step, inpLimVec, outLimVec)
    %������� ��������� ��� � ������ ��� ��������� ���� ��� ������
    SPlotInfo = get(hFigure, 'UserData');
    if isempty(SPlotInfo) % ������� ����� ���
%         real_ax = subplot(2, 1, 1);
%         imag_ax = subplot(2, 2, 1);
        SPlotInfo = struct('outLimVec', outLimVec);%, 'ax', [real_ax imag_ax]%);
        set(hFigure, 'UserData', SPlotInfo);
%     else 
%        real_ax = SPlotInfo.ax(1);
%        imag_ax = SPlotInfo.ax(2);
%        cla(real_ax, 'reset'); % �������� �������, �� �������� ���
%        cla(imag_ax, 'reset');
    end
    if length(hFigure.Children) >1
        real_ax = hFigure.Children(1);
        imag_ax = hFigure.Children(2);
    else
        real_ax = axes('Parent', hFigure, 'OuterPosition', [0    0.5307    1.0000    0.4248]);
        imag_ax = axes('Parent', hFigure, 'OuterPosition',[0    0.0568    1.0000    0.4146]);
    end
    real_ax.NextPlot = 'add';
    imag_ax.NextPlot = 'add';
    if ~isempty(SPlotInfo) && isfield(hFigure.UserData, 'ax_handles')
        delete(SPlotInfo.ax_handles);
    end
    % �������� ����, ���� b - a �� ������� �� h
    a = inpLimVec(1);
    b = inpLimVec(2);
    T = b - a;
    N = 1 + floor(T / step); %����� ����� �� [a, b]
    step = T / N; %�������� ����� ���
    % ������ ����� ������ [c, d] ���� ��� �� ������
    if isempty(outLimVec)
        if isempty(SPlotInfo.outLimVec)
            outLimVec = [0, 2*pi/step]; % ����� ���������� ���� ������
        end
    end
    SPlotInfo.outLimVec = outLimVec;
    outLimVec = SPlotInfo.outLimVec; %� ������ ���� ����� ����������� �����
    S = 2*pi/step; % ������ ��� ������ 
    %im_step = S / N; %��� ������������� ��� ������
    im_step = 2*pi / T;
    c = outLimVec(1);
    d = outLimVec(2);
    k = floor(c / S);
    n = floor(d / S);
    i_k = ceil((c - k * S) / im_step);%����� ��� ����� [c, d] ����� ���������� ���������
    i_n = floor((d - n * S) / im_step); 
    m = n - k; % ����� �������� ��� ������
    t = (0 : (N - 1)) * step; % ��������� ��� ���������
    F_shift = fft(fHandle(t + a));
    lambda = k * S + im_step * (i_k : (m * N + i_n)); % [c, d]
    % ���� � = 2pi/step �� ������ ���� ������
    if m == 0
        F_shift = F_shift((1+i_k):(1+i_n));
    else
        F_shift = [F_shift((1+i_k) : N), repmat(F_shift, 1, m - 1), F_shift(1: (1+i_n))];
    end
    F = exp(-1i * lambda * a) .* step .* F_shift;
    disp('after calculating');
    plot(real_ax, lambda, real(F));
    disp('plot1');
    plot(imag_ax, lambda, imag(F));
    disp('plot2');
    fft_a = zeros(1, length(lambda));
    if ~isempty(fFTHandle)
        for i = 1: length(lambda)
            fft_a(i) = fFTHandle(lambda(i));
        end
    end
    if ~isempty(fFTHandle)
        hold(real_ax, 'on');
        %plot(real_ax, lambda, real(fFTHandle(lambda)));
        plot(real_ax, lambda, real(fft_a));
        hold(real_ax, 'off');
        hold(imag_ax, 'on');
        %plot(imag_ax, lambda, imag(fFTHandle(lambda)));
        plot(imag_ax, lambda, imag(fft_a));
        legend(real_ax, {'Approximate calculation', 'Analitycal calculation'});
        legend(imag_ax, {'Approximate calculation', 'Analitycal calculation'});
    end
    title(real_ax, 'Real part', 'Interpreter', 'latex');
    title(imag_ax, 'Imagin part', 'Interpreter', 'latex');
    xlabel(real_ax, '\lambda', 'Interpreter', 'tex');
    ylabel(real_ax, 'F', 'Interpreter', 'latex');
    xlabel(imag_ax, '\lambda', 'Interpreter', 'tex');
    ylabel(imag_ax, 'F', 'Interpreter', 'latex');
    xlim(real_ax, outLimVec);
    xlim(imag_ax, outLimVec);
    Fres = struct('nPoints', N, 'step', step, 'inpLimVec', inpLimVec, 'outLimVec', outLimVec);
end
    
    
        
    