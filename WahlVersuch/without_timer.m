b = EV3();
b.connect('usb');

mx = b.motorA;
my = b.motorB;
mc = b.motorC;

mx.setProperties('speedRegulation', 'On', 'limitMode', 'Tacho', 'brakeMode', 'Brake');
my.setProperties('speedRegulation', 'On', 'limitMode', 'Tacho', 'brakeMode', 'Brake');
mc.setProperties('speedRegulation', 'On', 'limitMode', 'Tacho', 'brakeMode', 'Brake');

ratioX = 4;
ratioY = 1;
Durchmesser = 4.32;

degPerCmX = (360 * ratioX) / (pi * Durchmesser);
degPerCmY = -1 * (360 * ratioY) / (pi * Durchmesser); 

maxSpeed = 40;
penSpeed = 10;
penAngle = 0; 
penDownAngle = 90; 

t = 0:0.1:2*pi;
xPathCm = 10 + 5 * cos(t);
yPathCm = 10 + 5 * sin(t);

plot(xPathCm, yPathCm);

xPathDeg = round(xPathCm * degPerCmX);
yPathDeg = round(yPathCm * degPerCmY);

dX = diff(xPathDeg);
dY = diff(yPathDeg);

numSteps = length(dX);
powerX_List = zeros(1, numSteps);
powerY_List = zeros(1, numSteps);
limitX_List = abs(dX);
limitY_List = abs(dY);

for k = 1:numSteps
    changeX = dX(k);
    changeY = dY(k);
    
    if abs(changeX) < 1 && abs(changeY) < 1
        powerX_List(k) = 0;
        powerY_List(k) = 0;
        continue;
    end
    
    maxDist = max(abs(changeX), abs(changeY));
    
    spdX = (abs(changeX) / maxDist) * maxSpeed;
    spdY = (abs(changeY) / maxDist) * maxSpeed;
    
    if spdX < 5 && spdX > 0
        spdX = 5;
    end
    if spdY < 5 && spdY > 0
        spdY = 5;
    end
    
    powerX_List(k) = round(spdX * sign(changeX));
    powerY_List(k) = round(spdY * sign(changeY));
end

mc.power = -penSpeed;
mc.limitValue = abs(penAngle - penDownAngle); 
mc.resetTachoCount();
mc.start();
mc.waitFor();

startX = xPathDeg(1);
startY = yPathDeg(1);

mx.limitValue = abs(startX);
my.limitValue = abs(startY);

mx.power = 20 * sign(startX);
my.power = 20 * sign(startY);

mx.resetTachoCount();
my.resetTachoCount();

if abs(startX) > 0
    mx.start(); 
end
if abs(startY) > 0
    my.start(); 
end
mx.waitFor();
my.waitFor();

mc.power = penSpeed;
mc.limitValue = abs(penAngle - penDownAngle);
mc.resetTachoCount();
mc.start();
mc.waitFor();

for i = 1:numSteps
    limX = limitX_List(i);
    limY = limitY_List(i);
    powX = powerX_List(i);
    powY = powerY_List(i);
    
    if limX == 0 && limY == 0
        continue;
    end
    
    mx.limitValue = limX;
    my.limitValue = limY;
    
    mx.power = powX;
    my.power = powY;
    
    mx.resetTachoCount();
    my.resetTachoCount();
    
    if limX > 0
        mx.start(); 
    end
    if limY > 0
        my.start(); 
    end
    
    if limX > 0
        mx.waitFor(); 
    end
    if limY > 0
        my.waitFor(); 
    end
end

mc.power = -penSpeed;
mc.limitValue = abs(penAngle - penDownAngle);
mc.resetTachoCount();
mc.start();
mc.waitFor();

mx.stop();
my.stop();
mc.stop();
b.disconnect();
