%temp_monitor takes the data from the below code and provides an output based on the value it receives. 
%If the value is >24, the red light will blink every 0.25 secs
%If the value is <18, the amber light will blink every 0.5 seconds
%Otherwise the green light will remain on.
%This will allow for simple monitoring of the temperature in the cabin, being able to quickly assertain a rough reading of the temperature without having to look at a thermometer

yplot = temperatureArray(1,:);                   %assigns the y axis to be plotted as the temperature
xplot = temperatureArray(2,:);                   %assigns the x axis to be plotted as the tiem
plot(xplot, yplot, LineWidth=1.5,Color="b");     %plots the graph and formats the line
%labelling for x and y axis
xlabel = "Time (s)";
ylabel = "Temperature (C)";

%function for engaging the red LED
if temperatureArray(1, i+1) > 24;
    for j = 1:2                        %carries out the function twice so that it lasts 1 second
        writeDigitalPin(a, 'D8', 0);   %ensures green light is off
        writeDigitalPin(a, 'D10', 1);  %turns red light on
        pause(0.25);
        writeDigitalPin(a, 'D10', 0);  %turns red light off
        pause(0.25);
    end
end

%function for engaging the amber LED
if temperatureArray(1, i+1) < 18;
    writeDigitalPin(a, 'D8', 0);      %ensures green light is off
    writeDigitalPin(a,'D9', 1);       %turns amber light on
    pause(0.5);
    writeDigitalPin(a,'D9', 0);       %turns amber light off
    pause(0.5);
end

%function for engaging the green LED
if temperatureArray(1, i+1) > 18 & temperatureArray(1, i+1) < 24;
    writeDigitalPin(a, 'D8', 1);      %turns green light on
    pause(1);
end