% Insert name here 
% Nathan Wood
% Insert email address here 
% egynw4@nottingham.ac.uk


%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [10 MARKS]
clear
% Insert answers here
a = arduino("COM3", "Uno");

for i = 1:10
    writeDigitalPin(a,'D13',1);
    pause(0.5);
    writeDigitalPin(a,'D13',0);
    pause(0.5);
    disp(i);
end

%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]
clear

% Insert answers here
a = arduino("COM3", "Uno");
duration = input("Enter Test Duration: ");
V0 = 0.5;
Tc = 0.01;
output = [];
initialMessage = sprintf("Data Logging Initiated "+ string(date));
locationMessage = sprintf("Location - Huddersfield \n");

disp(initialMessage)
disp(locationMessage)

for i = 0:duration
    voltage = readVoltage(a, "A0");
    voltageArray(1, i+1) = voltage - V0;
    temperatureArray(1,i+1) = voltageArray(1,i+1) ./ Tc;
    temperatureArray(2, i+1) = i;
    pause(1)
    disp(i);

    if rem(i, 60) == 0
        minute = i / 60;
        output = [output, sprintf('Minute\t\t%d\n', minute)];
        output = [output,sprintf('Temperature\t%04.2f C\n\n', temperatureArray(i+1))];
    end
end

output = [output, sprintf('Max temp\t%04.2f C\n', max(temperatureArray(1,:)))];
output = [output, sprintf('Min temp\t%04.2f C\n', min(temperatureArray(1,:)))];
output = [output, sprintf('Mean temp \t%04.2f C\n\n', mean(temperatureArray(1,:)))];

disp(output);

plot(temperatureArray(2,:), temperatureArray(1,:), LineWidth=1.5);
xlabel("Time (s)")
ylabel("Temperature (C)")

file_one = fopen('cabin_temperature.txt','w');
fprintf(file_one, output);
fclose(file_one);

%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

% Insert answers here
matlab.git.clearCredential("https://github.com/egynw4/Arduino-Coursework.git")

%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [25 MARKS]

% Insert answers here


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% Insert reflective statement here (400 words max)


%% TASK 5 - COMMENTING, VERSION CONTROL AND PROFESSIONAL PRACTICE [15 MARKS]

% No need to enter any answershere, but remember to:
% - Comment the code throughout.
% - Commit the changes to your git repository as you progress in your programming tasks.
% - Hand the Arduino project kit back to the lecturer with all parts and in working order.