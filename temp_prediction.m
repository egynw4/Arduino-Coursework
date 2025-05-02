xplot = temperatureArray(2,:);
yplot = temperatureArray(1,:);
plot(xplot, yplot);

if temperatureArray(1, i+1) > 18 & temperatureArray(1, i+1) < 24
    writeDigitalPin(a, "D8", 1)
else
    writeDigitalPin(a, "D8", 0)
end

if  i > 0
    temperatureChange = diff(temperatureArray(1,1:i+1)) / diff(temperatureArray(2, 1:i+1));
    predictedTemp = temperatureArray(1, i+1) + ((300/i)*temperatureChange);
    fprintf('Current Temperature: \t%04.2f C\n', temperatureArray(1, i+1));
    
    if i > 4
        fprintf('Temperature expected in 5 mins: \t%04.2f C/s\n\n', predictedTemp);

    end
        if temperatureChange > 4
        writeDigitalPin(a, "D9", 0);
        writeDigitalPin(a, "D10", 1)
        
    elseif temperatureChange < -4
        writeDigitalPin(a, "D9", 1);
        writeDigitalPin(a, "D10", 0);

    else
        writeDigitalPin(a, "D9", 0);
        writeDigitalPin(a, "D10", 0);

    end
end



   


