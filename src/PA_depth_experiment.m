
%% Set up the Import Options and import the data
for i=1:72
filename = sprintf('C:/Users/Tatsuya/Matlab/Photoaccoustic/Data/20240328/All_channel (%d).csv', i);
   
opts = delimitedTextImportOptions("NumVariables", 3);
opts.DataLines = [22, 100021];
opts.Delimiter = ",";

opts.VariableNames = ["Var1", "ANALOG", "VarName3"];
opts.SelectedVariableNames = ["ANALOG", "VarName3"];
opts.VariableTypes = ["string", "double", "double"];

opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

opts = setvaropts(opts, "Var1", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "Var1", "EmptyFieldRule", "auto");


temp = readtable(filename, opts);
temp = table2array(temp);
PA_data1{i, :}=temp;

clear opts tmp

opts = delimitedTextImportOptions("NumVariables", 4);
opts.DataLines = [9, 9];
opts.Delimiter = ",";
opts.VariableNames = ["Var1", "ANALOG", "Var3", "Var4"];
opts.SelectedVariableNames = "ANALOG";
opts.VariableTypes = ["string", "double", "string", "string"];
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts = setvaropts(opts, ["Var1", "Var3", "Var4"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var1", "Var3", "Var4"], "EmptyFieldRule", "auto");

interval = readtable(filename, opts);

interval_all{i, :} = table2array(interval);

clear opts
end

%% Convert
% 
% for i=1:72
%     ch1(:, i)=PA_data1{i, 1}(:, 1);
%     ch2(:, i)=PA_data1{i, 1}(:, 2);
% 
% end
% ch1_mean=mean(ch1, 2);
% ch2_mean=mean(ch2, 2);

%%
startValue = 0;    % Starting value
increment = 10;     % Increment value ns
numElements = length(PA_data1{1, 1});  % Number of elements in the time series

% Generate the time series
timeSeries = startValue + (0:numElements-1) * increment;

fig = figure;
fig.PaperUnits      = 'centimeters';
fig.Units           = 'centimeters';
fig.Color           = 'w';
fig.InvertHardcopy  = 'off';
fig.Name            = ['Photo accoustic'];
fig.NumberTitle     = 'off';
set(fig,'defaultAxesXColor','k'); 
figure(fig);

% for i=1:163
% plot(timeSeries, ch1_mean*5+1, 'k');
% xlabel('Time(ns)')
% %plot(PA_data{i, 1}(:, 2), 'r');
% 
% end
hold on
for i=1:72

%plot(timeSeries, ch1_mean*50+0.5, 'k');
plot(timeSeries, PA_data1{i, 1}(:, 1), 'b');
xlim([0 10000])
xlabel('Time(ns)')
ylabel('Amplitude (uV)')
end


%%
fig = figure;
fig.PaperUnits      = 'centimeters';
fig.Units           = 'centimeters';
fig.Color           = 'w';
fig.InvertHardcopy  = 'off';
fig.Name            = ['Photo accoustic'];
fig.NumberTitle     = 'off';
set(fig,'defaultAxesXColor','k'); 
figure(fig);

interval=0.00000001;
Fs=1/interval;
th=0.01;

%y=highpass( PA_data2{8, 1}(:, 1), 30000000, Fs);
ch1(isinf(ch1)) = 0;
count=1;
ex_count=1;

[a, b]=envelope(abs(ch1), 70, 'peak');
subplot(3, 2, 1)

for i=1:size(a, 2)
    [spks, locs]=findpeaks((a(:, i)), 'MinPeakHeight', th);
    hold on
    if isempty(locs)==0
        idx(count, 1)= i;
        count=count+1;
        plot(locs, spks, 'o');
        
    else
        ex_idx(ex_count, 1)= i;
        ex_count=ex_count+1;

    end
    clear locs spks
end



plot(a, 'k');
ylim([0 0.02]);
%plot(ch1, 'k');
%yline(th, 'r');


yline(th, 'r')

subplot(3, 2, 2 )
plot(timeSeries,ch2, 'b');
xlim([1500 3000])

subplot(3, 2, 3)
plot(timeSeries, a(:, idx), 'k');
ylim([0 0.02]);

subplot(3, 2, 4)
plot(timeSeries, ch2(:, idx), 'b');
xlim([1500 3000])

subplot(3, 2, 5)
plot(timeSeries, a(:, ex_idx), 'k');
ylim([0 0.02]);

subplot(3, 2, 6)
plot(timeSeries, ch2(:, ex_idx), 'b');
xlim([1500 3000])

%%
% 
% % 
% fig = figure;
% fig.PaperUnits      = 'centimeters';
% fig.Units           = 'centimeters';
% fig.Color           = 'w';
% fig.InvertHardcopy  = 'off';
% fig.Name            = ['Photo accoustic'];
% fig.NumberTitle     = 'off';
% set(fig,'defaultAxesXColor','k'); 
% figure(fig);
% 
% idx_ch2=ch2(:, idx);
% plot(idx_ch2);
% hold on
% for i=1:size(idx_ch2, 2)
%     [s, l]=findpeaks(idx_ch2(:, i), 'MinPeakHeight', 0.4);
%     plot(l, s, 'o');
% end

%%
fig = figure;
fig.PaperUnits      = 'centimeters';
fig.Units           = 'centimeters';
fig.Color           = 'w';
fig.InvertHardcopy  = 'off';
fig.Name            = ['Photo accoustic'];
fig.NumberTitle     = 'off';
set(fig,'defaultAxesXColor','k'); 
figure(fig);
idx_ch2=ch2(:, idx);
idx_ch1=ch1(:, idx);

subplot(2, 1, 1)
plot(idx_ch2);
subplot(2, 1 ,2)
for i=2:size(idx_ch2, 2)
    hold on
    [Xa,Ya]=alignsignals(idx_ch2(:,1),idx_ch2(:, i), Method="npeak");
    plot(Ya)
    %xlim([100 500])
end
%%
fig = figure;
fig.PaperUnits      = 'centimeters';
fig.Units           = 'centimeters';
fig.Color           = 'w';
fig.InvertHardcopy  = 'off';
fig.Name            = ['Photo accoustic'];
fig.NumberTitle     = 'off';
set(fig,'defaultAxesXColor','k'); 
figure(fig);
subplot(3, 1, 1)
plot(timeSeries, idx_ch2);
xlim([0 3500])
subplot(3, 1, 2)

hold on
g=[1 5 8 9 16 31 39];
g_idx_ch2=idx_ch2(:,g);
g_idx_ch1=idx_ch1(:,g);

plot(timeSeries, g_idx_ch2);
xlim([0 3500])

subplot(3, 1, 3)
plot(timeSeries, sum(g_idx_ch2, 2));
xlim([0 3500])
%%

fig = figure;
fig.PaperUnits      = 'centimeters';
fig.Units           = 'centimeters';
fig.Color           = 'w';
fig.InvertHardcopy  = 'off';
fig.Name            = ['Photo accoustic'];
fig.NumberTitle     = 'off';
set(fig,'defaultAxesXColor','k'); 
figure(fig);

hold on
plot(timeSeries, ch1(:, 2)*10+0.2, 'k')
plot(timeSeries, mean(g_idx_ch2, 2), 'b');
xlim([0 5000])

%%
%% PA processing
fig = figure;
fig.PaperUnits      = 'centimeters';
fig.Units           = 'centimeters';
fig.Color           = 'w';
fig.InvertHardcopy  = 'off';
fig.Name            = ['Photo accoustic'];
fig.NumberTitle     = 'off';
set(fig,'defaultAxesXColor','k'); 
figure(fig);

e=2;
% Generate the time series
clear timeSeries b
th=0.01;
Fs          = 1/interval_all{e, :};
startValue  = 0;    % Starting value
increment   = interval_all{e, :};     % Increment value ns
numElements = length(PA_data1{e, 1}(:, 2));  % Number of elements in the time series
timeSeries  = startValue + (0:numElements-1) * increment;

subplot(2, 1, 1)
yyaxis left
plot(timeSeries, PA_data1{e, 1}(:, 2), 'b');
yyaxis right
plot(timeSeries, PA_data1{e, 1}(:, 1), 'r');

b=PA_data1{e, 1}(:, 2);
b(isinf(b)) = 0;
subplot(2, 1, 2)

%[cfs,frq] = cwt(xrec,"bump",Fs);
%cwt(b,"bump",Fs);
[cfs,frq] = cwt(b,Fs);
xrec = icwt(cfs,[],f,[50000000 70000000],'SignalMean',mean(b));


tms = (0:numel(b)-1)/Fs;
surface(tms,frq,abs(cfs))
xlabel('Time(s)')
ylabel('Frequency (Hz)')
title("Scalogram")
shading interp
colormap(jet)
clim([0 0.003])
%set(gca,"yscale","log") 
ylim([1000000 100000000])
%colorbar


%%


%%
startValue = 0;    % Starting value
increment = 10;     % Increment value ns
numElements = length(PA_data1{1, 1});  % Number of elements in the time series

% Generate the time series
timeSeries = startValue + (0:numElements-1) * increment;

fig = figure;
fig.PaperUnits      = 'centimeters';
fig.Units           = 'centimeters';
fig.Color           = 'w';
fig.InvertHardcopy  = 'off';
fig.Name            = ['Photo accoustic'];
fig.NumberTitle     = 'off';
set(fig,'defaultAxesXColor','k'); 
figure(fig);

% for i=1:163
% plot(timeSeries, ch1_mean*5+1, 'k');
% xlabel('Time(ns)')
% %plot(PA_data{i, 1}(:, 2), 'r');
% 
% end
subplot(2, 3, 1)

e=4;
%plot(timeSeries, ch1_mean*50+0.5, 'k');
plot(timeSeries,PA_data1{e, 1}(:, 2), 'b');
xlim([750000 770000])
ylim([-0.04 0.02])

xlabel('Time(ns)')
ylabel('Amplitude (uV)')

subplot(2, 3, 2)

e=8;
%plot(timeSeries, ch1_mean*50+0.5, 'k');
plot(timeSeries,PA_data1{e, 1}(:, 2), 'b');
xlim([750000 770000])
ylim([-0.04 0.02])

xlabel('Time(ns)')
ylabel('Amplitude (uV)')

subplot(2, 3, 3)

e=19; %% 200
%plot(timeSeries, ch1_mean*50+0.5, 'k');
plot(timeSeries,PA_data1{e, 1}(:, 2), 'b');
xlim([750000 770000])
ylim([-0.04 0.02])

xlabel('Time(ns)')
ylabel('Amplitude (uV)')

subplot(2, 3, 4)

e=32; %% 200
%plot(timeSeries, ch1_mean*50+0.5, 'k');
plot(timeSeries,PA_data1{e, 1}(:, 2), 'b');
xlim([750000 770000])
ylim([-0.04 0.02])

xlabel('Time(ns)')
ylabel('Amplitude (uV)')



subplot(2, 3, 5)

e=43; %% 325
%plot(timeSeries, ch1_mean*50+0.5, 'k');
plot(timeSeries,PA_data1{e, 1}(:, 2), 'b');
xlim([750000 770000])
ylim([-0.04 0.02])

xlabel('Time(ns)')
ylabel('Amplitude (uV)')

subplot(2, 3, 6)

e=61; %% 400
%plot(timeSeries, ch1_mean*50+0.5, 'k');
plot(timeSeries,PA_data1{e, 1}(:, 2), 'b');
xlim([750000 770000])
ylim([-0.04 0.02])

xlabel('Time(ns)')
ylabel('Amplitude (uV)')
%%

%%

fig = figure;
fig.PaperUnits      = 'centimeters';
fig.Units           = 'centimeters';
fig.Color           = 'w';
fig.InvertHardcopy  = 'off';
fig.Name            = ['Photo accoustic'];
fig.NumberTitle     = 'off';
set(fig,'defaultAxesXColor','k'); 
figure(fig);

clear b
e=41;
b=PA_data1{e, 1}(:, 2);
b(isinf(b)) = 0;
subplot(2, 1, 1)
plot(b)
xlim([75000 77000])

%ylim([-0.025 0.005])

%xlim([4000 4700])

subplot(2, 1, 2)
[wt,f] = cwt(b,Fs);
xrec = icwt(wt,[],f,[50000000 80000000],'SignalMean',mean(b));
plot(xrec)
xlim([75000 77000])
ylim([-0.025 0.005])
%xlim([4000 4700])

%%

%% PA processing
fig = figure;
fig.PaperUnits      = 'centimeters';
fig.Units           = 'centimeters';
fig.Color           = 'w';
fig.InvertHardcopy  = 'off';
fig.Name            = ['Photo accoustic'];
fig.NumberTitle     = 'off';
set(fig,'defaultAxesXColor','k'); 
figure(fig);

e=8;
% Generate the time series
clear timeSeries b
Fs=1/interval_all{e, :};
th=0.01;
startValue = 0;    % Starting value
increment = interval_all{e, :};     % Increment value ns
numElements = length(PA_data1{e, 1}(:, 2));  % Number of elements in the time series
timeSeries = startValue + (0:numElements-1) * increment;


subplot(2, 1, 1)
yyaxis left
plot(timeSeries, PA_data1{e, 1}(:, 1), 'b');
yyaxis right
plot(timeSeries, PA_data1{e, 1}(:, 2), 'r');

b=PA_data1{e, 1}(:, 2);
b(isinf(b)) = 0;
subplot(2, 1, 2)

[cfs,frq] = cwt(xrec,"bump",Fs);
%cwt(b,"bump",Fs);

tms = (0:numel(b)-1)/Fs;
surface(tms,frq,abs(cfs))
xlabel('Time(s)')
ylabel('Frequency (Hz)')
title("Scalogram")
shading interp
colormap(jet)
clim([0 0.03])
set(gca,"yscale","log")
ylim([10000000 100000000])

%colorbar
