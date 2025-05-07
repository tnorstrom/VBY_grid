% Script Airport Grid
% 24 point simulation, 01.00-24.00
%%
% Loadshapes Scenario Daytime Charge
% Fastcharging with high power during day 10 MW tot
loadshape1 = [0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1,...
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0].';

loadshape2 = [0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0,...
    0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0].';

loadshape3 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
    0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0].';

loadshape4 = [0, 0, 0, 0, 0, 0, 0.3, 0.3, 0, 0, 0, 0.3,...
    0.3, 0, 0, 0, 0.3, 0.3, 0, 0, 0, 0, 0, 0].'; % 300kW slow charge for smaller planes

loadshapeT = [0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1,...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0].';

% MAX Power
solarpower = 1e6;
terminalpower = 2E5; % 1300MWh per år, räknar med 75% nyttjande => 1300/6570h
batterydischarge = 5.5e5; % Batteryenergy = 2.2MWh ratio 1/4 VAttenfall UPPIS
chargepower = 1E6; % MW
batterycharge = 2e5;

% Power Curves
battery_power_curve = [0, 0, 0, 0, 0, 0, 1, 0, 0, 0,...
    0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0];%.*batterydischarge; %2.2 MWh Discharging on high power times when flight is charging

solar_power_curve = [0, 0, 0, 0, 0, 0, 0, 1, 1, 1,...
    1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0];%.*solarpower; % Uppskattad och numeriskt förenklad

%battery_charge_curve = [1, 1, 1, 1, 1, 1, 0, 0, 0, 0,...
  %  0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1].*batterycharge; %2.2 MWh
  %  Charging in night

battery_charge_curve = [0, 0, 0, 0, 0, 1, 0, 1, 1, 1,...
    1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0].*batterycharge; % Charging with PV
%%
% Loadshapes Scenario Nighttime and Daytime Charge
% Charge with lower power during night to lower demand on day 10MW tot
% 2 planes staying overnight
% Charger 1 and 2 200kw overnight,1,2 and 3 1MW during day
loadshape1 = [0, 1, 1, 1, 1, 1, 0, 0, 0, 5, 0, 5,...
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0].';

loadshape2 = [1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
    5, 0, 5, 0, 0, 0, 0, 0, 0, 0, 1, 1].';

loadshape3 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0,...
    0, 0, 0, 0, 0, 5, 0, 5, 0, 5, 0, 0].';

loadshape4 = [0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1,...
    1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0].'; % 200kW slow charge for smaller planes

loadshapeT = [0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1,...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0].';

% MAX Power
solarpower = 1e6;
terminalpower = 2E5;
batterydischarge = 5.5e5;
chargepower = 2E5; % 200kW
batterycharge = 2e5;

% Power Curves
battery_power_curve = [0, 0, 0, 0, 0, 0, 1, 0, 0, 0,...
    0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0];%2.2 MWh Discharging on high power times when flight is charging

solar_power_curve = [0, 0, 0, 0, 0, 0, 0, 1, 1, 1,...
    1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0]; % Uppskattad och numeriskt förenklad

%battery_charge_curve = [1, 1, 1, 1, 1, 1, 0, 0, 0, 0,...
 %   0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1].*batterycharge; %2.4 MWh

battery_charge_curve = [0, 0, 0, 0, 0, 1, 0, 1, 1, 1,...
   1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0].*batterycharge; % Charging with PV

%%
% Loadshapes SENSITIVITY ANALYSIS on NIGHT PV
% Charge with lower power during night to lower demand on day 10MW tot
% 2 planes staying overnight
% Charger 1 and 2 200kw overnight,1,2 and 3 1MW during day
loadshape1 = [0, 1, 1, 1, 1, 1, 0, 0, 0, 5, 0, 5,...
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0].';

loadshape2 = [1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
    5, 0, 5, 0, 0, 0, 0, 0, 0, 0, 1, 1].';

loadshape3 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0,...
    0, 0, 0, 0, 0, 5, 0, 5, 0, 5, 0, 0].';

loadshape4 = [0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1,...
    1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0].'; % 200kW slow charge for smaller planes

loadshapeT = [0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1,...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0].';

% MAX Power
solarpower = 1e6;
terminalpower = 2E5;
batterydischarge = 5.5e5;
chargepower = 2E5; % 200kW
batterycharge = 2e5;

% Power Curves
%battery_power_curve = [0, 0, 0, 0, 1, 1, 1, 0, 0, 0,...
%    0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0];%Double scenario

battery_power_curve = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0];%Half scenario

 %battery_power_curve = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
  %  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];%NO BATTERY

solar_power_curve = [0, 0, 0, 0, 0, 0, 0, 1, 1, 1,...
    1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0]; % Uppskattad och numeriskt förenklad

%battery_charge_curve = [0, 0, 0, 2, 0, 0, 0, 2, 2, 2,...
 %  2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0].*batterycharge; % Charging with PV 4.4 MWH DOUBLE

battery_charge_curve = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
   0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0].*batterycharge; % Charging with PV 1.1 MWH HALF

 %battery_charge_curve = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
  % 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0].*batterycharge; % NO BATTERY

%%
% Extract data from GEAB in VBY_grid
GEAB_power = out.outGEAB/1e6; % MW
GEAB_power = GEAB_power(1:24);
GEAB_energy = sum(GEAB_power);
disp(['Total energy use from GEAB: ', num2str(GEAB_energy),' MWh'])

%%
% Price Calculation when trained on ALL data
% Price depending on date
cost_GEAB_jan = GEAB_power.*future_price_all(25:48); 
cost_GEAB_apr = GEAB_power.*future_price_all(2185:2208);
cost_GEAB_jul = GEAB_power.*future_price_all(4369:4392);
cost_GEAB_oct = GEAB_power.*future_price_all(6576:6599);

total_cost_24h_jan = sum(cost_GEAB_jan);
total_cost_24h_apr = sum(cost_GEAB_apr);
total_cost_24h_jul = sum(cost_GEAB_jul);
total_cost_24h_oct = sum(cost_GEAB_oct);

disp('Prices after ALL data')
disp(['Total cost for January 2nd in 2030: ', num2str(total_cost_24h_jan) ,' EURO'])
disp(['Total cost for April 2nd in 2030: ', num2str(total_cost_24h_apr) ,' EURO'])
disp(['Total cost for July 2nd in 2030: ', num2str(total_cost_24h_jul) ,' EURO'])
disp(['Total cost for October 2nd in 2030: ', num2str(total_cost_24h_oct) ,' EURO'])

%%
% Price Calculation when trained on 2022 data
% Price depending on date
cost_GEAB_jan = GEAB_power.*future_price_22(25:48); 
cost_GEAB_apr = GEAB_power.*future_price_22(2185:2208);
cost_GEAB_jul = GEAB_power.*future_price_22(4369:4392);
cost_GEAB_oct = GEAB_power.*future_price_22(6576:6599);

total_cost_24h_jan = sum(cost_GEAB_jan);
total_cost_24h_apr = sum(cost_GEAB_apr);
total_cost_24h_jul = sum(cost_GEAB_jul);
total_cost_24h_oct = sum(cost_GEAB_oct);

disp('Prices after 2022 data')
disp(['Total cost for January 2nd in 2030: ', num2str(total_cost_24h_jan) ,' EURO'])
disp(['Total cost for April 2nd in 2030: ', num2str(total_cost_24h_apr) ,' EURO'])
disp(['Total cost for July 2nd in 2030: ', num2str(total_cost_24h_jul) ,' EURO'])
disp(['Total cost for October 2nd in 2030: ', num2str(total_cost_24h_oct) ,' EURO'])

%%
% Price Calculation when trained on 2017 data
% Price depending on date
cost_GEAB_jan = GEAB_power.*future_price_17(25:48); 
cost_GEAB_apr = GEAB_power.*future_price_17(2185:2208);
cost_GEAB_jul = GEAB_power.*future_price_17(4369:4392);
cost_GEAB_oct = GEAB_power.*future_price_17(6576:6599);

total_cost_24h_jan = sum(cost_GEAB_jan);
total_cost_24h_apr = sum(cost_GEAB_apr);
total_cost_24h_jul = sum(cost_GEAB_jul);
total_cost_24h_oct = sum(cost_GEAB_oct);

disp('Prices after 2017 data')
disp(['Total cost for January 2nd in 2030: ', num2str(total_cost_24h_jan) ,' EURO'])
disp(['Total cost for April 2nd in 2030: ', num2str(total_cost_24h_apr) ,' EURO'])
disp(['Total cost for July 2nd in 2030: ', num2str(total_cost_24h_jul) ,' EURO'])
disp(['Total cost for October 2nd in 2030: ', num2str(total_cost_24h_oct) ,' EURO'])

%%
% Price Calculation when trained on 2024 data
% Price depending on date
cost_GEAB_jan = GEAB_power.*future_price_24(25:48); 
cost_GEAB_apr = GEAB_power.*future_price_24(2185:2208);
cost_GEAB_jul = GEAB_power.*future_price_24(4369:4392);
cost_GEAB_oct = GEAB_power.*future_price_24(6576:6599);

total_cost_24h_jan = sum(cost_GEAB_jan);
total_cost_24h_apr = sum(cost_GEAB_apr);
total_cost_24h_jul = sum(cost_GEAB_jul);
total_cost_24h_oct = sum(cost_GEAB_oct);

disp('Prices after 2024 data')
disp(['Total cost for January 2nd in 2030: ', num2str(total_cost_24h_jan) ,' EURO'])
disp(['Total cost for April 2nd in 2030: ', num2str(total_cost_24h_apr) ,' EURO'])
disp(['Total cost for July 2nd in 2030: ', num2str(total_cost_24h_jul) ,' EURO'])
disp(['Total cost for October 2nd in 2030: ', num2str(total_cost_24h_oct) ,' EURO'])

%%
% Plot all together
plot(z,'LineWidth',1.5);
hold on
plot(zz,'LineWidth',1.5);
legend('Daytime','Nighttime')
xlabel('Time [hours]')
ylabel('MW')
title('Load demand from aircraft chargers')
grid on;
%plot(y,'LineWidth',1.5);
%plot(u,'LineWidth',1.5);
%legend('Nighttime PV','Double BESS','Half BESS','No BESS')
%t,y,u
%legend('Daytime Night','Daytime PV','Nighttime Night','Nighttime PV')
%q,w,e,r
%xlabel('Time [hours]')
%ylabel('MW')
%title('Powerflow from GEAB-grid')
%grid on;

%%
% Price per charge calculation Daytime Scenario
chargeLoad = loadshape1+loadshape2+loadshape3;
chargeLoad_power = chargeLoad.*GEAB_power;
chargeLoad_price = chargeLoad_power.*future_price_22(4369:4392); % Kollar på 2a Juli
remove_zeros = chargeLoad_price(chargeLoad_price~=0);
demand = [1.5 1.2 1.2 1.2 1.5 1.2 1.2 1.5 1.2 1.2]; % MW
charge_Demand = ones(1,length(remove_zeros));
share_of_demand = charge_Demand./demand;
price_per_charge = share_of_demand'.*remove_zeros;
avg_charge = mean(price_per_charge) 
avg_charge/30
% 79Euro snitt laddning 2022 /30 seats = 2.64 Euro per plats PV charge
% 18Euro snitt laddning 2017 /30 seats = 0.6 Euro per plats PV charge
% 22Euro snitt laddning 2024 /30 seats = 0.73 Euro per plats PV charge

% 74Euro snitt laddning 2022 /30 seats = 2.45 Euro per plats Night charge
% 17Euro snitt laddning 2017 /30 seats = 0.57 Euro per plats Night charge
% 20Euro snitt laddning 2024 /30 seats = 0.66 Euro per plats Night charge

%%
% Price per charge calculation Nighttime Scenario
chargeLoad = loadshape1+loadshape2+loadshape3;
chargeLoad_times = (chargeLoad ~= 0);
chargeLoad_power = chargeLoad_times.*GEAB_power;
chargeLoad_price = chargeLoad_power.*future_price_22(4369:4392); % Kollar på 2a Juli
remove_zeros = chargeLoad_price(chargeLoad_price~=0);
demand = [0.2 0.4 0.4 0.2 0.2 0.4 1.2 1.2 1.4 1.4 1.2 1.4 1.2 1.2 0.2 0.2]; % MW
charge_Demand = [0.2 0.4 0.4 0.2 0.2 0.2 1 1 1 1 1 1 1 1 0.2 0.2];
share_of_demand = charge_Demand./demand;
price_per_charge = share_of_demand'.*remove_zeros;
overnightplane1 = price_per_charge(2)/2+price_per_charge(3)/2+price_per_charge(4)+price_per_charge(5)+price_per_charge(6);
overnightplane2 = price_per_charge(1)+price_per_charge(2)/2+price_per_charge(3)/2+price_per_charge(15)+price_per_charge(16);
adjusted_pricepercharge = [overnightplane1 overnightplane2 price_per_charge(7:14)'];
avg_charge = mean(adjusted_pricepercharge) 
avg_charge/30
% 69Euro snitt laddning 2022 /30 seats = 2.29 Euro per plats PV charge
% 18Euro snitt laddning 2017 /30 seats = 0.61 Euro per plats PV charge
% 17Euro snitt laddning 2024 /30 seats = 0.57 Euro per plats PV charge

% 71Euro snitt laddning 2022 /30 seats = 2.37 Euro per plats Night charge
% 22Euro snitt laddning 2017 /30 seats = 0.72 Euro per plats Night charge
% 18Euro snitt laddning 2024 /30 seats = 0.61 Euro per plats Night charge