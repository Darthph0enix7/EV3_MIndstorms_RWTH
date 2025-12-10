function [value switchstate] = touchGetYPos(actualval_vector,cyclecount,brickObj)
% Berechnet den Wert des manuell veraenderlichen Signals fuer die GUI
% Beim Druecken des Tastsensors erhoeht sich der Wert
% und der Wert sinkt beim Loslassen des Tastsensors.
% Ausgabewerte:
%   value: neuer Y-Wert  neuerWert
%   switchstate: Tastsensor-Status
% Eingabewerte:
%   actualval_vector: speichert alle vorherigen Y-Werte (der letzte
%   Eintrag ist die letzte Y-Position)
%   cyclecount: Anzahl der bisherigen Funktionsaufrufe


% % Initialisieren der Bluetooth Verbindung
% brickObj = EV3();
%brickObj.connect('ioType','bt','serPort','/dev/rfcomm0');
% 
% 
% %COM_SetDefaultNXT(h);   gibt es keinen ersatzbefehl fuer?
% 
% % Initialisierung des Sensors und Aufruf der GUI
% 
% %OpenSwitch(SENSOR_1);
% brickObj.sensor1.mode = DeviceMode.Touch.Pushed;
% %
%% Bearbeitung des Codes ab hier:

brickObj.sensor1.mode = DeviceMode.Touch.Pushed;
change = 0.2;
new_y = 0;
y = actualval_vector(end);
if (brickObj.sensor1.value == 1)
    switchstate = 1;
    if (y > 1.3)
        new_y = 1.5;
    else
        new_y = y + change;
    end
else
    switchstate = 0;
    if (y < -1.3)
        new_y = -1.5;
    else
        new_y = y - change;
    
    end
end

value = new_y; 

end
