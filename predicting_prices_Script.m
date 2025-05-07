% Electricity Prices Prediction Script
%%
addpath('Elpriser');

% Read prices from CSV
prices_2015 = format_price(readtable('/Elpriser/prices_2015.csv'));
prices_2016 = format_price(readtable('/Elpriser/prices_2016.csv'));
prices_2017 = format_price(readtable('/Elpriser/prices_2017.csv'));
prices_2018 = format_price(readtable('/Elpriser/prices_2018.csv'));
prices_2019 = format_price(readtable('/Elpriser/prices_2019.csv'));
prices_2020 = format_price(readtable('/Elpriser/prices_2020.csv'));
prices_2021 = format_price(readtable('/Elpriser/prices_2021.csv'));
prices_2022 = format_price(readtable('/Elpriser/prices_2022.csv'));
prices_2023 = format_price(readtable('/Elpriser/prices_2023.csv'));
prices_2024 = format_price(readtable('/Elpriser/prices_2024.csv'));

% Read loads from CSV
load_2015 = format_load(readtable('/Elpriser/load_2015.csv'));
load_2016 = format_load(readtable('/Elpriser/load_2016.csv'));
load_2017 = format_load(readtable('/Elpriser/load_2017.csv'));
load_2018 = format_load(readtable('/Elpriser/load_2018.csv'));
load_2019 = format_load(readtable('/Elpriser/load_2019.csv'));
load_2020 = format_load(readtable('/Elpriser/load_2020.csv'));
load_2021 = format_load(readtable('/Elpriser/load_2021.csv'));
load_2022 = format_load(readtable('/Elpriser/load_2022.csv'));
load_2023 = format_load(readtable('/Elpriser/load_2023.csv'));
load_2024 = format_load(readtable('/Elpriser/load_2024.csv'));


all_prices = [prices_2015; prices_2016; prices_2017; prices_2018;...
    prices_2019; prices_2020; prices_2021;...
    prices_2022; prices_2023; prices_2024];
length(all_prices);

all_loads = [load_2015; load_2016; load_2017; load_2018; load_2019;...
    load_2020; load_2021; load_2022; load_2023; load_2024];

% Load Prediction 2030, adding 11.8 TWh in SE3
energy_2030 = 11.8*1e6;
power_2030 = energy_2030/8760;
load_2030 = load_2024 + power_2030;

% Time Vector
time_year = (1:8760)';
time_all = (1:length(all_prices))';

% Visa de första raderna
%head(prices)
%M1 = 1;
%compare(wind35dv, AR1, AR2, AR4, AR15, M1)
% future = forecast(arx111,mydatad,12), mitten är pastData plot(future)

% Format CSV files to get prices, loads and removing skottår, Input: readtable(filename)
function price_double = format_price(csv_file)
price_only = csv_file.Day_ahead_EUR_MWh_;
feb29_hours = 1417:1440;
    if height(price_only)>8760
        data_table_without_feb29 = price_only;
        data_table_without_feb29(feb29_hours, :) = [];
        price_double = data_table_without_feb29;        
    else
    price_double = price_only;
    end
end

function load_double = format_load(csv_file)
load_only = csv_file.ActualTotalLoad_MW_;
mean_value = mean(load_only, 'omitnan');
load_only(isnan(load_only)) = mean_value;
feb29_hours = 1417:1440;
    if height(load_only)>8760
        data_table_without_feb29 = load_only;
        data_table_without_feb29(feb29_hours, :) = [];
        load_double = data_table_without_feb29;        
    else
    load_double = load_only;
    end
end

%%
% Plotting of prices and loads
figure(25)
plot(time_all/8760,all_loads)
%plot(time_all/8760,all_prices)
%ylabel('EURO/MWh ~ öre/kWh')
%xlabel('Time in years')
%title('Electricity price SE3 2015-2024')
ylabel('MW')
xlabel('Time in years')
title('Load demand in SE3 2015-2024')


% Change from hours to years as x-axis unit
startYear = 2015;
numYears = floor(max(time_all/8760)); 
yearLabels = startYear:(startYear + numYears);
xticks(1:numYears)
xticklabels(string(yearLabels))
grid on

%%
% Plot every year
% Setting up for-loop
n = 1:8760;
var = zeros(10,1);
quart = ones(10,1);
avg = zeros(10,1);
maximum = zeros(10,1);

for i=1:10
    figure(i)
    plot(time_year,all_prices(n,:))
    ylabel('EURO/MWh ~ öre/kWh')
    xlabel('Time in hours')

    % Measurements
    avg(i,:) = mean(all_prices(n,:));
    maximum(i,:) = max(all_prices(n,:));
    var(i,:) = std(all_prices(n,:));
    quart(i,:) = iqr(all_prices(n,:));
    n = n + 8760;
    year = 2014 + i;
    title('Electricity prices SE3', num2str(year))
    grid on
end

%%
% Barplot of variation, IQR and mean
figure(22)
year = 2015:2024;
b = bar(year, [var,avg,quart]);
b(1).FaceColor = 'b';  
b(2).FaceColor = 'r';  
b(3).FaceColor = 'g';  
xlabel('Year')
title('Variation, IQR and Mean')
legend('Std','Mean','IQR')
grid on

%%
% Forecasting models trained on 2022: Crazy Year. RUnna tills jag får
% önskat
models = {amx2424241};
future_input = load_2030;
future_price_22 = zeros(length(time_year)*length(models),1);
index = 1:8760;
noise_factor = 1; % Brusigare kring medelvärdet, 
time_variation_factor = 4; % Slump hur brusigt lägre toppar blir
burst_factor = 4; % Högre randompikar, > hur ofta de kommer
for i=1:1
    output = sim(models{i}, future_input);

    % Add noise to model
    residuals = resid(models{i}, load_2022, prices_2022);
    noise_std = std(residuals); 
    time_variation = abs(randn(size(output))) * time_variation_factor;  
    burst_variation = poissrnd(burst_factor, size(output)); 
    burst_variation = burst_variation .* (rand(size(output)) > 0.97);
    noise = (noise_factor * noise_std * time_variation .* burst_variation)...
        + (noise_std * randn(size(output)));  
    future_price_22(index,:) = output + noise;

    % Plot
    figure(i)
    plot(future_price_22(index,:))    
    grid on
    title(['Estimated price 2030 using model: ', models{i}.Name])
    index = index + 8760;
end

%%
% Forecasting models trained on 2017: Little variation year
models = {amx24};
future_input = load_2030;
future_price_17 = zeros(length(time_year)*length(models),1);
index = 1:8760;
noise_factor = 1;
time_variation_factor = 1;
burst_factor = 10;
for i=1:1
    output = sim(models{i}, future_input);

    % Add noise to model
    residuals = resid(models{i}, load_2017, prices_2017);
    noise_std = std(residuals); 
    time_variation = abs(randn(size(output))) * time_variation_factor;  
    burst_variation = poissrnd(burst_factor, size(output)); 
    burst_variation = burst_variation .* (rand(size(output)) > 0.99); 
    noise = (noise_factor * noise_std * time_variation .* burst_variation)...
        + (noise_std * randn(size(output)));  
    future_price_17(index,:) = output + noise;

    % Plot
    figure(i)
    plot(future_price_17(index,:))    
    grid on
    title(['Estimated price 2030 using model: ', models{i}.Name])
    index = index + 8760;
end

%%
% Forecasting models trained on 2024: Average Year
models = {amx2424};
future_input = load_2030;
future_price_24 = zeros(length(time_year)*length(models),1);
index = 1:8760;
noise_factor = 2;
time_variation_factor = 2;
burst_factor = 5;
for i=1:1
    output = sim(models{i}, future_input);

    % Add noise to model
    residuals = resid(models{i}, load_2024, prices_2024);
    noise_std = std(residuals); 
    time_variation = abs(randn(size(output))) * time_variation_factor;  
    burst_variation = poissrnd(burst_factor, size(output)); 
    burst_variation = burst_variation .* (rand(size(output)) > 0.992);
    noise = (noise_factor * noise_std * time_variation .* burst_variation)...
        + (noise_std * randn(size(output)));  
    future_price_24(index,:) = output + noise;

    % Plot
    figure(i)
    plot(future_price_24(index,:))    
    grid on
    title(['Estimated price 2030 using model: ', models{i}.Name])
    index = index + 8760;
end

%%
% Forecasting models trained on every year. Kanske inte intressant
models = {all2, all10, all16, all24, all30, all40};
future_input = load_2030;
future_price_all = zeros(length(time_year)*length(models),1);
index = 1:8760;
noise_factor = 1;
time_variation_factor = 2;
burst_factor = 4;
for i=1:6
    output = sim(models{i}, future_input);

    % Add noise to model
    residuals = resid(models{i}, all_loads, all_prices);
    noise_std = std(residuals); 
    time_variation = abs(randn(size(output))) * time_variation_factor;  
    burst_variation = poissrnd(burst_factor, size(output)); 
    burst_variation = burst_variation .* (rand(size(output)) > 0.98);
    noise = (noise_factor * noise_std * time_variation .* burst_variation)...
        + (noise_std * randn(size(output)));  
    future_price_all(index,:) = output + noise;

    % Plot
    % figure(i)
    % plot(future_price_all(index,:))    
    % grid on
    % title(['Estimated price 2030 using model: ', models{i}.Name])
    index = index + 8760;
end

%%
% Plotting new prices
plot(future_price_24);
xlabel('Time [hours]')
ylabel('EURO/MWh ~ öre/kWh')
title('Estimated price in 2030 based on 2024 data')
grid on;