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

FREQ = 59.5;
PERIOD = 1/FREQ;
R1 = 1055;
R2 = 1050;
V = 0;
C = 0.4e-6;
L = 41e-3;
Rm = 52;

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
    
V = 8.9;

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
plot(totalTime, numIndCurrent, 'r', oscTimeIndCurrent+0.008445+0.008242, (oscIndCurrent)/Rm +0.007806-0.003667, 'g');
title('Corriente en el inductor');
legend('Solucion numerica', 'Osciloscopio');
xlabel('t(s)');
ylabel('Il(A)');
grid on;
 
figure(2);
plot(totalTime,numIndVoltage, 'r', oscTimeIndVoltage+0.008403, oscIndVoltage, 'g');
title('Voltaje en el inductor');
legend('Solucion numerica', 'Osciloscopio');
xlabel('t(s)');
ylabel('Vl(V)');
grid on;

figure(3);
plot(totalTime,numCapCurrent, 'r', oscTimeCapCurrent+0.0067+0.001697, (oscCapCurrent)/R2, 'g');
title('Corriente en el capacitor');
legend('Solucion numerica', 'Osciloscopio');
xlabel('t(s)');
ylabel('Ic(A)');
grid on;

figure(4);
plot(totalTime,numCapVoltage, 'r', oscTimeCapVoltage+0.00877, oscCapVoltage+4.24, 'g');
title('Voltaje en el capacitor');
legend('Solucion numerica', 'Osciloscopio');
xlabel('t(s)');
ylabel('Vc(V)');
grid on;