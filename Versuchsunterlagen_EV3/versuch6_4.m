b = EV3();

b.connect('bt','serPort','/dev/rfcomm0');
%b.connect('usb');
%s = b.sensor4;

% m1.setProperties('power', 30, 'limitValue', 0, 'brakeMode', 'Brake');
% m2.setProperties('power', -30, 'limitValue', 0, 'brakeMode', 'Brake');
% m1.start();
% m2.start();
% pause(5);
% m1.stop();
% m2.stop();
%escape(b);
locs = radar(b);
sizes = [];
length(locs)
for i = 2:length(locs)
        %locs(2, i)
        sizes(end+1) = locs(2, i) - locs(1, i);
end
sizes
for i=1:length(sizes)
    if sizes(i) < 0
        sizes(i) = sizes(i) + 360
    end
end

[bestval, bestindex] = max(sizes);
bestindex
best = mean([locs(1, bestindex+1) locs(2, bestindex+1)]);
best

escape(b, best);
b.disconnect();


function escape(b, angle)
m1 = b.motorA;
m2 = b.motorB;

m1.resetTachoCount();
m2.resetTachoCount();
m1.setProperties('power', 20, 'limitValue', angle*3, 'brakeMode', 'Brake', 'speedRegulation', 1);
m2.setProperties('power', 20, 'limitValue', angle*3, 'brakeMode', 'Brake', 'speedRegulation', 1);

%m1.setProperties('power', 30, 'limitValue', 4, 'limitMode', 'Time', 'brakeMode', 'Brake', 'speedRegulation', 1);
%m2.setProperties('power', -30, 'limitValue', 4, 'limitMode', 'Time', 'brakeMode', 'Brake', 'speedRegulation', 1);

m1.start();
m2.start();
m1.waitFor();
%pause(0.2);
m1.stop();
m2.stop();
"gedreht"
m1.resetTachoCount();
m2.resetTachoCount();
m1.setProperties('power', -50, 'limitValue', 0, 'brakeMode', 'Brake', 'speedRegulation', 1);
m2.setProperties('power', 50, 'limitValue', 0, 'brakeMode', 'Brake', 'speedRegulation', 1);

m1.start();
m2.start();
pause(5);
m1.stop();
m2.stop();
"gefahren"
end


function locs = radar(b)
m = b.motorC;
m.resetTachoCount();
m.setProperties('power', 1, 'limitValue', 359, 'brakeMode', 'Brake', 'speedRegulation', 0);
vals = NaN(2,1);
s = b.sensor1;

locs = NaN(2,1);
m.start();
i = 0
while 1
    if m.tachoCount >= 358
        break;
    end
    val = s.value;
    if val > 40 && i == 0
        locs(1, end+1) = m.tachoCount;
        "Lücke anfang"
        i = 1;
    elseif val < 40 && i == 1
        locs(2, end) = m.tachoCount;
        "Lücke ende"
        i = 0;
    end
    vals(2, end+1) = s.value;
    vals(1, end) = m.tachoCount*2*pi/360;
    pause(0.01);
end
locs
m.stop();
m.resetTachoCount();
m.setProperties('power', -10, 'limitValue', 360);
%length(vals(1, 1:end))
m.start();
m.waitFor();
m.stop();
%polarplot(vals(1, 1:end), vals(2, 1:end));
end