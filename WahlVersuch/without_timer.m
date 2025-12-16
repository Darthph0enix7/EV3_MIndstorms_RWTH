b = EV3();
b.connect('usb');

mx = b.motorA;
my = b.motorB;

mx.setProperties('speedRegulation', 'On', 'limitMode', 'Tacho', 'brakeMode', 'Brake');
my.setProperties('speedRegulation', 'On', 'limitMode', 'Tacho', 'brakeMode', 'Brake');

baseSpeed = 30;
wheelDiameter = 4.32;
clicksPerCm = 360 / (pi * wheelDiameter);

r = 5;
xPath = -r:0.2:r;
yPath = sqrt(r^2 - xPath.^2);

dxList = diff(xPath);
dyList = diff(yPath);

mx.resetTachoCount();
my.resetTachoCount();

for i = 1:length(dxList)
    dx = dxList(i);
    dy = dyList(i);
    
    ticksX = round(dx * clicksPerCm);
    ticksY = round(dy * clicksPerCm);
    
    if abs(ticksX) < 1 && abs(ticksY) < 1
        continue;
    end
    
    distMax = max(abs(ticksX), abs(ticksY));
    
    if distMax == 0
        powerX = 0;
        powerY = 0;
    else
        powerX = (abs(ticksX) / distMax) * baseSpeed;
        powerY = (abs(ticksY) / distMax) * baseSpeed;
    end
    
    if powerX > 0 && powerX < 5
        powerX = 5;
    end
    if powerY > 0 && powerY < 5
        powerY = 5;
    end
    
    mx.resetTachoCount();
    my.resetTachoCount();
    
    mx.limitValue = abs(ticksX);
    my.limitValue = abs(ticksY);
    
    mx.power = round(powerX * sign(dx));
    my.power = round(powerY * sign(dy));
    
    if abs(ticksX) > 0
        mx.start();
    end
    
    if abs(ticksY) > 0
        my.start();
    end
    
    if abs(ticksX) > 0
        mx.waitFor();
    end
    
    if abs(ticksY) > 0
        my.waitFor();
    end
end

mx.stop();
my.stop();

b.disconnect();