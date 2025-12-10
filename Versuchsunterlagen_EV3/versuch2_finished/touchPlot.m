function touchPlot(nominalval_vector,actualval_vector,switchstate_vector)
% Ausgabe der Ergebnisse von der GUI "touchGUI"
% Eingabewerte:
%   nominalval_vector: speichert die Sinuswelle
%   actualval_vector: speichert alle vorherigen Y-Werte (der letzte Eintrag
%   ist die letzte Y-Position)
%   switchstate_vector: speichert die Schalterzustaende des NXT Tastsensors


%% Variablen
x_values = 1:length(nominalval_vector);  % Vektor der x-Werte

%% Bearbeitung des Codes ab hier:
fig = figure();

plot(x_values, actualval_vector,x_values, nominalval_vector);
xlabel("X-Werte", 'FontSize', 12);
ylabel("Y-Werte", 'FontSize', 12);
title("Soll- und Istwert", 'FontSize', 15);
grid on;
legend({'Istwert','Sollwert'}, 'Location', 'southeast', 'Orientation', 'horizontal');
set(fig, 'Units', 'Normalized', 'OuterPosition', [0.25, 0.25, 0.5, 0.5]);
%movegui(fig,'center')


fig2 = figure();
plot(x_values, switchstate_vector);
title("Schalterstatus");
ylim([-0.5 1.5])

str= ['True-State Count: ' num2str(sum(switchstate_vector))];
text(0,-0.5, str, 'HorizontalAlignment','left','VerticalAlignment','bottom')
end