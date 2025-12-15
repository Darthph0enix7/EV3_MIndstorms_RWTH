

% messabstand = [28, 25, 23, 19, 16, 12, 9];
% 
% bremsweg = [2, 5, 7, 11, 14, 18, 21];
% 
% powers = [20, 30, 40, 50, 60, 70, 80];
% 
% polyfit(powers, bremsweg, 2)
% 
% fplot([0.001*x.^2+0.2262*x -2.9286], [-10 100]);

b = EV3();
b.connect('usb');
s = b.sensor2;
vals = NaN(1, 1000);
%s.mode = DeviceMode.Gyro.Rate;
for i = 1:1000
    vals(i) = s.value;
    pause(0.01);
end
plot(1:1000, vals, 1:999, diff(vals));
b.disconnect();