%% 基于粒子群算法的外骨骼在线控制策略仿真
% 作者：靳葳
% 最后修改时间：2021/12/18
% 
% 目的：通过对外骨骼各关节力矩控制器PID参数的优化，实现基于PSO的外骨骼在线助力优化。
% 优化对象：外骨骼九个关节控制器的PID参数（共27个）。
% 目标函数：外骨骼控制下的人体步态与实测步态关节角度的差值。
% 
% 前期准备：
% 1. 人机动力学建模，建立外骨骼施加力矩 - 关节角度和角速度 - 人/机/环境交互力的关系
% 2. 人体步态数据采集，生成目标步态（外骨骼控制器的理想步态）
% 
% PSO设计：
% 粒子数：100
% 维数：27
% 迭代次数：50
% 限幅：vmax 40, Pmax 120, I&Dmax 35, min 0
% 迭代公式：基于惯性权重法 v' = w * v + c1 * r1 * (pbest - x) + c2 * r2 * (gbest - x)
%          其中 c1 = c2 = 2, w 随迭代次数增加从 1 线性减小至 0.3 

clear; close all;
%% 初值设定

% 人体结构参数设定
x1(:,1) = [0,0,0.385,-0.1802,-0.0755,0.1870,-0.3134,0.3299,-0.0609]'; % 人体各关节坐标初值
x2(:,1) = zeros(9,1); % 人体各关节速度初值
initialization; % 给定人体骨架参数

% 导入实测数据
load_para;

% 控制参数设定
interval = 0.002; % 控制间隔（内含20个小循环）
number = 0; % 当前总代数（大循环数 + 大循环内代数 100）
dt = 0.3; 

% 粒子参数设定
dimension = 27; % 粒子维数，每个关节有Kp、Ki、Kd三个参数 → 9×3 = 27
n = 50; % 迭代代数/大循环数（50个大循环）
m = 100; % 粒子数
w = 1; c1 = 2; c2 = 2; % 速度惯性系数
vmax = 40; % 速度限幅
xmax(:,1:9) = 120.*ones(m,9); % Pmax
xmax(:,10:18) = 35.*ones(m,9); % Imax
xmax(:,19:27) = 35.*ones(m,9); % Dmax
xmin = zeros(m,27); % min
v = zeros(m,dimension); % 粒子初始速度
X = (xmax-xmin).*rand(m, dimension) + xmin; % 初始化种群，位置在(xmin,xmax)内均匀分布
P = X; % P为每个粒子每代的最优位置(pbest初始化)

% 输出设定
Yout = zeros(9,(n+1)*m); % 外骨骼控制下的各关节角度随时间的变化

%% 初始种群的适应值评估
tic
for j = 1 : m
    [last_f(j,:), q, dq, torq_motor, desire_position] = EulerPID_sim(j, x1, x2, X(j,:)); % 粒子群的适应值
    x1 = q;
    x2 = dq;
    Yout(1:9, j) = q;
    Yout(10:18, j) = dq;
    Torq_motor(:, j) = torq_motor;
    Desire_position(:, number+j) = desire_position;
    Particle(number+j, :) = X(j, :);
end

[fmin, min_i] = min(last_f); % Gbest
Pg = X(min_i,:); % Gbest对应的最优粒子
%% 正式迭代过程
for i = 1 : n % 第 i 个大循环（共50个，0.2秒×50）
    v = w * v + c1 * rand * (P - X) + c2 * rand * (ones(m,1) * Pg - X); % 产生新的速度
    v = (v>vmax).*vmax + (v>=-vmax & v<=vmax).*v + (v<-vmax).*(-vmax); % 限幅
    X = X + v * dt; % 更新粒子位置
    X = (X>xmax).*xmax + (X>=xmin & X<=xmax).*X + (X<xmin).*(xmin); % 限幅
    number = i * m;
    for j = 1 : m % 大循环中的第j代/第j个小循环（共100代，对应100个粒子，0.002秒×100）
        [new_f(j,:), q, dq, torq_motor, desire_position] ...
            = EulerPID_sim(number+j, x1, x2, X(j,:)); % 新的目标函数值，小循环，0.0001秒×20
        x1 = q;
        x2 = dq;
        Yout(1:9,number+j) = q;
        Yout(10:18,number+j) = dq;
        Torq_motor(:,number+j) = torq_motor;
        Desire_position(:,number+j) = desire_position;
        Particle(number+j,:) = X(j,:);
    end
    update_j = find(new_f<last_f); % 当前粒子的f是否优于Pbest
    P(update_j,:) = X(update_j,:); % 更新Pbest
    [new_fmin, min_i] = min(new_f); % 
    new_Pg = X(min_i,:);
    Pg = (new_fmin<fmin) * new_Pg + (new_fmin>=fmin) * Pg; % 更新Gbest
    last_f = new_f; % 保存当前的适应度函数
    fmin = min(new_fmin,fmin); % 更新全局最小f
    w = w - i/n * 0.7 * w; % 非线性的衰减项 后面和线性的做比较
end
toc
time = linspace(0, interval*(number+m), number+m); % 时程信号

