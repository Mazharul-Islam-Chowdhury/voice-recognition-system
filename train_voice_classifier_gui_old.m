function train_voice_classifier_gui_old
clc; close all;

dataDir = fullfile(pwd, 'data_voice');  % Folder containing subfolders for each speaker
modelFile = 'voice_model_old.mat';

fig = figure('Name','? Train Voice Classifier (Old MATLAB)', ...
    'Position',[500 300 400 280],'Color',[1 1 1],'NumberTitle','off');

uicontrol('Style','text','String','TRAIN VOICE CLASSIFIER','FontSize',14,...
    'FontWeight','bold','BackgroundColor',[1 1 1],'Position',[80 230 250 30]);

uicontrol('Style','pushbutton','String','Train Model','FontSize',12,...
    'Position',[120 150 150 35],'Callback',@trainModel);

status = uicontrol('Style','text','String','Status: Ready','BackgroundColor',[1 1 1],...
    'ForegroundColor',[0 0.5 0],'Position',[60 100 300 25]);

    % ---------------- Callback Function ----------------
    function trainModel(~, ~)
        set(status,'String','? Training model... Please wait'); drawnow;

        % Get all speaker subfolders
        speakers = dir(dataDir);
        speakers = speakers([speakers.isdir]);
        speakers = speakers(~ismember({speakers.name},{'.','..'}));

        if isempty(speakers)
            errordlg('No dataset found! Record first.','No Data');
            return;
        end

        features = [];
        labels = {};

        % Loop through each speaker
        for s = 1:length(speakers)
            spk = speakers(s).name;
            spkDir = fullfile(dataDir, spk);
            files = dir(fullfile(spkDir, '*.wav'));

            if isempty(files)
                fprintf('?? No .wav files found for %s\n', spk);
                continue;
            end

            % Process each .wav file
            for f = 1:length(files)
                filePath = fullfile(spkDir, files(f).name); % compatible with old MATLAB
                [y, fs] = audioread(filePath);

                feat = mfcc_basic(y, fs); % Manual MFCC
                features = [features; feat];
                labels{end+1} = spk;
            end

            set(status,'String',sprintf('Processing: %s (%d/%d)', spk, s, length(speakers)));
            drawnow;
        end

        % Train KNN classifier
        Mdl = fitcknn(features, labels, 'NumNeighbors', 3);
        save(modelFile, 'Mdl', 'features', 'labels');

        set(status,'String','? Model trained and saved to voice_model_old.mat');
    end
end

% ---------------- Manual MFCC Extraction ----------------
function feat = mfcc_basic(y, fs, fsTargetLocal, numCoeffsLocal)
    if nargin < 3, fsTargetLocal = fs; end
    if nargin < 4, numCoeffsLocal = 13; end

    if size(y,2) > 1, y = mean(y,2); end
    if fs ~= fsTargetLocal
        y = resample(y, fsTargetLocal, fs);
        fs = fsTargetLocal;
    end

    y = y ./ max(1e-9, max(abs(y))); % Normalize
    y = filter([1 -0.97], 1, y);     % Pre-emphasis

    frameLen = round(0.025*fs);
    frameHop = round(0.010*fs);
    Nfft = 2^nextpow2(frameLen);

    if length(y) < frameLen
        y(end+1:frameLen) = 0;
    end

    numFrames = floor((length(y)-frameLen)/frameHop)+1;
    frames = zeros(frameLen, numFrames);

    for ii = 1:numFrames
        idx = (1:frameLen) + (ii-1)*frameHop;
        frames(:,ii) = y(idx) .* hamming(frameLen);
    end

    % Power Spectrum
    S = abs(fft(frames, Nfft)).^2;
    S = S(1:Nfft/2+1,:);

    % Mel Filterbank
    numFilters = 26;
    fmin = 0; fmax = fs/2;
    mel = @(f) 2595*log10(1 + f/700);
    invmel = @(m) 700*(10.^(m/2595)-1);
    mels = linspace(mel(fmin), mel(fmax), numFilters+2);
    hz = invmel(mels);
    bins = floor((Nfft+1)*hz/fs);

    H = zeros(numFilters, size(S,1));
    for m = 1:numFilters
        f_m_minus = bins(m);
        f_m = bins(m+1);
        f_m_plus = bins(m+2);
        for k = max(1,f_m_minus):min(size(S,1), f_m)
            H(m,k) = (k - f_m_minus) / max(1,(f_m - f_m_minus));
        end
        for k = max(1,f_m):min(size(S,1), f_m_plus)
            H(m,k) = (f_m_plus - k) / max(1,(f_m_plus - f_m));
        end
    end

    E = H*S; E(E<=1e-12) = 1e-12;
    logE = log(E);

    coeffs = dct(logE);
    coeffs = coeffs(1:numCoeffsLocal,:);
    feat = mean(coeffs,2)'; % average across frames
end
