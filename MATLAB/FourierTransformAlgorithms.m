clear; close all
N = 4; % randi(100);
% x = rand(1, N) * randi([-100 100]) + 1i * rand(1, N) * randi([-100 100]);
x = [0 1 2 0];
%% Discrete Time Fourier Transform
XDTFT = @(f) DTFT(f, x, N);
f = linspace(0, 1, 100);

figure
plot(f, abs(XDTFT(f)), LineWidth=2)
hold on
%% Discrete Fourier Transform
fDFT = (0:N-1) / N;

XDFT = DFT(x, N);

stem(fDFT, abs(XDFT), 'r', LineWidth=1.5, MarkerSize=8)

%% Fast Fourier Transform
XFFT = fft(x);

plot(fDFT, abs(XFFT), 'xk', MarkerSize=8)

%% Discrete Fourier Transform
function X = DFT(x, N)
    X = zeros(1, N);
    for k = 0:N-1
        for n = 0:N-1
            X(k + 1) = X(k + 1) + x(n + 1) * exp(-1j * 2 * pi * n * k / N);
        end
    end
end

%% Discrete Time Fourier Transform
function X = DTFT(f, x, N)
    X = 0;
    for n = 0:N-1
        X = X + x(n + 1) * exp(-1j * 2 * pi * n * f);
    end
end