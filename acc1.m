clear all
clc

%Velocity step function - Steady at 30 (but because of inconsistencies it
%will still drop a bit from 30 before going back to 30 at the beginning)
v0 = 30;
v1 = 30;


%Lowering vref, braking scenario
vnew = -20
%at time, when the transient behavior in the beginning has disappeared
st = 200

%Lowering vref again to make it similiar to a slippery brake
vnew2 = 0
%at time
st3 = 200;

%First vehicle PID
Kp = 30 %2. 35;
Ki = 1;
Kd = 0;

%vehicle 2, 3 and 4
%PID - distance
Kp_s = 300 %1000%3. 1200;% 2. 500 %1. 1200; %500
Ki_s =  15%200 %3. 200; % 2. 20 %1. 200; %50

%PID - velocity
Kp_v = 700 %1700 %3. 1700;%2. 1000; %1. 900; %1000
Ki_v = 0
Kd_v = 0

%PID - acceleration
Kp_a = 1000 %3. 500; %2. 3000 %1. 500; %1000 
Ki_a = 0
Kd_a = 0

%PID - slip
Kp_l = 1800%3. 1500; %2. 1000 %1. 3000; %1900
Ki_l = 0;
Kd_l = 0%2000 0 %1000;

%Low pass gain
Klp = -200%140
tau = 0.5; %0.5


%Massvx
m2 = 450;
m3 = 450;
m4 = 450;

%desired spacing
spacing = 10;

% Inital conditions for integrators v->s going into friction function
s01 = 3*spacing;
s02 = 2*spacing;
s03 = spacing;
s04 = 0;

%position where fnew kicks in
S = 5781 % 5797;
fnew =0.2;
% Oklara [
%
K1 = 0;
testg2 = 1000;
testd = 0.3;

td = 1.7;

testg = 0;
D = 0;
I = 0;
P = 0;
st2 = 0;
% ]


s = sim('ACC');

t = s.simout.time;
v = s.simout.signals.values;

t1 = s.simout1.time;
v1 = s.simout1.signals.values;

t2 = s.simout2.time;
v2 = s.simout2.signals.values;

t3 = s.simout3.time;
v3 = s.simout3.signals.values;

t4 = s.simout4.time;
v4 = s.simout4.signals.values;

t5 = s.simout5.time;
v5 = s.simout5.signals.values;

t6 = s.simout6.time;
v6 = s.simout6.signals.values;

t7 = s.simout7.time;
v7 = s.simout7.signals.values;

t8 = s.simout8.time;
v8 = s.simout8.signals.values;

v9 = s.simout9.signals.values;
v10 = s.simout10.signals.values;

%Interpolation



%xlim, looking only at the braking at 200 seconds
a = 190;
b = 250;


% Visualisation, might not work now that we've added a fourth vehicle

% for i=a:length(t)
%     figure(15)
%     if abs(v3(i,1))>0.3 && abs(v3(i,1))<0.5
%         plot(0,0,'or','MarkerSize',10,'MarkerFaceColor','b')
%         hold on
%     elseif abs(v3(i,1))>0.5
%         plot(0,0,'or','MarkerSize',10,'MarkerFaceColor','r')
%         hold on
%     else
%         plot(0,0,'or','MarkerSize',10,'MarkerFaceColor','g')
%         hold on
%     end
% 
%     if abs(v3(i,2))>0.3 && abs(v3(i,2))<0.5
%         plot(-v1(i,1),0,'or','MarkerSize',10,'MarkerFaceColor','b')
%     elseif abs(v3(i,2))>0.5
%         plot(-v1(i,1),0,'or','MarkerSize',10,'MarkerFaceColor','r')
%     else
%         plot(-v1(i,1),0,'or','MarkerSize',10,'MarkerFaceColor','g')
%     end
% 
%     if abs(v3(i,3))>0.3 && abs(v3(i,3))<0.5
%         plot(-v1(i,2)-v1(i,1),0,'or','MarkerSize',10,'MarkerFaceColor','b')
%     elseif abs(v3(i,3))>0.5
%         plot(-v1(i,2)-v1(i,1),0,'or','MarkerSize',10,'MarkerFaceColor','r')
%     else
%         plot(-v1(i,2)-v1(i,1),0,'or','MarkerSize',10,'MarkerFaceColor','g')
%     end
% 
%     if abs(v3(i,4))>0.3 && abs(v3(i,4))<0.5
%         plot(-v1(i,3)-v1(i,2)-v1(i,1),0,'or','MarkerSize',10,'MarkerFaceColor','b')
%     elseif abs(v3(i,4))>0.5
%         plot(-v1(i,3)-v1(i,2)-v1(i,1),0,'or','MarkerSize',10,'MarkerFaceColor','r')
%     else 
%          plot(-v1(i,3)-v1(i,2)-v1(i,1),0,'or','MarkerSize',10,'MarkerFaceColor','g')
%     end
%     hold off
%     axis([-40 0 -2 2 ])
%     axis([ x(n+Dx) y1 y2]);drawnow
%     legend(num2str(round(v3(i,1),2)),num2str(round(v3(i,2),2)),num2str(round(v3(i,3),2)),num2str(round(v3(i,4),2)))
%     title("Distance in motion with slip altering the color of marker")
%     xlabel("Distance to first vehicle")
% 
% end

% for k = 1:4
%     figure(10)
%     subplot(3,1,1)
%     plot(t,v(:,k))
%     title('velocity')
%     xlabel('t (s)')
%     ylabel('v (m/s)')
%     legend('1','2','3','4')
%     xlim([a, b])
%     hold on
%     
%     subplot(3,1,2)
%     
%     plot(t1,v1(:,k))
%     title('intervehicular distance')
%     xlabel('t (s)')
%     ylabel('distance (m)')
%     legend('1-2','2-3','3-4')
%     xlim([a, b])
%     hold on
%     
%     %subplot(3,1,3)
%     
% %     plot(t2,v2(:,k)); 
% %     title('angular velocity')
% %     xlabel('t (s)')
% %     ylabel('angular velocity (rad/s)')
% %     legend('1','2','3','4')
% %     xlim([a, b])
% %     hold on
%     
%     subplot(3,1,3)
%     
%     plot(t,v3(:,k))
%     title('slip')
%     xlabel('t (s)')
%     ylabel('slip ratio')
%     legend('1','2','3','4')
%     xlim([a, b])
%     hold on
    
    
%     subplot(4,2,5)
%     
%     plot(t4,v4(:,k))
%     title('Fx')
%     xlabel('t (s)')
%     ylabel('Fx (N)')
%     legend('1','2','3','4')
%     xlim([a, b])
%     hold on
    
%     subplot(4,2,6)
%     
%     plot(t,v5(:,k))
%     title('acceleration')
%     xlabel('t (s)')
%     ylabel('a (m/s^2)')
%     legend('1','2','3','4')
%     xlim([a, b])
%     hold on
%     
%     subplot(4,2,7)
    
%     plot(t6,v6)
%     title('distance')
%     xlabel('t (s)')
%     ylabel('a (m/s^2)')
%     legend('1','2','3','4')
%     xlim([a, b])
%     hold on
%     
    %subplot(4,2,8)
    
%     plot(t7,v7(:,k))
%     title('input')
%     xlabel('t (s)')
%     ylabel('torque (Nm)')
%     legend('1','2','3')
%     xlim([a, b])
%     hold on
    
%     figure(2)
%     plot(t,v9(:,k))
%     hold on
%     xlim([a, b])
%       figure(3)
%       plot(t,v10(:,k))
%       hold on
%       xlim([a, b])

    
    
% end
%     figure(2)
%     plot(t,v8)
%     hold on
%     legend('distance error PID 1','acceleration error PID 1','velocity error PID 1','low pass 1','distance error PID 2','acceleration error PID 2','velocity error PID 2','low pass 2')
%     xlim([a, b])
% disp(Kp_l)
% disp(Klp)
% disp(tau)
% disp(min(v3(:,1)))
% disp(min(v3(:,2)))
% disp(min(v3(:,3)))
% disp(min(v3(:,4)))

 N_trucks = 4;                   % Number of trucks
% Parameters

time = t;
distance_analysis   = 60;      % Distance of analysis                  [m]
trackWidth          = 10;       % Track width                           [m]
laneMargin          = 2;        % Margin lane                           [m]
% Truck 1 (Leading truck)
truck_1_length      = 4;       % Length of the leading truck           [m]
truck_1_width       = 3;        % Width of the leading truck            [m]
truck_1_initial_speed    = v(1,1);   % Speed of the leading truck       [m/s]
truck_1_initial_position = s01; % Initial position of the leading truck [m]
% Truck 2 (Second truck)
truck_2_length      = 4;       % Length of the second truck            [m]
truck_2_width       = 3;        % Width of the second truck             [m]
truck_2_initial_speed    = v(2,1);   % Speed of the second truck        [m/s]
truck_2_initial_position = s02;  % Initial position of the second truck  [m]
% Truck 3 (Third truck)
truck_3_length      = 4;       % Length of the third truck            [m]
truck_3_width       = 3;        % Width of the third truck             [m]
truck_3_initial_speed    = v(3,1);   % Speed of the third truck        [m/s]
truck_3_initial_position = s03;  % Initial position of the third truck  [m]
% Truck 4 (Fourth truck)
truck_4_length      = 4;       % Length of the fourth truck           [m]
truck_4_width       = 3;        % Width of the fourth truck            [m]
truck_4_initial_speed    = v(4,1);   % Speed of the fourth truck       [m/s]
truck_4_initial_position = s04;  % Initial position of the fourth truck [m]

% dist_1_2 = truck_1_position - truck_2_position - truck_1_length;
% dist_2_3 = truck_2_position - truck_3_position - truck_2_length;
% dist_3_4 = truck_3_position - truck_4_position - truck_3_length;
%% Results

close all  

set(gcf,'Position',[50 50 1920 936]) % 720p
% set(gcf,'Position',[50 50 854 480]) % 480p
% Create and open video writer object
video = VideoWriter('platoon_string.avi');
video.Quality = 100;
open(video);  

acc_min = min(min(v5));
acc_max = max(max(v5));
v_min = min(min(v));
v_max=max(max(v));
dist_min=min(min(v1));
dist_max=max(max(v1));
dt=linspace(0,time(end),length(time));
dt1=linspace(a,time(end),length(t(a:end)));


%Interpolation

 xq=linspace(0,t(end),length(t));
 vq = interp1(t,v,xq);
 v3p = interp1(t3,v3,xq); %Slip
 v6p = interp1(t6, v6, xq); %Position
 vp = interp1(t,v,xq); %Slip
 v1p = interp1(t1, v1, xq); %Position
 v5p=interp1(t5,v5,xq);
a1=119;

count=0;
for i=(290):length(time)
   figure(1)
%     pause(0.00001);
%     frame_h = get(handle(gcf),'JavaFrame');
%     set(frame_h,'Maximized',1);
  subplot(3,2,1)
%         set(gca,'xlim',[0 time(end)],'ylim',[0 1.2*speed_max])
         
        plot(xq(a:end),vp(a:end,1))
        hold on ; grid on
        plot(xq(a:end),vp(a:end,2))
        plot(xq(a:end),vp(a:end,3))
        plot(xq(a:end),vp(a:end,4))
        plot([xq(i) xq(i)],[0 1.2*v_max],'k--')
        axis([a time(end) v_min v_max])
        set(gca, 'XTickLabel', 0:10:70)
        xlabel('Time [s]')
        ylabel('Speed [m/s]')
        title('Speed')
        legend('Car 1','Car 2','Car 3','Car 4')
        hold off

    subplot(3,2,2)
         
%         set(gca,'xlim',[0 time(end)],'ylim',[1.2*acc_min 1.2*acc_max])
        plot(xq(a:end),v5p(a:end,1))
        hold on ; grid on
        plot(xq(a:end),v5p(a:end,2))
        plot(xq(a:end),v5p(a:end,3))
        plot(xq(a:end),v5p(a:end,4))
        plot([xq(i) xq(i)],[1.2*acc_min 1.2*acc_max],'k--')
        axis([a time(end) acc_min acc_max])
        set(gca,'XTickLabel', 0:10:70)
        xlabel('Time [s]')
        ylabel('Acceleration [m/s2]')
        title('Acceleration')
        legend('Car 1','Car 2','Car 3','Car 4')
        hold off
    subplot(3,2,3)
        
        %set(gca,'xlim',[0 time(end)],'ylim',[0 1.2*dist_max])
        plot(xq(a:end),v1p(a:end,1))
        hold on ; grid on
        plot(xq(a:end),v1p(a:end,2))
        plot(xq(a:end),v1p(a:end,3))
        plot([xq(i) xq(i)],[0 1.2*dist_max],'k--')
        axis([a time(end) 0.9*dist_min 1.2*dist_max])

        set(gca,'XTickLabel', 0:10:70)
        xlabel('Time [s]')
        ylabel('Distance [m]')
        title('Separation Distance')
        legend('Cars 1 & 2','Cars 2 & 3','Cars 3 & 4', 'Location', 'southeast')
        hold off
    subplot(3,2,4)
%         set(gca,'xlim',[],'ylim',[-1 1])
    
%         cla
        set(gca, 'XTickLabel', 0:70)
        plot(xq(a:end),v3p(a:end,1))
        hold on ; grid on
        plot(xq(a:end),v3p(a:end,2))
        plot(xq(a:end),v3p(a:end,3))
        plot(xq(a:end),v3p(a:end,4))
        plot([xq(i) xq(i)],[-1.2 1.2],'k--')
        axis([a time(end) -1 1])
        set(gca, 'XTickLabel', 0:10:70)
        title('Tire-slip ratio')
        xlabel('Time [s]')
        ylabel('Slip ratio')
        legend('Car 1','Car 2','Car 3','Car 4', 'Location','northwest')
        hold off
    subplot(3,2,5:6)
        hold on ; axis equal
        cla 
        
        count = count + 1;

        % Position of the leading truck at instant [m]
        truck_1_position_inst = v6p(i,1)-v6p(290,4);
        truck_2_position_inst = v6p(i,2)-v6p(290,4);
        truck_3_position_inst = v6p(i,3)-v6p(290,4);
        truck_4_position_inst = v6p(i,4)-v6p(290,4);

        sideMarkingsX = [truck_1_position_inst-distance_analysis truck_1_position_inst+distance_analysis/2];
%         set(gca,'xlim',[truck_1_position_inst-distance_analysis+50 truck_1_position_inst+30],'ylim',[-trackWidth/2-laneMargin +trackWidth/2+laneMargin])
        plot(sideMarkingsX,[+trackWidth/2 +trackWidth/2],'k--') % Left marking
        plot(sideMarkingsX,[-trackWidth/2 -trackWidth/2],'k--') % Right marking
        axis([truck_1_position_inst-distance_analysis truck_1_position_inst+distance_analysis/2 -trackWidth/2-laneMargin +trackWidth/2+laneMargin])
        % DIMENSIONS
        % Truck 1
        truck_1_dimension_X = [truck_1_position_inst truck_1_position_inst truck_1_position_inst-truck_1_length truck_1_position_inst-truck_1_length];
        truck_1_dimension_Y = [+truck_1_width/2 -truck_1_width/2 -truck_1_width/2 +truck_1_width/2];
        % Truck 2
        truck_2_dimension_X = [truck_2_position_inst truck_2_position_inst truck_2_position_inst-truck_2_length truck_2_position_inst-truck_2_length];
        truck_2_dimension_Y = [+truck_2_width/2 -truck_2_width/2 -truck_2_width/2 +truck_2_width/2];
        % Truck 3
        truck_3_dimension_X = [truck_3_position_inst truck_3_position_inst truck_3_position_inst-truck_3_length truck_3_position_inst-truck_3_length];
        truck_3_dimension_Y = [+truck_3_width/2 -truck_3_width/2 -truck_3_width/2 +truck_3_width/2];
        % Truck 4
        truck_4_dimension_X = [truck_4_position_inst truck_4_position_inst truck_4_position_inst-truck_4_length truck_4_position_inst-truck_4_length];
        truck_4_dimension_Y = [+truck_4_width/2 -truck_4_width/2 -truck_4_width/2 +truck_4_width/2];
        
        % Plotting trucks
        if abs(v3p(i,1))>0.3 && abs(v3p(i,1))<0.5
        fill(truck_1_dimension_X,truck_1_dimension_Y, 'b')
        elseif abs(v3p(i,1))>0.5
        fill(truck_1_dimension_X,truck_1_dimension_Y, 'r')
        else
        fill(truck_1_dimension_X,truck_1_dimension_Y, 'g')
        end
        
        if abs(v3p(i,2))>0.3 && abs(v3p(i,2))<0.5
        fill(truck_2_dimension_X,truck_2_dimension_Y, 'b')
        elseif abs(v3p(i,2))>0.5
        fill(truck_2_dimension_X,truck_2_dimension_Y, 'r')
        else
        fill(truck_2_dimension_X,truck_2_dimension_Y, 'g')
        end

        if abs(v3p(i,3))>0.3 && abs(v3p(i,3))<0.5
        fill(truck_3_dimension_X,truck_3_dimension_Y, 'b')
        elseif abs(v3p(i,3))>0.5
        fill(truck_3_dimension_X,truck_3_dimension_Y, 'r')
        else
        fill(truck_3_dimension_X,truck_3_dimension_Y, 'g')
        end

        if abs(v3p(i,4))>0.3 && abs(v3p(i,4))<0.5
        fill(truck_4_dimension_X,truck_4_dimension_Y, 'b')
        elseif abs(v3p(i,4))>0.5
        fill(truck_4_dimension_X,truck_4_dimension_Y, 'r')
        else
        fill(truck_4_dimension_X,truck_4_dimension_Y, 'g')
        end
%         fill(truck_2_dimension_X,truck_2_dimension_Y, 'r')
%         fill(truck_3_dimension_X,truck_3_dimension_Y, 'y')
%         fill(truck_4_dimension_X,truck_4_dimension_Y, 'g')
    
        xlabel('Lon. distance [m]')
        ylabel('Lat. distance [m]')
            hold off
         pause(1)
    frame = getframe(gcf);
    writeVideo(video,frame);
            
%     
end
 close(video);