%{
    @author Julio Manuel Paredes Lugo
    @author Elvis Jose Paez Rujano
%}


% Global variables definition
global V L FREQ PERIOD R1 R2 R3 VTH RTH

% Global variables initialization
% Here you must set the values you used during simulation
FREQ = 1017; % Frequency, it appears in the osciloscope
PERIOD = 1/FREQ;

% Resistance values
R1 = 1000;
R2 = 900;
R3 = 1000;

% Here I calculated Thevenin Resistance. It's not a mandatory action, but simplifies the problem
RTH = (R1*R3 + R2*R3 + R1*R2)/(R1+R3);

% Same with Thevenin voltage
VTH = (R3)*V/((R1+R3));

V = 4.96;
L = 41e-3;

% Initial conditions

initTime = 0;
initIndCurrent = 0;
initIndVoltage = 0;
totalTime = 0;

% Numerical solution vectors
numIndCurrent = [initIndCurrent];
numIndVoltage = [initIndVoltage];

% Analytic solution vector
stateVariables = [initIndCurrent initIndVoltage];
analyticSolution = stateVariables;

% We want to simulate two cycles, and we must set the initial conditions
% for both of them


for i = 1: 2
    
    % First Cycle Setting
    
    % Time setting 
    finalTime = initTime + PERIOD/2; % The final time of the cycle
    interval = [initTime finalTime]; 
    
    % ode23 execution and data storage
    options = odeset('RelTol',1e-6,'AbsTol',1e-6);
    [simTime, stateSpace] = ode23('indEqSystem',interval,stateVariables,options);
    
    
    % As we must compare a numerical solution and an analytical solution, we just
    % set both of them in both cycles
    
    %% The numerical solution corresponds to the one obtained using ode23
    % We've obtained the simulation time (as a vector, with a step between time units)
    % and a state space where we have both state variables (voltage and current)
    
    totalTime = [totalTime; simTime];
    numIndCurrent = [numIndCurrent; stateSpace(:,1)];
    numIndVoltage = [numIndVoltage; stateSpace(:,2)];
       
    % Analytic Solution, which corresponds to the model calculated using Maple
    
    analyticIndCurrent = (stateVariables(:,1))*exp((-RTH)*(simTime-initTime)/L) + (VTH/RTH)*(1 - exp((-RTH)*(simTime-initTime)/L));

    analyticIndVoltage = stateVariables(:,2) * exp(-RTH*(simTime - initTime)/L);
    
    analyticSolution = [analyticSolution; analyticIndCurrent analyticIndVoltage];
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Second Cycle Setting
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    
    
    V = -V; %% The input is a squared signal. The lowest value is just the highest with the sign inverted
    VTH = -VTH; %% Same goes here!
    
    % Time setting 
    initTime = finalTime; % It's obvious, the start time of the second cycle is the final of the first
    finalTime = initTime + PERIOD/2;
    interval = [initTime finalTime];
    
    % ode23 execution and data storage
    stateVariables = [numIndCurrent(end) VTH-numIndCurrent(end)*RTH];
    options = odeset('RelTol',1e-6,'AbsTol',1e-6);
    [simTime, stateSpace] = ode23('indEqSystem',interval,stateVariables,options);
    
    totalTime = [totalTime; simTime];
    numIndCurrent = [numIndCurrent; stateSpace(:,1)];
    numIndVoltage = [numIndVoltage; stateSpace(:,2)];
       
    % Analytic Solution (As you can see, the formula is actually similar )
    
   analyticIndCurrent = (stateVariables(:,1))*exp(-RTH*(simTime-initTime)/L) + (VTH/RTH)*(1 - exp(-RTH*(simTime-initTime)/L));
   analyticIndVoltage = stateVariables(:,2) * exp(-RTH*(simTime - initTime)/L);
    
   analyticSolution = [analyticSolution; analyticIndCurrent analyticIndVoltage];
    
    
    % Variables reset for next iteration. We just rollback the changes to the very
    % beginning
    
    V = -V; 
    VTH = -VTH;
    initTime = finalTime;
    stateVariables = [numIndCurrent(end) VTH-numIndCurrent(end)*RTH];
end

% Plotting process

% Take a look to those minimal values added to the current and the voltage time,
% this happens because the osciloscope and ODE23 are not completely synchronized
% you must "play" with this values to fit both plots

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
 
