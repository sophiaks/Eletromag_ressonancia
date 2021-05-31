ant1 = spiralArchimedean('NumArms', 1, 'Tilt', 90, 'Turns', 5, 'InnerRadius', .45, 'OuterRadius', .5, 'TiltAxis', 'Y');
ant2 = spiralArchimedean('NumArms', 1, 'Tilt', 90, 'Turns', 5, 'InnerRadius', .4, 'OuterRadius', .5, 'TiltAxis', 'Y');

%%
% PLOTS ANTENAS
show(ant1);
show(ant2);

%%
% Impedância
freq = linspace(1000000,10000000, 30);
Z = impedance(ant1, freq);

%%
%PLOTS impedância
plot(freq, imag(Z));
impedance(ant1, freq');

%%
% Acoplamentos
la = linearArray;
la.NumElements = 2;
la.ElementSpacing = .4;
la.Element = ant1;

%%
% Ganhos (apenas antena 1)
sd = sparameters(la, freq);
rfplot(sd, 2, 1, 'abs');

%%
% Segundo elemento
la.Element = ant2;

%%
% Ganhos (ambas as antenas)
sd = sparameters(la, freq);
[freq_crit, index_crit] = max(abs(imag(Z)));
disp(freq(index_crit))

%%
% PLOTS
rfplot(sd, 2, 1, 'abs');

%%
% Variando as distâncias
% dist = linspace(5*1e-3, 5*1e-2, 30);
% Z_ganho = zeros(30);
% for i = 1:30
%     la.ElementSpacing = dist(i);
%     sd = sparameters(la, freq);
%     Z_ganho(:, i) =  abs(rfparam(sd, 2, 1));
% end

%%
% PLOT 3D
[X, Y] = meshgrid(freq, dist);
surf(X, Y, Z_ganho);

%% 
% Freq crítica e sigma
w_c = freq(index_crit);
sigma = 18.5; %ajustável
% L e C
L = sigma/w_c;
C = 1/(sigma*w_c);

Z_array_ant = zeros(1, 30);
for w = 1:length(freq)
    Z_ind = 1j*freq(w)*L;
    Z_cap = 1/(1j*freq(w)*C);
    Z_ant = ((Z_ind*Z_cap)/(Z_ind + Z_cap)) + 4*Z_ind;
    Z_array_ant(w) = Z_ant;
end

%%
% PLOT IMPEDANCIA DE TRANSFORMADORES
plot(freq, imag(Z_array_ant));
yline(0);
intersection = find(imag(Z_array_ant)==0, 2);
disp(intersection);
hold on
plot(freq, imag(Z));

%%
