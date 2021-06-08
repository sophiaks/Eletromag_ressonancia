
%% 1
% PLOTS ANTENAS
ant1 = spiralArchimedean('NumArms', 1, 'Tilt', 90, 'Turns', 5, 'InnerRadius', .45, 'OuterRadius', .5, 'TiltAxis', 'Y');
ant2 = spiralArchimedean('NumArms', 1, 'Tilt', 90, 'Turns', 5, 'InnerRadius', .45, 'OuterRadius', .5, 'TiltAxis', 'Y');

figure(1);
show(ant1);

%% 2
% Impedância
freq = linspace(1000000,10000000, 100);
figure(2);
Z = impedance(ant1, freq);
%% 3
figure(3);
show(ant2);

% Acoplamentos
la = linearArray('Element',[ant1, ant2],'ElementSpacing',0.4);
figure(4);
show(la);
%% 4 e 5
% Ganhos
sd = sparameters(la, freq);
figure(5);
rfplot(sd, 2, 1, 'abs');

%% 6
% Variando as distâncias
dist = linspace(0.1,1,100);
Z_ganho = zeros(100,100);

for i = 1:1:1
    la.ElementSpacing = dist(1,i);
    ganhos = sparameters(la, freq);
    Z_ganho(i ,:) =  abs(rfparam(ganhos, 2, 1));
end
figure(6);
mesh(freq, dist, Z_ganho);

title('3d');
xlabel('Frequência');
ylabel('Distância');
zlabel('Ganho');
%% 7

[freq_crit, index_crit] = max(abs(imag(Z)));
[freq_res, index_res] = max(abs(rfparam(sd, 2, 1)));

current(la, freq(index_res));
%% 8 a

% Freq crítica e sigma
freq_crit = freq(index_crit);
w_c = freq_crit*2*pi;
sigma = 20; %ajustável
% L e C
L = sigma/w_c;
C = 1/(sigma*w_c);

Z_array_ant = zeros(1, 30);
for w = 1:length(freq)
    Z_ind = 1j*freq(w)*2*pi*L;
    Z_cap = 1/(1j*freq(w)*2*pi*C);
    Z_ant = ((Z_ind*Z_cap)/(Z_ind + Z_cap)) + 1.326*Z_ind; %ajustável
    Z_array_ant(w) = Z_ant;
end

figure(7);
plot(freq, imag(Z_array_ant));
ylim([-100, 100])
yline(0);
intersection = find(imag(Z_array_ant)==0, 2);
hold on
plot(freq, imag(Z));
grid
hold off

%% 8 b

dist = linspace(0.1,1,100);
ganho = zeros(100,1);
M = linspace((1/freq_crit),0.1*1e-7,100);
for w = 1:length(M)
    ganho(w) = (abs(M(w) * freq_crit * 1j) ^2);  
end

figure(8);
plot(M,ganho);
xlabel('M (H)');
ylabel('Ganho');
grid

figure(9);
plot(dist,ganho);
xlabel('Distância (m)');
ylabel('Ganho');
grid