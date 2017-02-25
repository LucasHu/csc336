%%% Method1
% set the initial value to be 0.
s1 = 0; 

% set the exact of the series.
s = (pi)^2/6;

% i is the index in the original summation formula
i = 1;

% stop the summation when the value of sum is no longer changing.
while s1 ~= (s1 + 1/(i^2))
    s1 = s1 + 1/(i^2);
    i = i + 1; % i increases after every loop
end

relativeError_s1 = (s - s1)/s; % calculate the relative error for s1

%%% Method2
% set the initial value to be 0. 
s2 = 0;

last_h = 10000000000;

for h = last_h : -1 : 1
    s2 = s2 + 1/(h^2);
end

relativeError_s2 = (s - s2)/s; % calculate the relative error for s2

% print out the outputmatirx to a .txt file.
fileID = fopen('outputAssignment1Q3.txt', 'w');
fprintf(fileID, '%12s %18s %18s %8s\n', 'i-1', 's0', 's1', '(s0-s1)/s0)'); % print the title
fprintf(fileID, '%12d %18.16f %18.16f %8.1e\n', i-1, s, s1, relativeError_s1); % print the actual data
fprintf(fileID, '%12s %18s %18s %8s\n', 'i', 's0', 's2', '(s0-s2)/s0)'); % print the title
fprintf(fileID, '%12d %18.16f %18.16f %8.1e\n', last_h, s, s2, relativeError_s2); % print the actual data
fclose(fileID);



