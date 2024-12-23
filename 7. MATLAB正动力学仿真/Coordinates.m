function Coordinates( x1,x2 )
% 根据人体结构参数 和 关节角度 & 角速度，换算关节坐标 & 速度
%% 读取全局变量
global lb lt1 lt2 ls1 ls2 lf1 lf2;
global rf;
global Chip Cb Ck1 Ck2 Ca1 Ca2 Ct1 Ct2 Ch1 Ch2;
global Ch1dt Ch2dt Ct1dt Ct2dt;

%% 读取关节角度和角速度值
xhip=x1(1);
yhip=x1(2);
a1=x1(3);
a2=x1(4);
a3=x1(5);
a11=x1(6);
a22=x1(7);
b1=x1(8);
b2=x1(9);
xhipdt=x2(1);
yhipdt=x2(2);
a1dt=x2(3);
a2dt=x2(4);
a3dt=x2(5);
a11dt=x2(6);
a22dt=x2(7);
b1dt=x2(8);
b2dt=x2(9);

%% 换算关节位置
Chip=[xhip,yhip];
Cb=Chip-[lb*sin(a3),-lb*cos(a3)];
Ck1=Chip+[lt1*sin(a1),-lt1*cos(a1)];
Ck2=Chip+[lt2*sin(a2),-lt2*cos(a2)];
Ca1=Ck1+[ls1*sin(a11),-ls1*cos(a11)];
Ca2=Ck2+[ls2*sin(a22),-ls2*cos(a22)];
Ct1=Ca1+[lf1*(1-rf)*cos(b1),lf1*(1-rf)*sin(b1)];
Ct2=Ca2+[lf2*(1-rf)*cos(b2),lf2*(1-rf)*sin(b2)];
Ch1=Ca1+[-lf1*rf*cos(b1),-lf1*rf*sin(b1)];
Ch2=Ca2+[-lf2*rf*cos(b2),-lf2*rf*sin(b2)];

%% 换算关节速度
Ch1dt = [xhipdt + a1dt*lt1*cos(a1) + a11dt*ls1*cos(a11) + b1dt*lf1*rf*sin(b1),...
    yhipdt - b1dt*lf1*rf*cos(b1) + a1dt*lt1*sin(a1) + a11dt*ls1*sin(a11)];
Ch2dt = [xhipdt + a2dt*lt2*cos(a2) + a22dt*ls2*cos(a22) + b2dt*lf2*rf*sin(b2),...
    yhipdt - b2dt*lf2*rf*cos(b2) + a2dt*lt2*sin(a2) + a22dt*ls2*sin(a22)];
Ct1dt = [xhipdt + a1dt*lt1*cos(a1) + a11dt*ls1*cos(a11) - b1dt*lf1*(1-rf)*sin(b1),...
    yhipdt + b1dt*lf1*(1-rf)*cos(b1) + a1dt*lt1*sin(a1) + a11dt*ls1*sin(a11)];
Ct2dt = [xhipdt + a2dt*lt2*cos(a2) + a22dt*ls2*cos(a22) - b2dt*lf2*(1-rf)*sin(b2),...
    yhipdt + b2dt*lf2*(1-rf)*cos(b2) + a2dt*lt2*sin(a2) + a22dt*ls2*sin(a22)];
end

