function initialization
%% 给定需要的全局变量
global mbody mthigh mshank mfoot;
global Ibody Ithigh Ishank Ifoot;
global lb lt1 lt2 ls1 ls2 lf1 lf2;
global llb llt1 llt2 lls1 lls2;
global rf g;

%% 人体参数
mbody = 12;
mthigh = 2.5;
mshank = 2.5;
mfoot = 1.2;

lb = 0.6;
lt1 = 0.4;
lt2 = 0.4;
ls1 = 0.4;
ls2 = 0.4;
lf1 = 0.2;
lf2 = 0.2;

llb = lb/2;
llt1 = lt1/2;
llt2 = lt2/2;
lls1 = ls1/2;
lls2 = ls2/2;

Ibody = mbody*lb^2/12;
Ithigh = mthigh*lt1^2/12;
Ishank = mshank*ls1^2/12;
Ifoot = mfoot*lf1^2/12;

rf = 0.25; % (脚跟-脚踝长) / 脚长
g = 9.8;
end