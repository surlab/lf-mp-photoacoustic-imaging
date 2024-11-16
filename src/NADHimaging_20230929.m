opts = delimitedTextImportOptions("NumVariables", 18);
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

opts.VariableNames = ["Var1", "Mean1", "Mean2", "Mean3", "Mean4", "Mean5", "Mean6", "Mean7", "Mean8", "Mean9", "Mean10", "Mean11", "Mean12", "Mean13", "Mean14", "Mean15", "Mean16", "Mean17"];
opts.SelectedVariableNames = ["Mean1", "Mean2", "Mean3", "Mean4", "Mean5", "Mean6", "Mean7", "Mean8", "Mean9", "Mean10", "Mean11", "Mean12", "Mean13", "Mean14", "Mean15", "Mean16", "Mean17"];
opts.VariableTypes = ["string", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts = setvaropts(opts, "Var1", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "Var1", "EmptyFieldRule", "auto");

NADH_1 = readtable("C:\Users\Tatsuya\Matlab\Photoaccoustic\Data\20230928brainslice-nadhimaging-wildtype\Results_NADH_1.csv", opts);

NADH_1 = table2array(NADH_1);

clear opts

opts = delimitedTextImportOptions("NumVariables", 18);
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

opts.VariableNames = ["Var1", "Mean1", "Mean2", "Mean3", "Mean4", "Mean5", "Mean6", "Mean7", "Mean8", "Mean9", "Mean10", "Mean11", "Mean12", "Mean13", "Mean14", "Mean15", "Mean16", "Mean17"];
opts.SelectedVariableNames = ["Mean1", "Mean2", "Mean3", "Mean4", "Mean5", "Mean6", "Mean7", "Mean8", "Mean9", "Mean10", "Mean11", "Mean12", "Mean13", "Mean14", "Mean15", "Mean16", "Mean17"];
opts.VariableTypes = ["string", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts = setvaropts(opts, "Var1", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "Var1", "EmptyFieldRule", "auto");

THG_1 = readtable("C:\Users\Tatsuya\Matlab\Photoaccoustic\Data\20230928brainslice-nadhimaging-wildtype\Results_THG_1.csv", opts);

THG_1 = table2array(THG_1);

clear opts

%%

opts = delimitedTextImportOptions("NumVariables", 22);

opts.DataLines = [2, Inf];
opts.Delimiter = ",";
opts.VariableNames = ["Var1", "Mean1", "Mean2", "Mean3", "Mean4", "Mean5", "Mean6", "Mean7", "Mean8", "Mean9", "Mean10", "Mean11", "Mean12", "Mean13", "Mean14", "Mean15", "Mean16", "Mean17", "Mean18", "Mean19", "Mean20", "Mean21"];
opts.SelectedVariableNames = ["Mean1", "Mean2", "Mean3", "Mean4", "Mean5", "Mean6", "Mean7", "Mean8", "Mean9", "Mean10", "Mean11", "Mean12", "Mean13", "Mean14", "Mean15", "Mean16", "Mean17", "Mean18", "Mean19", "Mean20", "Mean21"];
opts.VariableTypes = ["string", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

opts = setvaropts(opts, "Var1", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "Var1", "EmptyFieldRule", "auto");

NADH_2 = readtable("C:\Users\Tatsuya\Matlab\Photoaccoustic\Data\20230928brainslice-nadhimaging-wildtype\Results_NADH_2.csv", opts);

NADH_2 = table2array(NADH_2);

clear opts

opts = delimitedTextImportOptions("NumVariables", 22);

opts.DataLines = [2, Inf];
opts.Delimiter = ",";
opts.VariableNames = ["Var1", "Mean1", "Mean2", "Mean3", "Mean4", "Mean5", "Mean6", "Mean7", "Mean8", "Mean9", "Mean10", "Mean11", "Mean12", "Mean13", "Mean14", "Mean15", "Mean16", "Mean17", "Mean18", "Mean19", "Mean20", "Mean21"];
opts.SelectedVariableNames = ["Mean1", "Mean2", "Mean3", "Mean4", "Mean5", "Mean6", "Mean7", "Mean8", "Mean9", "Mean10", "Mean11", "Mean12", "Mean13", "Mean14", "Mean15", "Mean16", "Mean17", "Mean18", "Mean19", "Mean20", "Mean21"];
opts.VariableTypes = ["string", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

opts = setvaropts(opts, "Var1", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "Var1", "EmptyFieldRule", "auto");

THG_2 = readtable("C:\Users\Tatsuya\Matlab\Photoaccoustic\Data\20230928brainslice-nadhimaging-wildtype\Results_THG_2.csv", opts);

THG_2 = table2array(THG_2);

clear opts
%%

mean_NADH_1=mean(NADH_1, 1);
mean_NADH_2=mean(NADH_2, 1);
mean_THG_1=mean(THG_1, 1);
mean_THG_2=mean(THG_2, 1);

delta_NADH_1=[];
delta_NADH_2=[];
delta_THG_1=[];
delta_THG_2=[];

for i=1:17
    delta_NADH_1(:, i)=NADH_1(:, i)./mean_NADH_1(:, i);
    delta_THG_1(:, i)=THG_1(:, i)./mean_THG_1(:, i);

end
for i=1:21
    delta_NADH_2(:, i)=NADH_2(:, i)./mean_NADH_2(:, i);
    delta_THG_2(:, i)=THG_2(:, i)./mean_THG_2(:, i);

end


substruct_NADH_1=delta_NADH_1-delta_THG_1;
substruct_NADH_2=delta_NADH_2-delta_THG_2;


norm_delta_NADH_1=normalize(delta_NADH_1,"zscore");
Rcoeff_NADH_1 = corrcoef(norm_delta_NADH_1);

norm_delta_NADH_2=normalize(delta_NADH_2,"zscore");
Rcoeff_NADH_2 = corrcoef(norm_delta_NADH_2);

norm_delta_THG_2=normalize(delta_THG_2,"zscore");
Rcoeff_THG_2 = corrcoef(norm_delta_THG_2);

norm_substruct_NADH_1=normalize(substruct_NADH_1,"zscore");
Rcoeff_sub_NADH_1 = corrcoef(norm_substruct_NADH_1);

norm_substruct_NADH_2=normalize(substruct_NADH_2,"zscore");
Rcoeff_sub_NADH_2 = corrcoef(norm_substruct_NADH_2);



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



for i=1:16

subplot(4, 4, i)
hold on
plot(delta_NADH_1(:, i), '.');
plot(delta_THG_1(:, i), '.');
plot(substruct_NADH_1(:, i), '.');

xlabel('Time (sec)')
ylabel('deltaF/F')

set(gca,'ytick',[]);
set(gca,'ycolor',[1 1 1])
set(gca,'xtick',[]);
set(gca,'xcolor',[1 1 1])

end

hold off
legend('NADH','THG', 'Substract-NADH', 'FontSize', 10, 'Location','best')
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


for i=1:20

subplot(4, 5, i)
hold on
plot(delta_NADH_2(:, i), '-');
plot(delta_THG_2(:, i), '-');
plot(substruct_NADH_2(:, i), '-');
xlabel('Time (sec)')
ylabel('deltaF/F')

set(gca,'ytick',[]);
set(gca,'ycolor',[1 1 1])
set(gca,'xtick',[]);
set(gca,'xcolor',[1 1 1])


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

imagesc(Rcoeff_sub_NADH_1);
colormap("jet");
c2=colorbar;
caxis([0.2 0.8]);