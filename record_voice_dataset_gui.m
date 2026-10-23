function record_voice_dataset_gui_old
% Compatible GUI version (uses uicontrol, not uifigure)
clc; close all;

fs = 16000;
clipSeconds = 2;
clipsPerLabel = 20;
dataDir = fullfile(pwd, 'data_voice');

% Create GUI window
fig = figure('Name', '? Voice Dataset Recorder (Old MATLAB)', ...
    'Position', [500 300 400 280], 'Color', [1 1 1], 'NumberTitle', 'off');

uicontrol('Style','text','String','VOICE DATASET RECORDER','FontSize',14, ...
    'FontWeight','bold','BackgroundColor',[1 1 1],'Position',[80 230 250 30]);

uicontrol('Style','text','String','Speaker Name:','BackgroundColor',[1 1 1], ...
    'Position',[40 190 100 20]);
nameField = uicontrol('Style','edit','Position',[150 190 180 25],'String','');

uicontrol('Style','pushbutton','String','Record 10 Clips','FontSize',12, ...
    'Position',[120 130 150 35],'Callback',@startRecording);

status = uicontrol('Style','text','String','Status: Ready','BackgroundColor',[1 1 1], ...
    'ForegroundColor',[0 0.5 0],'Position',[60 80 300 25]);

    function startRecording(~,~)
        speaker = strtrim(get(nameField,'String'));
        if isempty(speaker)
            errordlg('Please enter a speaker name first!','Missing Name');
            return;
        end

        speakerDir = fullfile(dataDir, speaker);
        if ~exist(speakerDir,'dir')
            mkdir(speakerDir);
        end

        recObj = audiorecorder(fs, 16, 1);
        set(status,'String',['Recording 20 clips for ',speaker,'...']);
        drawnow;

        for k = 1:clipsPerLabel
            set(status,'String',sprintf('Recording clip %d/%d...',k,clipsPerLabel));
            drawnow;
            recordblocking(recObj, clipSeconds);
            y = getaudiodata(recObj);
            y = y ./ max(1e-9, max(abs(y)));
            fileName = fullfile(speakerDir, sprintf('%s_%02d.wav', speaker, k));
            audiowrite(fileName, y, fs);
            pause(0.4);
        end

        set(status,'String',['? Done recording for ',speaker]);
        drawnow;
    end
end
