%% This is a file where you define the system. It's pretty simple

% t represents the independent variable, 
% X represents the vector of state variables, 
% diff represents the first derivative of the state variables

function diffX = indEqSystem(t, X) 
    %@brief Global variables declaration
    global R V L FREQ PERIOD R1 R2 R3
    diffX = zeros(2, 1); % Here I initialize my system as a vector with two rows and one col
 
 
    % Model definition
    diffX(1) = -((R1*R2 + R1*R3 +R2*R3)/(R1 + R3))*(X(1))/L + V*(R3/(R1+R3))/L;
    diffX(2) = -(X(2)/L)*((R1*R2 + R1*R3 +R2*R3)/(R1 + R3));
end
