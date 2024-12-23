%% ��������Ⱥ�㷨����������߿��Ʋ��Է���
% ���ߣ�����
% ����޸�ʱ�䣺2021/12/18
% 
% Ŀ�ģ�ͨ������������ؽ����ؿ�����PID�������Ż���ʵ�ֻ���PSO����������������Ż���
% �Ż�����������Ÿ��ؽڿ�������PID��������27������
% Ŀ�꺯��������������µ����岽̬��ʵ�ⲽ̬�ؽڽǶȵĲ�ֵ��
% 
% ǰ��׼����
% 1. �˻�����ѧ��ģ�����������ʩ������ - �ؽڽǶȺͽ��ٶ� - ��/��/�����������Ĺ�ϵ
% 2. ���岽̬���ݲɼ�������Ŀ�경̬������������������벽̬��
% 
% PSO��ƣ�
% ��������100
% ά����27
% ����������50
% �޷���vmax 40, Pmax 120, I&Dmax 35, min 0
% ������ʽ�����ڹ���Ȩ�ط� v' = w * v + c1 * r1 * (pbest - x) + c2 * r2 * (gbest - x)
%          ���� c1 = c2 = 2, w ������������Ӵ� 1 ���Լ�С�� 0.3 

clear; close all;
%% ��ֵ�趨

% ����ṹ�����趨
x1(:,1) = [0,0,0.385,-0.1802,-0.0755,0.1870,-0.3134,0.3299,-0.0609]'; % ������ؽ������ֵ
x2(:,1) = zeros(9,1); % ������ؽ��ٶȳ�ֵ
initialization; % ��������Ǽܲ���

% ����ʵ������
load_para;

% ���Ʋ����趨
interval = 0.002; % ���Ƽ�����ں�20��Сѭ����
number = 0; % ��ǰ�ܴ�������ѭ���� + ��ѭ���ڴ��� 100��
dt = 0.3; 

% ���Ӳ����趨
dimension = 27; % ����ά����ÿ���ؽ���Kp��Ki��Kd�������� �� 9��3 = 27
n = 50; % ��������/��ѭ������50����ѭ����
m = 100; % ������
w = 1; c1 = 2; c2 = 2; % �ٶȹ���ϵ��
vmax = 40; % �ٶ��޷�
xmax(:,1:9) = 120.*ones(m,9); % Pmax
xmax(:,10:18) = 35.*ones(m,9); % Imax
xmax(:,19:27) = 35.*ones(m,9); % Dmax
xmin = zeros(m,27); % min
v = zeros(m,dimension); % ���ӳ�ʼ�ٶ�
X = (xmax-xmin).*rand(m, dimension) + xmin; % ��ʼ����Ⱥ��λ����(xmin,xmax)�ھ��ȷֲ�
P = X; % PΪÿ������ÿ��������λ��(pbest��ʼ��)

% ����趨
Yout = zeros(9,(n+1)*m); % ����������µĸ��ؽڽǶ���ʱ��ı仯

%% ��ʼ��Ⱥ����Ӧֵ����
tic
for j = 1 : m
    [last_f(j,:), q, dq, torq_motor, desire_position] = EulerPID_sim(j, x1, x2, X(j,:)); % ����Ⱥ����Ӧֵ
    x1 = q;
    x2 = dq;
    Yout(1:9, j) = q;
    Yout(10:18, j) = dq;
    Torq_motor(:, j) = torq_motor;
    Desire_position(:, number+j) = desire_position;
    Particle(number+j, :) = X(j, :);
end

[fmin, min_i] = min(last_f); % Gbest
Pg = X(min_i,:); % Gbest��Ӧ����������
%% ��ʽ��������
for i = 1 : n % �� i ����ѭ������50����0.2���50��
    v = w * v + c1 * rand * (P - X) + c2 * rand * (ones(m,1) * Pg - X); % �����µ��ٶ�
    v = (v>vmax).*vmax + (v>=-vmax & v<=vmax).*v + (v<-vmax).*(-vmax); % �޷�
    X = X + v * dt; % ��������λ��
    X = (X>xmax).*xmax + (X>=xmin & X<=xmax).*X + (X<xmin).*(xmin); % �޷�
    number = i * m;
    for j = 1 : m % ��ѭ���еĵ�j��/��j��Сѭ������100������Ӧ100�����ӣ�0.002���100��
        [new_f(j,:), q, dq, torq_motor, desire_position] ...
            = EulerPID_sim(number+j, x1, x2, X(j,:)); % �µ�Ŀ�꺯��ֵ��Сѭ����0.0001���20
        x1 = q;
        x2 = dq;
        Yout(1:9,number+j) = q;
        Yout(10:18,number+j) = dq;
        Torq_motor(:,number+j) = torq_motor;
        Desire_position(:,number+j) = desire_position;
        Particle(number+j,:) = X(j,:);
    end
    update_j = find(new_f<last_f); % ��ǰ���ӵ�f�Ƿ�����Pbest
    P(update_j,:) = X(update_j,:); % ����Pbest
    [new_fmin, min_i] = min(new_f); % 
    new_Pg = X(min_i,:);
    Pg = (new_fmin<fmin) * new_Pg + (new_fmin>=fmin) * Pg; % ����Gbest
    last_f = new_f; % ���浱ǰ����Ӧ�Ⱥ���
    fmin = min(new_fmin,fmin); % ����ȫ����Сf
    w = w - i/n * 0.7 * w; % �����Ե�˥���� ��������Ե����Ƚ�
end
toc
time = linspace(0, interval*(number+m), number+m); % ʱ���ź�

