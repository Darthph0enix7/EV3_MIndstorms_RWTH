% t1 = timer;
% t2 = timer;
% 
b = EV3();
b.connect('usb');

m = b.motorA;
m.setProperties('power', -50, 'limitValue', 0, 'brakeMode', 'Brake');
m.internalReset();
m.resetTachoCount();
m.start();
tic;
while toc < 5
    m.tachoCount
end
m.stop();

b.disconnect();

% myData1.val = 0;
% myData2.val = 0;
% 
% set(t1, 'TimerFcn', @timer1, 'Period', 0.3, 'UserData', myData1, 'ExecutionMode', 'fixedSpacing');
% set(t2, 'TimerFcn', @timer2, 'Period', 0.4, 'UserData', myData2, 'ExecutionMode', 'fixedSpacing');
% t1.start();
% t2.start();
% pause(12);
% t1.stop();
% t2.stop();
% 
% 
% function timer1(t, e)
%     i = t.UserData.val;
%     ["Timer 1: " i]
%     i = i + 1;
%     t.UserData.val = i;
%     if i > 10
%         t.stop()
%     end
% end
% 
% function timStop(t, e)
%     
% end
% 
% function timer2(t, e)
%     i = t.UserData.val;
%     ["Timer 2: " i]
%     i = i + 1;
%     t.UserData.val = i;
% end