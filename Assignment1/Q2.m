% create a matrix to store the results
% the first column has values of i
% the second column has the values of d0
% the third column has the values of d1
% the fourth column has the values of d2
% the fifth column has the values of d0-d1
% the sixth column has the values of d0-d2
% the seventh column has the values of h
% the eighth column has the values of |d0-d1|
% the ninth column has the values of |d0-d2|
outputMatrix = zeros(17, 9); % the size of the matrix is 17 * 9

a = 10; % or 10 based on the question
 
% loop through all integers from 1 to 17. 
% perform the computation in three ways and store the values into
% corresponding vectors in the matrix created above.
for i = 1 : 17

    h = 10^(-i);
    outputMatrix(i,1) = i; % the interger i
    outputMatrix(i,2) = 1/(2*sqrt(a)); % the exact d0
    outputMatrix(i,3) = (sqrt(a + h) - sqrt(a - h))/(2 * h); % calculate d1
    outputMatrix(i,4) = 1/(sqrt(a + h) + sqrt(a - h)); % calculate d2
    outputMatrix(i,5) = outputMatrix(i,2) - outputMatrix(i,3); % d0 - d1
    outputMatrix(i,6) = outputMatrix(i,2) - outputMatrix(i,4); % d0 - d2
    outputMatrix(i,7) = h; % the last column for storing the values of h
    outputMatrix(i,8) = abs(outputMatrix(i,5)); % |d0 - d1|
    outputMatrix(i,9) = abs(outputMatrix(i,6)); % |d0 - d2|
    
end
 
h_vector = outputMatrix(:,7); % a vector has the values of h
d0_d1 = outputMatrix(:,8); % a vector has the values of |d0 - d1|
d0_d2 = outputMatrix(:,9); % a vector has the values of |d0 - d2|
 
loglog(h_vector,d0_d1,'-s') % plot the |d0 - d1| vs. h in log-log scale
hold on;
loglog(h_vector,d0_d2,'-.') % plot the |d0 - d2| vs. h in log-log scale
axis([1e-18 2e-1 1e-17 1]) % set the axis as the question asked
 
% print out the outputMatrix to a .txt file.
fileID = fopen('outputAssignment1Q2d_10.txt', 'w'); % or 'outputAssignment1Q2d_10.txt', depends on the value of a
fprintf(fileID, '%3s %17s %17s %17s %8s %8s\n','i', 'd0', 'd1', 'd2', 'd0-d1', 'd0-d2'); % print the title
fprintf(fileID, '%3d %17.14f %17.14f %17.14f %8.1e %8.1e\n',outputMatrix(:,1:6)'); % print the actual data
fclose(fileID);
