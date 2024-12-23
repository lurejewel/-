
h_f=figure(1);
set(h_f,'Position',[0,100,6000,400])
h_p1=plot(time,Torq_motor(4,:),'b','LineWidth',2);
hold on
h_p2=plot(time,Torq_motor(3,:),'r','LineWidth',2);
h_l=legend([h_p1,h_p2],'Right Hip Torque','Left Hip Torque');
set(h_l,'FontName','Times New Roman','FontSize',14)
grid on
xlabel('Time (s)','FontName','Times New Roman','FontSize',14)
ylabel('Torque (N.m)','FontName','Times New Roman','FontSize',14)
set(gca,'FontName','Times New Roman','FontSize',14)
xlim([0,10])
% ylim([-550,150])

h_f=figure(2);
set(h_f,'Position',[0,100,6000,400])
h_p1=plot(time,Torq_motor(7,:),'b','LineWidth',2);
hold on
h_p2=plot(time,Torq_motor(6,:),'r','LineWidth',2);
h_l=legend([h_p1,h_p2],'Right knee Torque','Left knee Torque');
set(h_l,'FontName','Times New Roman','FontSize',14)
grid on
xlabel('Time (s)','FontName','Times New Roman','FontSize',14)
ylabel('Torque (N.m)','FontName','Times New Roman','FontSize',14)
set(gca,'FontName','Times New Roman','FontSize',14)
xlim([0,10])

h_f=figure(3);
set(h_f,'Position',[0,100,6000,400])
h_p1=plot(time,Torq_motor(9,:),'b','LineWidth',2);
hold on
h_p2=plot(time,Torq_motor(8,:),'r','LineWidth',2);
h_l=legend([h_p1,h_p2],'Right ankle Torque','Left ankle Torque');
set(h_l,'FontName','Times New Roman','FontSize',14)
grid on
xlabel('Time (s)','FontName','Times New Roman','FontSize',14)
ylabel('Torque (N.m)','FontName','Times New Roman','FontSize',14)
set(gca,'FontName','Times New Roman','FontSize',14)
xlim([0,10])

h_f=figure(4);
set(h_f,'Position',[0,100,6000,400])
h_p1=plot(time,Desire_position(3,:),'b','LineWidth',2);
hold on
h_p2=plot(time,Yout(3,:),'r','LineWidth',2);
h_l=legend([h_p1,h_p2],'Desire hip position','simulation hip position');
set(h_l,'FontName','Times New Roman','FontSize',14)
grid on
xlabel('Time (s)','FontName','Times New Roman','FontSize',14)
ylabel('angle (rad)','FontName','Times New Roman','FontSize',14)
set(gca,'FontName','Times New Roman','FontSize',14)
xlim([0,10])

h_f=figure(5);
set(h_f,'Position',[0,100,6000,400])
h_p1=plot(time,Desire_position(3,:)-Yout(3,:),'b','LineWidth',2);
h_l=legend(h_p1,'hip position error');
set(h_l,'FontName','Times New Roman','FontSize',14)
grid on
xlabel('Time (s)','FontName','Times New Roman','FontSize',14)
ylabel('angle (rad)','FontName','Times New Roman','FontSize',14)
set(gca,'FontName','Times New Roman','FontSize',14)
xlim([0,10])

h_f=figure(6);
set(h_f,'Position',[0,100,6000,400])
h_p1=plot(time,Desire_position(6,:),'b','LineWidth',2);
hold on
h_p2=plot(time,Yout(6,:),'r','LineWidth',2);
h_l=legend([h_p1,h_p2],'Desire knee position','simulation knee position');
set(h_l,'FontName','Times New Roman','FontSize',14)
grid on
xlabel('Time (s)','FontName','Times New Roman','FontSize',14)
ylabel('angle (rad)','FontName','Times New Roman','FontSize',14)
set(gca,'FontName','Times New Roman','FontSize',14)
xlim([0,10])

h_f=figure(7);
set(h_f,'Position',[0,100,6000,400])
h_p1=plot(time,Desire_position(6,:)-Yout(6,:),'b','LineWidth',2);
h_l=legend(h_p1,'knee position error');
set(h_l,'FontName','Times New Roman','FontSize',14)
grid on
xlabel('Time (s)','FontName','Times New Roman','FontSize',14)
ylabel('angle (rad)','FontName','Times New Roman','FontSize',14)
set(gca,'FontName','Times New Roman','FontSize',14)
xlim([0,10])

h_f=figure(8);
set(h_f,'Position',[0,100,6000,400])
h_p1=plot(time,Desire_position(8,:),'b','LineWidth',2);
hold on
h_p2=plot(time,Yout(8,:),'r','LineWidth',2);
h_l=legend([h_p1,h_p2],'Desire ankle position','simulation ankle position');
set(h_l,'FontName','Times New Roman','FontSize',14)
grid on
xlabel('Time (s)','FontName','Times New Roman','FontSize',14)
ylabel('angle (rad)','FontName','Times New Roman','FontSize',14)
set(gca,'FontName','Times New Roman','FontSize',14)
xlim([0,10])

h_f=figure(9);
set(h_f,'Position',[0,100,6000,400])
h_p1=plot(time,Desire_position(8,:)-Yout(8,:),'b','LineWidth',2);
h_l=legend(h_p1,'ankle position error');
set(h_l,'FontName','Times New Roman','FontSize',14)
grid on
xlabel('Time (s)','FontName','Times New Roman','FontSize',14)
ylabel('angle (rad)','FontName','Times New Roman','FontSize',14)
set(gca,'FontName','Times New Roman','FontSize',14)
xlim([0,10])

h_f=figure(10);
set(h_f,'Position',[0,100,6000,400])
h_p1=plot(time,Desire_position(12,:),'b','LineWidth',2);
hold on
h_p2=plot(time,Yout(12,:),'r','LineWidth',2);
h_l=legend([h_p1,h_p2],'Desire hip velocity','simulation hip velocity');
set(h_l,'FontName','Times New Roman','FontSize',14)
grid on
xlabel('Time (s)','FontName','Times New Roman','FontSize',14)
ylabel('angular velocity (rad/s)','FontName','Times New Roman','FontSize',14)
set(gca,'FontName','Times New Roman','FontSize',14)
xlim([0,10])

h_f=figure(11);
set(h_f,'Position',[0,100,6000,400])
h_p1=plot(time,Desire_position(12,:)-Yout(12,:),'b','LineWidth',2);
h_l=legend(h_p1,'hip velocity error');
set(h_l,'FontName','Times New Roman','FontSize',14)
grid on
xlabel('Time (s)','FontName','Times New Roman','FontSize',14)
ylabel('angular velocity (rad/s)','FontName','Times New Roman','FontSize',14)
set(gca,'FontName','Times New Roman','FontSize',14)
xlim([0,10])

h_f=figure(12);
set(h_f,'Position',[0,100,6000,400])
h_p1=plot(time,Desire_position(15,:),'b','LineWidth',2);
hold on
h_p2=plot(time,Yout(15,:),'r','LineWidth',2);
h_l=legend([h_p1,h_p2],'Desire knee velocity','simulation knee velocity');
set(h_l,'FontName','Times New Roman','FontSize',14)
grid on
xlabel('Time (s)','FontName','Times New Roman','FontSize',14)
ylabel('angular velocity (rad/s)','FontName','Times New Roman','FontSize',14)
set(gca,'FontName','Times New Roman','FontSize',14)
xlim([0,10])

h_f=figure(13);
set(h_f,'Position',[0,100,6000,400])
h_p1=plot(time,Desire_position(15,:)-Yout(15,:),'b','LineWidth',2);
h_l=legend(h_p1,'knee velocity error');
set(h_l,'FontName','Times New Roman','FontSize',14)
grid on
xlabel('Time (s)','FontName','Times New Roman','FontSize',14)
ylabel('angular velocity (rad/s)','FontName','Times New Roman','FontSize',14)
set(gca,'FontName','Times New Roman','FontSize',14)
xlim([0,10])

h_f=figure(14);
set(h_f,'Position',[0,100,6000,400])
h_p1=plot(time,Desire_position(17,:),'b','LineWidth',2);
hold on
h_p2=plot(time,Yout(17,:),'r','LineWidth',2);
h_l=legend([h_p1,h_p2],'Desire ankle velocity','simulation ankle velocity');
set(h_l,'FontName','Times New Roman','FontSize',14)
grid on
xlabel('Time (s)','FontName','Times New Roman','FontSize',14)
ylabel('angular velocity (rad/s)','FontName','Times New Roman','FontSize',14)
set(gca,'FontName','Times New Roman','FontSize',14)
xlim([5,25])

h_f=figure(15);
set(h_f,'Position',[0,100,6000,400])
h_p1=plot(time,Desire_position(17,:)-Yout(17,:),'b','LineWidth',2);
h_l=legend(h_p1,'ankle velocity error');
set(h_l,'FontName','Times New Roman','FontSize',14)
grid on
xlabel('Time (s)','FontName','Times New Roman','FontSize',14)
ylabel('angular velocity (rad/s)','FontName','Times New Roman','FontSize',14)
set(gca,'FontName','Times New Roman','FontSize',14)
xlim([0,50])

h_f=figure(16);
set(h_f,'Position',[0,100,6000,400])
h_p1=plot(time,Particle(:,3),'b','LineWidth',2);
h_l=legend(h_p1,'KP(hip)');
set(h_l,'FontName','Times New Roman','FontSize',14)
grid on
xlabel('Time (s)','FontName','Times New Roman','FontSize',14)
ylabel('KP','FontName','Times New Roman','FontSize',14)
set(gca,'FontName','Times New Roman','FontSize',14)
xlim([0,50])

h_f=figure(17);
set(h_f,'Position',[0,100,6000,400])
h_p1=plot(time,Particle(:,6),'b','LineWidth',2);
h_l=legend(h_p1,'KP(knee)');
set(h_l,'FontName','Times New Roman','FontSize',14)
grid on
xlabel('Time (s)','FontName','Times New Roman','FontSize',14)
ylabel('KP','FontName','Times New Roman','FontSize',14)
set(gca,'FontName','Times New Roman','FontSize',14)
xlim([0,50])

h_f=figure(18);
set(h_f,'Position',[0,100,6000,400])
h_p1=plot(time,Particle(:,8),'b','LineWidth',2);
h_l=legend(h_p1,'KP(ankle)');
set(h_l,'FontName','Times New Roman','FontSize',14)
grid on
xlabel('Time (s)','FontName','Times New Roman','FontSize',14)
ylabel('KP','FontName','Times New Roman','FontSize',14)
set(gca,'FontName','Times New Roman','FontSize',14)
xlim([0,50])

h_f=figure(19);
set(h_f,'Position',[0,100,6000,400])
h_p1=plot(time,Particle(:,12),'b','LineWidth',2);
h_l=legend(h_p1,'KI(hip)');
set(h_l,'FontName','Times New Roman','FontSize',14)
grid on
xlabel('Time (s)','FontName','Times New Roman','FontSize',14)
ylabel('KI','FontName','Times New Roman','FontSize',14)
set(gca,'FontName','Times New Roman','FontSize',14)
xlim([0,50])

h_f=figure(20);
set(h_f,'Position',[0,100,6000,400])
h_p1=plot(time,Particle(:,15),'b','LineWidth',2);
h_l=legend(h_p1,'KI(knee)');
set(h_l,'FontName','Times New Roman','FontSize',14)
grid on
xlabel('Time (s)','FontName','Times New Roman','FontSize',14)
ylabel('KI','FontName','Times New Roman','FontSize',14)
set(gca,'FontName','Times New Roman','FontSize',14)
xlim([0,50])

h_f=figure(21);
set(h_f,'Position',[0,100,6000,400])
h_p1=plot(time,Particle(:,17),'b','LineWidth',2);
h_l=legend(h_p1,'KI(ankle)');
set(h_l,'FontName','Times New Roman','FontSize',14)
grid on
xlabel('Time (s)','FontName','Times New Roman','FontSize',14)
ylabel('KI','FontName','Times New Roman','FontSize',14)
set(gca,'FontName','Times New Roman','FontSize',14)
xlim([0,50])

h_f=figure(22);
set(h_f,'Position',[0,100,6000,400])
h_p1=plot(time,Particle(:,21),'b','LineWidth',2);
h_l=legend(h_p1,'KD(hip)');
set(h_l,'FontName','Times New Roman','FontSize',14)
grid on
xlabel('Time (s)','FontName','Times New Roman','FontSize',14)
ylabel('KD','FontName','Times New Roman','FontSize',14)
set(gca,'FontName','Times New Roman','FontSize',14)
xlim([0,50])

h_f=figure(23);
set(h_f,'Position',[0,100,6000,400])
h_p1=plot(time,Particle(:,24),'b','LineWidth',2);
h_l=legend(h_p1,'KD(knee)');
set(h_l,'FontName','Times New Roman','FontSize',14)
grid on
xlabel('Time (s)','FontName','Times New Roman','FontSize',14)
ylabel('KD','FontName','Times New Roman','FontSize',14)
set(gca,'FontName','Times New Roman','FontSize',14)
xlim([0,50])

h_f=figure(24);
set(h_f,'Position',[0,100,2000,400])
h_p1=plot(time,Particle(:,26),'b','LineWidth',2);
h_l=legend(h_p1,'KD(ankle)');
set(h_l,'FontName','Times New Roman','FontSize',14)
grid on
xlabel('Time (s)','FontName','Times New Roman','FontSize',14)
ylabel('KD','FontName','Times New Roman','FontSize',14)
set(gca,'FontName','Times New Roman','FontSize',14)
xlim([0,50])


% animation(Yout,time); 