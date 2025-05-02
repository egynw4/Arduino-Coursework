%Temperature Prediction uses previous temperature readings to find a rate 
%of change of temperature and extrapolates this data to make a prediction
%for the temperature 5 minutes in advance.

xplot = temperatureArray(2,:);
yplot = temperatureArray(1,:);
plot(xplot, yplot);
xlabel = "Time (s)";
ylabel = "Temperature (C)";



if temperatureArray(1, i+1) > 18 & temperatureArray(1, i+1) < 24
    writeDigitalPin(a, "D8", 1)
else
    writeDigitalPin(a, "D8", 0)
end

if  i > 0 && i <changeTime
    temperatureChange = diff(temperatureArray(1,1:i+1)) / diff(temperatureArray(2, 1:i+1));
    predictedTemp = temperatureArray(1, i+1) + ((300/changeTime)*temperatureChange);
    fprintf('Current Temperature: \t%04.2f C\n', temperatureArray(1, i+1));

    if i > 4
        fprintf('Temperature expected in 5 mins: \t%04.2f C\n', predictedTemp);
        fprintf('Temperature Change: \t%04.2f C/s\n\n', temperatureChange)

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

elseif i > changeTime-1
    temperatureChange = diff(temperatureArray(1,i-(changeTime-1):i+1)) / diff(temperatureArray(2, i-(changeTime-1):i+1));
    predictedTemp = temperatureArray(1, i+1) + ((300/changeTime)*temperatureChange);
    fprintf('Current Temperature: \t%04.2f C\n', temperatureArray(1, i+1));
    fprintf('Temperature expected in 5 mins: \t%04.2f C\n', predictedTemp);
    fprintf('Temperature Change: \t%04.2f C/s\n\n', temperatureChange)
        
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

   


