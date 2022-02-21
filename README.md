# FaultClf_SmartGrids

Information about Dataset:

This dataset is extracted from IEEE-13 node test feeder without renewable energy (RE), a distribution network operating at 4.16 kV simulated in MATLAB Simulink environments. The dataset is organized in 3 main folders:

1. RawTimeSeriesDate:
There are two folders for raw time-series data one contains raw faulty data and the other health data.
   a. FaultySignal_withoutRE:
   
For fault simulation, we divided the network into four zones as shown in Figure 1. We injected 11 fault types (AG, BG, CG, AB, AC, BC, ABG, ACG, BCG, ABC, ABCG)  with 22 different resistances for each type of faults to these four critical zones adjacent to load flow buses number 671, 633, 675 and 680 in for the whole simulation time was t = [0.0 - 0.022]. Each fault with every resistances have been applied at a certain start time t= 0.01 and revoked at time t= 0.02, so t_f = [0.01-0.02] represents the faulty duration, while t_h = [0-0.01] represents the healthy (non-faulty) time period.
This folder contains three .csv files that include phase A, B, and C voltage measurements. 

![IEEE-13pdf](https://user-images.githubusercontent.com/38736959/154933815-8bb93d98-f34e-4024-a24b-6efa221d2696.png)
