clear
clc
close all

% Created by: Fatemeh Nazary, 
%             Dec 27, 2021 
%

% Input:
%       'inputFld': folder where all raw healthy signals are stored. 
%        There are 6 'xlsx' files, 3 for current and 3 for voltage.
%        We used voltage data for phase A, B, and C. For example:
%        file "voltage_phaseA.xlsx" contains 352 samples in the following
%        format:
%
%         Input Signal = [Vout_pA1, Vout_pA2, ... Vout_pA2201, measloc, lineLength] 

%       'outputFld': folder where all spectrograms are stored. Each image has the
%                   following name format: 
%           e.g., IEEE13__mesloc_1_lineLength_0.60526_voltage_phaseB_healthy      



inputFld = '/Users/MyHome/Documents/PhD_DataSets/0-ESWA21_IEEE13Spectrogram/Revision_1/RawTimeSeriesData/HealthySignal_withoutRE';
% outputFld = '/Users/MyHome/Documents/PhD_DataSets/0-ESWA21_IEEE13Spectrogram/Revision_1/Spectrograms/All_Spects/spect_dataset_withoutRE_healthy_cropped2000';
outputFld = '/Users/MyHome/Documents/PhD_DataSets/0-ESWA21_IEEE13Spectrogram/Revision_1/Spectrograms/All_Spects/spect_dataset_withoutRE_healthy_cropped_ExcludLine28';

I = dir(fullfile(inputFld,'voltage_phaseC_*.xlsx'));

mesCnt1 = 0;
mesCnt2 = 0;
mesCnt3 = 0;
mesCnt4 = 0;

tic
for item = 1 : length(I)

    data = readtable(fullfile(inputFld,I(item).name));
%     if cnt == 4
%         batch = 1+(cnt-1)*100 : 352; % we have 352 samples for health signals
%     else
%         batch = 1+(cnt-1)*100 : (cnt)*100;
%     end
%     disp(['batch '  num2str(cnt)])
    
    for n = 1 : size(data,1)

        if rem(n,20) == 1
            disp(['sample '  num2str(n)])
        end
        %loc 1
        x = table2array(data(n,1:end-203)); % end-203
        % x = x + e*randn(0,1)    0.01 0.001 0.1
        spectrogram(x,128,120,128,1e3,'yaxis');title('sectrogram');
        %ylabel('normalized frequency')
        %xlabel('time')
        colorbar('off')

        if table2array(data(n,end-1)) == 1
            mesCnt1 = mesCnt1 + 1;
            if mesCnt1 >60
                continue
            end
        elseif table2array(data(n,end-1)) ==2
            mesCnt2 = mesCnt2 + 1;
            if mesCnt2 >60
                continue
            end
        elseif table2array(data(n,end-1)) ==3
            mesCnt3 = mesCnt3 + 1;
            if mesCnt3 >60
                continue
            end
        elseif table2array(data(n,end-1)) ==4
            mesCnt4 = mesCnt4 + 1;
            if mesCnt4 >60
                continue
            end
        end
        

        % Extract mesloc and lineLength from the healthy signal
        saveFileName = fullfile(outputFld, ['IEEE13_',  ...
            '_mesloc_' , num2str(table2array(data(n,end-1))) , '_lineLength_' , num2str(table2array(data(n,end))), ...
           '_' I(item).name]);
       


        set(gca,'xlabel',[]);
        set(gca,'ylabel',[]);
        set(gca,'title',[]);
        set(gca,'XTickLabel',[]);
        set(gca,'YTickLabel',[]);

        ax = gca;

        exportgraphics(ax,[saveFileName(1:end-4),'png']);
        %Img = imread([saveFileName(1:end-4),'.png']);
        %Img = imresize(Img, 0.5);
        %imwrite(Img,[saveFileName(1:end-4),'.png']);

    end
end
t = toc