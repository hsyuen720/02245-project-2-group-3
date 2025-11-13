# Viper Examples

This directory contains verification examples written in the Viper language. Each file demonstrates different aspects of formal program verification.

## Examples

### 01_sum.vpr - Sum of Natural Numbers
**Concepts:** Loop invariants, mathematical reasoning, induction

Computes the sum of the first n natural numbers (0 + 1 + 2 + ... + n) and proves it equals n*(n+1)/2.

**Key specifications:**
- Precondition: n must be non-negative
- Postcondition: Result matches the mathematical formula
- Loop invariant: Maintains the sum relationship at each iteration

### 02_array_max.vpr - Maximum Element
**Concepts:** Array reasoning, quantified specifications, existential properties

Finds the maximum element in an array and proves both that it's greater than or equal to all elements and that it exists in the array.

**Key specifications:**
- Universal quantifier: max is greater than or equal to all elements
- Existential quantifier: max is actually in the array
- Loop invariant: max is greatest among elements seen so far

### 03_factorial.vpr - Factorial Computation
**Concepts:** Recursive functions, iterative implementation, mathematical properties

Defines factorial recursively and implements it iteratively, proving the iterative version matches the recursive definition.

**Key specifications:**
- Recursive function definition as specification
- Loop invariant: maintains factorial relationship
- Termination: guaranteed by decreasing iteration variable

### 04_binary_search.vpr - Binary Search
**Concepts:** Sorted sequences, search algorithms, complex invariants

Implements binary search on a sorted array, proving correctness and completeness of the search.

**Key specifications:**
- Precondition: Array must be sorted
- Postcondition: If found, result is correct; if not found, element doesn't exist
- Loop invariant: Search space progressively narrows while maintaining correctness

### 05_gcd.vpr - Greatest Common Divisor
**Concepts:** Euclidean algorithm, mathematical properties, divisibility

Computes the greatest common divisor of two integers using the Euclidean algorithm.

**Key specifications:**
- Divisibility function definition
- Loop invariant: maintains GCD property through iterations
- Result: proven to divide both input numbers

### 06_swap.vpr - Variable and Array Swapping
**Concepts:** State changes, array updates, immutable sequences

Demonstrates swapping values and proves the state after swap matches expectations.

**Key specifications:**
- Simple swap: values are exchanged
- Array swap: two elements exchange positions while others remain unchanged
- Sequence update syntax in Viper

### 07_absolute_value.vpr - Absolute Value
**Concepts:** Conditional reasoning, branch coverage, non-negativity

Computes absolute value and proves the result is always non-negative and matches the input's magnitude.

**Key specifications:**
- Conditional postconditions based on input sign
- Branch verification: both paths proven correct
- Distance function built on absolute value

### 08_array_sum.vpr - Array Summation
**Concepts:** Recursive specifications, array aggregation, sequence reasoning

Sums all elements in an array using a recursive function specification and iterative implementation.

**Key specifications:**
- Recursive function for sum specification
- Loop invariant: partial sum matches recursive definition
- Accumulator pattern verification

### 09_predicates.vpr - Predicates and Abstract Specifications
**Concepts:** Predicate definitions, folding/unfolding, abstract specifications

Demonstrates how to use predicates to encapsulate and abstract specifications, including range validation and sorted segment checking.

**Key specifications:**
- Predicate definitions for reusable specifications
- Fold/unfold operations for predicates
- Abstract bounds checking and validation
- Compositional verification with predicates

### 10_matrix.vpr - Matrix Operations
**Concepts:** Nested sequences, 2D reasoning, nested loops, complex data structures

Implements matrix operations including transpose, element access, and summation with verification of 2D array properties.

**Key specifications:**
- Valid matrix predicate (all rows same length)
- Nested loop invariants for 2D traversal
- Transpose correctness: result[j][i] == matrix[i][j]
- Complex quantified properties over 2D structures

## Verification Concepts Used

### Specifications
- **Preconditions** (`requires`): What must be true before execution
- **Postconditions** (`ensures`): What is guaranteed after execution
- **Invariants** (`invariant`): Properties maintained throughout loops

### Quantifiers
- **Universal** (`forall`): Property holds for all elements
- **Existential** (`exists`): Property holds for at least one element

### Data Types
- **Int**: Unbounded mathematical integers
- **Bool**: Boolean values
- **Seq[T]**: Immutable sequences (arrays)

### Functions vs Methods
- **Functions**: Pure, can be used in specifications
- **Methods**: Can have side effects, verified separately

## Running the Examples

### Option 1: Viper IDE (Recommended)
1. Install Visual Studio Code
2. Install the "Viper" extension
3. Open any `.vpr` file
4. Verification runs automatically

### Option 2: Command Line (if tools installed)
```bash
# Using Silicon backend
silicon 01_sum.vpr

# Using Carbon backend
carbon 01_sum.vpr
```

### Option 3: ViperServer
```bash
# Start server (if you have viperserver.jar)
java -jar viperserver.jar

# Use HTTP API to submit verification requests
```

## Expected Verification Results

All examples in this directory are designed to verify successfully with both Silicon and Carbon backends. They demonstrate:

✅ Correct loop invariants
✅ Proper preconditions and postconditions
✅ Valid quantified assertions
✅ Termination guarantees
✅ Type safety
✅ Memory safety (where applicable)

## Learning Path

Recommended order for studying these examples:

1. **Beginner**: Start with 01_sum.vpr, 06_swap.vpr, 07_absolute_value.vpr
2. **Intermediate**: Move to 02_array_max.vpr, 03_factorial.vpr, 08_array_sum.vpr
3. **Advanced**: Study 04_binary_search.vpr, 05_gcd.vpr, 09_predicates.vpr
4. **Expert**: Explore 10_matrix.vpr for complex 2D reasoning

## Common Patterns

### Pattern: Loop with Accumulator
```viper
var accumulator := initial_value
var i := 0
while (i < n)
  invariant 0 <= i && i <= n
  invariant accumulator == f(i)  // relates accumulator to iteration
{
  accumulator := accumulator + contribution
  i := i + 1
}
```

### Pattern: Array Processing
```viper
var i := 0
while (i < |array|)
  invariant 0 <= i && i <= |array|
  invariant forall j :: 0 <= j && j < i ==> property(array[j])
{
  // process array[i]
  i := i + 1
}
```

### Pattern: Conditional Property
```viper
method example(x: Int) returns (r: Int)
  ensures x >= 0 ==> r == x
  ensures x < 0 ==> r == -x
{
  if (x >= 0) { r := x } else { r := -x }
}
```

## References

- [Viper Language Reference](http://viper.ethz.ch/documentation/)
- [Viper Tutorial](http://viper.ethz.ch/tutorial/)
- [DTU 02245 Course](http://courses.compute.dtu.dk/02245/)
