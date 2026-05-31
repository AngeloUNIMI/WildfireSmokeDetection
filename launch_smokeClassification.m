clc
close all
clear variables
%path
addpath('./util/');


%--------------------------------------------------------------------------
currDir = pwd;
dirFrames = [currDir '\(VID SEGM) Smoke3\Frames'];
%output dir
dirVideo = [currDir '\(VID SEGM) Smoke3'];


%--------------------------------------------------------------------------
files = dir([dirFrames '\*.jpeg']);

example = imread([dirFrames '\' files(1).name]); %'

vid.nFrames = numel(files);
vid.Height = size(example,1);
vid.Width = size(example,2);
vid.RGB = size(example,3);
vid.Fps = 7; %numero fisso


%struttura dati video
vidUnc = zeros(vid.Height,vid.Width,vid.RGB,vid.nFrames);

for i=1:numel(files)
    str = files(i).name;
    frame = imread([dirFrames '\' str]); %'
    vidUnc(:,:,:,i) = im2double(frame);
end


%SALVATAGGIO VIDEO (encoding)
% Prepare the new file.
vidObj = VideoWriter([dirVideo '\Video.avi'],'Motion JPEG AVI');
vidObj.FrameRate = vid.Fps;
open(vidObj);

for k = 1:vid.nFrames
    
    frameV = im2frame(vidUnc(:,:,:,k));
    writeVideo(vidObj,frameV);
    
    if (mod(k,10) == 0)
        fprintf(1,'%d... ',k);
    end
    if (mod(k,100) == 0)
        fprintf(1,'\n');
    end
    
    
end
fprintf(1,'\n');

close(vidObj)


%--------------------------------------------------------------------------
%training dirs
videoFile = [currDir '\(VID SEGM) Smoke3\Video.avi'];
onlyMov = 0; %usarlo solo per video contenenti il fumo
%output directory nn data
nnDir = [currDir '\(VID SEGM) Smoke3\NNData_input_App2'];

showFinal = 0;
startFt = 1;
%frame di partenza
scale01 = 0;


%---- VIDEO PARAMETERS ----
resizeV = 0;

%LOAD PARAMETERS
Bb_params

%EXECUTE
cd('./Feature_extraction')
Main_extr

cd('..')


%--------------------------------------------------------------------------
dirSegm = [currDir '\(VID SEGM) Smoke3\Segmentation'];
dirNNin = [currDir '\(VID SEGM) Smoke3\NNData_input_App2'];
%output directory nn data
dirNNout = [currDir '\(VID SEGM) Smoke3\NNData_output_App2'];

filesIn = dir([dirNNin '\*.mat']);

filesSegm = dir([dirSegm '\*.bmp']);

p = 1;

for k=frameLoad:numel(filesSegm) %facciamo partire da 5 i file segmentati
    
    str = filesSegm(k).name;
    
    strNN = filesIn(p).name;
    
    p = p + 1;
    
    frame = imread([dirSegm '\' str]); %'
    
    load([dirNNin '\' strNN]); %'
    
    %INVERSIONE
    frame = im2double(invertIm(frame));
    
    %eliminazione in modo analogo all'input
    frame(Imov) = [];
    
    nPixel = size(frame,1)*size(frame,2);
    
    outputV = reshape(frame,[1 nPixel]);
    
    if (k<10), fileName = [dirNNout '\outputV_0' num2str(k)]; end
    if (k>=10), fileName = [dirNNout '\outputV_' num2str(k)]; end
    
    if (k > frameLoad - 1)
        save(fileName,'outputV','nPixel');
    end
    
    if (mod(k,10) == 0)
        fprintf(1,'%d... ',k);
    end
    if (mod(k,100) == 0)
        fprintf(1,'\n');
    end
    
    
    
end
fprintf(1,'\n');


%--------------------------------------------------------------------------
%directories containing input vectors
inputVDirs = {...
			  [currDir '\(VID SEGM) Smoke3\NNData_input_App2']; ...
};
%respective directories containing output vectors
outputVDirs = {...
			  [currDir '\(VID SEGM) Smoke3\NNData_output_App2']; ...
};

%output directory to save the network
dirNNout = [currDir '\nets'];

%global structures
inputVT = [];
outputVT = [];

%step in loading files
stepf = 10;

cF = pwd;
%load Data
for i=1:numel(inputVDirs)

	cd(inputVDirs{i});
	filesI = dir('*.mat');
	for k=1:stepf:numel(filesI)
		load(filesI(k).name);
		clear Imov imov jmov
		inputVT = [inputVT inputV];
    end

end


for i=1:numel(outputVDirs)

	cd(outputVDirs{i});
	filesI = dir('*.mat');
	for k=1:stepf:numel(filesI)
		load(filesI(k).name);
		outputVT = [outputVT outputV];
    end

end

cd(cF)

%step in taking training data
% siftf = 87;
siftf = 1;

inputs = inputVT(:,1:siftf:end);
targets = outputVT(:,1:siftf:end);

nNeuroni = [10];
goalp = 0.0000000002;
epoche = 150;

% Create a Pattern Recognition Network
hiddenLayerSize = nNeuroni;
net = feedforwardnet(hiddenLayerSize);

net.layers{1}. transferFcn = 'tansig'; %hidden - default
net.layers{2}. transferFcn = 'purelin'; %output - default

net.trainParam.goal = goalp;
net.trainParam.epochs = epoche;

% Choose Input and Output Pre/Post-Processing Functions
% For a list of all processing functions type: help nnprocess
net.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
net.outputs{2}.processFcns = {'removeconstantrows','mapminmax'};

% Setup Division of Data for Training, Validation, Testing
% For a list of all data division functions type: help nndivide
net.divideFcn = 'dividerand';  % Divide data randomly
%net.divideMode = 'sample';  % Divide up every sample
net.divideMode = 'time';  %
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

% For help on training function 'trainlm' type: help trainlm
% For a list of all training functions type: help nntrain
net.trainFcn = 'trainlm';  % Levenberg-Marquardt

% Choose a Performance Function
% For a list of all performance functions type: help nnperformance
net.performFcn = 'mse';  % Mean squared error

% Choose Plot Functions
% For a list of all plot functions type: help nnplot
net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};

% Train the Network
[net,tr] = train(net,inputs,targets);

% Test the Network
outputs = net(inputs);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs)

% Recalculate Training, Validation and Test Performance
trainTargets = targets .* tr.trainMask{1};
valTargets = targets  .* tr.valMask{1};
testTargets = targets  .* tr.testMask{1};
trainPerformance = perform(net,trainTargets,outputs);

% View the Network
%view(net)

% Plots
% Uncomment these lines to enable various plots.
%figure, plotperform(tr)
%figure, plottrainstate(tr)
%figure, plotconfusion(targets,outputs)
%figure, ploterrhist(errors)

%Salvataggio rete
save([dirNNout '\net_ff_hidden_' num2str(hiddenLayerSize) '_' net.layers{1}.transferFcn '_' ...
      net.layers{2}.transferFcn],'net');














