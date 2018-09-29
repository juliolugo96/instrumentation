function diffX = indEqSystem(t, X)

    %@brief Global variables declaration

    global V L C FREQ PERIOD R1 R2 Rm;
    
    diffX = zeros(4, 1);
    
    %Il(t)
    diffX(1) = ((-R2-Rm)*R1-Rm*R2)*X(1)/(L*(R1+R2))-R1*X(4)/(L*(R1+R2))+V/L;
    %Vl(t)
    diffX(2) = -((R2+Rm)*R1+Rm*R2)*X(2)/(L*(R1+R2))-R1*X(3)/(C*(R1+R2));
    %Ic(t)
    diffX(3) = R1*X(2)/(L*(R1+R2))-X(3)/((R1+R2)*C);
    %Vc(t)
    diffX(4) = R1*X(1)/(C*(R1+R2))-X(4)/(C*(R1+R2));

end