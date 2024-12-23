
load('x_gait.mat')
load('t_gait.mat')

t0=t_gait(1:6000);
t1=t_gait(1:5000);
q_Body=x_gait(1:6000,5);
q_Lhip=x_gait(1:6000,3);
q_Rhip=x_gait(1:6000,4);
q_Lknee=x_gait(1:6000,6);
q_Rknee=x_gait(1:6000,7);
q_Lankle=x_gait(1:6000,8);
q_Rankle=x_gait(1:6000,9);

q_Lhip_Denoising=smoothdata(q_Lhip,'gaussian',18);
q_Rhip_Denoising=smoothdata(q_Rhip,'gaussian',18);
q_Body_Denoising=smoothdata(q_Body,'gaussian',18);
q_Lknee_Denoising=smoothdata(q_Lknee,'gaussian',18);
q_Rknee_Denoising=smoothdata(q_Rknee,'gaussian',18);
q_Lankle_Denoising=smoothdata(q_Lankle,'gaussian',18);
q_Rankle_Denoising=smoothdata(q_Rankle,'gaussian',18);

ppq_Body=csape(t0,q_Body_Denoising,'periodic'); 
ppq_Lhip=csape(t0,q_Lhip_Denoising,'periodic');
ppq_Rhip=csape(t0,q_Rhip_Denoising,'periodic');
ppq_Lknee=csape(t0,q_Lknee_Denoising,'periodic');
ppq_Rknee=csape(t0,q_Rknee_Denoising,'periodic');
ppq_Lankle=csape(t0,q_Lankle_Denoising,'periodic');
ppq_Rankle=csape(t0,q_Rankle_Denoising,'periodic');

Torq_Joint=Rec_General_Force_Calculation;
Torq_Lhip=Torq_Joint(3,:)';
Torq_Rhip=Torq_Joint(6,:)';
Torq_Lknee=Torq_Joint(4,:)';
Torq_Rknee=Torq_Joint(7,:)';
Torq_Lankle=Torq_Joint(5,:)';
Torq_Rankle=Torq_Joint(8,:)';

Torq_Lhip_Denoising=smoothdata(Torq_Lhip,'gaussian',20);
Torq_Rhip_Denoising=smoothdata(Torq_Rhip,'gaussian',15);
Torq_Lknee_Denoising=smoothdata(Torq_Lknee,'gaussian',15);
Torq_Rknee_Denoising=smoothdata(Torq_Rknee,'gaussian',15);
Torq_Lankle_Denoising=smoothdata(Torq_Lankle,'gaussian',15);
Torq_Rankle_Denoising=smoothdata(Torq_Rankle,'gaussian',15);

ppq_Torq_Lhip=csape(t1,Torq_Lhip_Denoising,'periodic');
ppq_Torq_Rhip=csape(t1,Torq_Rhip_Denoising,'periodic');
ppq_Torq_Lknee=csape(t1,Torq_Lknee_Denoising,'periodic');
ppq_Torq_Rknee=csape(t1,Torq_Rknee_Denoising,'periodic');
ppq_Torq_Lankle=csape(t1,Torq_Lankle_Denoising,'periodic');
ppq_Torq_Rankle=csape(t1,Torq_Rankle_Denoising,'periodic');

% xishu=pp.coefs
% Y5=ppval(ppq_Body,t0); 
% Y3=ppval(ppq_Lhip,t0); 
% Y4=ppval(ppq_Rhip,t0); 
% Y6=ppval(ppq_Lknee,t0); 
% Y7=ppval(ppq_Rknee,t0); 
% Y8=ppval(ppq_Lankle,t0); 
% Y9=ppval(ppq_Rankle,t0); 
% 
% dq_Body=fnval(fnder(ppq_Body,1),t0); %求一阶导
% dq_Lhip=fnval(fnder(ppq_Lhip,1),t0);
% dq_Rhip=fnval(fnder(ppq_Rhip,1),t0);
% dq_Lknee=fnval(fnder(ppq_Lknee,1),t0);
% dq_Rknee=fnval(fnder(ppq_Rknee,1),t0);
% dq_Lankle=fnval(fnder(ppq_Lankle,1),t0);
% dq_Rankle=fnval(fnder(ppq_Rankle,1),t0);


% pp2=fnval(fnder(pp,2),X); %求二阶导

% plot(t0,Y1,'r',t0,dq_Body,'b')%,t0,Y3,t0,Y4,t0,Y5,t0,Y6
% title('三次线条插值B'); 

