
close all;
clc;


%% --------------- Record 1 second of audio ---------------
% Sampling rate in Hz
Fs = 22050;

% Bits per sampl
nBits = 8;

% Number of channels: 1 (mono) or 2 (stereo).
nChannels = 1;

% Create audiorecorder object
recObj = audiorecorder(Fs,nBits,nChannels);

% Record 1s of audio
disp('Start speaking.')
recordblocking(recObj, 1);
disp('End of Recording.');

% Play recorded audio
play(recObj);
