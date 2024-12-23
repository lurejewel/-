function Torq_Joint=Rec_General_Force_Calculation
clc; clear; close all;
%% Load coordination and torque samples (Do not edit)
Data=load('General Coord and Ground Torque.mat');
T=Data.T_Resamp;  % Time series (total 50 seconds)
Omega=Data.Gait_Omeg;  % Gait frequency (rad/s) with respect to time 
q_d=Data.Gen_Disp;  % Displacement of the general coordinations (x, y, theta_right_thigh, theta_right_shank, theta_right_foot, theta_left_thigh, theta_left_shank, theta_left_foot)
q_v=Data.Gen_Velo;  % Velocity of the general coordinations
q_a=Data.Gen_Acce;  % Acceleration of the general coordinations
Gen_tau=Data.Gen_Torq;  % Ground reaction torque, where the first row is the reaction torque acted on the right foot, and the second row is that on the left foot

%% Specify body parameters (User defined)
Mass=90;  % Total mass of the testee
m_tr=0.557*Mass;  m_th=0.1*Mass;  m_sh=0.0535*Mass;  m_ft=0.019*Mass;  % Masses of the body sections
l_th=0.48;  l_sh=0.42;  l_ft=0.27;  l_fh=0.1;  % Lengths of the body sections
I_th=1/12*m_th*l_th^2;  I_sh=1/12*m_sh*l_sh^2;  I_ft=1/24*m_ft*l_ft^2;  phi_fh=40/180*pi;  % Inertias of the body sections
g=9.8;  % Gravity acceleration

%% Do not edit this part
f1=(m_tr+2*m_th+2*m_sh+2*m_ft)*q_a(1,:)+(1/2*m_th+m_ft+m_sh)*l_th*(cos(q_d(3,:)).*q_a(3,:)+cos(q_d(6,:)).*q_a(6,:))+(1/2*m_sh+m_ft)*l_sh*(cos(q_d(4,:)).*q_a(4,:)+cos(q_d(7,:)).*q_a(7,:))+...
    m_ft*l_fh*(cos(phi_fh+q_d(5,:)).*q_a(5,:)+cos(phi_fh+q_d(8,:)).*q_a(8,:))-(1/2*m_th+m_ft+m_sh)*l_th*(sin(q_d(3,:)).*q_v(3,:).^2+sin(q_d(6,:)).*q_v(6,:).^2)-...
    (1/2*m_sh+m_ft)*l_sh*(sin(q_d(4,:)).*q_v(4,:).^2+sin(q_d(7,:)).*q_v(7,:).^2)-l_fh*m_ft*(sin(phi_fh+q_d(5,:)).*q_v(5,:).^2+sin(phi_fh+q_d(8,:)).*q_v(8,:).^2);

f2=(m_tr+2*m_th+2*m_sh+2*m_ft)*q_a(2,:)+(1/2*m_th+m_ft+m_sh)*l_th*(sin(q_d(3,:)).*q_a(3,:)+sin(q_d(6,:)).*q_a(6,:))+(1/2*m_sh+m_ft)*l_sh*(sin(q_d(4,:)).*q_a(4,:)+sin(q_d(7,:)).*q_a(7,:))+...
    m_ft*l_fh*(sin(phi_fh+q_d(5,:)).*q_a(5,:)+sin(phi_fh+q_d(8,:)).*q_a(8,:))+(1/2*m_th+m_ft+m_sh)*l_th*(cos(q_d(3,:)).*q_v(3,:).^2+cos(q_d(6,:)).*q_v(6,:).^2)-...
    (1/2*m_sh+m_ft)*l_sh*(cos(q_d(4,:)).*q_v(4,:).^2+cos(q_d(7,:)).*q_v(7,:).^2)+l_fh*m_ft*(cos(phi_fh+q_d(5,:)).*q_v(5,:).^2+cos(phi_fh+q_d(8,:)).*q_v(8,:).^2)+(m_tr+2*(m_th+m_sh+m_ft))*g;

f3=(1/2*m_th+m_ft+m_sh)*l_th*cos(q_d(3,:)).*q_a(1,:)+(1/2*m_th+m_sh+m_ft)*l_th*sin(q_d(3,:)).*q_a(2,:)+(1/4*m_th+m_ft+m_sh+I_th/l_th^2)*l_th^2*q_a(3,:)+...
    (1/2*m_sh+m_ft)*l_sh*l_th*cos(q_d(3,:)-q_d(4,:)).*q_a(4,:)+m_ft*l_fh*l_th*cos(q_d(3,:)-q_d(5,:)-phi_fh).*q_a(5,:)+(1/2*m_sh+m_ft)*l_sh*l_th*sin(q_d(3,:)-q_d(4,:)).*q_v(4,:).^2+...
    m_ft*l_fh*l_th*sin(q_d(3,:)-q_d(5,:)-phi_fh).*q_v(5,:).^2+(1/2*m_th+m_sh+m_ft)*g*l_th*sin(q_d(3,:));

f4=(1/2*m_sh+m_ft)*l_sh*cos(q_d(4,:)).*q_a(1,:)+(1/2*m_sh+m_ft)*l_sh*sin(q_d(4,:)).*q_a(2,:)+(1/2*m_sh+m_ft)*l_sh*l_th*cos(q_d(3,:)-q_d(4,:)).*q_a(3,:)+...
    (I_sh/l_sh^2+1/4*m_sh+m_ft)*l_sh^2*q_a(4,:)+m_ft*l_fh*l_sh*cos(q_d(4,:)-q_d(5,:)-phi_fh).*q_a(5,:)-(1/2*m_sh+m_ft)*l_sh*l_th*sin(q_d(3,:)-q_d(4,:)).*q_v(3,:).^2+...
    m_ft*l_fh*l_sh*sin(q_d(4,:)-q_d(5,:)-phi_fh).*q_v(5,:).^2+(1/2*m_sh+m_ft)*g*l_sh*sin(q_d(4,:));

f5=m_ft*l_fh*cos(phi_fh+q_d(5,:)).*q_a(1,:)+m_ft*l_fh*sin(phi_fh+q_d(5,:)).*q_a(2,:)+m_ft*l_fh*l_th*cos(q_d(3,:)-q_d(5,:)-phi_fh).*q_a(3,:)+m_ft*l_fh*l_sh*cos(q_d(4,:)-q_d(5,:)-phi_fh).*q_a(4,:)+...
    (m_ft+I_ft/l_fh^2)*l_fh^2*q_a(5,:)-l_fh*l_th*m_ft*sin(q_d(3,:)-q_d(5,:)-phi_fh).*q_v(3,:).^2-m_ft*l_fh*l_sh*sin(q_d(4,:)-q_d(5,:)-phi_fh).*q_v(4,:).^2+m_ft*g*l_fh*sin(phi_fh+q_d(5,:));

f6=(1/2*m_th+m_ft+m_sh)*l_th*cos(q_d(6,:)).*q_a(1,:)+(1/2*m_th+m_sh+m_ft)*l_th*sin(q_d(6,:)).*q_a(2,:)+(1/4*m_th+m_ft+m_sh+I_th/l_th^2)*l_th^2*q_a(6,:)+...
    (1/2*m_sh+m_ft)*l_sh*l_th*cos(q_d(6,:)-q_d(7,:)).*q_a(7,:)+m_ft*l_fh*l_th*cos(q_d(6,:)-q_d(8,:)-phi_fh).*q_a(8,:)+(1/2*m_sh+m_ft)*l_sh*l_th*sin(q_d(6,:)-q_d(7,:)).*q_v(7,:).^2+...
    m_ft*l_fh*l_th*sin(q_d(6,:)-q_d(8,:)-phi_fh).*q_v(8,:).^2+(1/2*m_th+m_sh+m_ft)*g*l_th*sin(q_d(6,:));

f7=(1/2*m_sh+m_ft)*l_sh*cos(q_d(7,:)).*q_a(1,:)+(1/2*m_sh+m_ft)*l_sh*sin(q_d(7,:)).*q_a(2,:)+(1/2*m_sh+m_ft)*l_sh*l_th*cos(q_d(6,:)-q_d(7,:)).*q_a(6,:)+...
    (I_sh/l_sh^2+1/4*m_sh+m_ft)*l_sh^2*q_a(7,:)+m_ft*l_fh*l_sh*cos(q_d(7,:)-q_d(8,:)-phi_fh).*q_a(8,:)-(1/2*m_sh+m_ft)*l_sh*l_th*sin(q_d(6,:)-q_d(7,:)).*q_v(6,:).^2+...
    m_ft*l_fh*l_sh*sin(q_d(7,:)-q_d(8,:)-phi_fh).*q_v(8,:).^2+(1/2*m_sh+m_ft)*g*l_sh*sin(q_d(7,:));

f8=m_ft*l_fh*cos(phi_fh+q_d(8,:)).*q_a(1,:)+m_ft*l_fh*sin(phi_fh+q_d(8,:)).*q_a(2,:)+m_ft*l_fh*l_th*cos(q_d(6,:)-q_d(8,:)-phi_fh).*q_a(6,:)+m_ft*l_fh*l_sh*cos(q_d(7,:)-q_d(8,:)-phi_fh).*q_a(7,:)+...
    (m_ft+I_ft/l_fh^2)*l_fh^2*q_a(8,:)-l_fh*l_th*m_ft*sin(q_d(6,:)-q_d(8,:)-phi_fh).*q_v(6,:).^2-m_ft*l_fh*l_sh*sin(q_d(7,:)-q_d(8,:)-phi_fh).*q_v(7,:).^2+m_ft*g*l_fh*sin(phi_fh+q_d(8,:));

A= [1,0,0,0,0,0,0,0;...
    0,1,0,0,0,0,0,0;...
    0,0,1,1,1,0,0,0;...
    0,0,0,1,1,0,0,0;...
    0,0,0,0,1,0,0,0;...
    0,0,0,0,0,1,1,1;...
    0,0,0,0,0,0,1,1;...
    0,0,0,0,0,0,0,1];
Gen_force=[f1;f2;f3;f4;f5;f6;f7;f8];
Torq_Joint=A*(Gen_force-Gen_tau);

%% Torque display
% h_f=figure(1);
% set(h_f,'Position',[100,100,1000,400])
% h_p1=plot(T,Torq_Joint(1,:),'b','LineWidth',2);
% hold on
% h_p2=plot(T,Torq_Joint(2,:),'r','LineWidth',2);
% h_l=legend([h_p1,h_p2],'F_x','F_y');
% set(h_l,'FontName','Times New Roman','FontSize',14)
% grid on
% xlabel('Time (s)','FontName','Times New Roman','FontSize',14)
% ylabel('Force (N)','FontName','Times New Roman','FontSize',14)
% set(gca,'FontName','Times New Roman','FontSize',14)
% xlim([10,16])
% ylim([-850,350])
% 
% h_f=figure(2);
% set(h_f,'Position',[100,100,1000,400])
% h_p1=plot(T,Torq_Joint(3,:),'b','LineWidth',2);
% hold on
% h_p2=plot(T,Torq_Joint(6,:),'r','LineWidth',2);
% h_l=legend([h_p1,h_p2],'Right Hip','Left Hip');
% set(h_l,'FontName','Times New Roman','FontSize',14)
% grid on
% xlabel('Time (s)','FontName','Times New Roman','FontSize',14)
% ylabel('Torque (N.m)','FontName','Times New Roman','FontSize',14)
% set(gca,'FontName','Times New Roman','FontSize',14)
% xlim([10,16])
% ylim([-550,150])
% 
% h_f=figure(3);
% set(h_f,'Position',[100,100,1000,400])
% h_p1=plot(T,Torq_Joint(4,:),'b','LineWidth',2);
% hold on
% h_p2=plot(T,Torq_Joint(7,:),'r','LineWidth',2);
% h_l=legend([h_p1,h_p2],'Right Knee','Left Knee');
% set(h_l,'FontName','Times New Roman','FontSize',14)
% grid on
% xlabel('Time (s)','FontName','Times New Roman','FontSize',14)
% ylabel('Torque (N.m)','FontName','Times New Roman','FontSize',14)
% set(gca,'FontName','Times New Roman','FontSize',14)
% xlim([10,16])
% ylim([-450,150])
% 
% h_f=figure(4);
% set(h_f,'Position',[100,100,1000,400])
% h_p1=plot(T,Torq_Joint(5,:),'b','LineWidth',2);
% hold on
% h_p2=plot(T,Torq_Joint(8,:),'r','LineWidth',2);
% h_l=legend([h_p1,h_p2],'Right Ankle','Left Ankle');
% set(h_l,'FontName','Times New Roman','FontSize',14)
% grid on
% xlabel('Time (s)','FontName','Times New Roman','FontSize',14)
% ylabel('Torque (N.m)','FontName','Times New Roman','FontSize',14)
% set(gca,'FontName','Times New Roman','FontSize',14)
% xlim([10,16])
% ylim([-150,50])


% mean(Torq_Joint(1,:))+mean(Gen_tau(1,:))
% mean(Torq_Joint(2,:))+mean(Gen_tau(2,:))
end
