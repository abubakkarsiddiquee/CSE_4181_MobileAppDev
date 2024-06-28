import Accelerate

// Define the coefficients matrix A
let A: [Double] = [2, 3, 
                   4, 1]

// Define the constants vector b
var b: [Double] = [5, 6]

// Number of equations
let n = __CLPK_integer(sqrt(Double(A.count)))

// LU decomposition requires an array of pivot indices
var pivots = [__CLPK_integer](repeating: 0, count: n)
var workspace = [Double](repeating: 0.0, count: n)
var error: __CLPK_integer = 0

// Perform LU decomposition
withUnsafeMutablePointer(to: &n) { nPtr in
    dgetrf_(nPtr, nPtr, &A, nPtr, &pivots, &error)
}

// Solve the system of equations
withUnsafeMutablePointer(to: &n) { nPtr in
    dgetrs_("N", nPtr, nPtr, &A, nPtr, &pivots, &b, nPtr, &error)
}

// Display the solution
print("The solution is:")
print(b)
