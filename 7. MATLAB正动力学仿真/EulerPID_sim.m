function [f, q, dq, torq_motor, desire_position] = EulerPID_sim(j, x1, x2, pid)
%% ��ʼ��
global Height ; % �Ų������ĳ�ʼ�߶�
Height = -0.7832;
Alpha = 0.5; % ��Ӧ��Ȩ��ϵ��
Beta = 0.5; % ��Ӧ��Ȩ��ϵ��
loop = 20;% Сѭ������20��
h = 0.0001; % Сѭ����ÿ���Ŀ��Ƽ��
e_1 = zeros(9,1); % �ϴ����
errorSum = zeros(9,1); % ������
yout = zeros(9,1);
Coordinates(x1(:,1), x2(:,1)); % �ؽڽǶȡ����ٶ� ���㵽 ���ꡢ�ٶ�

%% ����ʵ������
global ppq_Body ppq_Lhip ppq_Rhip ppq_Lknee ppq_Rknee ppq_Lankle ppq_Rankle;
% global ppq_Torq_Lhip ppq_Torq_Rhip ppq_Torq_Lknee ppq_Torq_Rknee ppq_Torq_Lankle ppq_Torq_Rankle;

for k = 1 : loop
    % ��j�����ӣ���ʱ�Ѿ�������j-1��Сѭ������Сѭ����k����ʱ��
    % Сѭ��ʱ����Ϊ h ��0.1 ms��
    time(k) = ((j-1)*loop+k) * h; 
    
    %% ��ȡʵ�������ڵ�ǰʱ���µ�ֵ
    Y5 = ppval(ppq_Body,time(k));
    Y3 = ppval(ppq_Lhip,time(k));
    Y4 = ppval(ppq_Rhip,time(k));
    Y6 = ppval(ppq_Lknee,time(k));
    Y7 = ppval(ppq_Rknee,time(k));
    Y8 = ppval(ppq_Lankle,time(k));
    Y9 = ppval(ppq_Rankle,time(k));
    dq_Body = fnval(fnder(ppq_Body,1),time(k)); %��һ�׵�
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
    
    %% ���㵱ǰʱ�̵Ĺ۲�ֵ
    u(:,1) = zeros(9,1);
    Mq = Mfunction(x1(:,k));
    Cq = Cfunction(x1(:,k),x2(:,k));
    Nq = Nfunction(x1(:,k))';
    Fe = Fefunction(x1(:,k),x2(:,k),Height);
    
    % ���ն���ѧ�������һʱ�̵�λ�ú��ٶ�
    x1(:,k+1) = x1(:,k) + h.*x2(:,k);
    x2(:,k+1) = x2(:,k) + h.*(Mq \ (u(:,k) + Fe - Cq*x2(:,k) - Nq));
    %     x2(:,k+1) = x2(:,k)+h*(Mq_*(u(:,k)+0.75*Nq+Fe-Cq*x2(:,k)-Nq));
    %     y=x1;
    
    yout(3:9,k) = x1(3:9,k); % ��Ϊ��һ���������ƣ����Լ������ʱĬ��Ϊ��
    e = inputRef(1:9,k) - yout(:,k); % �����
    errorSum = errorSum + e.*h; % �����֣�ֻ��Сѭ���ڻ��֣��¸�Сѭ�������㣬�ǲ��ǲ�̫�ã�
    de = (e - e_1)./h; % ���΢��

    u(:,k+1) = diag(pid(1:9)) * e + diag(pid(10:18)) * errorSum ...
        + diag(pid(19:27)) * de + 0.75 * Nq; % PID�������������
    % + condition1.*0.1.*Torq_all_Joint(:,k) - condition2.*0.1.*Torq_all_Joint(:,k)
    
    % �о�f������Ĳ��Ǻܶ�...�ǲ���Ӧ��20��Сѭ����f��ӣ����֣�����
    % ����ֻ��������һ����f
    f = Alpha * sqrt(sum(e.^2)) + Beta * sqrt(sum(de.^2)); % ���/��Ӧ�Ⱥ���
    % Control limit
    %     if u(k)>10.0
    %         u(k)=10.0;
    %     end
    %     if u(k)<-10.0
    %         u(k)=-10.0;
    %     end
    e_1 = e;
end

q = x1(:,loop+1); % Сѭ����Ĺؽ�λ��
dq = x2(:,loop+1); % Сѭ����Ĺؽ��ٶ�
torq_motor = u(:,loop+1); % �ؽڿ�����
desire_position = inputRef(:,loop); % Сѭ���������/ʵ��ؽ�����

end