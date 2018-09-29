%{
    @author Julio Manuel Paredes Lugo
    @author Elvis Jose Paez Rujano
    @author Javier Mérida
%}

% Console setting

clc
clf

% Global variables definition
global V L C FREQ PERIOD R1 R2 Rm;

% Global variables initialization

FREQ = 60.743;
PERIOD = 1/FREQ;
R1 = 1000;
R2 = 250; 
V = 0;
C = 0.4e-6;
L = 41e-3;
Rm = 55;

% Initial conditions

initTime = 0;
initIndCurrent = 0;
initIndVoltage = 0;
initCapCurrent = 0;
initCapVoltage = 0;
totalTime = 0;
numIndCurrent = [initIndCurrent];
numIndVoltage = [initIndVoltage];
numCapCurrent = [initIndCurrent];
numCapVoltage = [initIndVoltage];

stateVariables = [initIndCurrent initIndVoltage initCapCurrent initCapVoltage];

% Time setting

finalTime = initTime + PERIOD/2;
interval = [initTime finalTime];

% ode23 execution and data storage

options = odeset('RelTol',1e-6,'AbsTol',1e-6);    
[simTime, stateSpace] = ode23('Equations',interval,stateVariables,options);

totalTime = [totalTime; simTime];
numIndCurrent = [numIndCurrent; stateSpace(:,1)];
numIndVoltage = [numIndVoltage; stateSpace(:,2)];
numCapCurrent = [numCapCurrent; stateSpace(:,3)];
numCapVoltage = [numCapVoltage; stateSpace(:,4)];
% Second Cycle Setting
    
V =9;

% Time setting 

initTime = finalTime;
finalTime = initTime + PERIOD/2;
interval = [initTime finalTime];
    
% ode23 execution and data storage
    
stateVariables = [numIndCurrent(end) V 0 numCapVoltage(end)];
options = odeset('RelTol',1e-6,'AbsTol',1e-6);
[simTime, stateSpace] = ode23('Equations',interval,stateVariables,options);

totalTime = [totalTime; simTime];
numIndCurrent = [numIndCurrent; stateSpace(:,1)];
numIndVoltage = [numIndVoltage; stateSpace(:,2)];
numCapCurrent = [numCapCurrent; stateSpace(:,3)];
numCapVoltage = [numCapVoltage; stateSpace(:,4)];

% Plotting process

figure(1);
plot(totalTime,numIndCurrent, 'r', oscTimeIndCurrent+0.008231, (oscIndCurrent)/(Rm) + 0.004,'g');
title('Inductor Current');
legend('Numeric Solution', 'Osciloscope');
xlabel('t(s)');
ylabel('Il(A)');
grid on;
 
figure(2);
plot(totalTime,numIndVoltage, 'r', oscTimeIndVoltage+0.00015, (oscIndVoltage+0.08)*0.93, 'g');
title('Inductor Voltage');
legend('Numeric Solution', 'Osciloscope');
xlabel('t(s)');
ylabel('Vl(V)');
grid on;

figure(3);
plot(totalTime,numCapCurrent, 'r', oscTimeCapCurrent+0.0088, -oscCapCurrent/(R2-100), 'g');
title('Capacitor Current');
legend('Numeric Solution', 'Osciloscope');
xlabel('t(s)');
ylabel('Ic(A)');
grid on;

figure(4);
plot(totalTime,numCapVoltage, 'r', oscTimeCapVoltage+0.00844, oscCapVoltage+4.24, 'g');
title('Capacitor Voltage');
legend('Numeric Solution', 'Osciloscope');
xlabel('t(s)');
ylabel('Vc(V)');
grid on;