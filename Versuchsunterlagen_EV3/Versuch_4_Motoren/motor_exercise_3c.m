%% Aufgabe Zahlendarstellung c)
% Template


%%  ----- MATLAB Calculation -----
 

%% Get two numbers from user dialog
% Tips:
% * use MATLAB command "inputdlg".
% * see MATLAB help for usage and more information.
% * convert the reponse cell array into numbers using "str2double"
%
% ... insert here your code
prompt = {'Enter number 1:','Enter number 2:'};
dlgtitle = 'Input';
fieldsize = [1 45; 1 45];
answer = inputdlg(prompt,dlgtitle,fieldsize);


%% Calculate the summation of the two numbers
% ... insert here your code
result = str2double(answer(1)) + str2double(answer(2));
dec = floor(result/10);
single = mod(result, 10);

%% Initialize figures
plot_number_face;   % plot calculator face figure
hold on             % hold on flag to plot more plots into the calculator face figure



%% Calculate pointers to plot
% Tips:
% * for line plotting only the start and end point of the line has to be given
% * the rotated pointers can be easily constructed by a complex number (value and phase)
% * the length of the complex vectors should be different for both pointers and less than one
% * note the number zero is located at the coordinates (x,y) = (0,1) or (0,i) respectively
% * take care to use degrees or radian
% * consider only angles which are related to the exact number position. Angles between two
% numbers should be neglected.
%
% ... insert here your code
decDeg = pi/2 - dec * pi/5;
singDeg = pi/2 - single * pi/5;


%% Plot pointers into the figure
% Tips:
% * for line plotting only the start and end point of the line has to be given
% * use different colors for the pointers
%
% ... insert here your code

plot([0, 0.8*cos(decDeg)], [0, 0.8*sin(decDeg)], 'LineWidth',8);
plot([0, 0.4*cos(singDeg)], [0, 0.4*sin(singDeg)], 'LineWidth',8);


%% Mindstorms NXT - Control
%

%%
% *Program the Mindstorms machine*
%
% ... insert here your code
b=EV3();
b.connect('usb');
m1=b.motorA;
m2=b.motorB;

m1.internalReset();
m2.internalReset();

m1.limitMode='Tacho'
m2.limitMode='Tacho'
m1.brakeMode='Brake'
m2.brakeMode='Brake'
decDeg
m1.tachoCount
decDeg = int32(-1*(decDeg*360/(2*pi) + m1.tachoCount));
decDeg
while decDeg < 0
    decDeg = decDeg + 360;
end
while decDeg > 360
    decDeg = decDeg - 360;
end
decDeg
singDeg = int32(singDeg*360/(2*pi) + m2.tachoCount);
if singDeg < 0
    singDeg = singDeg + 360;
elseif singDeg > 360
    singDeg = singDeg - 360;
end
singDeg
m1.limitValue= decDeg;
m2.limitValue= singDeg;
m1.resetTachoCount();
m2.resetTachoCount();


m1.start();
m1.waitFor();
m2.start();
m2.waitFor();
m1.stop();
m2.stop();

pause(5);
m1.limitValue= 360-decDeg;
m2.limitValue= 360-singDeg;

m1.start();
m1.waitFor();
m2.start();
m2.waitFor();
m1.stop();
m2.stop();


b.disconnect();