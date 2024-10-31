function myode
%declare variables global for func to call on
global tspan;
tspan = [0 1500];

global T Pl Ph fhd Vl Vh Vd;

%% Static Numbers %%

% initial conc:Low, High, Deep
X = [0.5 0.5 2.144]; %umol kg^-1

%important conversions
rho = 1.025E3; % kg m^-3, density of sea water
s_to_y = 3.15E7; % sec per 1 year, converts seconds to years

%areas
A_ocean = 349E12; %m^2, area of the ocean

%% Variables %%

% thermohaline circulation
T_Sv = 20E6; % m^3 s^-1
T = T_Sv*s_to_y*rho; %kg y^-1

%Pumps

%carbon pump
P_C = 1.0E6; %umol m^-2 y^-1
%converting carbon flux to phos
P_P = P_C/162.5; 

% Pump high lattitude 
Ph  = P_P*0.15*A_ocean; %umol P y^-1
% Pump low lattitude 
%Pl  =  P_P*A_ocean; %umol P y^-1
Pl = T*X(3); %umol P y^-1

% Mixing 
fhd_init  = 60E6; %m^3 s^-1
fhd = fhd_init*s_to_y*rho; %kg y^-1


%Volumes converted to kg

% Volume low lattitude box 
Vl  = 2.97E16*rho; %kg seawater
% Volume high lattitude reservoir 
Vh  = 1.31E16*rho; %kg seawater
% Volume Deep Ocean 
Vd  = 1.249E18*rho; %kg seawater


% solve the problem using ODE45
figure(1)
ode45(@f,tspan,X);
%set(gca,'YScale', 'log')

% --------------------------------------------------------------------------

function dydt = f(t, y)
%redeclare global vars for func to access
global T Pl Ph fhd Vl Vh Vd;

%set of diff eq
dydt = [((T*(y(3)-y(1))-Pl)/Vl)
    ((T*(y(1)-y(2))-Ph+fhd*(y(3)-y(2)))/Vh)
    ((T*(y(2)-y(3))+Pl+Ph+fhd*(y(2)-y(3)))/Vd)];

legend({'Xl', 'Xh', 'Xd'})
xlabel('Time (years)')
ylabel('umol PO4 per kg seawater')
title('PO4 Three Box Model')
%outputing in umol kg^-1