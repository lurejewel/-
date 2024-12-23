function [ Fe ] = Fefunction(x1,x2,Height)
%求与环境的接触力，包括正压力，摩擦力和膝关节打直的力
global lt1 lt2 ls1 ls2 lf1 lf2;
global rf;
global Ct1 Ct2 Ch1 Ch2;
global Ct1dt Ct2dt Ch1dt Ch2dt;
Coordinates(x1,x2);
a1=x1(3);
a2=x1(4);
a11=x1(6);
a22=x1(7);
b1=x1(8);
b2=x1(9);
a1dt=x2(3);
a2dt=x2(4);
a11dt=x2(6);
a22dt=x2(7);
%---------------计算Jaccobi矩阵的每一行-----------------------
Cknee=[0,0,(-1),0,0,1,0,0,0];
Cheely=[0,1,lt1.*sin(a1),0,0,ls1.*sin(a11),0,(-1).*lf1.*rf.*cos(b1),0];
Ctoey=[0,1,lt1.*sin(a1),0,0,ls1.*sin(a11),0,lf1.*(1+(-1).*rf).*cos(b1),0];
Cknee2=[0,0,0,(-1),0,0,1,0,0];
Ctoe2y=[0,1,0,lt2.*sin(a2),0,0,ls2.*sin(a22),0,lf2.*(1+(-1).*rf).*cos(b2)];
Cheel2y=[0,1,0,lt2.*sin(a2),0,0,ls2.*sin(a22),0,(-1).*lf2.*rf.*cos(b2)];
Cheelx=[1,0,lt1.*cos(a1),0,0,ls1.*cos(a11),0,lf1.*rf.*sin(b1),0];
Ctoex=[1,0,lt1.*cos(a1),0,0,ls1.*cos(a11),0,(-1).*lf1.*(1+(-1).*rf).*sin(b1),0];
Cheel2x=[1,0,0,lt2.*cos(a2),0,0,ls2.*cos(a22),0,lf2.*rf.*sin(b2)];
Ctoe2x=[1,0,0,lt2.*cos(a2),0,0,ls2.*cos(a22),0,(-1).*lf2.*(1+(-1).*rf).*sin(b2)];
%-------设置摩擦力、接触力和膝关节打直时作用力的参数------------
kn=1e6;C1=1e9;
kc=1e6;C2=1e9;
C3=1e6;
cn=10;
Mu=0.4;
%------------------计算脚跟与脚尖的接触力-------------------
Fn_heel=-kn*(1/2-atan(C1*(Ch1(2)-Height))/pi)*(Ch1(2)-Height)-cn*(1/2-atan(C1*(Ch1(2)-Height))/pi)*Ch1dt(2);
Fn_toe=-kn*(1/2-atan(C1*(Ct1(2)-Height))/pi)*(Ct1(2)-Height)-cn*(1/2-atan(C1*(Ct1(2)-Height))/pi)*Ct1dt(2);
Fn_heel2=-kn*(1/2-atan(C1*(Ch2(2)-Height))/pi)*(Ch2(2)-Height)-cn*(1/2-atan(C1*(Ch2(2)-Height))/pi)*Ch2dt(2);
Fn_toe2=-kn*(1/2-atan(C1*(Ct2(2)-Height))/pi)*(Ct2(2)-Height)-cn*(1/2-atan(C1*(Ct2(2)-Height))/pi)*Ct2dt(2);
%------------------计算脚跟与脚尖的摩擦力-------------------
Ff_heel=-2*atan(C3*Ch1dt(1))/pi*Mu*Fn_heel;
Ff_toe=-2*atan(C3*Ct1dt(1))/pi*Mu*Fn_toe;
Ff_heel2=-2*atan(C3*Ch2dt(1))/pi*Mu*Fn_heel2;
Ff_toe2=-2*atan(C3*Ct2dt(1))/pi*Mu*Fn_toe2;
%------------------计算膝关节打直时的作用力-------------------
Fc_knee=-kc*(1/2-atan(C2*(a1-a11))/pi)*(a11-a1)-cn*(1/2-atan(C2*(a1-a11))/pi)*(a11dt-a1dt);
Fc_knee2=-kc*(1/2-atan(C2*(a2-a22))/pi)*(a22-a2)-cn*(1/2-atan(C2*(a2-a22))/pi)*(a22dt-a2dt);
% Fc_knee=0;
% Fc_knee2=0;

Fe=[Cheely;Ctoey;Cheel2y;Ctoe2y;Cknee;Cknee2;Cheelx;Ctoex;Cheel2x;Ctoe2x]'*[Fn_heel;Fn_toe;Fn_heel2;Fn_toe2;Fc_knee;Fc_knee2;Ff_heel;Ff_toe;Ff_heel2;Ff_toe2];
% Fe=[Cheely;Ctoey;Cheel2y;Ctoe2y;Cknee;Cknee2]'*[Fn_heel;Fn_toe;Fn_heel2;Fn_toe2;Fc_knee;Fc_knee2];


end


