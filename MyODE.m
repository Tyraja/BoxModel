function rigidode

global cd cl ch t pl ph fhd vl vh vd;

cd = micromol_to_mol(2.2);           % mol/kg                  %Conc deep ocn
cl = micromol_to_mol(1.5);           % mol/kg                  %Conc low lattitude
ch = micromol_to_mol(2);            % mol/kg                  %Conc high lattitude
t = sv_to_m3_per_kg(20);             % m³/kg/s                 %thermohaline ciruclation 
pl = micromol_to_mol(12);              % mol/kg                  %pump low lattitude

% Define a range for the free variable 'ph' (high latitude pump flux)

ph = linspace(0, 10, 5);  % Example: 5 values from 0 to 10
                               % free variable           %pump high lattitude
fhd = sv_to_m3_per_kg(3);            % m³                      %Mixing 
vl = 2.97 * 10^16;                   % m³                      %Vol low latitude 
vh = 1.31 * 10^16;                   % m³                      %Vol high lattitude 
vd = 1.249 * 10^18;                  % m³                      %Vol deep ocean 


y0 = [0,0,0];


% solve the problem using ODE45
figure(1)
ode45(@f,tspan,y0);

% --------------------------------------------------------------------------

% Replace equations with variables 
function dydt = f(t,~)

global cd cl ch t pl ph fhd vl vh vd;

dydt = [
    (t * (cd - cl) - pl)/vl;
    (t * (cl - ch) - ph + fhd * (cd - ch))/vh;
    (t * (cl - cd) + pl + ph + fhd * (ch - cd))/vd;
];
