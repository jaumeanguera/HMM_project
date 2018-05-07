
clc;
close all;

% Second assignment Pattern Recognition and Machine Learning Project
% Authors: Ashutosh Vaishnav and Jaume Anguera Peris
% A.2 Feature Extraction


%% ---------------- Sound Signals ----------------
show_audio_sig = 0;   % Show signals in the time domain? Yes (1) / No (0)
listen_audio = 0;     % Listen to the audio? ? Yes (1) / No (0)
winlength = 0.03;     % Window length for the spectrogram in seconds
ncep = 13;            % Number of cepstrogram coefficients
audio = 'female';     % Audio to be read? Options: female, male, or music 
%audio = 'male';
%audio = 'music';
audio_q9 = 'plastic';   % Audio to be read in q9? Options: paper or plastic
%audio_q9 = 'paper';
listen_audio_q9 = 1;  % Listen to the audio in q9? ? Yes (1) / No (0)

% Read audio file
[sig_audio,fs_audio] = audioread(['Sounds/',audio,'.wav']);


% Plot signal
if show_audio_sig
    samples_audio = length(sig_audio);         % Length audio in samples
    time = (1:samples_audio)./fs_audio*1000;   % Time in ms
    figure('Name','Plot audio signal');
    plot(time,sig_audio);
    grid on; grid minor;
    xlabel('Time t (ms)');
    ylabel('Signal amplitude');
    if (strcmp(audio,'music'))
        title([audio,' signal']);
        ylim([-0.35 0.35]);
    else
        title([audio,' speech signal']);
    end
end


% Plot audio zoomed in a particular range [t_start,t_start+50ms]
% The factor fs_audio/1000 converts milisecons into indexes, which is 
% useful for retreiving information from a vector.
if show_audio_sig
    if (strcmp(audio,'music'))
        t_start = 2300*fs_audio/1000;  % Index in 'time' vector for the starting time
        t_end = 2400*fs_audio/1000;    % Index in 'time' vector for the ending time
        figure('Name','Music signal zoomed in a particular range');
        plot(time(t_start:t_end),sig_audio(t_start:t_end));
        grid on; grid minor;
        xlabel('Time t (ms)');
        ylabel('Signal amplitude');
        title('Harmonic pattern of the music signal');
        ylim([-0.2 0.2]);

    else
        % Voiced pattern
        t_start = 30*fs_audio/1000;  % Index in 'time' vector for the starting time
        t_end = 80*fs_audio/1000;    % Index in 'time' vector fpr the ending time
        figure('Name','Speech signal zoomed in a particular range (voiced)');
        plot(time(t_start:t_end),sig_audio(t_start:t_end));
        grid on; grid minor;
        xlabel('Time t (ms)');
        ylabel('Signal amplitude');
        title(['Voiced sound of the ',audio,' speech signal']);
        ylim([-0.4 0.4]);

        % Unvoiced pattern
        t_start = 140*fs_audio/1000;  % Index in 'time' vector for the starting time
        t_end = 190*fs_audio/1000;    % Index in 'time' vector fpr the ending time
        figure('Name','Speech signal zoomed in a particular range (unvoiced)');
        plot(time(t_start:t_end),sig_audio(t_start:t_end));
        grid on; grid minor;
        xlabel('Time t (ms)');
        ylabel('Signal amplitude');
        title(['Voiced sound of the ',audio,' speech signal']);
        ylim([-0.4 0.4]);
    end
end


% Play audio file
if listen_audio
    sound(sig_audio,fs_audio);
end


% Get spectrogram and cepstrogram from GetSpeechFeaturesand 
[mfccs,spectgram,f,t] = GetSpeechFeatures(sig_audio,fs_audio,winlength,ncep);


% Show spectrogram
if (strcmp(audio,'music'))
    figure('Name','Spectogram of the music signal');
    imagesc(t,f,log10(spectgram));
    xlabel('Time t (seconds)');
    ylabel('Frequencies of the spectrogram f (Hz)');
    title('Spectogram of the music signal');
    colorbar;
else
    figure('Name',['Spectogram of the ',audio,' speech']);
    imagesc(t,f,log10(spectgram));
    xlabel('Time t (seconds)');
    ylabel('Frequencies of the spectrogram f (Hz)');
    title(['Spectogram of the ',audio,' speech']);
    colorbar;   
end


% Show cepstrogram
if (strcmp(audio,'music'))
    figure('Name','Ceptogram of the music signal');
    imagesc(zscore(mfccs(2:end,:),0,1));
    xlabel('Time t (seconds)');
    ylabel('Coefficients cepstrogram');
    title('Ceptogram of the music signal speech');
    colorbar;
else
    figure('Name',['Ceptogram of the ',audio,' speech']);
    imagesc(zscore(mfccs(2:end,:),0,1));
    xlabel('Time t (seconds)');
    ylabel('Coefficients cepstrogram');
    title(['Ceptogram of the ',audio,' speech']);
    colorbar;    
end


% Correlation analysis of the spectrogram
correlation_spect = corr(log10(spectgram)');
figure
imagesc(abs(correlation_spect))
colorbar,
xlabel('Frequency bins');
ylabel('Frequency bins');
title('Correlation between Spectrogram coefficients');

% Correlation analysis of the cepstrogram
correlation_mfcc = corr(mfccs(2:end,:)');
figure
imagesc(abs(correlation_mfcc))
colorbar,
xlabel('MFC coefficients(1 to 12)');
ylabel('MFC coefficients(1 to 12)');
title('Correlation between the MFCCs');

% Compute dynamic features of the signal
[mfccs_delta,mfccs_delta2] = GetDerivativeTypeFeatures(mfccs);

figure('Name','First derivative cepstrogram');
imagesc(zscore(mfccs_delta(2:end,:),0,1));
xlabel('Time t (seconds)');
ylabel('Coefficients first derivative cepstrogram');
title('First derivative cepstrogram');
colorbar;

figure('Name','Second derivative cepstrogram');
imagesc(zscore(mfccs_delta2(2:end,:),0,1));
xlabel('Time t (seconds)');
ylabel('Coefficients second derivative cepstrogram');
title('Second derivative cepstrogram');
colorbar;


% Comparing cepstral coefficients of paper rustling vs plastic rustling
load('Sounds/paper_rustle.mat');   % Load audio paper rustling
load('Sounds/plastic_rustle.mat'); % Load audio plastic rustling
winlength_rust = 0.03;             % Window length for the spectrogram in seconds              
fs_rust = 8000;                    % Sampling freq for the rustling audio

if listen_audio_q9
    if (strcmp(audio_q9,'paper'))
        sound(paper,fs_rust);
    else
        sound(plastic,fs_rust);
    end
end


if (strcmp(audio_q9,'paper'))
    [mfccs] = GetSpeechFeatures(paper,fs_rust,winlength_rust,ncep);
    figure('Name','Ceptogram for the paper rustling');
    imagesc(zscore(mfccs(2:end,:),0,1));
    colorbar;
    xlabel('Time t(seconds)');
    ylabel('Cepstrogram coefficients');
    title('MFCC for paper rustling');
else
    [mfccs] = GetSpeechFeatures(plastic,fs_rust,winlength_rust,ncep);
    figure('Name','Ceptogram for the plastic rustling');
    imagesc(zscore(mfccs(2:end,:),0,1));
    colorbar;
    xlabel('Time t(seconds)');
    ylabel('Cepstrogram coefficients');
    title('MFCC for plastic rustling');   
end

