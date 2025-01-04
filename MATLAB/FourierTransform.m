clear; close all

T = 1;
figure;

for fs = 10.^(5:-1:1)
    Ts = 1 / fs;
    samples = fs * T;
    f = linspace(-fs/2, fs/2, samples + 1); f(end) = [];
    
    x = ones(samples, 1);
    X = fftshift(fft(x)) * fs;

    plot(ax, f, abs(X))
    hold on
end

%% Discrete
figure;

for T = 1:5
    fs = 10;
    samples = fs * T;
    f = linspace(-fs/2, fs/2, samples + 1); f(end) = [];
    
    x = ones(samples, 1);
    X = fftshift(fft(x)) * fs;

    plot(f, abs(X))
    hold on
end
xlim([-1 1])
legend(string(1:5))

%%
syms f t;
figure;

for T = 1:5
    X = int(exp(-1j * 2 * pi * f * t), 0, T);

    fplot(abs(X), [-1 1])
    hold on
end
xlim([-1 1])
legend(string(1:5))