% initialize paramters as a = 2, b = 1, xp = 1.4, yp = 1.7
a = 2;
b = 1;
p = [1.4; 1.7];
%r = [pi/4; -pi/2];
r = [pi/4; pi/2];


% set the first arm starting point at (0,0)
x0 = 0;
y0 = 0;

% calculate the first arm end point before moving (initial location)
xm_initial = a*cos(r(1));
ym_initial = a*sin(r(1));

% calculate the second arm end point before moving (initial location)
xp_initial = a*cos(r(1))+b*cos(r(1)+r(2));
yp_initial = a*sin(r(1))+b*sin(r(1)+r(2));

% call the funtion to perform Newton's method
[r, it, rall, res] = robotarm(a, b, p, r, 10^(-8));

% calculate the first arm end point using computed angles
xm = a*cos(r(1)); 
ym = a*sin(r(1));

% calculate the second arm end point using computed angles
xp = a*cos(r(1))+b*cos(r(1)+r(2));
yp = a*sin(r(1))+b*sin(r(1)+r(2));

% plot the arms: both initial position and position after moving 
plot([x0,xm_initial], [y0, ym_initial],'-.');
hold on;
plot([xm_initial, xp_initial],[ym_initial,yp_initial], '-.');
plot([x0, xm], [y0, ym]);
hold on;
plot([xm, xp],[ym,yp]);
axis equal
xlabel('x-axis');
ylabel('y-axis');
%title('Plot for starting position at [Pi/4, -Pi/2]')
title('Plot for starting position at [Pi/4, Pi/2]')

% output the angles calculated at each iteration.
disp(rall);
% output the Eucidean norm of residual calculated at each iteration
disp(res);

% the function for performing Newton's method
function [r, it, rall, res] = robotarm(a, b, p, r, tol)
rall = r';
res = [];
it = 0;
temp_res = 1;

f = zeros(2,1);

while (temp_res > tol) 

Jacobian = zeros(2,2);

% calculate the Jacobian Matrix
Jacobian(1,1) = -a*sin(r(1))-b*sin(r(1)+r(2));
Jacobian(1,2) = -b*sin(r(1)+r(2));
Jacobian(2,1) = a*cos(r(1))+b*cos(r(1)+r(2));
Jacobian(2,2) = b*cos(r(1)+r(2));

% calculate the vector of f using updated angles
f(1) = a*cos(r(1))+b*cos(r(1)+r(2))-p(1);
f(2) = a*sin(r(1))+b*sin(r(1)+r(2))-p(2);

% compute Newton step
v = Jacobian\(-f); 

% update solution 
r = r + v; 

% use Eclidean norms to calculate residuals 
temp_res = sqrt((a*cos(r(1))+b*cos(r(1)+r(2))-p(1))^2 +(a*sin(r(1))+b*sin(r(1)+r(2))-p(2))^2); 

% update residuals
res = [res; temp_res];

% update rall array to keep track the angles
rall = [rall; r'];

% count the number of iterations
it = it + 1;
end

% get rid of the last iteration value, since it is already convergent
it = it -1;
rall = rall(1:it + 1,:);
res = res(1:it);
end

