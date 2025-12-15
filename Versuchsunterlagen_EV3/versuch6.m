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

escape(b);
b.disconnect();


function escape(b)
m1 = b.motorA;
m2 = b.motorB;
s = b.sensor1;

m1.setProperties('power', 30, 'limitValue', 0, 'brakeMode', 'Brake');
m2.setProperties('power', -30, 'limitValue', 0, 'brakeMode', 'Brake');
m1.start();
m2.start();

while s.value < 40
    pause(0.01)
    s.value
end
pause(0.2);
m1.stop();
m2.stop();
m1.setProperties('power', 50, 'limitValue', 0, 'brakeMode', 'Brake');

m1.syncedStart(m2);
pause(5);
m1.stop();
end


function vals = radar(b)
m = b.motorC;
m.resetTachoCount();
m.setProperties('power', 1, 'limitValue', 359, 'brakeMode', 'Brake', 'speedRegulation', 0);
vals = NaN(2,1);
s = b.sensor1;


m.start();


while 1
    if m.tachoCount >= 358
        break;
    end
    vals(2, end+1) = s.value;
    vals(1, end) = m.tachoCount*2*pi/360;
    pause(0.01);
end
m.stop();
m.resetTachoCount();
m.setProperties('power', -10, 'limitValue', 360);
%length(vals(1, 1:end))
m.start();
m.waitFor();
m.stop();
%polarplot(vals(1, 1:end), vals(2, 1:end));
end

function brakeTest(b)
%tic;
%while toc < 20
%    s.value
%    pause(0.01);
%end
%b.disconnect();

m1 = b.motorA;
m2 = b.motorB;
power = 80;
m1.setProperties('power', power);
m2.setProperties('power', power);

sensor = b.sensor1;

m1.syncedStart(m2);


% for i = 1:1000
%     sensor.value
%     pause(0.01);
%     if sensor.value < 40
%         break;
%     end
% end
    
while sensor.value > 30 + 0.001*power^2 + 0.2262*power - 2.9286
   pause(0.01);
end



m1.stop();
sensor.value
pause(1);
sensor.value
end





