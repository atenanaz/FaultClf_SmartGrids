clear
clc
close all

% Created by: Fatemeh Nazary, 
%             Dec 28, 2021 
% 
% Information: Since MATLAB datastore class, requires images to be
% organized in subfolders where each sub-folder is a class labels, this
% particular piece of code creates necessary sub-folders and copies/paste
% data into it. Here we assume the classes are 'Zone_1', 'Zone_2', 'Zone_3', 'Zone_4'
% and each zone has 11 classes of faults.
%
% Files stored in 'inputFld' have the following name format:
%   IEEE13_locLabel_2_mesloc_1_resistance_0.001_faultLabel_AC_voltage_phaseA.png
% 
% we read each sample file name, and identify fault location (locaLabel)
% and fault type class (faultLabel) together.  
%  
% Input:
%       'inputFld': folder where all images are stored. Each image has the
%                   following name format:
%       IEEE13_locLabel_1_mesloc_1_resistance_0.001_faultLabel_AC_voltage_phaseA.png (fault location: 1, fault type: AC, measurement collected from location: 1)
%       IEEE13_locLabel_2_mesloc_1_resistance_0.001_faultLabel_AC_voltage_phaseA.png (fault location: 2, fault type: AC, measurement collected from location: 1) 
%       IEEE13_locLabel_2_mesloc_1_resistance_0.001_faultLabel_AB_voltage_phaseA.png (fault location: 2, fault type: AB, measurement collected from location: 1) 
%
% Output:
%      Subfolders according to 'outputFolder' are created and data are copied
%      from source to output. 
%
%       'outputFolder': create images where subfolder names are class labels (first zone then each zone contain subfolders of fault types) ;
%           e.g., outputFolder/Zone_1/sub_fldi'    ----->  subfld1 = 'z1_Fault_AB' images 
%                                                          subfld2 = 'z1_Fault_ABC' images
%                                                          subfld3 = 'z1_Fault_ABCG' images
%                                                          subfld4 = 'z1_Fault_ABG' images  
%                                                          subfld5 = 'z1_Fault_AC' images
%                                                          subfld6 = 'z1_Fault_ACG' images
%                                                          subfld7 = 'z1_Fault_AG' images 
%                                                          subfld8 = 'z1_Fault_BC' images
%                                                          subfld9 = 'z1_Fault_BCG' images
%                                                          subfld10 = 'z1_Fault_BG' images 
%                                                          subfld11 = 'z1_Fault_CG' images 
%    
%      
% Note: Given 4 locations and 11 fault types, in total we have 44 classes (subfolders)
%       

inputFld =  '/Users/MyHome/Documents/PhD_DataSets/0-ESWA21_IEEE13Spectrogram/Revision_1/Spectrograms/All_Spects/spect_dataset_withoutRE_cropped2000';  % orginal data unsplitted
outputFld = '/Users/MyHome/Documents/PhD_DataSets/0-ESWA21_IEEE13Spectrogram/Revision_1/Spectrograms/Spects_divided_by_task/FinalData_joint_Type_Loc_cropped_ExcludRes';

I = dir(fullfile(inputFld,'*.png'));


for i = 1: 44
    eval(['cnt',num2str(i),'=0;'])
end

for i = 1 : length(I)
    disp(['fileNo: ' num2str(i) ' from ' num2str(length(I)) ' copied!'])
    newStr1 = strsplit(I(i).name,'_');
    newStr2 = newStr1(9);
    newStr3 = newStr1(3);
    R = str2double(newStr1{7});
    if ismember(R,[0.1323, 0.1848, 0.2636, 0.3687, 0.4212, 0.4737, 2])
    elseif strcmp(newStr2,'ABC') && strcmp(newStr3, '1')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_1/z1_Fault_ABC');
        copyfile(fileSource,fldDestin)
        cnt1 = cnt1+1;
    elseif strcmp(newStr2,'ABC') && strcmp(newStr3, '2')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_2/z2_Fault_ABC');
        copyfile(fileSource,fldDestin)
        cnt2 = cnt2+1;
    elseif strcmp(newStr2,'ABC') && strcmp(newStr3, '3')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_3/z3_Fault_ABC');
        copyfile(fileSource,fldDestin)
        cnt3 = cnt3+1;
    elseif strcmp(newStr2,'ABC') && strcmp(newStr3, '4')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_4/z4_Fault_ABC');
        copyfile(fileSource,fldDestin)
        cnt4 = cnt4+1;
    elseif strcmp(newStr2,'ABCG') && strcmp(newStr3, '1')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_1/z1_Fault_ABCG');
        copyfile(fileSource,fldDestin)
        cnt5 = cnt5+1;
    elseif strcmp(newStr2,'ABCG') && strcmp(newStr3, '2')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_2/z2_Fault_ABCG');
        copyfile(fileSource,fldDestin)
        cnt6 = cnt6+1;
    elseif strcmp(newStr2,'ABCG') && strcmp(newStr3, '3')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_3/z3_Fault_ABCG');
        copyfile(fileSource,fldDestin)
        cnt7 = cnt7+1;
    elseif strcmp(newStr2,'ABCG') && strcmp(newStr3, '4')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_4/z4_Fault_ABCG');
        copyfile(fileSource,fldDestin)
        cnt8 = cnt8+1;
    elseif strcmp(newStr2,'AB') && strcmp(newStr3, '1')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_1/z1_Fault_AB');
        copyfile(fileSource,fldDestin)
        cnt9 = cnt9+1;
    elseif strcmp(newStr2,'AB') && strcmp(newStr3, '2')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_2/z2_Fault_AB');
        copyfile(fileSource,fldDestin)
        cnt10 = cnt10+1;
    elseif strcmp(newStr2,'AB') && strcmp(newStr3, '3')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_3/z3_Fault_AB');
        copyfile(fileSource,fldDestin)
        cnt11 = cnt11+1;
    elseif strcmp(newStr2,'AB') && strcmp(newStr3, '4')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_4/z4_Fault_AB');
        copyfile(fileSource,fldDestin)
        cnt12 = cnt12+1;
    elseif strcmp(newStr2,'BC') && strcmp(newStr3, '1')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_1/z1_Fault_BC');
        copyfile(fileSource,fldDestin)
        cnt13 = cnt13+1;
    elseif strcmp(newStr2,'BC') && strcmp(newStr3, '2')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_2/z2_Fault_BC');
        copyfile(fileSource,fldDestin)
        cnt14 = cnt14+1;
    elseif strcmp(newStr2,'BC') && strcmp(newStr3, '3')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_3/z3_Fault_BC');
        copyfile(fileSource,fldDestin)
        cnt15 = cnt15+1;
    elseif strcmp(newStr2,'BC') && strcmp(newStr3, '4')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_4/z4_Fault_BC');
        copyfile(fileSource,fldDestin)
        cnt16 = cnt16+1;
    elseif strcmp(newStr2,'AC') && strcmp(newStr3, '1')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_1/z1_Fault_AC');
        copyfile(fileSource,fldDestin)
        cnt17 = cnt17+1;
    elseif strcmp(newStr2,'AC') && strcmp(newStr3, '2')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_2/z2_Fault_AC');
        copyfile(fileSource,fldDestin)
        cnt18 = cnt18+1;
    elseif strcmp(newStr2,'AC') && strcmp(newStr3, '3')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_3/z3_Fault_AC');
        copyfile(fileSource,fldDestin)
        cnt19 = cnt19+1;
    elseif strcmp(newStr2,'AC') && strcmp(newStr3, '4')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_4/z4_Fault_AC');
        copyfile(fileSource,fldDestin)
        cnt20 = cnt20+1;
    elseif strcmp(newStr2,'ABG') && strcmp(newStr3, '1')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_1/z1_Fault_ABG');
        copyfile(fileSource,fldDestin)
        cnt21 = cnt21+1;
    elseif strcmp(newStr2,'ABG') && strcmp(newStr3, '2')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_2/z2_Fault_ABG');
        copyfile(fileSource,fldDestin)
        cnt22 = cnt22+1;
    elseif strcmp(newStr2,'ABG') && strcmp(newStr3, '3')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_3/z3_Fault_ABG');
        copyfile(fileSource,fldDestin)
        cnt23 = cnt23+1;
    elseif strcmp(newStr2,'ABG') && strcmp(newStr3, '4')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_4/z4_Fault_ABG');
        copyfile(fileSource,fldDestin)
        cnt24 = cnt24+1;
    elseif strcmp(newStr2,'BCG') && strcmp(newStr3, '1')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_1/z1_Fault_BCG');
        copyfile(fileSource,fldDestin)
        cnt25 = cnt25+1;
    elseif strcmp(newStr2,'BCG') && strcmp(newStr3, '2')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_2/z2_Fault_BCG');
        copyfile(fileSource,fldDestin)
        cnt26 = cnt26+1;
    elseif strcmp(newStr2,'BCG') && strcmp(newStr3, '3')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_3/z3_Fault_BCG');
        copyfile(fileSource,fldDestin)
        cnt27 = cnt27+1;
    elseif strcmp(newStr2,'BCG') && strcmp(newStr3, '4')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_4/z4_Fault_BCG');
        copyfile(fileSource,fldDestin)
        cnt28 = cnt28+1;
    elseif strcmp(newStr2,'ACG') && strcmp(newStr3, '1')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_1/z1_Fault_ACG');
        copyfile(fileSource,fldDestin)
        cnt29 = cnt29+1;
    elseif strcmp(newStr2,'ACG') && strcmp(newStr3, '2')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_2/z2_Fault_ACG');
        copyfile(fileSource,fldDestin)
        cnt30 = cnt30+1;
    elseif strcmp(newStr2,'ACG') && strcmp(newStr3, '3')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_3/z3_Fault_ACG');
        copyfile(fileSource,fldDestin)
        cnt31 = cnt31+1;
    elseif strcmp(newStr2,'ACG') && strcmp(newStr3, '4')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_4/z4_Fault_ACG');
        copyfile(fileSource,fldDestin)
        cnt32 = cnt32+1;
    elseif strcmp(newStr2,'AG') && strcmp(newStr3, '1')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_1/z1_Fault_AG');
        copyfile(fileSource,fldDestin)
        cnt33 = cnt33+1;
    elseif strcmp(newStr2,'AG') && strcmp(newStr3, '2')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_2/z2_Fault_AG');
        copyfile(fileSource,fldDestin)
        cnt34 = cnt34+1;
    elseif strcmp(newStr2,'AG') && strcmp(newStr3, '3')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_3/z3_Fault_AG');
        copyfile(fileSource,fldDestin)
        cnt35 = cnt35+1;
    elseif strcmp(newStr2,'AG') && strcmp(newStr3, '4')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_4/z4_Fault_AG');
        copyfile(fileSource,fldDestin)
        cnt36 = cnt36+1;
    elseif strcmp(newStr2,'BG') && strcmp(newStr3, '1')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_1/z1_Fault_BG');
        copyfile(fileSource,fldDestin)
        cnt37 = cnt37+1;
    elseif strcmp(newStr2,'BG') && strcmp(newStr3, '2')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_2/z2_Fault_BG');
        copyfile(fileSource,fldDestin)
        cnt38 = cnt38+1;
    elseif strcmp(newStr2,'BG') && strcmp(newStr3, '3')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_3/z3_Fault_BG');
        copyfile(fileSource,fldDestin)
        cnt39 = cnt39+1;
    elseif strcmp(newStr2,'BG') && strcmp(newStr3, '4')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_4/z4_Fault_BG');
        copyfile(fileSource,fldDestin)
        cnt40 = cnt40+1;
    elseif strcmp(newStr2,'CG') && strcmp(newStr3, '1')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_1/z1_Fault_CG');
        copyfile(fileSource,fldDestin)
        cnt41 = cnt41+1;
    elseif strcmp(newStr2,'CG') && strcmp(newStr3, '2')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_2/z2_Fault_CG');
        copyfile(fileSource,fldDestin)
        cnt42 = cnt42+1;
    elseif strcmp(newStr2,'CG') && strcmp(newStr3, '3')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_3/z3_Fault_CG');
        copyfile(fileSource,fldDestin)
        cnt43 = cnt43+1;
    elseif strcmp(newStr2,'CG') && strcmp(newStr3, '4')
        fileSource = fullfile(inputFld,I(i).name);
        fldDestin = fullfile(outputFld,'Zone_4/z4_Fault_CG');
        copyfile(fileSource,fldDestin)
        cnt44 = cnt44+1;

    end

end

for i = 1 : 44
    eval(['tmp = cnt', num2str(i), ';'])
    disp(['Case ', num2str(i), '; ', num2str(tmp) ' files copied.'])
end
