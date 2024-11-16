%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 6);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["VarName1", "Mean1", "Mean2", "Mean3", "Mean4", "Mean5"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Import the data
Results = readtable("C:\Users\Tatsuya\Matlab\Photoaccoustic\Data\20230925brainslice-gcamp6f\Results.csv", opts);
GCAMP = table2array(Results);
clear opts
%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 54);

opts.DataLines = [2, Inf];
opts.Delimiter = ",";

opts.VariableNames = ["VarName1", "Mean1", "Mean2", "Mean3", "Mean4", "Mean5", "Mean6", "Mean7", "Mean8", "Mean9", "Mean10", "Mean11", "Mean12", "Mean13", "Mean14", "Mean15", "Mean16", "Mean17", "Mean18", "Mean19", "Mean20", "Mean21", "Mean22", "Mean23", "Mean24", "Mean25", "Mean26", "Mean27", "Mean28", "Mean29", "Mean30", "Mean31", "Mean32", "Mean33", "Mean34", "Mean35", "Mean36", "Mean37", "Mean38", "Mean39", "Mean40", "Mean41", "Mean42", "Mean43", "Mean44", "Mean45", "Mean46", "Mean47", "Mean48", "Mean49", "Mean50", "Mean51", "Mean52", "Mean53"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

GCAMP2 = readtable("C:\Users\Tatsuya\Matlab\Photoaccoustic\Data\20230925brainslice-gcamp6f\Results2.csv", opts);
GCAMP2 = table2array(GCAMP2);
clear opts
%%

mean_GCAMP=mean(GCAMP, 1);
mean_GCAMP2=mean(GCAMP2, 1);


delta_GCAMP=[];
delta_GCAMP2=[];


for i=1:6
    delta_GCAMP(:, i)=GCAMP(:, i)./mean_GCAMP(:, i);

end


for i=1:54
    delta_GCAMP2(:, i)=GCAMP2(:, i)./mean_GCAMP2(:, i);

end

%substruct_NADH_1=delta_NADH_1-delta_THG_1;

% 
norm_delta_GCAMP=normalize(delta_GCAMP,"zscore");
Rcoeff_GCAMP = corrcoef(norm_delta_GCAMP);

norm_delta_GCAMP2=normalize(delta_GCAMP2,"zscore");
Rcoeff_GCAMP2 = corrcoef(norm_delta_GCAMP2);

% 
% norm_delta_THG_2=normalize(delta_THG_2,"zscore");
% Rcoeff_THG_2 = corrcoef(norm_delta_THG_2);
% 
% norm_substruct_NADH_1=normalize(substruct_NADH_1,"zscore");
% Rcoeff_sub_NADH_1 = corrcoef(norm_substruct_NADH_1);
% 
% norm_substruct_NADH_2=normalize(substruct_NADH_2,"zscore");
% Rcoeff_sub_NADH_2 = corrcoef(norm_substruct_NADH_2);

%%

fig = figure;
fig.PaperUnits      = 'centimeters';
fig.Units           = 'centimeters';
fig.Color           = 'w';
fig.InvertHardcopy  = 'off';
fig.Name            = 'NADH change';
fig.NumberTitle     = 'off';
set(fig,'defaultAxesXColor','k');
figure(fig);



for i=2:6

subplot(2, 3, i-1)
hold on
plot(delta_GCAMP(:, i), '-');

xlabel('Time (sec)')
ylabel('deltaF/F')
set(gca,'ytick',[]);
set(gca,'ycolor',[1 1 1])
set(gca,'xtick',[]);
set(gca,'xcolor',[1 1 1])

end

hold off
%legend('NADH','THG', 'Substract-NADH', 'FontSize', 10, 'Location','best')
%legend('boxoff')
%title('Neuron')

set(gca,'ytick',[]);
set(gca,'ycolor',[1 1 1])
set(gca,'xtick',[]);
set(gca,'xcolor',[1 1 1])



%%

fig = figure;
fig.PaperUnits      = 'centimeters';
fig.Units           = 'centimeters';
fig.Color           = 'w';
fig.InvertHardcopy  = 'off';
fig.Name            = 'NADH change';
fig.NumberTitle     = 'off';
set(fig,'defaultAxesXColor','k');
figure(fig);



for i=2:54

subplot(18, 3, i-1)
hold on
plot(delta_GCAMP2(:, i), '-');

xlabel('Time (sec)')
ylabel('deltaF/F')
set(gca,'ytick',[]);
set(gca,'ycolor',[1 1 1])
set(gca,'xtick',[]);
set(gca,'xcolor',[1 1 1])

end

hold off
%legend('NADH','THG', 'Substract-NADH', 'FontSize', 10, 'Location','best')
%legend('boxoff')
%title('Neuron')

set(gca,'ytick',[]);
set(gca,'ycolor',[1 1 1])
set(gca,'xtick',[]);
set(gca,'xcolor',[1 1 1])


%%

fig = figure;
fig.PaperUnits      = 'centimeters';
fig.Units           = 'centimeters';
fig.Color           = 'w';
fig.InvertHardcopy  = 'off';
fig.Name            = 'NADH change';
fig.NumberTitle     = 'off';
set(fig,'defaultAxesXColor','k');
figure(fig);


for i=1:20

subplot(4, 5, i)
hold on
plot(delta_NADH_2(:, i), '.');
plot(delta_THG_2(:, i), '.');
plot(substruct_NADH_2(:, i), '.');
xlabel('Time (sec)')
ylabel('deltaF/F')

end
hold off
legend('NADH','THG', 'Substract-NADH', 'FontSize', 10, 'Location','bestoutside')
legend('boxoff')
title('Neuron')
%%

fig = figure;
fig.PaperUnits      = 'centimeters';
fig.Units           = 'centimeters';
fig.Color           = 'w';
fig.InvertHardcopy  = 'off';
fig.Name            = 'NADH change';
fig.NumberTitle     = 'off';
set(fig,'defaultAxesXColor','k');
figure(fig);

imagesc(Rcoeff_GCAMP2);
colormap("jet");
c2=colorbar;
caxis([0 1]);