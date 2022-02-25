clear
clc
close all



% Created by: Fatemeh Nazary, 
%            Feb 5, 2022 
% 
% Information: there are three classification task here which shown by
% "trgClf": location classification, Fault type classification, and joint
% fault type-location classification.
% Here we built custom-CNN  with 4 layers (two hidden layers). number of
% neurons: 64,32
% Input:
%      subfolders of location, type and joint classification.(MATLAB datastore class, requires images to be
%      organized in subfolders where each sub-folder is a class labels)
%
% Output:
%      .Mat file that stored classification result.

for taskNo = [2]
    for lr = [0.001]
        trgClf = {'location_cropped_ExcludRes','Type_cropped_ExcludRes','joint_Type_Loc_cropped_ExcludRes'};
        %taskNo = 2;
        MaxEpochs = 15;

        fldName = ['/Users/MyHome/Documents/PhD_DataSets/0-ESWA21_IEEE13Spectrogram/Revision_1/Spectrograms/Spects_divided_by_task/FinalData_' trgClf{taskNo} '/'];
        imds = imageDatastore(fullfile(fldName),'IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames');


        rng default
        [imgsTrain,imgsTest] = splitEachLabel(imds,0.7,'randomized');
        disp(['Number of training images: ',num2str(numel(imgsTrain.Files))]);
        disp(['Number of Test images: ',num2str(numel(imgsTest.Files))]);

        imageSize = [224 224 3];
        augimgsTrain = augmentedImageDatastore(imageSize,imgsTrain);
        augimgsTest = augmentedImageDatastore(imageSize,imgsTest);


        layers = [
            imageInputLayer(imageSize)

            convolution2dLayer(9,64,'Padding','same')
            batchNormalizationLayer
            reluLayer

            maxPooling2dLayer(2,'Stride',2)

            convolution2dLayer(3,32,'Padding','same')
            batchNormalizationLayer
            reluLayer

            maxPooling2dLayer(2,'Stride',2)

            %             convolution2dLayer(3,32,'Padding','same')
            %             batchNormalizationLayer
            %             reluLayer

            fullyConnectedLayer(12)
            softmaxLayer
            classificationLayer];

        batchSize = 128;
        valFreq = floor(numel(augimgsTrain.Files)/batchSize);
        options = trainingOptions('sgdm', ...
            'MiniBatchSize',batchSize,...
            'InitialLearnRate',lr, ...
            'MaxEpochs',MaxEpochs, ...
            'Shuffle','every-epoch', ...
            'ValidationData',augimgsTest, ...
            'ValidationFrequency',valFreq, ...
            'Verbose',false, ...
            'Plots','training-progress');

        tic
        net = trainNetwork(augimgsTrain,layers,options);
        t1 = toc;


        YPred = classify(net,augimgsTest);
        accuracy = mean(YPred==imgsTest.Labels);
        disp(['GoogLeNet Accuracy: ',num2str(100*accuracy),'%'])

        fileName =  ['CostumCNN_', trgClf{taskNo} , '_lr_', num2str(lr) ,'_MaxEpoch_', num2str(MaxEpochs), '_Ittr_', num2str(valFreq),'_BatchSize_', num2str(batchSize),'.mat'];
        save(fileName)
    end
end
%
% trgClf = {'location_cropped_ExcludRes','Type_cropped_ExcludRes','joint_Type_Loc_cropped_ExcludRes'};
% taskNo = 1;
%MaxEpochs = 2;
%
% fldName = ['/Users/MyHome/Documents/PhD_DataSets/0-ESWA21_IEEE13Spectrogram/Revision_1/Spectrograms/Spects_divided_by_task/FinalData_' trgClf{taskNo} '/'];
% imds = imageDatastore(fullfile(fldName),'IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames');
%
% rng default
% [imgsTrain,imgsTest] = splitEachLabel(imds,0.7,'randomized');
% disp(['Number of training images: ',num2str(numel(imgsTrain.Files))]);
% disp(['Number of Test images: ',num2str(numel(imgsTest.Files))]);
%
% % imageSize = [28 28 1];
% imageSize = [909,719,3];
%
% augimgsTrain = augmentedImageDatastore(imageSize,imgsTrain);
% augimgsTest = augmentedImageDatastore(imageSize,imgsTest);
%
% layers = [
%     imageInputLayer(imageSize)
%
%     convolution2dLayer(3,64,'Padding','same')
%     batchNormalizationLayer
%     reluLayer
%
%     maxPooling2dLayer(2,'Stride',2)
%
% %     convolution2dLayer(3,32,'Padding','same')
% %     batchNormalizationLayer
% %     reluLayer
% %
% %     maxPooling2dLayer(2,'Stride',2)
% %
% %     convolution2dLayer(3,16,'Padding','same')
% %     batchNormalizationLayer
% %     reluLayer
%
%     fullyConnectedLayer(4)
%     softmaxLayer
%     classificationLayer];
%
% opts = trainingOptions('sgdm', ...
%     'MaxEpochs',15, ...
%     'Shuffle','every-epoch', ...
%     'Plots','training-progress', ...
%     'Verbose',false, ...
%     'ValidationData',augimgsTest);
%
% net = trainNetwork(augimgsTrain,layers,opts);
%
%
% YPred = classify(net,imdsValidation);
% YValidation = imdsValidation.Labels;
%
% accuracy = sum(YPred == YValidation)/numel(YValidation)


