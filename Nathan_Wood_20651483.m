% Insert name here 
% Nathan Wood
% Insert email address here 
% egynw4@nottingham.ac.uk


%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [10 MARKS]
clear
% Insert answers here
a = arduino("COM3", "Uno");

for i = 1:10
    writeDigitalPin(a,'D13',1);    %Applies 5V to the Circuit 
    pause(0.5);                    %pauses the program for 0.5 seconds
    writeDigitalPin(a,'D13',0);    %Applies 0V to the Circuit
    pause(0.5);
end

%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]
clear

% Insert answers here
a = arduino("COM3", "Uno");

V0 = 0.5;    %assigns a value to V0
Tc = 0.01;   %assigns a value to the Thermal Coefficient
output = []; %Creates the output array
fprintf("Data Logging Initiated "+ string(date));  %Creates the message for the initalisation
fprintf("Location - Huddersfield \n");             %Continues with the initialisation message

for i = 0:600                                               %runs the program for 10 mins
    voltage = readVoltage(a, "A0");                         %measures the voltage across the thermistor
    voltageArray(1, i+1) = voltage - V0;                    %Keeps a constant record of the voltages
    temperatureArray(1,i+1) = voltageArray(1,i+1) ./ Tc;    %calculates the temperature
    temperatureArray(2, i+1) = i;                           %stores i to make plotting easier
    pause(1);

    if rem(i, 60) == 0                                      %allows for the minute reports to take place on the minute
        minute = i / 60;                                    %stores the minute timer
        output = [output, sprintf('Minute\t\t%d\n', minute)];                            %Creates the text for the minute updates
        output = [output,sprintf('Temperature\t%04.2f C\n\n', temperatureArray(i+1))];
    end
end

%adds the functionality to print Max Min and Mean temperature
output = [output, sprintf('Max temp\t%04.2f C\n', max(temperatureArray(1,:)))];
output = [output, sprintf('Min temp\t%04.2f C\n', min(temperatureArray(1,:)))];
output = [output, sprintf('Mean temp \t%04.2f C\n\n', mean(temperatureArray(1,:)))];

disp(output);

%plots the graph with labels Time and Temperature on the x and y axis
%respectively
plot(temperatureArray(2,:), temperatureArray(1,:), LineWidth=1.5);
xlabel("Time (s)")
ylabel("Temperature (C)")

%opens the file, writes the output data into the file, and closes it
file_one = fopen('cabin_temperature.txt','w');
fprintf(file_one, output);
fclose(file_one);

%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]
clc
clear
% Insert answers here
a = arduino("COM3", "Uno");

i = 0;         %initialises i for looping and array storage
V0 = 0.5;
Tc = 0.01;
output = [];
initialMessage = sprintf("Data Logging Initiated "+ string(date));
locationMessage = sprintf("Location - Nottingham \n");

disp(initialMessage)
disp(locationMessage)

while V0 == 0.5;
    voltage = readVoltage(a, "A0");
    voltageArray(1, i+1) = voltage - V0;
    temperatureArray(1,i+1) = voltageArray(1,i+1) ./ Tc;
    temperatureArray(2, i+1) = i;
    disp(i);
    temp_monitor; %calls the temp_monitor script

    if rem(i, 60) == 0
        minute = i / 60;
        output = [output, sprintf('Minute\t\t%d\n', minute)];
        output = [output,sprintf('Temperature\t%04.2f C\n\n', temperatureArray(i+1))];
    end

    i = i+1;  %iterates the value of i
end

output = [output, sprintf('Max temp\t%04.2f C\n', max(temperatureArray(1,:)))];
output = [output, sprintf('Min temp\t%04.2f C\n', min(temperatureArray(1,:)))];
output = [output, sprintf('Mean temp \t%04.2f C\n\n', mean(temperatureArray(1,:)))];
disp(output);


%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [25 MARKS]
clc
clear
% Insert answers here
a = arduino("COM3", "Uno");


i=0;
changeTime = 30; %sets the period of averaging the temperature increase to 30 secs
V0 = 0.5;
Tc = 0.01;

while V0 == 0.5;
    voltage = readVoltage(a, "A0");
    voltageArray(1, i+1) = voltage - V0;
    temperatureArray(1,i+1) = voltageArray(1,i+1) ./ Tc;
    temperatureArray(2, i+1) = i;
    temp_prediction;  %calls the temp_prediction script
    pause(1);
    i=i+1;
end

%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% Insert reflective statement here (400 words max)
%Overall, I feel that my problem solving has been quite strong in terms of
%figuring out the logic required to solve said problems, decomposing them
%into smaller problems that were much more manageable. My greatest weakness
%in this has probably been the optimisation, where making the code more
%manageable for testing has resulted in unoptimised code, for instance in
%task 2 where the arrays are repeatedly indexed with i+1, when i could
%change it to the minute timer being determined by i-1 instead, however I
%have not changed this as I would have to change it throughout the
%temp_monitor script. I could also do more work for more accurate
%temperature prediction on task 3.

%% TASK 5 - COMMENTING, VERSION CONTROL AND PROFESSIONAL PRACTICE [15 MARKS]

% No need to enter any answershere, but remember to:
% - Comment the code throughout.
% - Commit the changes to your git repository as you progress in your programming tasks.
% - Hand the Arduino project kit back to the lecturer with all parts and in working order.