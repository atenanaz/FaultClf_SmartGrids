clear
clc
close all
rng(2)

inputFld = '/Users/MyHome/Documents/PhD_DataSets/0-ESWA21_IEEE13Spectrogram/Revision_1/Baseline/Features_withoutRE/';
I = dir([inputFld,'features_voltage_phaseA.csv']);
fileName = I.name;
Xtable_pA = readtable([inputFld,fileName]);

I = dir([inputFld,'features_voltage_phaseB.csv']);
fileName = I.name;
Xtable_pB = readtable([inputFld,fileName]);

I = dir([inputFld,'features_voltage_phaseC.csv']);
fileName = I.name;
Xtable_pC = readtable([inputFld,fileName]);

XF = [Xtable_pA;Xtable_pB;Xtable_pC];

ind = (XF.resistance ==0.1323) | (XF.resistance == 0.1848) | (XF.resistance == 0.2636) | (XF.resistance == 0.3687) ...
      | (XF.resistance == 0.4212)  | (XF.resistance == 0.4737) | (XF.resistance == 2) ;

XF=XF(~ind,:);
XF (:,end-2:end-1) = [];
%XF (:,end-3:end-1) = [];
%XF (:,end-2:end) = [];

inputFld = '/Users/MyHome/Documents/PhD_DataSets/0-ESWA21_IEEE13Spectrogram/Revision_1/Baseline/Features_HealthySignal/';

I = dir([inputFld,'features_voltage_phaseA_healthy.csv']);
fileName = I.name;
XHtable_pA = readtable([inputFld,fileName]);

ind_keep = randi(88,1,60);
XHtable_pA_meas1 = XHtable_pA(XHtable_pA.measloc == 1,:);
XHtable_pA_meas1 = XHtable_pA_meas1(ind_keep,:);
XHtable_pA_meas2 = XHtable_pA(XHtable_pA.measloc == 2,:);
XHtable_pA_meas2 = XHtable_pA_meas2(ind_keep,:);
XHtable_pA_meas3 = XHtable_pA(XHtable_pA.measloc == 3,:);
XHtable_pA_meas3 = XHtable_pA_meas3(ind_keep,:);
XHtable_pA_meas4 = XHtable_pA(XHtable_pA.measloc == 4,:);
XHtable_pA_meas4 = XHtable_pA_meas4(ind_keep,:);

XHtable_pA = [XHtable_pA_meas1;XHtable_pA_meas2;XHtable_pA_meas3;XHtable_pA_meas4];


I = dir([inputFld,'features_voltage_phaseB_healthy.csv']);
fileName = I.name;
XHtable_pB = readtable([inputFld,fileName]);

XHtable_pB_meas1 = XHtable_pB(XHtable_pB.measloc == 1,:);
XHtable_pB_meas1 = XHtable_pB_meas1(ind_keep,:);
XHtable_pB_meas2 = XHtable_pB(XHtable_pB.measloc == 2,:);
XHtable_pB_meas2 = XHtable_pB_meas2(ind_keep,:);
XHtable_pB_meas3 = XHtable_pB(XHtable_pB.measloc == 3,:);
XHtable_pB_meas3 = XHtable_pB_meas3(ind_keep,:);
XHtable_pB_meas4 = XHtable_pB(XHtable_pB.measloc == 4,:);
XHtable_pB_meas4 = XHtable_pB_meas4(ind_keep,:);

XHtable_pB = [XHtable_pB_meas1;XHtable_pB_meas2;XHtable_pB_meas3;XHtable_pB_meas4];

I = dir([inputFld,'features_voltage_phaseC_healthy.csv']);
fileName = I.name;
XHtable_pC = readtable([inputFld,fileName]);

XHtable_pC_meas1 = XHtable_pC(XHtable_pC.measloc == 1,:);
XHtable_pC_meas1 = XHtable_pC_meas1(ind_keep,:);
XHtable_pC_meas2 = XHtable_pC(XHtable_pC.measloc == 2,:);
XHtable_pC_meas2 = XHtable_pC_meas2(ind_keep,:);
XHtable_pC_meas3 = XHtable_pC(XHtable_pC.measloc == 3,:);
XHtable_pC_meas3 = XHtable_pC_meas3(ind_keep,:);
XHtable_pC_meas4 = XHtable_pC(XHtable_pC.measloc == 4,:);
XHtable_pC_meas4 = XHtable_pC_meas4(ind_keep,:);

XHtable_pC = [XHtable_pC_meas1;XHtable_pC_meas2;XHtable_pC_meas3;XHtable_pC_meas4];

XH = [XHtable_pA;XHtable_pB;XHtable_pC];

XH.locLabel = repmat(5, size(XH,1), 1);
XH.faultLabel = repmat({'H'}, size(XH,1), 1);
XH (:,end-3:end-2) = [];

%XH (:,end-2:end-1) = [];
%Xtable(:,end-2) = [];
XC = [XF;XH]; 

XC.jointLabel= strcat(num2str(XC.locLabel), '_', XC.faultLabel);
