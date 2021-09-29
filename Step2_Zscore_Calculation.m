%% Calculate Z-score

load('data_final.mat');

% Sampling rate
f_original = 1200;

% Re-sample rate
fs = 500;

electrode_tag = [1:102]; % electrode selected

for  j = 1:length(electrode_tag)
    for i = 1 : length(data_final)
        P_all = 0;
        for k = 1:length(data_final{i}.trial)
            temp = resample(data_final{i}.trial{k}(electrode_tag(j),:),fs,f);
            [S,F,T,P]=spectrogram(temp,200,190,1:150,fs);
            P = 10*log10(P);
            P_all = P_all + P;
            clear P
        end
        P_all = P_all/length(data_final{i}.trial);
        for ii = 1:size(P_all,1)
            for jj = 1:1:size(P_all,2)
                if(T(jj)>=0.3)
                    temp1 = jj-1;
                    break
                end
            end
            for jj = 1:1:size(P_all,2)
                if(T(jj)>=0.5)
                    temp2 = jj-1;
                    break
                end
            end
            P_temp =  mean(P_all(ii,temp1:temp2));
            P_temp_std = std(P_all(ii,temp1:temp2));
            P_all(ii,:) = P_all(ii,:) - P_temp;
            P_all(ii,:) =  P_all(ii,:)/P_temp_std;
        end
        
        T = T - 0.5;
        for iii = 1 : length(T)
            if T(iii) > -0.2
                temp_T_1 = iii-1;
                break
            end
        end
        for iii = 1 : length(T)
            if T(iii) > 0.8
                temp_T_2 = iii-1;
                break
            end
        end
        P_all_2 = P_all(:,temp_T_1:temp_T_2);
        signal_trial = mean(P_all_2(70:140,:),1); % High Gamma frequcncy rage
        signal_Zscore_temp(i,:) = signal_trial;
        clear signal_trial
    end
    signal_Zscore = signal_Zscore_temp;
    signal_Zscore_final{j} = signal_Zscore;
    T2 = T(temp_T_1:temp_T_2);
    
    clear signal_Zscore signal_Zscore_temp
end


save(signal_Zscore_final,signal_Zscore_final);
