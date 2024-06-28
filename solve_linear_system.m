% Define the coefficients matrix A
A = [2 3; 4 1];

% Define the constants vector b
b = [5; 6];

% Solve the system of equations Ax = b
x = A\b;

% Display the solution
disp('The solution is:');
disp(x);
