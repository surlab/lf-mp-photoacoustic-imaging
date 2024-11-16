


% This file is part of k-Wave. k-Wave is free software: you can
% redistribute it and/or modify it under the terms of the GNU Lesser
% General Public License as published by the Free Software Foundation,
% either version 3 of the License, or (at your option) any later version.
% 
% k-Wave is distributed in the hope that it will be useful, but WITHOUT ANY
% WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
% FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
% more details. 


clearvars;

% =========================================================================
% SIMULATION
% =========================================================================

% create the computational grid
Nx = 128;            % number of grid points in the x direction
Ny = 128;            % number of grid points in the y direction
Nz = 128;            % number of grid points in the z direction
dx = 10e-6;        % grid point spacing in the x direction [m]
dy = 10e-6;        % grid point spacing in the y direction [m]
dz = 10e-6;        % grid point spacing in the z direction [m]
kgrid = kWaveGrid(Nx, dx, Ny, dy, Nz, dz);

%x0 = 0.2e-3;            % x-coordinate of the box center (m)
%y0 = 0.2e-3;            % y-coordinate of the box center (m)
%width = 3.5;             % Width of the box (grid points)
%height = 25;            % Height of the box (grid points)


%WDL FFT data
L=444;

% define the properties of the propagation medium
medium.sound_speed = 1500 * ones(Nx, Ny, Nz);	% [m/s]
medium.sound_speed(1:Nx/2, :, :) = 1550;        % [m/s]
medium.density = 1000 * ones(Nx, Ny, Nz);       % [kg/m^3]
medium.density(:, Ny/4:end, :) = 1000;          % [kg/m^3]

% define a square source element
source_lateral = 1;
source_axial = 2;
source.p0 = zeros(Nx, Ny, Nz);
source.p0(Nx/2 - source_lateral:Nx/2 - source_lateral, Ny/2 - source_lateral:Ny/2 + source_lateral, Nz/2 - source_axial:Nz/2 + source_axial ) = 1;

% define a single sensor point
source_sensor_distance = 15;
sensor.mask = zeros(Nx, Nx, Nx);
sensor.mask(Nx/2, Ny/2, Nz/2+ source_sensor_distance) = 1;

% input arguments
input_args = {'PlotLayout', true,'PlotPML', false, 'RecordMovie', true,'DataCast', 'single',  'CartInterp','nearest'};

% run the simulation
sensor_data = kspaceFirstOrder3D(kgrid, medium, source, sensor, input_args{:});

%WDL FFT
Fs=600e+06;
FFT= fft(sensor_data);
P2=abs(FFT/L);
P1= P2(1:L/2+1);
P1(2:end-1)= 2*P1(2:end-1);
f=Fs*(0:(L/2))/L;
% =========================================================================
% VISUALISATION
% =========================================================================

% plot the simulation layout using voxelplot
voxelPlot(double(source.p0 | cart2grid(kgrid, sensor.mask)));
view([50, 20]);

%%
voxelPlot(double(source.p0 | cart2grid(kgrid, sensor.mask)));
view([50, 20]);

% plot the simulated sensor data
fig = figure;
fig.PaperUnits      = 'centimeters';
fig.Units           = 'centimeters';
fig.Color           = 'w';
fig.InvertHardcopy  = 'off';
fig.Name            = ['Photo accoustic'];
fig.NumberTitle     = 'off';
set(fig,'defaultAxesXColor','k'); 
figure(fig);


plot(sensor_data)
%plot(sensor_data(1,:))
title(['Sensor data'])
xlabel('time step 1.9355ns')
%%
figure;
plot(f,P1);
xlabel('f(Hz)')
ylabel('|P1(f)|')
title(['FFT'])

%%
figure;
imagesc(sensor_data, [-1, 1]);
colormap(getColorMap);
ylabel('Sensor Position');
xlabel('Time Step');
colorbar;

%%

% calculate the grid spacing based on the PPW and F0
dx = c0 / (ppw * source_f0);   % [m]

% compute the size of the grid
Nx = roundEven(axial_size / dx);
Ny = roundEven(lateral_size / dx);
Nz = Ny;

% create the computational grid
kgrid = kWaveGrid(Nx, dx, Ny, dx, Nz, dx);

% compute points per temporal period
PPP = round(ppw / cfl);

% compute corresponding time spacing
dt = 1 / (PPP * source_f0);

% create the time array using an integer number of points per period
Nt = round(t_end / dt);
kgrid.setTime(Nt, dt);

...

% record only the final few periods when the field is in steady state
sensor.record_start_index = kgrid.Nt - record_periods * PPP + 1;

...

% extract amplitude from the sensor data
amp = extractAmpPhase(sensor_data.p, 1/kgrid.dt, source_f0, ...
    'Dim', 2, 'Window', 'Rectangular', 'FFTPadding', 1);