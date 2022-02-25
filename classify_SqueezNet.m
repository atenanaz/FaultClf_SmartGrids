clear
clc
close all

% Created by: Fatemeh Nazary, 
%             Jan 18, 2022 
% 
% Information: there are three classification task here which shown by
% "trgClf": location classification, Fault type classification, and joint
% fault type-location classification.
% Here we used the SqueezNet pretrianed network.
% Input:
%      subfolders of location, type and joint classification.(MATLAB datastore class, requires images to be
%      organized in subfolders where each sub-folder is a class labels)
%
% Output:
%      .Mat file that stored classification result.


rng default

trgClf = {'location_cropped_ExcludRes','Type_cropped_ExcludRes','joint_Type_Loc_cropped_ExcludRes'};
taskNo = 3;
MaxEpochs = 15;

tic
for miniBatchSize = [32]

    for ilr = [1e-3]

        fldName = ['/Users/MyHome/Documents/PhD_DataSets/0-ESWA21_IEEE13Spectrogram/Revision_1/Spectrograms/Spects_divided_by_task/FinalData_' trgClf{taskNo} '/'];
        imds = imageDatastore(fullfile(fldName),'IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames');

        rng default
        [imgsTrain,imgsTest] = splitEachLabel(imds,0.7,'randomized');
        disp(['Number of training images: ',num2str(numel(imgsTrain.Files))]);
        disp(['Number of Test images: ',num2str(numel(imgsTest.Files))]);

        sqz = squeezenet;

        lgraphSqz = layerGraph(sqz);
        disp(['Number of Layers: ',num2str(numel(lgraphSqz.Layers))])

        lgraphSqz.Layers(end-5:end);
        tmpLayer = lgraphSqz.Layers(end-5);
        newDropoutLayer = dropoutLayer(0.6,'Name','new_dropout');
        lgraphSqz = replaceLayer(lgraphSqz,tmpLayer.Name,newDropoutLayer);

        numClasses = numel(categories(imgsTrain.Labels));
        tmpLayer = lgraphSqz.Layers(end-4);
        newLearnableLayer = convolution2dLayer(1,numClasses, ...
            'Name','new_conv', ...
            'WeightLearnRateFactor',10, ...
            'BiasLearnRateFactor',10);
        lgraphSqz = replaceLayer(lgraphSqz,tmpLayer.Name,newLearnableLayer);

        tmpLayer = lgraphSqz.Layers(end);
        newClassLayer = classificationLayer('Name','new_classoutput');
        lgraphSqz = replaceLayer(lgraphSqz,tmpLayer.Name,newClassLayer);

        lgraphSqz.Layers(63:68)

        augimgsTrain = augmentedImageDatastore([227 227],imgsTrain);
        augimgsTest = augmentedImageDatastore([227 227],imgsTest);

        %ilr = 3e-4;
        %miniBatchSize = 10;
        %MaxEpochs = 15;
        valFreq = floor(numel(augimgsTrain.Files)/miniBatchSize);
        opts = trainingOptions('sgdm',...
            'MiniBatchSize',miniBatchSize,...
            'MaxEpochs',MaxEpochs,...
            'InitialLearnRate',ilr,...
            'ValidationData',augimgsTest,...
            'ValidationFrequency',valFreq,...
            'Verbose',1,...
            'ExecutionEnvironment','cpu',...
            'Plots','training-progress');

        rng default
        trainedSN = trainNetwork(augimgsTrain,lgraphSqz,opts);

        [YPred,probs] = classify(trainedSN,augimgsTest);
        accuracy = mean(YPred==imgsTest.Labels);
        disp(['SqueezNet Accuracy: ',num2str(100*accuracy),'%'])
        %save(['trainingResults/trainedSN_Spect-IEEE13_Epoch' num2str(MaxEpochs) '_' trg{1}])

    end
end
t = toc;
final_test_acc = 100*accuracy;
training_time = t ;

fileName =  ['SNet_', trgClf{taskNo} , '_lr_', num2str(ilr) ,'_MaxEpoch_', num2str(MaxEpochs), '_Ittr_', num2str(valFreq),'_BatchSize_', num2str(miniBatchSize),'.mat']
save(fileName)
