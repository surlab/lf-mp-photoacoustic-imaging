fig = figure;
fig.PaperUnits      = 'centimeters';
fig.Units           = 'centimeters';
fig.Color           = 'w';
fig.InvertHardcopy  = 'off';
fig.Name            = ['Photo accostic '];
fig.NumberTitle     = 'off';
set(fig,'defaultAxesXColor','k'); 
figure(fig);

img10=div_10_power100_00001;
img100=div_100_power100_00002;
img1000=div_1000_power100_00001;
img4000=div_4000_power100_00001;
divider={10, 100, 1000, 4000};

imagset={img10, img100, img1000, img4000};

reprate=400000; % Hz
pulse_interval_us=1/reprate*1000000; %2.5 us / pulse

dataarray={'Div10', 'Div100', 'Div1000', 'Div4000'};
xlim_list={[0 20000], [0 20000], [0 20000], [0 20000]};
peakIntervals_set=cell(4);
for i=1:4
subplot(4, 4, 4*i-3)

divided_pulse_interval_us=pulse_interval_us*divider{i};
Fs=1/8;
re_div=reshape(imagset{i}', 1, []);
[spks, locs]=findpeaks(double(re_div), Fs, 'MinPeakHeight',50);
peakIntervals = diff(locs);
peakIntervals_set{i}=peakIntervals;

image(imagset{i});
colormap(gray);
%re_div=img(:);
% Parameters
startValue = 0;    % Starting value
increment = 8;     % Increment value
numElements = length(re_div);  % Number of elements in the time series

% Generate the time series
timeSeries = startValue + (0:numElements-1) * increment;

% Display the time series
%disp(timeSeries);
title(dataarray{i});
subplot(4, 4, [4*i-2 4*i])

plot(timeSeries, re_div);
hold on
plot(locs, spks, 'o')
xlim([xlim_list{1, i}(1, 1) xlim_list{1, i}(1, 2)])
title(dataarray{i});
end


fig = figure;
fig.PaperUnits      = 'centimeters';
fig.Units           = 'centimeters';
fig.Color           = 'w';
fig.InvertHardcopy  = 'off';
fig.Name            = ['Photo accostic '];
fig.NumberTitle     = 'off';
set(fig,'defaultAxesXColor','k'); 
figure(fig);

% Example cell array

% Convert cell array to numeric array
data1 = cell2mat(peakIntervals_set(1, :));
data2 = cell2mat(peakIntervals_set(2, :));
data3 = cell2mat(peakIntervals_set(3, :));
data4 = cell2mat(peakIntervals_set(4, :));

data={data1, data2, data3, data4};
% Create bar graph

subplot(1, 2, 1)
hold on
x= ones(1,length(data1));
swarmchart(x, data1, '.');

x= 2*ones(1,length(data2));
swarmchart(x, data2, '.');

x= 3*ones(1,length(data3));
swarmchart(x, data3, '.');

x= 4* ones(1,length(data4));
swarmchart(x, data4, '.');

% Set x-axis labels

% Add axis labels and title
xlabel('Data Points');
ylabel('Peak interspace (us)');
%title('Div10, Div100, Div1000, Div4000 from left panel');

subplot(1, 2, 2)
hold on
x= ones(1,length(data1));
swarmchart(x, log10(data1), '.');

x= 2*ones(1,length(data2));
swarmchart(x, log10(data2), '.');

x= 3*ones(1,length(data3));
swarmchart(x, log10(data3), '.');

x= 4* ones(1,length(data4));
swarmchart(x, log10(data4), '.');

% Set x-axis labels

% Add axis labels and title
xlabel('Data Points');
ylabel('Peak interspace (us), log10');
%title('Div10, Div100, Div1000, Div4000 from left panel');
