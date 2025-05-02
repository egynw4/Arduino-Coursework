%Temperature Prediction uses previous temperature readings to find a rate 
%of change of temperature and extrapolates this data to make a prediction
%for the temperature 5 minutes in advance.

%create the parameters for x and y axis plots
xplot = temperatureArray(2,:); 
yplot = temperatureArray(1,:);

plot(xplot, yplot, LineWidth=1.5, Color="b");     %plots the graph with formatting

%assigns labels to the x and y axis
xlabel = "Time (s)";
ylabel = "Temperature (C)";



if temperatureArray(1, i+1) > 18 && temperatureArray(1, i+1) < 24    %checks the parameters for the green LED to turn on
    writeDigitalPin(a, "D8", 1)                                      %turns the green LED on
else
    writeDigitalPin(a, "D8", 0)                                      %turns the green LED off
end

%finding the temperature change until the time passed = changeTime, to avoid index errors
if  i > 0 && i <changeTime
    temperatureChange = diff(temperatureArray(1,1:i+1)) / diff(temperatureArray(2, 1:i+1));  %finds the value of the temperature change
    predictedTemp = temperatureArray(1, i+1) + ((300/changeTime)*temperatureChange);         %finds the estimate for temperature in 5 mins
    fprintf('Current Temperature: \t%04.2f C\n', temperatureArray(1, i+1));                  %prints the current temperature

    %only prints the change in temperature after 5 secs to allow values to even out and reduce uncertainty
    if i > 4
        fprintf('Temperature expected in 5 mins: \t%04.2f C\n', predictedTemp);             %prints the predicted temperature
        fprintf('Temperature Change: \t%04.2f C/s\n\n', temperatureChange)                  %prints the change in temperature (C/s)

    end
      
    %checks eligibility for the red LED to turn on
     if temperatureChange > 4
        writeDigitalPin(a, "D9", 0);    %amber off
        writeDigitalPin(a, "D10", 1);   %red on
        
   %checks eligibility for the amber LED to turn on
    elseif temperatureChange < -4
        writeDigitalPin(a, "D9", 1);    %amber on
        writeDigitalPin(a, "D10", 0);   %red off

   %turns off the red and amber LED if neither are eligible
    else
        writeDigitalPin(a, "D9", 0);    %amber off
        writeDigitalPin(a, "D10", 0);   %red off

    end


%changes in temperature after time reaches 30 secs
elseif i > changeTime-1
    temperatureChange = diff(temperatureArray(1,i-(changeTime-1):i+1)) / diff(temperatureArray(2, i-(changeTime-1):i+1));  %finds the value of the temperature change
    predictedTemp = temperatureArray(1, i+1) + ((300/changeTime)*temperatureChange);                                       %finds the estimate for temperature in 5 mins
    fprintf('Current Temperature: \t%04.2f C\n', temperatureArray(1, i+1));            %outputs the current temperature
    fprintf('Temperature expected in 5 mins: \t%04.2f C\n', predictedTemp);            %outputs the predicted temperature
    fprintf('Temperature Change: \t%04.2f C/s\n\n', temperatureChange);                %outputs the change in temperature (C/s)      
        
    %checks eligibility for the red LED to turn on
     if temperatureChange > 4
        writeDigitalPin(a, "D9", 0);    %amber off
        writeDigitalPin(a, "D10", 1);   %red on
        
   %checks eligibility for the amber LED to turn on
    elseif temperatureChange < -4
        writeDigitalPin(a, "D9", 1);    %amber on
        writeDigitalPin(a, "D10", 0);   %red off

   %turns off the red and amber LED if neither are eligible
    else
        writeDigitalPin(a, "D9", 0);    %amber off
        writeDigitalPin(a, "D10", 0);   %red off

    end
end  

   


