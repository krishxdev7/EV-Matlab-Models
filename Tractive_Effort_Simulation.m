%% ELECTRIC VEHICLE - TRACTIVE EFFORT SIMULATION
clc;
clear;
close all;

%% Vehicle Parameters

m = 1200;          % Vehicle mass (kg)
g = 9.81;          % Gravity (m/s^2)
Crr = 0.012;       % Coefficient of rolling resistance
rho = 1.225;       % Air density (kg/m^3)
Cd = 0.29;         % Aerodynamic drag coefficient
A = 2.2;           % Frontal area (m^2)

theta = 0;         % Road grade angle (degrees)
theta_rad = deg2rad(theta);

%% Speed Range

v_kmph = 0:5:150;          % Vehicle speed (km/h)
v = v_kmph / 3.6;          % Convert km/h to m/s

%% Acceleration

a = 2;                     % Acceleration (m/s^2)

%% Forces

% 1. Rolling Resistance Force
Frr = Crr * m * g * cos(theta_rad);

% 2. Aerodynamic Drag Force
Fd = 0.5 * rho * Cd * A .* v.^2;

% 3. Grade Resistance Force
Fgrade = m * g * sin(theta_rad);

% 4. Acceleration Force
Facc = m * a;

% 5. Total Tractive Force
Ftotal = Frr + Fd + Fgrade + Facc;

%% Motor Power

% Mechanical power required by motor
Power_W = Ftotal .* v;

% Convert power to kW
Power_kW = Power_W / 1000;

%% Display Results

fprintf('\n');
fprintf('========================================================================================\n');
fprintf('          ELECTRIC VEHICLE TRACTIVE EFFORT SIMULATION\n');
fprintf('========================================================================================\n');

fprintf('\nVehicle Mass       : %.0f kg\n', m);
fprintf('Rolling Resistance : %.3f\n', Crr);
fprintf('Drag Coefficient   : %.2f\n', Cd);
fprintf('Frontal Area       : %.2f m^2\n', A);
fprintf('Acceleration       : %.2f m/s^2\n', a);
fprintf('Road Grade         : %.1f degrees\n', theta);

fprintf('\n');
fprintf('%8s %12s %12s %12s %12s %14s %12s\n', ...
    'Speed', 'Frr (N)', 'Fd (N)', 'Fgrade (N)', ...
    'Facc (N)', 'Ftotal (N)', 'Power (kW)');

fprintf('----------------------------------------------------------------------------------------\n');

for i = 1:length(v_kmph)

    fprintf('%8.0f %12.2f %12.2f %12.2f %12.2f %14.2f %12.2f\n', ...
        v_kmph(i), ...
        Frr, ...
        Fd(i), ...
        Fgrade, ...
        Facc, ...
        Ftotal(i), ...
        Power_kW(i));

end

%% Plot 1 - Tractive Effort Components

figure('Name','EV Tractive Effort','NumberTitle','off');

plot(v_kmph, Frr * ones(size(v_kmph)), ...
    'g-', 'LineWidth', 2);
hold on;

plot(v_kmph, Fd, ...
    'b-', 'LineWidth', 2);

plot(v_kmph, Fgrade * ones(size(v_kmph)), ...
    'k--', 'LineWidth', 2);

plot(v_kmph, Facc * ones(size(v_kmph)), ...
    'm-.', 'LineWidth', 2);

plot(v_kmph, Ftotal, ...
    'r-', 'LineWidth', 2.5);

grid on;

xlabel('Vehicle Speed (km/h)');
ylabel('Force (N)');

title('Electric Vehicle - Tractive Effort vs Speed');

legend( ...
    'Rolling Resistance', ...
    'Aerodynamic Drag', ...
    'Grade Resistance', ...
    'Acceleration Force', ...
    'Total Tractive Effort', ...
    'Location','northwest');

%% Plot 2 - Motor Power vs Speed

figure('Name','EV Motor Power','NumberTitle','off');

plot(v_kmph, Power_kW, ...
    'r-', 'LineWidth', 2.5);

grid on;

xlabel('Vehicle Speed (km/h)');
ylabel('Motor Power (kW)');

title('Electric Vehicle - Motor Power Requirement vs Speed');

%% Plot 3 - Aerodynamic Drag vs Speed

figure('Name','Aerodynamic Drag','NumberTitle','off');

plot(v_kmph, Fd, ...
    'b-', 'LineWidth', 2.5);

grid on;

xlabel('Vehicle Speed (km/h)');
ylabel('Aerodynamic Drag Force (N)');

title('Aerodynamic Drag vs Vehicle Speed');

%% Maximum Values

[maxForce, indexForce] = max(Ftotal);
[maxPower, indexPower] = max(Power_kW);

fprintf('\n========================================================================================\n');
fprintf('                     SIMULATION RESULTS\n');
fprintf('========================================================================================\n');

fprintf('Maximum Tractive Force : %.2f N\n', maxForce);
fprintf('At Speed               : %.0f km/h\n', v_kmph(indexForce));

fprintf('Maximum Motor Power    : %.2f kW\n', maxPower);
fprintf('At Speed               : %.0f km/h\n', v_kmph(indexPower));

fprintf('========================================================================================\n');