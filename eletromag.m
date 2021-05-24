ant1 = spiralArchimedean('NumArms', 1, 'Turns', 1, 'Tilt', 90, 'Turns', 6, 'InnerRadius', .45, 'OuterRadius', .5, 'TiltAxis', 'Y');
%show(ant1);
ant2 = spiralArchimedean('NumArms', 1, 'Turns', 1, 'Tilt', 90, 'Turns', 6, 'InnerRadius', .45, 'OuterRadius', .5, 'TiltAxis', 'Y');

tiledlayout(2,1)

% Impedância
freq = linspace(10e5,10e6,200);
Z = impedance(ant1, freq);

nexttile
plot(freq, imag(Z));

% Acoplamentos
la = linearArray;
la.NumElements = 2;
la.ElementSpacing = 0.4;
show(la);

% Ganhos
sd = sparameters(la, freq);
nexttile
rfplot(sd ,2, 1, 'abs');
rfparam(sd,2,1)

% Variando as distâncias
dist = linspace(5*1e-3, 5*1e-2);

for i = 1:dist
    %plot...
    % Me fala a frequência, me fala a distância, eu te falo o M
    % Trocar jwL1 pela imp total
    % Achar as correntes, achando as correntes acha o ganho
end