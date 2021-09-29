%% CS Selectivtity Index Calculation
%% 

signal_final = load ('Z-Score.mat'); % load data


%% CS Selectivtity Index for all electrodes

for i = 1:length(signal_final) % electrodes
        temp_1 = mean(max(signal_final{i}(1:3,:)')); % ES
        temp_2 = mean(max(signal_final{i}(4:6,:)')); % CS
        
        if (min(max(signal_final{i}(4:6,:)'))) > 2 %significant responses
           Chi_SI(i) = (temp_2 - temp_1)/(temp_2 + temp_1);
        else
           Chi_SI(i) = 0;
        end
end

