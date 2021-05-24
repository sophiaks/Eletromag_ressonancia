ant1 = spiralArchimedean('NumArms', 1, 'Turns', 1, 'Tilt', 90, 'Turns', 6, 'InnerRadius', .45, 'OuterRadius', .5, 'TiltAxis', 'Y');
%show(ant1);
ant2 = spiralArchimedean('NumArms', 1, 'Turns', 1, 'Tilt', 90, 'Turns', 6, 'InnerRadius', .4, 'OuterRadius', .5, 'TiltAxis', 'Y');
%show(ant2);

% Impedância
freq = linspace(10e5,10e6,200);
%impedance(ant1, freq);

Z = impedance(ant1, freq);
%plot(freq, imag(Z));

% Acoplamentos
la = linearArray;
la.NumElements = 2;
la.ElementSpacing = .4;
la.Element = ant1;

% Ganhos
sd = sparameters(la, freq);
%rfplot(sd, 2, 1, 'abs');

% Segundo elemento
%la.Element = ant2;

% Ganhos
%sd = sparameters(la, freq);
%rfplot(sd, 2, 1, 'abs');
%show(la);

% Variando as distâncias
dist = linspace(5*1e-3, 5*1e-2, 200);

%plot3(dist, freq, rfparam(sd,2,1));
plot(rfplot(sd, 2, 1, 'abs'), dist);
for i = 1:dist
    la.ElementSpacing = dist;
    sd = sparameters(la, freq);
    %plot3(rfparam(sd,2,1), freq, dist);
    hold on;
end
hold off;