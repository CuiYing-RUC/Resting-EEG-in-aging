%% Functional Connectivity Visualization using NBS
% Step 1: Load precomputed connectivity matrices (one per subject)
% Step 2: Load NBS result (significant adjacency matrix)
% Step 3: Extract significant electrode pairs
% Step 4: Load EEG channel locations (from EEGLAB)
% Step 5: Visualize significant connections on topographic layout

% -------------------------------
% Load connectivity data
% -------------------------------
% Example: all_data(:,:,i) is the connectivity matrix for subject i
load('example_connectivity_data.mat');  % contains all_data [chan × chan × subjects]
idx_1 = 1:100;  % group 1 indices (e.g., younger)
idx_2 = 101:200;  % group 2 indices (e.g., older)

A_fc = all_data(:,:,idx_1);
B_fc = all_data(:,:,idx_2);

% -------------------------------
% Load NBS results
% -------------------------------
load('nbs_result_example.mat');  % contains nbs.NBS.con_mat
sig_conn = full(nbs.NBS.con_mat{1});
[node1, node2] = find(sig_conn > 0);
sig_edges = [node1 node2];  % electrode index pairs

% -------------------------------
% Load EEG channel locations
% -------------------------------
load('example_chanlocs.mat');  % contains EEG.chanlocs or chanlocs

% -------------------------------
% Count significant nodes and edges
% -------------------------------
num_edges = nnz(sig_conn);
sig_nodes = unique([find(any(sig_conn,1)), find(any(sig_conn,2))]);
num_nodes = length(sig_nodes);

fprintf('Number of significant edges: %d\n', num_edges);
fprintf('Number of significant nodes: %d\n', num_nodes);

% -------------------------------
% Prepare connection data structure
% -------------------------------
ds.chanPairs = sig_edges;
ds.connectStrength = ones(size(sig_edges,1),1);
ds.connectStrengthLimits = [0 1];

% -------------------------------
% Topographic connectivity plot
% -------------------------------
figure;
topoplot([], chanlocs, 'style', 'blank', 'electrodes', 'labels');
hold on;
topoplot_connect(ds, chanlocs);
title('Significant Connections (Older > Younger)', 'FontSize', 14);

% -------------------------------
% Optional: clean topoplot only
% -------------------------------
figure;
topoplot([], chanlocs, 'style', 'blank', 'electrodes', 'labels');
title('EEG Electrode Layout');

