%% Lichtsensor-Versuch - Sensor timergesteuert auslesen
function lightReadWithTimer(brickObj, numberOfSeconds)

% ... Initialisierung der Vektoren, Starten der Stoppuhr hierher kopieren ...
% ...
myUserData.vals = NaN(1);
myUserData.timestamps = NaN(1);
% Timer-Objekt anlegen und starten
% ...
t = timer
set(t, 'TimerFcn', @readLightTimerFcn);
set(t, 'ExecutionMode', 'fixedSpacing');
set(t, 'UserData', myUserData);
% Daten aus Timer-Objekt auslesen.
% ...
start(t);
pause(numberOfSeconds);
stop(t);
% Plotten der Ergebnisse hierher kopieren
% ...


%--------------------------------------------------------------------------

%%
function readLightTimerFcn (timerObj, event)

% UserData aus Timer-Objekt holen
% ...
    myUserData = get(timerObj, 'UserData');
    myUserData.vals(end+1) = brickObj.sensor1.value;
    myUserData.timestamps(end+1) = event.Data.time;
% Zeit und Sensorwert in Datenstruktur speichern:
    set(timerObj, 'UserData', vals);
% Schleifeninhalt der while-Schleife aus lightReadWithLoop hierher kopieren
% ...

% Daten zurueck in Timer-Objekt sichern
% ...

%--------------------------------------------------------------------------

