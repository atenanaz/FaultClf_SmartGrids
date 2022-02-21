# FaultClf_SmartGrids

Information about Dataset:

This dataset is extracted from IEEE-13 node test feeder without renewable energy (RE), a distribution network operating at 4.16 kV simulated in MATLAB Simulink environments. The dataset is organized in 3 main folders:

1. RawTimeSeriesDate:
There are two folders for raw time-series data one contains raw faulty data and the other health data.
   a. FaultySignal_withoutRE:
   For fault simulation, we divided the network into four zones as shown in Figure 1. We injected 11 fault types (AG, BG, CG, AB, AC, BC, ABG, ACG, BCG, ABC, ABCG)  with 22 different resistances for each type of faults to these four critical zones adjacent to load flow buses number 671, 633, 675 and 680 in for the whole simulation time was t = [0.0 - 0.022]. Each fault with every resistances have been applied at a certain start time t= 0.01 and revoked at time t= 0.02, so t_f = [0.01-0.02] represents the faulty duration, while t_h = [0-0.01] represents the healthy (non-faulty) time period.
This folder contains three .csv files that include phase A, B, and C voltage measurements. 

![IEEE-13pdf](https://user-images.githubusercontent.com/38736959/154933815-8bb93d98-f34e-4024-a24b-6efa221d2696.png)

   b. HealthySignal_withoutRE:
For Healthy data, we got raw healthy signals for 88 line lengths by measuring from four locations and for three phases. This folder contains three .xlsx files that include phase A, B, and C voltage measurements. The whole simulation time was t = [0.0 - 0.022].
The number of samples created by simulation for both faulty and healthy signals is demonstrated in the figure below.

![Design of dataset](https://user-images.githubusercontent.com/38736959/154936004-ce2987b0-b0bc-4a0e-acac-7ec23b162b6f.png)

Notification:
In the paper, we considered the whole simulation time as t = [0.0 - 0.02] which means the fault remains in the network. Also, the number of resistances and line lengths were reduced to 15 and 60, respectively. You can see in figure below the number of samples for the rest data “Features” and “Spectrogram”.

![Design of dataset-paper](https://user-images.githubusercontent.com/38736959/154936641-fb2459d7-4cd4-4dcd-8ab0-cefc445df228.png)

2. FeatureData:

For the baseline, three domains: time, frequency (discrete Fourier transform DFT), and Discrete wavelet transform are considered (DWT). For feature representation, we investigate the impact of several statistical aggregation functions computing the n-th moment of the probability distribution functions (PDFs) (n \ in [1,4]) together with the energy and maximum level of the signals for three domains as an input of classifiers. 
In total, 48 features are extracted: 6 features from time-domain, 6 features from DFT, and 36 features from DWT (5 levels of decomposition + 1 level of approximation). In this regard, for DWT 6 features are multiplied by 6.
In this folder there are two folders related to features for faulty and healthy signals.

   a. Features_FaultySignal:
   For faulty data, there are three .csv files that each include 48 features and labels with 2640 samples for phases A, B, and C, respectively. Furthermore,     there are two labels, “locLabel” and “faultLabel” and information about resistance and where the measurements are done in columns by headers “resistance”  and “measloc”.
   
   b. Features_HealthySignal:
For healthy data, there are three .csv files that each include 48 features and labels with 240 samples for phases A, B, and C, respectively. Furthermore, there are information about line length and where the measurements are done in columns by headers “lineLength” and “measloc”.


3. Spectrogram:
For spectrograms, there are two main folders (1) All_spectrograms and (2) Spect_divided_by_task. Since the MATLAB datastore class requires images to be organized in subfolders where each sub-folder is a class label, “Spect_divided_by_task” folder is created. 
   a. All_spectrograms:
This folder contains two files:
(1) spect_withoutRE_faulty, which includes faulty spectrograms. All images have a name that contains all information about the location label, the location where the signal is measured, resistance, type of the fault, and finally the phase, for instance:
“IEEE13_locLabel_1_mesloc_1_resistance_0.001_faultLabel_AB_voltage_phaseC.png”

(2) spect_withoutRE_healthy file includes healthy spectrograms. All images have a name that contains all information about the the location where the signal is measured, line length, and finally the phase, for instance:
“IEEE13__mesloc_1_lineLength_0.60554_voltage_phaseB_healthy.png”

   b. Spect_divided_by_task:
This folder contains three folders that each of them are prepared as a MATLAB datastore class where each sub-folder is a class label. These three folders relate to the three tasks of classification.

i) FinalData_location
This folder contains 4 sub-folders (Zone_1, Zone_2, Zone_3, Zone_4) that are labels with corresponding images for CNN.

ii) FinalData_Type
This folder contains 12 sub-folders (Fault_AB, Fault_ABC, Fault_ABCG, Fault_ABG, Fault_AC, Fault_ACG, Fault_BC, Fault_BCG, Fault_BG, Fault_CG, Fault_AG, Healthy) that are labels with images for CNN.

iii) FinalData_joint_Type_Loc
This folder contains 5 sub-folders (Zone_1, Zone_2, Zone_3, Zone_4, Zone_h) and each of these sub-folders contain 11 sub-sub-folders for instance (z1_Fault_AB, z1_Fault_ABC, z1_Fault_ABCG, z1_Fault_ABG, z1_Fault_AC, z1_Fault_ACG, z1_Fault_BC, z1_Fault_BCG, z1_Fault_BG, z1_Fault_CG, z1_Fault_AG) except sub-folder Zone_h which contain one sub-sub-folder “Healthy”  that are labels with corresponding images for CNN.


The diagram of folders is shown in the following:

![Folder](https://user-images.githubusercontent.com/38736959/154938716-09e429f1-a5a1-41f0-86fb-57619eb3d92f.png)

Dataset can be downloaded from the linke: https://drive.google.com/drive/folders/1IOYheTnH6bidXhvvTQPs5O_g3SWDfjvF?usp=sharing
