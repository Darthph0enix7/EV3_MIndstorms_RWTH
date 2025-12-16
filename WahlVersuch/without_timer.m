b = EV3();
b.connect('usb');

mx = b.motorA;
my = b.motorB;

mx.setProperties('speedRegulation', 'On', 'limitMode', 'Tacho', 'brakeMode', 'Brake');
my.setProperties('speedRegulation', 'On', 'limitMode', 'Tacho', 'brakeMode', 'Brake');

mx.resetTachoCount();
my.resetTachoCount();

wheelDia = 4.32;
degPerCm = 360 / (pi * wheelDia);
maxSpeed = 40;

t = 0:0.1:2*pi;
xPath = 10 + 5 * cos(t);
yPath = 10 + 5 * sin(t);

currentAbsX = 0;
currentAbsY = 0;

for i = 1:length(xPath)
    targetAbsX = round(xPath(i) * degPerCm);
    targetAbsY = round(yPath(i) * degPerCm);
    
    deltaX = targetAbsX - currentAbsX;
    deltaY = targetAbsY - currentAbsY;
    
    if abs(deltaX) < 1 && abs(deltaY) < 1
        continue;
    end
    
    maxDist = max(abs(deltaX), abs(deltaY));
    
    speedX = (abs(deltaX) / maxDist) * maxSpeed;
    speedY = (abs(deltaY) / maxDist) * maxSpeed;
    
    if speedX < 5 && speedX > 0
        speedX = 5;
    end
    if speedY < 5 && speedY > 0
        speedY = 5;
    end
    
    mx.power = round(speedX * sign(deltaX));
    my.power = round(speedY * sign(deltaY));
    
    mx.limitValue = abs(deltaX);
    my.limitValue = abs(deltaY);
    
    mx.resetTachoCount();
    my.resetTachoCount();
    
    if abs(deltaX) > 0
        mx.start();
    end
    if abs(deltaY) > 0
        my.start();
    end
    
    if abs(deltaX) > 0
        mx.waitFor();
    end
    if abs(deltaY) > 0
        my.waitFor();
    end
    
    currentAbsX = targetAbsX;
    currentAbsY = targetAbsY;
end

mx.stop();
my.stop();
b.disconnect();
