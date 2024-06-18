function u = solveDirichlet(fHandle, xiHandle, etaHandle, mu, M, N)
    h_x = 1/M;%������ ���
    h_y = 1/N;
    x = h_x*(0:1:M-1); %���� ����� ���������� ������
    y = h_y*(0:1:N-1);
    xi = xiHandle(x); %��������� �������
    eta = etaHandle(y);
    phi = ifft(xi);% ���������� �������� ��������������
    psi = ifft(eta);
    cHandle = @(p, q) (2/(h_x^2))*(cos(2*pi*p/M) - 1)+ ...
        (2/(h_y^2))*(cos(2*pi*q/N) - 1) - mu;
    gammaHandle = @(k, p) exp(2*pi*1i*k.*p./M)./ (M*N);%������������ � �������� ������ ��� b
    deltaHandle = @(l, q) exp(2*pi*1i*l.*q./N)./(M*N);
    [P, Q] = meshgrid(0:1:M-1, 0:1:N-1);
    P = transpose(P);
    Q = transpose(Q);
    c = cHandle(P, Q);
    c = 1./c; %�� � ���� ���� ������ �� �
    x2 = h_x * P;
    y2 = h_y * Q;
    f_dis = fHandle(x2, y2);
    f_dis(:, 1) = 0;%�� ����� ������� �������, ����� ��������� b ������
    f_dis(1, :) = 0; 
    b_0 = ifft2(f_dis); % b c ������
    [P1, P2] = meshgrid(1:1:M-1, 0:1:M-1);% ��� ����� � �������� �������������� b
    P1 = transpose(P1);
    P2 = transpose(P2);
    gamma = gammaHandle(P1, P2);
    [Q1, Q2] = meshgrid(1:1:N-1, 0:1:N-1);
    Q1 = transpose(Q1);
    Q2 = transpose(Q2);
    delta = deltaHandle(Q1, Q2);
    %������ ����� ������ ����
    %������ '���������' �������
    A = sum(c, 2)./(M*N); % ����������� ��� f00
    B = transpose(gamma).*repmat(sum(c, 2), 1, M-1);%����������� ��� fk0 M-1 ���������
    C = transpose(delta * transpose(c)); %���� ��� f0t
    D1 = transpose(phi) - sum(b_0 .* c, 2);
    E1 = [A, B, C];
    A = transpose(sum(c, 1))./(M * N);
    B = transpose(gamma * c);
    C = transpose(delta .* repmat(sum(c, 1), N-1, 1));
    D2 = transpose(psi - sum(b_0 .* c, 1));
    E2 = [A, B, C];
    E = [E1; E2];
    G = [D1; D2];
    E = E(2:end, :); %������� ���� ��������� �� ������� �� � ��� �������� ��� ���������
    G = G(2:end, :);
    f_0 = transpose(E\G); % �������� �������
    f_dis(:, 1) = f_0(1:M); %f00
    f_dis(1, 2:end) = f_0(M+1 : end);
    b = ifft2(f_dis); %����������� b
    a = c .* b; %�� �������
    u = fft2(a);
    u = [u, transpose(xi); eta, xiHandle(1)];
end
    
    
    
    