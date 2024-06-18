clc;
clear;
step = 0.25;
inpLimVec = [-2 2]; %рябь хорошая
outLimVec = [-3*pi/(step), 3*pi/(step)];
h = figure('Name', 'FFT');
plotFT(h, @func3,[], step, inpLimVec, outLimVec);



    
