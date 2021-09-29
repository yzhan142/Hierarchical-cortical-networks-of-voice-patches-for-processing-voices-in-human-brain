function [trl event] = trialfun_ECoGTrigger(cfg)
%requiring fields:
% cfg.triggerdef.trigger_channel - trigger channel no.
% cfg.triggerdef.trigger_threshold - threshold for detecing a trigger
% cfg.triggerdef.trigger_minterval - minimal interval between triggers - to reduce mis-recognition
% for trial definition:
% cfg.trialdef.prestim - prestim time before the trigger
% cfg.trialdef.poststim - poststim time after the trigger
adjust_const = 4.095;
thr=cfg.triggerdef.trigger_threshold;
prestim=cfg.trialdef.prestim;
poststim=cfg.trialdef.poststim;
% read the header, contains the sampling frequency 
hdr=ft_read_header(cfg.headerfile, 'headerformat', cfg.headerformat);
fs=hdr.Fs;
fs = 1200;
% read the trigger channel data
cfg_tri=[];
cfg_tri.dataset=cfg.dataset;
cfg_tri.continuous = 'yes';
cfg_tri.channel = cfg.triggerdef.trigger_channel;%trigger channel
data_trigger=ft_preprocessing(cfg_tri);
tri=data_trigger.trial{1};
tri = round(adjust_const*tri);
%load the stimulus sequence
% load(cfg.triggerdef.sequencefile);


%start to search for triggers
tri_cnt = 1;
for i = 1:length(tri)-1
    if tri(i) == thr && tri(i+1) == 0
        tri_index = i;
        trl(tri_cnt,1)=tri_index-prestim*fs;
        trl(tri_cnt,2)=tri_index+poststim*fs-1;
        trl(tri_cnt,3)=-prestim*fs;
        event{tri_cnt}.eventtype='trigger';
        event{tri_cnt}.eventvalue=thr;
        tri_cnt=tri_cnt+1;
    end
end