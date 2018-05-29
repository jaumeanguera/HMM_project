
function hmm = GenerateHMM(class)

% Read all files from the class
mainDir = ['../sample_recordings/',class,'/'];
audios = dir([mainDir,'*.*']);      % Select all files from mainDir
audios = audios(4:end);             % Ignore . and .. fileNames
lenAudios = length(audios);         % Number of audios

% Parameters MFCC
winlength = 0.03;              % Window length for the spectrogram in seconds
ncep = 13;                     % Number of cepstrogram coefficients
obsData = zeros(ncep,1);       % Create initial X with the correct number of cols
lData = zeros(1,lenAudios);    % Vector with lenghts of training sub-sequences

% Compute MFCC for each audio file
for l = 1:lenAudios;
    
    % Read audio file
    [sig_audio,fs_audio] = audioread([mainDir,audios(l).name]);

    % Get cepstrogram from GetSpeechFeaturesand 
    [mfccs] = GetSpeechFeatures(sig_audio,fs_audio,winlength,ncep);
    
    obsData = [obsData mfccs];
    lData(l) = size(mfccs,2);
    
end

% Remove first column of X because it is dummy data 
obsData = obsData(:,2:end);

hmm = MakeLeftRightHMM(10,GaussD,obsData,lData);

end
