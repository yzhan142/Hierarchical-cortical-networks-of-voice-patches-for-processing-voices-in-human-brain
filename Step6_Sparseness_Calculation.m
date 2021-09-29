%% Sparseness Calculation
% based on Z-score
% only for CS condition (3 stimuli, 20 trial per each)

signal_Zscore = load ('Z-Score.mat'); % load data for single trial

r = [];
for i = 1:length(signal_Zscore) % electrode tag
    ii = 1;
    for j = 4:6 % CS condition
        for k = 1:20 % trial
            for jj = 1:size(signal_Zscore{i}{j},2) - 5
               if (signal_Zscore{i}{j}(k,jj) > 2 && min(signal_Zscore{i}{j}(k,jj:jj+5)) > 2
                   r(ii) = 1; % responsive trial
                   break;
               else
                   r(ii) = 0;
               end
            end
            ii = ii + 1;
        end
    end
    spar_n(i) = (1 - (sum(r)/60)^2/(sum(r.^2/60)))/(1-1/60);
end
