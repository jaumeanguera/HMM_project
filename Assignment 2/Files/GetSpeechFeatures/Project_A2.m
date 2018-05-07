%% Initialization
[X,fs]= audioread('../Sounds/female.wav');
figure(1), plot(X)
sound(X,fs);
%% Spectrogram
[spectgram,f,t]=GetSpeechFeatures(X,fs,0.03);
log_spectgram = log10(spectgram);
figure(2)
imagesc(t,f(1:250),log_spectgram(1:250,:));
xlabel('Time t (seconds)');
ylabel('Frequencies of the spectogram f (Hz)');
title('Spectrogram of the music signal');
%% MFCCS
ncep = 13;
[mfccs]=GetSpeechFeatures(X,fs,0.03,ncep);
mfccs = mfccs(2:end,:);
mean_mfccs = ones(ncep-1,1)*mean(mfccs,1);
mfccs = mfccs - mean_mfccs;
mfccs = mfccs./sqrt(var(mfccs,1,1));

imagesc(mfccs)
colorbar;
%% Correlation between coefficients
correlation_mfcc = corr(mfccs');
figure
imagesc(abs(correlation_mfcc))
colorbar,
xlabel('MFC coefficients(1 to 12)');
ylabel('MFC coefficients(1 to 12)');
title('Correlation between the MFCCs');

figure
correlation_spect = corr(log_spectgram');
imagesc(abs(correlation_spect))
colorbar,
xlabel('Frequency bins');
ylabel('Frequency bins');
title('Correlation between Spectrogram coefficients');
%% Paper vs plastic
load('paper_rustle.mat');
load('plastic_rustle.mat');
sound(plastic,8000);
ncep = 13;
[mfccs]=GetSpeechFeatures(plastic,8000,0.03,ncep);
mfccs = mfccs(2:end,:);
mean_mfccs = ones(ncep-1,1)*mean(mfccs,1);
mfccs = mfccs - mean_mfccs;
mfccs = mfccs./sqrt(var(mfccs,1,1));
figure
imagesc(mfccs)
colorbar;
xlabel('Time t(seconds)');
ylabel('Cepstrogram coefficients');
title('MFCC for plastic rustling');
