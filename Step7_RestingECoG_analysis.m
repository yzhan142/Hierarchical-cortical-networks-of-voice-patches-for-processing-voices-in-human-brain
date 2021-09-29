%% ECoG resting data analysis



%% edf file to mat file
clear
cfg=[];
file_to_load='SOZ_locolazier.edf';
cfg.dataset=file_to_load;
cfg.continuous='yes';
cfg.channel='all';
data_fil=ft_preprocessing(cfg);
data_final=data_fil.trial{1,1};
f=data_fil.fsample;

     
 %% cut stimuli into a 5 min duration, and detrend
 
 fs = data_fil.fsample;
 data_temp = data_fil.trial{1}(:,fs*60+1:fs*300);
 for i = 1:size(data_final,1)
     data_final(i,:) = (data_temp(i,:) - mean(data_temp(i,:)));
 end
 clear data_temp data_fil

 
 %% Resting Correlation delta 1-3Hz, theta 4-7 alpha 8-12 beta 12-20 gamma 20-40 highgamma 70-140
 
 %filter to different bands
 for i = 1:size(data_final,1)
     % high gamma
     temp_1 = eegfilt(data_final(i,:),fs,70,140);
     temp_2 = abs(temp_1);
     temp_3 = eegfilt(temp_2,fs,0,1); % extract envelop
     data_HG(i,:) = temp_3;
     clear temp_1 temp_2 temp_3
     
               
     % gamma
      temp_1 = eegfilt(data_final(i,:),fs,20,40);
     temp_2 = abs(temp_1);
     temp_3 = eegfilt(temp_2,fs,0,1);
     data_G(i,:) = temp_3;
     clear temp_1 temp_2 temp_3
     
      % beta
     temp_1 = eegfilt(data_final(i,:),fs,12,20);
     temp_2 = abs(temp_1);
     temp_3 = eegfilt(temp_2,fs,0,1);
     data_B(i,:) = temp_3;
     clear temp_1 temp_2 temp_3
     
     % alpha
     temp_1 = eegfilt(data_final(i,:),fs,8,12);
     temp_2 = abs(temp_1);
     temp_3 = eegfilt(temp_2,fs,0,1);
     data_A(i,:) = temp_3;
     clear temp_1 temp_2 temp_3
     
      % theta
     temp_1 = eegfilt(data_final(i,:),fs,4,7);
     temp_2 = abs(temp_1);
     temp_3 = eegfilt(temp_2,fs,0,1);
     data_T(i,:) = temp_3;
     clear temp_1 temp_2 temp_3
     
       % delta
     temp_1 = eegfilt(data_final(i,:),fs,1,3);
     temp_2 = abs(temp_1);
     temp_3 = eegfilt(temp_2,fs,0,1);
     data_D(i,:) = temp_3;
     clear temp_1 temp_2 temp_3
     
 end
 
 % correlation between different electrodes
 for i = 1:size(data_final,1)
     for j = 1:size(data_final,1)
         [temp,p] = corrcoef(data_HG(i,:),data_HG(j,:));
         CC_HG(i,j) = temp(1,2);
         CC_HG_p(i,j) = p(1,2);
         clear  temp p
         
         [temp,p] = corrcoef(data_G(i,:),data_G(j,:));
         CC_G(i,j) = temp(1,2);
         CC_G_p(i,j) = p(1,2);
         clear temp p
         
         [temp,p] = corrcoef(data_A(i,:),data_A(j,:));
         CC_A(i,j) = temp(1,2);
         CC_A_p(i,j) = p(1,2);
         clear temp p
         
         [temp,p] = corrcoef(data_B(i,:),data_B(j,:));
         CC_B(i,j) = temp(1,2);
         CC_B_p(i,j) = p(1,2);
         clear temp p
         
         [temp,p] = corrcoef(data_D(i,:),data_D(j,:));
         CC_D(i,j) = temp(1,2);
         CC_D_p(i,j) = p(1,2);
         clear temp p
         
         [temp,p] = corrcoef(data_T(i,:),data_T(j,:));
         CC_T(i,j) = temp(1,2);
         CC_T_p(i,j) = p(1,2);
         clear temp p
     end
 end
 
