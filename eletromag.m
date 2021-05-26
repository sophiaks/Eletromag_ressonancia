ant1 = spiralArchimedean('NumArms', 1, 'Turns', 1, 'Tilt', 90, 'Turns', 6, 'InnerRadius', .45, 'OuterRadius', .5, 'TiltAxis', 'Y');
%show(ant1);
ant2 = spiralArchimedean('NumArms', 1, 'Turns', 1, 'Tilt', 90, 'Turns', 6, 'InnerRadius', .4, 'OuterRadius', .5, 'TiltAxis', 'Y');
%show(ant2);

% Impedância
freq = linspace(10e5,10e6,	18);
%impedance(ant1, freq);

Z = impedance(ant1, freq);
%plot(freq, imag(Z));

% Acoplamentos
la = linearArray;
la.NumElements = 2;
la.ElementSpacing = .4;
la.Element = ant1;

% Ganhos
%sd = sparameters(la, freq);
%rfplot(sd, 2, 1, 'abs');

% Segundo elemento
la.Element = ant2;

% Ganhos
sd = sparameters(la, freq);
%disp(rfparam(sd, 2, 1));
[freq_res, index_res] = max(abs(rfparam(sd, 2, 1)));

disp(freq_res);
disp(index_res);
rfplot(sd, 2, 1, 'abs');
%show(la);

% Variando as distâncias
dist = linspace(5*1e-3, 5*1e-2, 18);

%rfplot(sd, 2, 1, 'abs')
Z_ganho = zeros(18);

% for i = 1:18
%     disp(i);
%     la.ElementSpacing = dist(i);
%     sd = sparameters(la, freq);
%     Z_ganho(:, i) =  abs(rfparam(sd, 2, 1));
% end
% [X, Y] = meshgrid(freq, dist);
% surf(X, Y, Z_ganho);

