%D3 Prep

%Variables
    %step 1
    Ic2 = 0.002; %Collector Current of CC Amp
    Vcc = 10; %Supply Voltage
    diode = 0.586136; %Vbe of BC547
    beta = 200; %beta value of BC547
    gain = 6; %gain of amplifier
    T = 293; %Temperature of Room
    k = 1.38064852*10^(-23); %Boltzmann
    q = 1.60217662*10^(-19); %Charge
    alpha = beta/(beta+1); %alpha value of BC547
    f = 1000; %Frequency for Capacitor calculations
    Rsource = 100; %Source Resistance

%CC Amp

    
    %step 2
    Vce2 = Vcc/2;
    Ve2 = Vce2;
    
    %step 3
    Vb2 = Ve2 + diode;
    Ib2 = Ic2/beta;
    
    %step 4
    Ir34 = 10*Ib2; %Current through Resistors R3, R4
    
    %step 5
    R4 = Vb2/Ir34;
    R3 = (Vcc/Ir34)-R4;
    
    %step 6
    Re = Ve2/Ic2;
    Rs = 1/((1/R3) + (1/R4));
    
    %step 8
    rp2 = (beta * ((k*T)/q))/Ic2;
    Rin2 = 1/((1/Rs)+(1/(rp2+Re*(beta+1))));
   
    %step 7
    %Ro2 = 1/((1/Re)+(1/((rp2 + Rs)/(beta + 1))));
    Ro2 = (Rs+rp2)/(1+beta);
    
%CE Amp
    Ic1 = 0.002; %step 13
    Rc = Rin2/10; %step 9
    Vc = 10-(Ic1*Rc);
    
    %step 10
    Re2 = Rc/gain;
    
    %step 11
    Rin = 1/((1/40000)-(1/((beta+1)*(Re2))));

    %step 13
    Ie1 = Ic1/alpha;
    Ve1 = Vc/gain;
    
    %step 16
    Vb1 = diode + Ve1; 
    ReCombined = Ve1/Ie1; %ReCombined - series resistance of Re1, Re2
    
    %step 12
    Vswing = Vcc-Vc; %Max swing voltage from the CE Amp
    
    %step 14
    Vce1 = Vc-Ve1;

    %step 15
    Re1 = ReCombined - Re2; 
    
    %step 17
    R1 = (Vce1*Rs)/Vb1; %Rs - parallel R1//R2
    R2 = (Vb1*R1)/(Vcc-Vb1); 
    rp1 = (beta * ((k*T)/q))/Ic1; 

%Capacitances
    %step 18
    Ce = 10/(2*pi*f*(1/((1/Re1)+(1/(Re2 + (rp1/(beta+1))+Rs/(beta+1))))));
    
    %step 19
    Ci = 10/(2*pi*f*(Rsource + 1/(1/Rs + 1/(rp1+(beta+1)*Re2))));


%Display Results
    display(Ic2)
    display(Ib2)
    display(Ir34)
    display(Rs)
    display(Ro2)
    display(Rin2)
    display(Rin)
    display(Ic1)
    display(Ie1)
    display(Ve1)
    display(Vb1)
    display(ReCombined)
    display(Vc)
    display(Vswing)
    display(Vce1)
    display(rp1)
    display(rp2)
    %Component Values below:
    display(R4)
    display(R3)
    display(Re)
    display(Rc)
    display(Re2)
    display(Re1)
    display(R1)
    display(R2)
    display(Ce)
    display(Ci)

    %Output impedence of the Actual Resistor values to be used
    %Actual available R values have been scaled by a factor of 8 to give 
    %   an input impedance of ~40k
    RinTest = (1/(8*68000) + 1/(8*12000) + 1/(rp1+(beta+1)*(Re2)))^(-1)
    %Use actual R1 = 560k
    %Use actual R2 = 100k