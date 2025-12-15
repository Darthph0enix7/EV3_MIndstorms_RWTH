b=EV3();
x_axis=[0,10,10,0,0];
y_axis=[0,0,10,10,0];
mx=b.motorA;
my=b.motorB;
mx.setProperties('power', 10, 'speedRegulation', 1, 'limitValue', 0, 'brakeMode', 'Brake');
my.setProperties('power', 10, 'speedRegulation', 1, 'limitValue', 0, 'brakeMode', 'Brake');

plot(x_axis,y_axis);
t1 = timer;
t2 = timer;

myData1.val = 0;
myData2.val = 0;

set(t1, 'TimerFcn', @timer1, 'Period', 0.3, 'UserData', myData1, 'ExecutionMode', 'fixedSpacing');
set(t2, 'TimerFcn', @timer2, 'Period', 0.4, 'UserData', myData2, 'ExecutionMode', 'fixedSpacing');
t1.start();
t2.start();
pause(12);
t1.stop();
t2.stop();