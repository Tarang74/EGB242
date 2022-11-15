%% EGB242 Lab - Quantization
clear;
close all;
clc;

%% 1
% Possible input levels
xMax = 1;
xMin = -xMax;
pts = 1e3;

% Note: (Not a time vector)
input = linspace(xMin, xMax, pts);
%% 2
% Number of representable levels
n = 5;          % bits/sym
numLevs = 2^n;  % lvls/sym

%% 3
% Uniform level spacings
Delta = (xMax - xMin) / numLevs;

%% 4
% Quantizer levels  (MR - Mid-riser, MT - Mid-tread)
MR = xMin + Delta / 2:Delta:xMax;
MT = xMin:Delta:xMax;

% Good to remember here there may be a wasted level for MT as it has an odd
% number of levels

%% 5
% Find corresponding output values
MROutput = Delta * (floor(input / Delta) + 1 / 2);
MROutput(MROutput > MR(end)) = MR(end);

MTOutput = Delta * floor(input / Delta + 1 / 2);
% The signal's limits for MT
%is -9*delta/2 to 7*delta/2 whereas MR is -4*delta to 4 delta

%% 6
% View Input/Output relationship - Note how they cross zero
figure();
subplot(2,1,1);
hold on;

plot(input, input, 'k')
plot(input, MROutput, 'r')
plot(input, MTOutput, 'b')

legend('Linear (no Quantization)','MROutput','MTOutput', 'Location', 'Best');
grid on;
title('Quantisation types'); xlabel('Input'); ylabel('Output');
hold off;

%% 7
% Compare Input/Output
qErrorMR = input - MROutput;
qErrorMT = input - MTOutput;

%% 8
subplot(2,1,2);
hold on;

plot(input, qErrorMR, 'r')
plot(input, qErrorMT, 'b')

grid on;
title('Quantisation error'); xlabel('Input'); ylabel('Error');
legend('qError', 'input - MTOutput', 'Location', 'Best');
hold off;

%% 9
% Find Mean Squared Error
mseMR = mean(qErrorMR.^2);
mseMT = mean(qErrorMT.^2);

qNoise = Delta^2 / 12;
% Note output - MSE 2 bits = 0.0209, qNoise 2 bits = 0.0208
% Quantization noise (uniform quantizer) approx. (delta^2)/12
Psig = mean(input.^2);

SQNR = Psig / qNoise;
%% 10 Change 'bits' to 3 on line 16, highlight lines 6-66 and press F9

%% 11
% MSE 3 bits = 0.0052, qNoise 3 bits = 0.0052
% Approx change in quantization noise power when 1 bit is added - 
ratio = 0.0052 / 0.0208;

ratio_dB = 10 * log10(ratio);
%% 12
% In decibels - noise power change

% Approx -6dB -- For every additional bit in a quantizer, there is a 6dB
% improvement in SNR