%% latency Calculation
%% two standard deviations from the baseline mean
% based on Z-score, for single trial  Z-score > 2 persist for 100ms
% only for CS condition

signal_Zscore = load ('Z-Score.mat'); % load data for single trial

for i = 1:size(signal_Zscore,1)   % electrode tag
    ii = 1;
    for j = 4:6    % CS condition
        for k = 1:size(signal_Zscore{i,j},1) % trial
            for jj = 1:size(signal_Zscore{i}{j},2) - 5
                if (signal_Zscore{i}{j}(k,jj) > 2 && min(signal_Zscore{i}{j}(k,jj:jj+5)) > 2)
                    latency{i}(ii)  = T(jj); % responsive trial
                    ii = ii + 1;
                    break;
                end
            end
        end
    end
end
