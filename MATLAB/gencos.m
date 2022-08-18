function [st, t] = gencos(f0, phi, R)
%GENCOS Generates a cosine function given specific arguments.
%   Inputs:
%       f0 [periods / sec]: frequency
%       phi [rad]: phase offset
%       R [int]: number of periods
%   Outputs:
%       st [vector]: cos(2 pi f0 t + phi)
%       t [vector]: time vector
    if (R ~= floor(R))
        error("R is not an integer.");
    end

    samples = 100;
    t = linspace(0, R / f0, R * samples + 1);
    t(end) = [];

    st = cos(2 * pi * f0 * t + phi);
    
    figure
    plot(t, st, 'r-')
    hold on
    title("cos(" + num2str(2 * pi * f0) + "t + " + num2str(phi) + ")")
    
    xlabel("Time (sec)")
    ylabel("Amplitude")

    if R > 1
        if sum(abs(st(1:samples) - st(samples + 1: 2 * samples))) < 1e-8
            disp("Function is periodic.")
        end
    end
end


