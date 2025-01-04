clear; close all

% Number of points
N = 100;

% Samples
t = linspace(0, 1, N+1); t(end) = [];
x = rectangularPulse(t);

%% Discrete Fourier Series
[cn, XDFS] = DFS(x, N);

%% Discrete Time Fourier Transform
XDTFT = @(f) DTFT(f, x, N);
f = linspace(0, 1, N+1); f(end) = [];
fs = f(2) - f(1);

%% Discrete Fourier Transform
fDFT = (0:N-1) / N;
XDFT = DFT(x, N);

%% Fast Fourier Transform
XFFT = fft(x);

%% Plot
figure
plot(f, fftshift(abs(XDTFT(f))) * fs, LineWidth=2)
hold on
stem(fDFT, fftshift(abs(XDFT)) * fs, 'r', LineWidth=1.5, MarkerSize=8)
plot(fDFT, fftshift(abs(cn)), '*c', MarkerSize=8)
plot(fDFT, fftshift(abs(XFFT)) * fs, 'xk', MarkerSize=8)

xlabel("Normalised Frequency")
ylabel("Magnitude")
legend("DTFT", "DFT", "DFS", "FFT")

%% Discrete Fourier Series
function [cn, X] = DFS(x, N)
    X = zeros(1, N);
    cn = zeros(1, N);

    % cn
    for k = 0:N-1
        for n = 0:N-1
            cn(k + 1) = cn(k + 1) + x(n + 1) * exp(-1j * 2 * pi / N * k * n);
        end
    end
    cn = 1 / N * cn;

    % X
    for k = 0:N-1
        for n = 0:N-1
            X(k + 1) = X(k + 1) + cn(n + 1) * exp(1j * 2 * pi / N * k * n);
        end
    end
end

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