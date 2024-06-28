import { Matrix, math } from 'mathjs';

// Define the coefficients matrix A
const A: Matrix = math.matrix([
  [2, 3],
  [4, 1]
]);

// Define the constants vector b
const b: Matrix = math.matrix([5, 6]);

// Function to solve a system of linear equations Ax = b
function solveLinearSystem(A: Matrix, b: Matrix): number[] | null {
  try {
    // Solve the system of equations
    const solution = math.lusolve(A, b);
    
    // Convert solution to array and return
    return solution.valueOf() as number[];
  } catch (error) {
    console.error('An error occurred while solving the system:', error);
    return null;
  }
}

// Solve the system of equations
const solution = solveLinearSystem(A, b);

// Display the solution
if (solution) {
  console.log('The solution is:');
  solution.forEach((value, index) => {
    console.log(`x[${index}] = ${value}`);
  });
} else {
  console.log('Failed to solve the system of equations');
}
