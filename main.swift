import Accelerate

// Function to solve a system of linear equations Ax = b
func solveLinearSystem(coefficients: [Double], constants: [Double]) -> [Double]? {
    // Validate input dimensions
    let n = __CLPK_integer(sqrt(Double(coefficients.count)))
    guard coefficients.count == Int(n * n) && constants.count == Int(n) else {
        print("Invalid matrix or vector dimensions")
        return nil
    }

    // Prepare the LU decomposition and pivot array
    var A = coefficients
    var b = constants
    var pivots = [__CLPK_integer](repeating: 0, count: Int(n))
    var error: __CLPK_integer = 0

    // Perform LU decomposition
    withUnsafeMutablePointer(to: &n) { nPtr in
        dgetrf_(nPtr, nPtr, &A, nPtr, &pivots, &error)
    }

    // Check for singularity
    if error != 0 {
        print("Matrix is singular and cannot be solved")
        return nil
    }

    // Solve the system of equations
    withUnsafeMutablePointer(to: &n) { nPtr in
        dgetrs_("N", nPtr, nPtr, &A, nPtr, &pivots, &b, nPtr, &error)
    }

    // Check for errors during solving
    if error != 0 {
        print("An error occurred while solving the system")
        return nil
    }

    // Return the solution vector
    return b
}

// Define the coefficients matrix A (flattened 2D array in row-major order)
let coefficients: [Double] = [2, 3,
                              4, 1]

// Define the constants vector b
let constants: [Double] = [5, 6]

// Solve the system of equations
if let solution = solveLinearSystem(coefficients: coefficients, constants: constants) {
    print("The solution is:")
    for (index, value) in solution.enumerated() {
        print("x[\(index)] = \(value)")
    }
} else {
    print("Failed to solve the system of equations")
}
