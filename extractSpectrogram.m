%clear
clc
close all

fldName = '/Users/MyHome/Documents/PhD_DataSets/0-ESWA21_IEEE13Spectrogram/Revision_1/RawTimeSeriesData/HealthySignal_withoutRE';
I = dir(fullfile(fldName,'voltage_*.xlsx'));

tic
cnt = 1 ;
for item = 1 : 1%length(I)
    
    data = readtable(fullfile(fldName,I(item).name));
%     if cnt == 39
%         batch = 1+(cnt-1)*100 : 3872;
%     else
%         batch = 1+(cnt-1)*100 : (cnt)*100;
%     end
%   disp(['batch '  num2str(cnt)])

    for n = batch %size(data,1)

        %loc 1
        x = table2array(data(n,1:end-4));
        spectrogram(x,128,120,128,1e3,'yaxis');title('sectrogram');
        %ylabel('normalized frequency')
        %xlabel('time') 
        colorbar('off')    
        saveFileName = ['spect_dataset_withRE/' , 'IEEE13_', 'locLabel_' , num2str(table2array(data(n,end-3))) , ...
         '_mesloc_' , num2str(table2array(data(n,end-2))) , '_resistance_' , num2str(table2array(data(n,end-1))), ...
        '_faultLabel_' , char(table2array(data(n,end))), '_' , I(item).name];

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