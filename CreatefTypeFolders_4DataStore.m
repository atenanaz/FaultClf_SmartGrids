clear
clc
close all

% Created by: Fatemeh Nazary, 
%             Dec 28, 2021 
% 
% Information: Since MATLAB datastore class, requires images to be
% organized in subfolders where each sub-folder is a class labels, this
% particular piece of code creates necessary sub-folders and copies/paste
% data into it. Here we assume the classes are 'Fault_ABC','Fault_ABCG',...
%      'Fault_AB', 'Fault_AC', 'Fault_BC','Fault_ABG','Fault_ACG','Fault_BCG'
%      'Fault_AG', 'Fault_BG', 'Fault_CG'

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
%
%       'outputFolder': create images where subfolder names are class labels;
%           e.g., outputFolder/subfld1 = 'Fault_AB' images 
%                 outputFolder/subfld2 = 'Fault_ABC' images
%                 outputFolder/subfld3 = 'Fault_ABCG' images
%                 outputFolder/subfld4 = 'Fault_ABG' images  
%                 outputFolder/subfld5 = 'Fault_AC' images
%                 outputFolder/subfld6 = 'Fault_ACG' images
%                 outputFolder/subfld7 = 'Fault_AG' images 
%                 outputFolder/subfld8 = 'Fault_BC' images
%                 outputFolder/subfld9 = 'Fault_BCG' images
%                 outputFolder/subfld10 = 'Fault_BG' images 
%                 outputFolder/subfld11 = 'Fault_CG' images 
% Output:
%      Subfolders according to 'outputFolder' are created and data are copied
%      from source to output. 

inputFld =  '/Users/MyHome/Documents/PhD_DataSets/0-ESWA21_IEEE13Spectrogram/Revision_1/Spectrograms/All_Spects/spect_dataset_withoutRE_cropped2000';  % orginal data unsplitted
outputFld = '/Users/MyHome/Documents/PhD_DataSets/0-ESWA21_IEEE13Spectrogram/Revision_1/Spectrograms/Spects_divided_by_task/FinalData_Type_cropped_ExcludRes';



I = dir(fullfile(inputFld,'*.png'));


cnt1 = 0;
cnt2 = 0;
cnt3 = 0;
cnt4 = 0;
cnt5 = 0;
cnt6 = 0;
cnt7 = 0;
cnt8 = 0;
cnt9 = 0;
cnt10 = 0;
cnt11 = 0;

%tmp = [];
%for i = 1 : length(I)
    %disp(['fileNo: ' num2str(i) ' from ' num2str(length(I)) ' copied!'])
    %newStr1 = strsplit(I(i).name,'_')
    %R = str2num(newStr1{7});
    %tmp = [tmp, R];

   %if ismember(R,[0.1323, 0.1848, 0.2636, 0.3687, 0.4212, 0.4737, 2])
    % continue
    %end
%end


for i = 1 : length(I)
    disp(['fileNo: ' num2str(i) ' from ' num2str(length(I)) ' copied!'])
    newStr1 = strsplit(I(i).name,'_');
    newStr2 = newStr1(9);
    R = str2double(newStr1{7});
    if ismember(R,[0.1323, 0.1848, 0.2636, 0.3687, 0.4212, 0.4737, 2])
  
    elseif strcmp(newStr2,'ABC')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Fault_ABC');
        copyfile(fileSource,fldDestin)
        cnt1 = cnt1+1;
    elseif strcmp(newStr2,'ABCG')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Fault_ABCG');
        copyfile(fileSource,fldDestin)
        cnt2 = cnt2+1;
    elseif strcmp(newStr2,'AB')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Fault_AB');
        copyfile(fileSource,fldDestin)
        cnt3 = cnt3+1;
    elseif strcmp(newStr2,'BC')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Fault_BC');
        copyfile(fileSource,fldDestin)
        cnt4 = cnt4+1;
    elseif strcmp(newStr2,'AC')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Fault_AC');
        copyfile(fileSource,fldDestin)
        cnt5 = cnt5+1;
    elseif strcmp(newStr2,'ABG')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Fault_ABG');
        copyfile(fileSource,fldDestin)
        cnt6 = cnt6+1;
    elseif strcmp(newStr2,'BCG')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Fault_BCG');
        copyfile(fileSource,fldDestin)
        cnt7 = cnt7+1;
    elseif strcmp(newStr2,'ACG')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Fault_ACG');
        copyfile(fileSource,fldDestin)
        cnt8 = cnt8+1;
    elseif strcmp(newStr2,'AG')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Fault_AG');
        copyfile(fileSource,fldDestin)
        cnt9 = cnt9+1;
    elseif strcmp(newStr2,'BG')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Fault_BG');
        copyfile(fileSource,fldDestin)
        cnt10 = cnt10+1;
    elseif strcmp(newStr2,'CG')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Fault_CG');
        copyfile(fileSource,fldDestin)
        cnt11 = cnt11+1;
    
    end

    end



disp('')
disp(['Fault Type ABC ', num2str(cnt1) 'files copied.'])
disp(['Fault Type ABCG ', num2str(cnt2) 'files copied.'])
disp(['Fault Type AB ', num2str(cnt3) 'files copied.'])
disp(['Fault Type BC ', num2str(cnt4) 'files copied.'])
disp(['Fault Type AC ', num2str(cnt4) 'files copied.'])
disp(['Fault Type BC ', num2str(cnt4) 'files copied.'])
disp(['Fault Type ABG ', num2str(cnt4) 'files copied.'])
disp(['Fault Type BCG ', num2str(cnt4) 'files copied.'])
disp(['Fault Type ACG ', num2str(cnt4) 'files copied.'])
disp(['Fault Type AG ', num2str(cnt4) 'files copied.'])
disp(['Fault Type BG ', num2str(cnt4) 'files copied.'])
disp(['Fault Type CG ', num2str(cnt4) 'files copied.'])