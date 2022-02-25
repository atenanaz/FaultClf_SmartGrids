clear
clc
close all

% Created by: Fatemeh Nazary, 
%            Jan 25, 2022 
% 
% Information: For baseline, we extract 48 features from raw signals: 6
% features (mean, norm, std, skewness, kurtosis, max) from raw signals,
% these 6 features from fourier transform and these 6 features from wavelet
% transform (5 wavedec + 1 appcoef), finallt we have 36 features for
% wavelet. These features are computed in "Extract_Feature_Sigal" function.
%
% Input:
%      gets raw sinals 'voltage_phaseC.csv' for three phase A, B, C
%
%
% Output:
%      .csv file that stored features for three phases A, B, C.

signalType = 'healthy' ; %faulty %healthy

if strcmp(signalType, 'healthy')
    inputFld = '/Users/MyHome/Documents/PhD_DataSets/0-ESWA21_IEEE13Spectrogram/Revision_1/RawTimeSeriesData/HealthySignal_withoutRE/';
    outputFld = '/Users/MyHome/Documents/PhD_DataSets/0-ESWA21_IEEE13Spectrogram/Revision_1/Baseline/Features_HealthySignal';
    I = dir([inputFld,'voltage_phaseC_healthy.xlsx']);
elseif strcmp(signalType, 'faulty')
    inputFld = '/Users/MyHome/Documents/PhD_DataSets/0-ESWA21_IEEE13Spectrogram/Revision_1/RawTimeSeriesData/rawSignal_withoutRE/';
    outputFld = '/Users/MyHome/Documents/PhD_DataSets/0-ESWA21_IEEE13Spectrogram/Revision_1/Baseline/Features_withoutRE';
    I = dir([inputFld,'voltage_phaseC.csv']);
end

fileName = I.name;
A = readtable([inputFld,fileName]);

% extracting data acoording to measloc
%data_measloc1 = A(A.measloc == 1,:);
%data_measloc2 = A(A.measloc == 2,:);
%data_measloc3 = A(A.measloc == 3,:);
%data_measloc4 = A(A.measloc == 4,:);

c = 1010;

%Xtemp = data_measloc4;
%ml_num = 4;
Xtemp = A;

tabTit = {'norm_t', 'mean_t', 'std_t', 'skew_t', 'kurt_t', 'max_t' , ...
          'norm_f', 'mean_f', 'std_f', 'skew_f', 'kurt_f', 'max_f', ...
          'norm_a5_db4', 'norm_cd1_db4', 'norm_cd2_db4', 'norm_cd3_db4', 'norm_cd4_db4','norm_cd5_db4', ...
          'mean_a5_db4', 'mean_cd1_db4', 'mean_cd2_db4', 'mean_cd3_db4', 'mean_cd4_db4','mean_cd5_db4', ...
          'std_a5_db4', 'std_cd1_db4', 'std_cd2_db4', 'std_cd3_db4', 'std_cd4_db4','std_cd5_db4', ...
          'skew_a5_db4', 'skew_cd1_db4', 'skew_cd2_db4', 'skew_cd3_db4', 'skew_cd4_db4','skew_cd5_db4', ...
          'kurt_a5_db4', 'kurt_cd1_db4', 'kurt_cd2_db4', 'kurt_cd3_db4', 'kurt_cd4_db4','kurt_cd5_db4', ...
          'max_a5_db4', 'max_cd1_db4', 'max_cd2_db4', 'max_cd3_db4', 'max_cd4_db4','max_cd5_db4'
          }; 

Xtr = [];
Xfr = [];
Xdwt = [];

for i = 1 : size(Xtemp,1)
    X1 = table2array(Xtemp(i,1:2201));
    plot(X1)
    [Ft, Ffrq,Fdwt] = Extract_Feature_Signal(X1,c);
    Xtr = [Xtr ; Ft(:)'];
    Xfr = [Xfr ; Ffrq(:)'];
    Xdwt = [Xdwt ; Fdwt(:)'];
end

X = [Xtr, Xfr, Xdwt];
Xtable = array2table(X,'VariableNames',tabTit);
%Xtable = [Xtable,Xtemp(:,end-3:end)];
Xtable = [Xtable,Xtemp(:,end-1:end)];
%Xtable(:,end-2) = [];

saveFileName = fullfile(outputFld,['features_'  fileName]);
tmp = strsplit(saveFileName,'.');

writetable(Xtable,[tmp{1},'.csv'],'Delimiter',',');


