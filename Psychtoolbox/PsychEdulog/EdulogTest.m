function [test, tFig] = EdulogTest(port, dur, sps, loggers)
% Perform a test to ensure that eduloggers are working, then plot the data.
% This program will repeat until the user confirms data is acceptible, or
% cancels.
%
% "port" is the port Eduloggers are connected to, this is visible on the
% Neulog API window.
% "dur" is the duration (s) of the clap test, it must be at least 15s for
% any response to be visible.
% "sps" is the number of samples the edulogger should take per second, up
% to a maximum of 5.
% "loggers" is a one dimensional cell array, with each string specifying
% the name of a different Edulogger as described in the Neulog API 
% literature:
% https://neulog.com/wp-content/uploads/2014/06/NeuLog-API-version-7.pdf
%
% "test" is a structure generated by running an Edulogger experiment,
% consisting of the following fields:
% Time: The time (s) since the start of the experiment of each sample.
% (double)
% Concern: Whether or not each sample took more than twice the specified
% sample rate to retrieve (logical)
% Event (optional): Whether or not an event happened at this point
% (logical)
% An additional field for each kind of Edulogger used, containing the
% measurements taken at each point in data.Time. Fieldnames should line up 
% with the names specified in "loggers".
% "tFig" is a Graphics Object containing the graph generated, properties of
% the graph can be changed by editing this object.

input('Press ''Enter'' to test eduloggers...\n', 's'); % Wait for user response to begin test
cont = false; % Set cont initially equal to false

while cont == false % While cont is false...
    switch testcycle % What is the value of testcycle?
        case 'No' % If it's No...
            test = EdulogRun(port, dur, sps, loggers); % Run the eduloggers
            tFig = EdulogPlot(test, loggers); % Plot results
            testcycle = questdlg('Does this data look reasonable?','Test Eduloggers','Yes','No', 'Cancel','Yes'); % Ask user whether to move on
            close all % Close plot
        case 'Yes' % If it's Yes...
            cont = true; % Set cont to true so the script moves on
            close all % Close plot
        case 'Cancel' % If it's Cancel...
            cont = true; % Set cont to true so the script moves on
            close all % Close plot
            error('Edulogger test cancelled') % Return an error
    end
end

end