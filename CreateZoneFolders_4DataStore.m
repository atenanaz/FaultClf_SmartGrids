clear
clc
close all

% Created by: Fatemeh Nazary, 
%             Dec 20, 2021 
% 
% Information: Since MATLAB datastore class, requires images to be
% organized in subfolders where each sub-folder is a class labels, this
% particular piece of code creates necessary sub-folders and copies/paste
% data into it. Here we assume the classes are 'Zone_1', 'Zone_2', 'Zone_3', 'Zone_4'

% Files stored in 'inputFld' have the following name format:
%   IEEE13_locLabel_2_mesloc_1_resistance_0.001_faultLabel_AC_voltage_phaseA.png
% 
% we read each sample file name, and identify fault location (locaLabel)
% and fault type class (faultLabel).  
%  
% Input:
%       'inputFld': folder where all images are stored. Each image has the
%                   following name format:
%       IEEE13_locLabel_1_mesloc_1_resistance_0.001_faultLabel_AC_voltage_phaseA.png (fault location: 1, fault type: AC, measurement collected from location: 1)
%       IEEE13_locLabel_2_mesloc_1_resistance_0.001_faultLabel_AC_voltage_phaseA.png (fault location: 2, fault type: AC, measurement collected from location: 1) 
%       IEEE13_locLabel_2_mesloc_1_resistance_0.001_faultLabel_AB_voltage_phaseA.png (fault location: 2, fault type: AB, measurement collected from location: 1) 
% Output:
%      Subfolders according to 'outputFolder' are created and data are copied
%      from source to output. 
%
%       'outputFolder': create images where subfolder names are class labels;
%           e.g., outputFolder/zone_1/spect_*.png (containing 4(mesloc) * 22(res) * 3(phase) * 11 (fault) = 2904  spect) 
%                 outputFolder/zone_2/spect_*.png (containing 4(mesloc) * 22(res) * 3(phase) * 11 (fault) = 2904  spect) 
%                 outputFolder/zone_3/spect_*.png (containing 4(mesloc) * 22(res) * 3(phase) * 11 (fault) = 2904  spect) 
%                 outputFolder/zone_4/spect_*.png (containing 4(mesloc) * 22(res) * 3(phase) * 11 (fault) = 2904  spect)   
%
% 


%inputFld =  '/Users/MyHome/Documents/PhD_DataSets/0-ESWA21_IEEE13Spectrogram/Revision_1/Spectrograms/All_Spects/spect_dataset_withoutRE_cropped2000';  % orginal data unsplitted
inputFld =  '/Users/MyHome/Documents/PhD_DataSets/0-ESWA21_IEEE13Spectrogram/Revision_1/Spectrograms/All_Spects/spect_dataset_withoutRE_cropped2000';  % orginal data unsplitted

% outputFld = '/Users/MyHome/Documents/PhD_DataSets/0-ESWA21_IEEE13Spectrogram/Revision_1/Spectrograms/Spects_divided_by_task/FinalData_location_cropped';
outputFld = '/Users/MyHome/Documents/PhD_DataSets/0-ESWA21_IEEE13Spectrogram/Revision_1/Spectrograms/Spects_divided_by_task/FinalData_location_cropped_ExcludRes';

for i = 1 : 4
    zoneStr = ['Zone_' num2str(i)];
    if ~exist(fullfile(outputFld, zoneStr),'dir')
           mkdir(fullfile(outputFld, zoneStr))
    end
end



I = dir(fullfile(inputFld,'*.png'));

cnt1 = 0;
cnt2 = 0;
cnt3 = 0;
cnt4 = 0;

for i = 1 : length(I)
    disp(['fileNo: ' num2str(i) ' from ' num2str(length(I)) ' copied!'])
    newStr1 = strsplit(I(i).name,'_');
     
        R = newStr1(7);


    if strcmp(R,'0.1323')
        continue
    elseif strcmp(R,'0.1848')
        continue
    elseif strcmp(R,'0.2636')
        continue
    elseif strcmp(R,'0.3687')
        continue
    elseif strcmp(R,'0.4212')
        continue
    elseif strcmp(R,'0.4737')
        continue
    elseif strcmp(R,'2')
        continue
    end

%     if R == a || b || c  || disp
%         contiue
%     end

    newStr2 = newStr1(3);
    if strcmp(newStr2,'1')        
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_1');
        copyfile(fileSource,fldDestin)
        cnt1 = cnt1+1;
    elseif strcmp(newStr2,'2')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_2');
        copyfile(fileSource,fldDestin)
        cnt2 = cnt2+1;
    elseif strcmp(newStr2,'3')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_3');
        copyfile(fileSource,fldDestin)
        cnt3 = cnt3+1;
    elseif strcmp(newStr2,'4')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_4');
        copyfile(fileSource,fldDestin)
        cnt4 = cnt4+1;
    end
    
end


disp('')
disp(['Class zone 1 ', num2str(cnt1) 'files copied.'])
disp(['Class zone 2 ', num2str(cnt2) 'files copied.'])
disp(['Class zone 3 ', num2str(cnt3) 'files copied.'])
disp(['Class zone 4 ', num2str(cnt4) 'files copied.'])

