function [f, q, dq, torq_motor, desire_position] = EulerPID_sim(j, x1, x2, pid)
%% 初始化
global Height ; % 髋部与地面的初始高度
Height = -0.7832;
Alpha = 0.5; % 适应度权重系数
Beta = 0.5; % 适应度权重系数
loop = 20;% 小循环迭代20代
h = 0.0001; % 小循环中每代的控制间隔
e_1 = zeros(9,1); % 上代误差
errorSum = zeros(9,1); % 误差积分
yout = zeros(9,1);
Coordinates(x1(:,1), x2(:,1)); % 关节角度、角速度 换算到 坐标、速度

%% 导入实测数据
global ppq_Body ppq_Lhip ppq_Rhip ppq_Lknee ppq_Rknee ppq_Lankle ppq_Rankle;
% global ppq_Torq_Lhip ppq_Torq_Rhip ppq_Torq_Lknee ppq_Torq_Rknee ppq_Torq_Lankle ppq_Torq_Rankle;

for k = 1 : loop
    % 第j个粒子（此时已经经历了j-1个小循环）在小循环第k代的时刻
    % 小循环时间间隔为 h （0.1 ms）
    time(k) = ((j-1)*loop+k) * h; 
    
    %% 读取实测数据在当前时刻下的值
    Y5 = ppval(ppq_Body,time(k));
    Y3 = ppval(ppq_Lhip,time(k));
    Y4 = ppval(ppq_Rhip,time(k));
    Y6 = ppval(ppq_Lknee,time(k));
    Y7 = ppval(ppq_Rknee,time(k));
    Y8 = ppval(ppq_Lankle,time(k));
    Y9 = ppval(ppq_Rankle,time(k));
    dq_Body = fnval(fnder(ppq_Body,1),time(k)); %求一阶导
    dq_Lhip = fnval(fnder(ppq_Lhip,1),time(k));
    dq_Rhip = fnval(fnder(ppq_Rhip,1),time(k));
    dq_Lknee = fnval(fnder(ppq_Lknee,1),time(k));
    dq_Rknee = fnval(fnder(ppq_Rknee,1),time(k));
    dq_Lankle = fnval(fnder(ppq_Lankle,1),time(k));
    dq_Rankle = fnval(fnder(ppq_Rankle,1),time(k));
    inputRef(:,k) = [0;0;Y3;Y4;Y5;Y6;Y7;Y8;Y9;0;0;...
        dq_Lhip;dq_Rhip;dq_Body;dq_Lknee;dq_Rknee;dq_Lankle;dq_Rankle];
    
%     Torq_Lhip = ppval(ppq_Torq_Lhip,time(k));
%     Torq_Rhip = ppval(ppq_Torq_Rhip,time(k));
%     Torq_Lknee = ppval(ppq_Torq_Lknee,time(k));
%     Torq_Rknee = ppval(ppq_Torq_Rknee,time(k));
%     Torq_Lankle = ppval(ppq_Torq_Lankle,time(k));
%     Torq_Rankle = ppval(ppq_Torq_Rankle,time(k));
    % Torq_all_Joint(:,k) = [0;0;Torq_Lhip;Torq_Rhip;0;...
    %     Torq_Lknee;Torq_Rknee;Torq_Lankle;Torq_Rankle];
    
    %% 计算当前时刻的观测值
    u(:,1) = zeros(9,1);
    Mq = Mfunction(x1(:,k));
    Cq = Cfunction(x1(:,k),x2(:,k));
    Nq = Nfunction(x1(:,k))';
    Fe = Fefunction(x1(:,k),x2(:,k),Height);
    
    % 按照动力学计算的下一时刻的位置和速度
    x1(:,k+1) = x1(:,k) + h.*x2(:,k);
    x2(:,k+1) = x2(:,k) + h.*(Mq \ (u(:,k) + Fe - Cq*x2(:,k) - Nq));
    %     x2(:,k+1) = x2(:,k)+h*(Mq_*(u(:,k)+0.75*Nq+Fe-Cq*x2(:,k)-Nq));
    %     y=x1;
    
    yout(3:9,k) = x1(3:9,k); % 因为第一二项不参与控制，所以计算误差时默认为零
    e = inputRef(1:9,k) - yout(:,k); % 误差项
    errorSum = errorSum + e.*h; % 误差积分（只在小循环内积分，下个小循环又置零，是不是不太好）
    de = (e - e_1)./h; % 误差微分

    u(:,k+1) = diag(pid(1:9)) * e + diag(pid(10:18)) * errorSum ...
        + diag(pid(19:27)) * de + 0.75 * Nq; % PID控制输出控制量
    % + condition1.*0.1.*Torq_all_Joint(:,k) - condition2.*0.1.*Torq_all_Joint(:,k)
    
    % 感觉f这里算的不是很对...是不是应该20个小循环的f相加（积分）啊，
    % 否则只输出了最后一代的f
    f = Alpha * sqrt(sum(e.^2)) + Beta * sqrt(sum(de.^2)); % 误差/适应度函数
    % Control limit
    %     if u(k)>10.0
    %         u(k)=10.0;
    %     end
    %     if u(k)<-10.0
    %         u(k)=-10.0;
    %     end
    e_1 = e;
end

q = x1(:,loop+1); % 小循环后的关节位置
dq = x2(:,loop+1); % 小循环后的关节速度
torq_motor = u(:,loop+1); % 关节控制量
desire_position = inputRef(:,loop); % 小循环后的理想/实测关节数据

end