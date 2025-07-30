%% Spectral Power Analysis using FieldTrip
% Step 1: Load cleaned data (already segmented into cond100 / cond200)
% Step 2: Compute power spectral density using multitaper method
% Step 3: Average power data
% Step 4: Grand average per group
% Step 5: Plotting (multiplot + topoplot)


% -------------------------------
% Parameters
% -------------------------------
cfg = [];
cfg.output     = 'pow';
cfg.channel    = 'all';
cfg.method     = 'mtmfft';
cfg.taper      = 'dpss';
cfg.keeptrials = 'yes';
cfg.foi        = 1:1:40;
cfg.tapsmofrq  = 4;
cfg.pad        = 'nextpow2';

% -------------------------------
% Example for a single subject
% -------------------------------
load('sub01_CleanData.mat'); % Contains cond100, cond200, condmerge

power_100  = ft_freqanalysis(cfg, cond100);
power_200  = ft_freqanalysis(cfg, cond200);
power_merge = ft_freqanalysis(cfg, condmerge);

% Save
save('sub01_power.mat', 'power_100', 'power_200', 'power_merge');

% -------------------------------
% Group average and grand average
% -------------------------------
% After computing power_* for all subjects, merge using:
% ft_appendfreq + ft_freqdescriptives + ft_freqgrandaverage

% Example:
cfg = [];
cfg.method = 'mean';
combined_data = ft_appendfreq([], allsub_Y100{:});
vg_Y100 = ft_freqdescriptives(cfg, combined_data);

cfg = [];
cfg.channel   = 'all';
cfg.foilim    = 'all';
cfg.keepindividual = 'no';
allsub_Y100_grand = ft_freqgrandaverage(cfg, vg_Y100);

% -------------------------------
% Plotting
% -------------------------------
cfg = [];
cfg.parameter = 'powspctrm';
cfg.xlim = [1 14];
cfg.layout = 'your_layout_path.lay';
ft_multiplotER(cfg, allsub_Y100_grand);

cfg = [];
cfg.parameter = 'powspctrm';
cfg.xlim = [8 14];
cfg.layout = 'your_layout_path.lay';
ft_topoplotTFR(cfg, allsub_Y100_grand);
