%% Lichtsensor-Versuch - Sensor in Schleife auslesen
function lightReadWithLoop(brickObj, numberOfSeconds)

% hier wird keine Initialisierung des Sensors benoetigt!

% Initialisierung der Vektoren, Start der Stoppuhr
% ...
vals = NaN(1);
time_values =NaN(1);
s = numberOfSeconds;

tic;
n = 0
while toc < s
    if n < 10
        toc
    end
    n = n + 1;
    vals(end+1)= brickObj.sensor1.value;
    time_values(end+1)= toc;
end
fig = figure();
plot(time_values, vals);
xlabel("Zeit [s]");
ylabel("Sensorwert");

% In einer Schleife für die angegebene Anzahl an Sekunden messen
% ...
change=diff(vals);
mittelwert = mean(change, 'omitnan');
fig2 = figure();
plot(time_values(2:end), change);
hold on
plot([0, time_values(end)], [mittelwert, mittelwert], 'g')



set()
