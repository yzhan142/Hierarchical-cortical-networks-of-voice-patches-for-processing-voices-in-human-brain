%% load .edf data to matlab 

datasetnames_temp = [1:30];
for i =1:length(datasetnames_temp)
    datasetnames{i} = ['sti_',num2str(datasetnames_temp(i))];
end
dataset = {'voicelocalizor_1.edf','voicelocalizor_2.edf','voicelocalizor_3.edf','voicelocalizor_4.edf'};
for i=1:length(datasetnames)
    for j =1:length(dataset)
        cfg_re = [];
            cfg_re.dataset=dataset{j};
            cfg_re.continuous = 'yes';
            cfg_re.channel = 'all';%all channel
            data_fil = ft_preprocessing(cfg_re);

            %denoise 50,100,150Hz
            cfg_tmp = [];
            cfg_tmp.continuous = 'yes';
            cfg_tmp.bsfilter = 'yes';
            cfg_tmp.bsfreq = [48 52];
            cfg_tmp.detrend = 'no';
            cfg_tmp.demean = 'no';
            data_fil = ft_preprocessing(cfg_tmp,data_fil);

            cfg_tmp = [];
            cfg_tmp.continuous = 'yes';
            cfg_tmp.bsfilter = 'yes';
            cfg_tmp.bsfreq = [98 102];
            cfg_tmp.detrend = 'no';
            cfg_tmp.demean = 'no';
            data_fil = ft_preprocessing(cfg_tmp,data_fil);
        
        
        cfg=[];
        cfg.dataset = dataset{j};
        cfg.trialdef.eventtype = 'trigger'; % viewing all possible event types
        cfg.trialdef.prestim = 0.5;
        cfg.trialdef.poststim = 1.5;
        cfg.trialfun = 'trialfun_ECoGTrigger';
        cfg.triggerdef.trigger_channel = 102;
        cfg.triggerdef.trigger_threshold = i;
        cfg = ft_definetrial(cfg);
        cfg.continuous = 'yes';

        % forming datasets
        eval([num2str(datasetnames{i}) ' = ft_preprocessing(cfg);']);
        save(['trials/block',num2str(j),'/',datasetnames{i}],datasetnames{i});
        dataone = ft_redefinetrial(cfg,data_fil);
        data{j} = dataone;
    end
    data_final{i} = ft_appenddata([],data{1},data{2},data{3},data{4});
     
    
end

save(data_final,data_final);