function animation(x,tt)
%展示行走的动画
global lb lt1 lt2 ls1 ls2 lf1 lf2;
global rf;
global Height;
    xhip=x(1,:);
    yhip=x(2,:);
    a1=x(3,:);
    a2=x(4,:);
    a3=x(5,:);
    a11=x(6,:);
    a22=x(7,:);
    b1=x(8,:);
    b2=x(9,:);
    
    % Create figure
    screenSize = get(0, 'ScreenSize');
    width = screenSize(3)/1;
    left = 0;
    bottom = screenSize(4)/4;
    height = screenSize(4)/2;
    fig=figure('Position', [left bottom width height], 'Color','w');
    set(fig,'DoubleBuffer','on');
    set(gca,'xlim',[-120 120],'ylim',[-120 120],'NextPlot','replace','Visible','off');
     % Initialize the movie
%     refPoint = [0 0];
%     camera_shift = [0,0];
    nextFrameTime=0;
    timescale=1/5;
    FramesPerSec=15;  
    
    mov=VideoWriter('行走动画');
    mov.FrameRate=FramesPerSec;
    mov.Quality=100;
    open(mov);
    
     for i=1:1:length(tt)
%         for i=1:104
         %各节点坐标
            Chip=[xhip(i),yhip(i)];%+0.01*i
            Cb=Chip-[lb*sin(a3(i)),-lb*cos(a3(i))];
            Ck1=Chip+[lt1*sin(a1(i)),-lt1*cos(a1(i))];
            Ck2=Chip+[lt2*sin(a2(i)),-lt2*cos(a2(i))];
            Ca1=Ck1+[ls1*sin(a11(i)),-ls1*cos(a11(i))];
            Ca2=Ck2+[ls2*sin(a22(i)),-ls2*cos(a22(i))];
            Ct1=Ca1+[lf1*(1-rf)*cos(b1(i)),lf1*(1-rf)*sin(b1(i))];
            Ct2=Ca2+[lf2*(1-rf)*cos(b2(i)),lf2*(1-rf)*sin(b2(i))];
            Ch1=Ca1+[-lf1*rf*cos(b1(i)),-lf1*rf*sin(b1(i))];
            Ch2=Ca2+[-lf2*rf*cos(b2(i)),-lf2*rf*sin(b2(i))];
             
        
        xpos=[Ch1(1) Ct1(1) Ca1(1) Ck1(1) Chip(1) Cb(1)];
        ypos=[Ch1(2) Ct1(2) Ca1(2) Ck1(2) Chip(2) Cb(2)];
        xpos_swing=[Chip(1) Ck2(1) Ca2(1) Ch2(1) Ct2(1)];
        ypos_swing=[Chip(2) Ck2(2) Ca2(2) Ch2(2) Ct2(2)];
        
        if (tt(i) >= nextFrameTime) || i == length(tt)
            nextFrameTime = nextFrameTime + timescale/FramesPerSec;
            hold off
        
        plot(xpos, ypos, 'Color',[0.3 0.3 0.3],'LineWidth',3);hold on
        plot(xpos_swing, ypos_swing, 'Color',[0.3 0.3 0.3],'LineWidth',3,'LineStyle','-.');hold on
        %
        plot(Chip(1), Chip(2), 'o','LineWidth',1,'MarkerSize',6,'MarkerEdgeColor','k','MarkerFaceColor','y');hold on
        plot(Cb(1),Cb(2), 'o:','LineWidth',1,'MarkerSize',4,'MarkerEdgeColor','k','MarkerFaceColor','y');hold on
        plot(Ck1(1), Ck1(2), 'o:','LineWidth',1,'MarkerSize',4,'MarkerEdgeColor','k','MarkerFaceColor','y');hold on
        plot(Ck2(1), Ck2(2), 'o:','LineWidth',1,'MarkerSize',4,'MarkerEdgeColor','k','MarkerFaceColor','y');hold on
        plot(Ca1(1), Ca1(2), 'o:','LineWidth',1,'MarkerSize',4,'MarkerEdgeColor','k','MarkerFaceColor','y');hold on
        plot(Ca2(1), Ca2(2), 'o:','LineWidth',1,'MarkerSize',4,'MarkerEdgeColor','k','MarkerFaceColor','y');hold on
        plot(Ct1(1), Ct1(2), 'o:','LineWidth',1,'MarkerSize',4,'MarkerEdgeColor','k','MarkerFaceColor','y');hold on
        plot(Ct2(1), Ct2(2), 'o:','LineWidth',1,'MarkerSize',4,'MarkerEdgeColor','k','MarkerFaceColor','y');hold on
        plot(Ch1(1), Ch1(2), 'o:','LineWidth',1,'MarkerSize',4,'MarkerEdgeColor','k','MarkerFaceColor','y');hold on
        plot(Ch2(1), Ch2(2), 'o:','LineWidth',1,'MarkerSize',4,'MarkerEdgeColor','k','MarkerFaceColor','y');hold on
        
%         ymax = Cb(2)-refPoint(2)+1.0 + camera_shift(2);
%         ymin = Ch2(2)-refPoint(2)-.2 + camera_shift(2);
%         xmin = Ch2(1)-refPoint(1)+.5 + camera_shift(1);
%         xmax = xmin+(ymax-ymin)*width/height;
        ymax=1.5;
        ymin=-1.5;
        xmin=-1;
        xmax=xmin+(ymax-ymin)*width/height;
        
        axis([xmin,xmax,ymin,ymax]);
        plot([xmin,xmax],[Height,Height],'Color',[0.396, 0.263, 0.129]);
        axis off;
        text( xmin ,ymax - .05 ,strcat('tstep = ' ,num2str(tt(i))) );
        drawnow;
        
          F = getframe(gcf);
          writeVideo(mov,F);
        end
     end
end