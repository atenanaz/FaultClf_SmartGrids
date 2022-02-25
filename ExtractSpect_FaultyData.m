%clear
clc
close all


% Created by: Fatemeh Nazary, 
%            Jan 3, 2022 
%

% Input:
%       'inputFld': folder where all raw faulty signals are stored. 
%        There are 6 'csv' files, 3 for current and 3 for voltage.
%        We used voltage data for phase A, B, and C. For example:
%        file "voltage_phaseA.csv" contains 3872 samples in the following
%        format:
%
%         Input Signal = [Vout_pA1, Vout_pA2, ... Vout_pA2201, locLabel, measloc, resistance, faultLabel] 

%       'outputFld': folder where all spectrograms are stored. Each image has the
%                   following name format: 
%           e.g., IEEE13_locLabel_1_mesloc_1_resistance_0.0798_faultLabel_ABCG_voltage_phaseA

% We reduced the number of total spectrograms by reducing the number of resistance
% and cuting Vout untill Vout_pA2000.

inputFld = '/Users/MyHome/Documents/PhD_DataSets/0-ESWA21_IEEE13Spectrogram/Revision_1/RawTimeSeriesData/rawSignal_withoutRE';
outputFld = '/Users/MyHome/Documents/PhD_DataSets/0-ESWA21_IEEE13Spectrogram/Revision_1/Spectrograms/All_Spects/spect_dataset_withoutRE_croped2000';

I = dir(fullfile(inputFld,'voltage_*.csv'));


tic
%cnt = 6 ;
for item = 3 : 3  %length(I)
    
    data = readtable(fullfile(inputFld,I(item).name));
    if cnt == 39
        batch = 1+(cnt-1)*100 : 3872;
    else
        batch = 1+(cnt-1)*100 : (cnt)*100;
    end

    disp(['batch '  num2str(cnt)])

    for n = batch %size(data,1)

        %loc 1
        x = table2array(data(n,1:end-205)); %(1:end-4)
        spectrogram(x,128,120,128,1e3,'yaxis');title('sectrogram');
        %ylabel('normalized frequency')
        %xlabel('time') 
        colorbar('off')    
        

        saveFileName = fullfile(outputFld, ['IEEE13_', 'locLabel_' , num2str(table2array(data(n,end-3))) , ...
         '_mesloc_' , num2str(table2array(data(n,end-2))) , '_resistance_' , num2str(table2array(data(n,end-1))), ...
        '_faultLabel_' , char(table2array(data(n,end))), '_' , I(item).name]);


        set(gca,'xlabel',[]);
        set(gca,'ylabel',[]);
        set(gca,'title',[]);
        set(gca,'XTickLabel',[]);
        set(gca,'YTickLabel',[]);

        ax = gca;
        
        exportgraphics(ax,[saveFileName(1:end-4),'.png']);
        %Img = imread([saveFileName(1:end-4),'.png']);
        %Img = imresize(Img, 0.5);
        %imwrite(Img,[saveFileName(1:end-4),'.png']);

    end
end
t = toc