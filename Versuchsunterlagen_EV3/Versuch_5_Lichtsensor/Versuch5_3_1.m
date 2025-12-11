b = lightConnectEV3("usb", "reflect"); 
%vals = NaN(1);
%for i=1:1000
%    vals(end+1)= b.sensor1.value
%    pause(0.01);
%end
%max(vals)%100 max

lightReadWithLoop(b, 5);
lightDisconnectEV3(b);

b = lightConnectEV3("bt", "reflect"); 
lightReadWithLoop(b, 5);
lightDisconnectEV3(b);
%reflect white:100 gelb:70 blau:10 green:7 rot:50 black:0
%Ambient max 100 min 0