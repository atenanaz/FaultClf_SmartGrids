clear
clc
close all

% Created by: Fatemeh Nazary, 
%            Jan 15, 2022 
% 
% Information: there are three classification task here which shown by
% "trgClf": location classification, Fault type classification, and joint
% fault type-location classification.
% Here we used the GoogleNet pretrianed network.
% Input:
%      subfolders of location, type and joint classification.(MATLAB datastore class, requires images to be
%      organized in subfolders where each sub-folder is a class labels)
%
% Output:
%      .Mat file that stored classification result.




trgClf = {'location_cropped_ExcludRes','Type_cropped_ExcludRes','joint_Type_Loc_cropped_ExcludRes'};
taskNo = 3;
MaxEpochs = 25;
% batchSize = 256;

for lr = [1e-3]
    for valFreq = [15]
        for batchSize = [128]
            fldName = ['/Users/MyHome/Documents/PhD_DataSets/0-ESWA21_IEEE13Spectrogram/Revision_1/Spectrograms/Spects_divided_by_task/FinalData_' trgClf{taskNo} '/'];
            imds = imageDatastore(fullfile(fldName),'IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames');

            rng default
            [imgsTrain,imgsTest] = splitEachLabel(imds,0.7,'randomized');
            disp(['Number of training images: ',num2str(numel(imgsTrain.Files))]);
            disp(['Number of Test images: ',num2str(numel(imgsTest.Files))]);

            augimgsTrain = augmentedImageDatastore([224 224 3],imgsTrain);
            augimgsTest = augmentedImageDatastore([224 224 3],imgsTest);

            net = googlenet;

            lgraph = layerGraph(net);
            numberOfLayers = numel(lgraph.Layers);
            figure('Units','normalized','Position',[0.1 0.1 0.8 0.8]);
            plot(lgraph)
            title(['GoogLeNet Layer Graph: ',num2str(numberOfLayers),' Layers']);

            newDropoutLayer = dropoutLayer(0.6,'Name','new_Dropout');
            lgraph = replaceLayer(lgraph,'pool5-drop_7x7_s1',newDropoutLayer);

            numClasses = numel(categories(imgsTrain.Labels));
            newConnectedLayer = fullyConnectedLayer(numClasses,'Name','new_fc',...
                'WeightLearnRateFactor',5,'BiasLearnRateFactor',5);
            lgraph = replaceLayer(lgraph,'loss3-classifier',newConnectedLayer);

            newClassLayer = classificationLayer('Name','new_classoutput');
            lgraph = replaceLayer(lgraph,'output',newClassLayer);

            % MaxEpochs = 20;
            options = trainingOptions('sgdm',...
                'MiniBatchSize',batchSize,...
                'MaxEpochs',MaxEpochs,...
                'InitialLearnRate',lr,...
                'ValidationData',augimgsTest,...
                'ValidationFrequency',valFreq,...
                'Verbose',1,...
                'ExecutionEnvironment','cpu',...
                'Plots','training-progress');
            rng default
            tic
            trainedGN = trainNetwork(augimgsTrain,lgraph,options);
            t1 = toc;
            disp(['Training time (min): ',num2str(t1/60)])

            [YPred,probs] = classify(trainedGN,augimgsTest);
            accuracy = mean(YPred==imgsTest.Labels);
            disp(['GoogLeNet Accuracy: ',num2str(100*accuracy),'%'])
        end
    end
end
% 
fileName =  ['GNet_', trgClf{taskNo} , '_lr_', num2str(lr) ,'_MaxEpoch_', num2str(MaxEpochs), '_Ittr_', num2str(valFreq),'_BatchSize_', num2str(batchSize),'.mat'];
save(fileName)

% for MaxEpochs = [30]
%     for trg = trgClf
%
%        fldName = ['/Users/MyHome/Documents/PhD_DataSets/0-ESWA21_IEEE13Spectrogram/Revision_1/Spectrograms/Spects_divided_by_task/FinalData_' trg{1} '/'];
%
%         imds = imageDatastore(fullfile(fldName),...
%             'IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames');
%
%
%         rng default
%         [imgsTrain,imgsTest] = splitEachLabel(imds,0.8,'randomized');
%         disp(['Number of training images: ',num2str(numel(imgsTrain.Files))]);
%         disp(['Number of Test images: ',num2str(numel(imgsTest.Files))]);
%
%         % % imageAugmenter = imageDataAugmenter( ...
%         % %     'RandRotation',[-20,20], ...
%         % %     'RandXTranslation',[-3 3], ...
%         % %     'RandYTranslation',[-3 3]);
%         % %
%         % %
%         % % imageSize = [224 224 3];
%         % % augimds = augmentedImageDatastore(imageSize,imgsTrain,imgsTest,'DataAugmentation', imageAugmenter);
%         %
%         augimgsTrain = augmentedImageDatastore([224 224 3],imgsTrain);
%         augimgsTest = augmentedImageDatastore([224 224 3],imgsTest);
%
%         net = googlenet;
%
%         lgraph = layerGraph(net);
%         numberOfLayers = numel(lgraph.Layers);
%         figure('Units','normalized','Position',[0.1 0.1 0.8 0.8]);
%         plot(lgraph)
%         title(['GoogLeNet Layer Graph: ',num2str(numberOfLayers),' Layers']);
%
%         newDropoutLayer = dropoutLayer(0.6,'Name','new_Dropout');
%         lgraph = replaceLayer(lgraph,'pool5-drop_7x7_s1',newDropoutLayer);
%
%         numClasses = numel(categories(imgsTrain.Labels));
%         newConnectedLayer = fullyConnectedLayer(numClasses,'Name','new_fc',...
%             'WeightLearnRateFactor',5,'BiasLearnRateFactor',5);
%         lgraph = replaceLayer(lgraph,'loss3-classifier',newConnectedLayer);
%
%         newClassLayer = classificationLayer('Name','new_classoutput');
%         lgraph = replaceLayer(lgraph,'output',newClassLayer);
%
%         % MaxEpochs = 20;
%         options = trainingOptions('sgdm',...
%             'MiniBatchSize',15,...
%             'MaxEpochs',MaxEpochs,...
%             'InitialLearnRate',1e-4,...
%             'ValidationData',augimgsTest,...
%             'ValidationFrequency',10,...
%             'Verbose',1,...
%             'ExecutionEnvironment','cpu',...
%             'Plots','training-progress');
%         rng default
%         trainedGN = trainNetwork(augimgsTrain,lgraph,options);
%
%         %%
%         [YPred,probs] = classify(trainedGN,augimgsTest);
%         accuracy = mean(YPred==imgsTest.Labels);
%         disp(['GoogLeNet Accuracy: ',num2str(100*accuracy),'%'])
%         save(['trainingResults/trainedGN_Spect-IEEE34_Epoch' num2str(MaxEpochs) '_' trg{1}])
%
%     end
% end