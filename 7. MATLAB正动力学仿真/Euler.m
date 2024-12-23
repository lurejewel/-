%Discrete PID control for continuous plant
clear;
close all;
initialization;
global Ct2 ;
global Height ;
Kp = 90;
Ki = 3;
Kd = 15;
loop=50000;
h = 0.0001; %constant
e_1=zeros(9,1); %last time error
errorSum =zeros(9,1); %the error integral
yout=zeros(9,1);
data_processing
x1(:,1)=[0,0,0.385,-0.1802,-0.0755,0.1870,-0.3134,0.3299,-0.0609]';
x2(:,1)=zeros(9,1);
Coordinates(x1(:,1),x2(:,1));
Height=Ct2(2);  
% Height=-0.7832;  

for k=1:1:loop

    time(k) = k*h;
    Y5=ppval(ppq_Body,time(k)); 
    Y3=ppval(ppq_Lhip,time(k)); 
    Y4=ppval(ppq_Rhip,time(k)); 
    Y6=ppval(ppq_Lknee,time(k)); 
    Y7=ppval(ppq_Rknee,time(k)); 
    Y8=ppval(ppq_Lankle,time(k)); 
    Y9=ppval(ppq_Rankle,time(k));
    inputRef(:,k)=[0;0;Y3;Y4;Y5;Y6;Y7;Y8;Y9]; 
    u(:,1)=zeros(9,1);
    Mq=Mfunction(x1(:,k));
    Cq=Cfunction(x1(:,k),x2(:,k));
    Nq=Nfunction(x1(:,k))';
    Fe=Fefunction(x1(:,k),x2(:,k),Height);
    Mq_=pinv(Mq);
    
    x1(:,k+1) = x1(:,k)+h.*x2(:,k);
    x2(:,k+1) = x2(:,k)+h.*(Mq\(u(:,k)+Fe-Cq*x2(:,k)-Nq));
%     x2(:,k+1) = x2(:,k)+h*(Mq_*(u(:,k)+0.75*Nq+Fe-Cq*x2(:,k)-Nq)); 
    y(:,k) = x1(:,k+1);
    yout(3:9,k)=y(3:9,k);
    e(:,k)=inputRef(:,k)-yout(:,k);
    errorSum = errorSum + e(:,k).*h;
    de(:,k)=(e(:,k)-e_1)./h;
    u(:,k+1)=Kp.*e(:,k) + Ki.*errorSum + Kd.*de(:,k)+0.75*Nq;
    %%Control limit
%     if u(k)>10.0
%         u(k)=10.0;
%     end
%     if u(k)<-10.0
%         u(k)=-10.0;
%     end
    
    e_1 = e(:,k);
end

figure(1);
plot(time,inputRef,'r',time,y,'k:','linewidth',2);
xlabel('time(s)');ylabel('yd,y');
legend('Ideal position signal','Position tracking');
figure(2);
plot(time,inputRef-y,'r','linewidth',2);
xlabel('time(s)'),ylabel('error');
animation(y,time);