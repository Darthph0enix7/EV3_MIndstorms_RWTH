function [values] = soundsensor()
    handle = EV3();
    handle.connect("usb");
    handle.sensor2.mode = DeviceMode.NXTSound.DB;

    values = zeros(0,1000);
    
    for i = 1:1000
        values(i) = handle.sensor2.value;
    end
    
    plot(values);
    handle.disconnect();
end