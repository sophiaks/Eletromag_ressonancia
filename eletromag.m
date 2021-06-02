ant1 = spiralArchimedean('NumArms', 1, 'Tilt', 90, 'Turns', 5, 'InnerRadius', .45, 'OuterRadius', .5, 'TiltAxis', 'Y');
ant2 = spiralArchimedean('NumArms', 1, 'Tilt', 90, 'Turns', 5, 'InnerRadius', .45, 'OuterRadius', .5, 'TiltAxis', 'Y');

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
%plot(freq, imag(Z));
impedance(ant1, freq);
%impedance(ant2, freq);

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
la_2  = linearArray('Element', [ant1, ant2]);

%%
% Ganhos (ambas as antenas)
sd = sparameters(la, freq);
[freq_crit, index_crit] = max(abs(imag(Z)));
[freq_res, index_res] = max(abs(rfparam(sd, 2, 1)));
disp(freq(index_crit))

%%
% PLOTS
rfplot(sd, 2, 1, 'abs');

%%
% Variando as distâncias
dist = linspace(5*1e-3, 5*1e-2, 30);
Z_ganho = zeros(30);
list_ganhozitos = zeros(length(dist), 1);


for i = 1:length(dist)
    la_2.ElementSpacing = dist(i);
    ganhoS = sparameters(la_2, freq);
    Z_ganho(i ,:) =  rfparam(ganhoS, 2, 1);
end
%MEU AMIGO
%%
% PLOT 3D
[X, Y] = meshgrid(freq, dist);
surf(X, Y, abs(Z_ganho));

xlabel('Distância');
ylabel('Frequência');
zlabel('Ganho');

%%
% Corrente ressonante
current(la, freq(index_res));
%% 
% Freq crítica e sigma
w_c = freq(index_crit);
sigma = 20; %ajustável
% L e C
L = sigma/w_c;
C = 1/(sigma*w_c);

Z_array_ant = zeros(1, 30);
for w = 1:length(freq)
    Z_ind = 1j*freq(w)*L;
    Z_cap = 1/(1j*freq(w)*C);
    Z_ant = ((Z_ind*Z_cap)/(Z_ind + Z_cap)) + 1.326*Z_ind; %ajustável
    Z_array_ant(w) = Z_ant;
end

%%
% PLOT IMPEDANCIA DE TRANSFORMADORES
plot(freq, imag(Z_array_ant));
ylim([-100, 100])
yline(0);
intersection = find(imag(Z_array_ant)==0, 2);
disp(intersection);
hold on
plot(freq, imag(Z));
%%
