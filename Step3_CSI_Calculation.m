%% Category Selectivtity Index Calculation
%% CSI = meanResponse(selectiveCat) - meanResponse(nonSelectiveCat)/meanResponse(selectiveCat) + meanResponse(nonSelectiveCat)

signal_final = load ('Z-Score.mat'); % load data 


%% CSI for all electrodes

for i = 1:length(signal_final) % electrodes
        temp_1 = mean(max(signal_final{i}(1:3,:)')); % ES
        temp_2 = mean(max(signal_final{i}(4:6,:)')); % CS
        temp_3 = mean(max(signal_final{i}(7:12,:)')); % NSV
        temp_4 = mean(max(signal_final{i}(13:18,:)')); % AV
        temp_5 = mean(max(signal_final{i}(19:24,:)')); % NS
        temp_6 = mean(max(signal_final{i}(25:30,:)')); % SS
        temp_all = [temp_1,temp_2,temp_3,temp_4,temp_5,temp_6];
        temp_big = find(temp_all >= mean(temp_all)); % selectiveCat
        temp_small = find(temp_all < mean(temp_all)); % nonSelectiveCat
        if (min(max(signal_final{i}(4:6,:)'))) > 2 %significant responses
           Chi_SI(i) = (mean(temp_all(temp_big)) - mean(temp_all(temp_small)))...
               /(mean(temp_all(temp_big)) + mean(temp_all(temp_small)));
        else
           Chi_SI(i) = 0;
        end
end

