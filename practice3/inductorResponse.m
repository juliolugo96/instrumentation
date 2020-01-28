%{
    @author Julio Manuel Paredes Lugo
    @author Elvis Jose Paez Rujano
%}

% Console setting

clc
clf

% Global variables definition
global V L FREQ PERIOD R1 R2 R3 VTH RTH

% Global variables initialization

FREQ = 1017;
PERIOD = 1/FREQ;
R1 = 1000;
R2 = 900;
R3 = 1000;
RTH = (R1*R3 + R2*R3 + R1*R2)/(R1+R3);
V = 4.96;
VTH = (R3)*V/((R1+R3));
L = 41e-3;

% Initial conditions

initTime = 0;
initIndCurrent = 0;
initIndVoltage = 0;
totalTime = 0;
numIndCurrent = [initIndCurrent];
numIndVoltage = [initIndVoltage];

stateVariables = [initIndCurrent initIndVoltage];
analyticSolution = stateVariables;

for i = 1: 2
    
    % First Cycle Setting
    
    % Time setting 
    finalTime = initTime + PERIOD/2;
    interval = [initTime finalTime];
    % ode23 execution and data storage
    options = odeset('RelTol',1e-6,'AbsTol',1e-6);
    [simTime, stateSpace] = ode23('indEqSystem',interval,stateVariables,options);
    
    totalTime = [totalTime; simTime];
    numIndCurrent = [numIndCurrent; stateSpace(:,1)];
    numIndVoltage = [numIndVoltage; stateSpace(:,2)];
       
    % Analytic Solution
    
    analyticIndCurrent = (stateVariables(:,1))*exp((-RTH)*(simTime-initTime)/L) + (VTH/RTH)*(1 - exp((-RTH)*(simTime-initTime)/L));

    analyticIndVoltage = stateVariables(:,2) * exp(-RTH*(simTime - initTime)/L);
    
    analyticSolution = [analyticSolution; analyticIndCurrent analyticIndVoltage];
    
    % Second Cycle Setting
    
    V = -V;
    VTH = -VTH;
    
    % Time setting 
    initTime = finalTime;
    finalTime = initTime + PERIOD/2;
    interval = [initTime finalTime];
    % ode23 execution and data storage
    
    stateVariables = [numIndCurrent(end) VTH-numIndCurrent(end)*RTH];
    options = odeset('RelTol',1e-6,'AbsTol',1e-6);
    [simTime, stateSpace] = ode23('indEqSystem',interval,stateVariables,options);
    
    totalTime = [totalTime; simTime];
    numIndCurrent = [numIndCurrent; stateSpace(:,1)];
    numIndVoltage = [numIndVoltage; stateSpace(:,2)];
       
    % Analytic Solution
    
   analyticIndCurrent = (stateVariables(:,1))*exp(-RTH*(simTime-initTime)/L) + (VTH/RTH)*(1 - exp(-RTH*(simTime-initTime)/L));
   analyticIndVoltage = stateVariables(:,2) * exp(-RTH*(simTime - initTime)/L);
    
   analyticSolution = [analyticSolution; analyticIndCurrent analyticIndVoltage];
    
    
    % Variables reset for next iteration
    
    V = -V;
    VTH = -VTH;
    initTime = finalTime;
    stateVariables = [numIndCurrent(end) VTH-numIndCurrent(end)*RTH];
end

% Plotting process

 figure(1);
 plot(totalTime,numIndCurrent, 'r' ,totalTime, analyticSolution(:,1), currentTime+0.001480, currentInductor/R2);
 title('Corriente en el inductor')
 legend('Solucion numerica','Solucion analitica');
 xlabel('t(s)')
 ylabel('Il(A)')
 grid on;
 
 figure(2);
 plot(totalTime,numIndVoltage, 'r', totalTime, analyticSolution(:,2),'b', voltageTime+0.001960, voltageInductor, 'g')
 title('Voltaje en el inductor')
 legend('Solucion numerica','Solucion analitica');
 xlabel('t(s)');
 ylabel('Vl(V)');
 grid on;
 
