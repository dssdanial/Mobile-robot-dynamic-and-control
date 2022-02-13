clc
clear 
close all

dt=0.01; %sample time

%% Load Trajectory and Sensor Input Data

% position
Pos_ref=xlsread('Ref_Pos.xlsx');
Xref=Pos_ref(:,2); % meter
Yref=Pos_ref(:,3);

% velocity
Vel_ref=xlsread('Ref_vel.xlsx');
Vel_Xref=Vel_ref(:,2); % m/s
Vel_Yref=Vel_ref(:,3);

% Theta
Theta_ref=xlsread('Ref_yaw.xlsx');
Theta_ref=Theta_ref(:,2);   %convert to degree


% Gyro
Gyr_ref=xlsread('Ref_Gyro.xlsx');
Gyr_x=Gyr_ref(:,2).*(pi/180);  % Based on Rad/s
Gyr_y=Gyr_ref(:,3).*(pi/180); % Based on Rad/s
Gyr_z=Gyr_ref(:,4).*(pi/180); % Based on Rad/s



% body to inertial 
phi=0;
theta=0;
psi=Theta_ref(1);

%% System requirements


T_final=length(Theta_ref);
% X=zeros(17,1);
L=0.5; %wheels distance


Theta=Theta_ref(1,1);   % initial Theta
X_correct=Xref(1);   % initial X
Y_correct=Yref(1);   % initial Y

% initial errors
Xe=0;
Ye=0;
Theta_E=0;

% initial saving data

Xsave=zeros(T_final,1);
Ysave=zeros(T_final,1);
Theta_save=zeros(T_final,1);
X_Err=zeros(T_final,1);
Y_Err=zeros(T_final,1);
Ang_Err=zeros(T_final,1);


% Main Loop

for i=1:T_final-1





%% Designing of Controller and Robot Dynamic
% M=[cos(Theta_correct)  cos(Theta_correct);sin(Theta_correct) -sin(Theta_correct)];
% r=0.25;
% VV=2/r *inv(M)*[Vel_Xref(i); Vel_Yref(i)];
% % Vl=2/r *inv(M)*Vel_Yref(i);
% 
% Vref_T=(VV(1)+VV(2))/2;
Vr_max = 0.5;                              %% 500 mm/sec Velocity
%         Vx = (Xref(i+1) -Xref(i) )/dt;
%         Vy = (Yref(i+1) -Yref(i) )/dt;
        Vr = sqrt(Vel_Xref(i)^2 + Vel_Yref(i)^2);
        Wr =Gyr_z(i);% (Theta_ref(i+1)-Theta_ref(i))/dt;
        
        if (Vr >= Vr_max)
            Vr = Vr_max;
        elseif Vr <= -Vr_max
            Vr = -Vr_max;
        end


[Vt,W] = Unique_Controller(Wr,Vr,Xe, Ye, Theta_E); % Controller design

% robot
[Dx,Dy,Theta] = Robot_Dynamic(Vt,W,Theta); % Robot Dynamic model

%% Correction


X_correct=X_correct +Dx*dt;
Y_correct=Y_correct +Dy*dt;
%  Theta_correct=Theta_correct+ Dtheta*dt;

Error_x=Xref(i) -X_correct;
Error_y=Yref(i) -Y_correct;
% Error_theta=Theta_ref(i) -Theta_correct;


Xe= cos(Theta)*Error_x + sin(Theta)*Error_y ;
Ye= -sin(Theta)*Error_x + cos(Theta)*Error_y ;
Theta_E=Theta_ref(i) -Theta;




%% Save data

Xsave(i)=X_correct;
Ysave(i)=Y_correct;
Theta_save(i)=Theta;

X_Err(i)=Error_x;
Y_Err(i)=Error_y;
Ang_Err(i)=Theta_E;





iteration=i
end % for loop

Xsave(i+1)=X_correct;
Ysave(i+1)=Y_correct;
Theta_save(i+1)=Theta;

X_Err(i+1)=Error_x;
Y_Err(i+1)=Error_y;
Ang_Err(i+1)=Theta_E;


Time=1:T_final;

figure(1);
plot(Time,Xref,Time,Xsave,'--','linewidth',1.5)
xlabel('Time (s)')
ylabel('X (m)')
title('X trajectory');
legend('Ref','Robot');


figure(2);
plot(Time,Yref,Time,Ysave,'--','linewidth',1.5)
xlabel('Time (s)')
ylabel('Y (m)')
title('Y trajectory');
legend('Ref','Robot');



figure(3);
plot(Xref,Yref,'linewidth',1.5);
hold on;
plot(Xsave,Ysave,'--','linewidth',1.5)
xlabel('X (m)')
ylabel('Y (m)')
title('XY trajectory');
legend('Ref','Robot');



figure(4);
plot(Time,Theta_ref,Time,Theta_save,'--','linewidth',1.5)
xlabel('Time (s)')
ylabel('Theta (deg)')
title('Theta trajectory');
legend('Ref','Robot');


figure(5);
subplot(311);
plot(Time,X_Err,'linewidth',1.5)
xlabel('Time (s)')
ylabel('X error (m)')
title('System Errors');
subplot(312);
plot(Time,Y_Err,'linewidth',1.5)
xlabel('Time (s)')
ylabel('Y error (m)')
subplot(313);
plot(Time,Ang_Err,'linewidth',1.5)
xlabel('Time (s)')
ylabel('\theta error (deg)')






