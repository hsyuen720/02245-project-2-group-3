# 02245 Project 2 - Group 3

## Program Verification with Viper

This repository contains Viper verification examples for DTU course 02245 (Program Verification). All solutions are implemented using the Viper verification language and are designed to verify with both Silicon and Carbon backends.

## Project Structure

```
viper-examples/
├── 01_sum.vpr              - Sum of first n natural numbers with loop invariants
├── 02_array_max.vpr        - Finding maximum element in an array
├── 03_factorial.vpr        - Factorial computation (recursive and iterative)
├── 04_binary_search.vpr    - Binary search in a sorted array
├── 05_gcd.vpr              - Greatest Common Divisor (Euclidean algorithm)
├── 06_swap.vpr             - Variable and array element swapping
├── 07_absolute_value.vpr   - Absolute value and distance computation
├── 08_array_sum.vpr        - Sum of array elements with recursive specification
├── 09_predicates.vpr       - Predicates and abstract specifications
└── 10_matrix.vpr           - Matrix operations with 2D reasoning
```

## About Viper

Viper is a verification infrastructure that provides:
- **Viper Language (Silver)**: A language for writing formally verified programs
- **Silicon Backend**: Symbolic execution-based verifier
- **Carbon Backend**: Verification condition generation-based verifier
- **Z3 Integration**: SMT solver for automated reasoning

## Examples Overview

Each example demonstrates key verification concepts:

### 1. Sum (01_sum.vpr)
Demonstrates basic loop invariants and mathematical reasoning for computing the sum of first n natural numbers using the formula: n*(n+1)/2

### 2. Array Maximum (02_array_max.vpr)
Shows array reasoning with quantified specifications, proving that the result is both in the array and is the maximum element.

### 3. Factorial (03_factorial.vpr)
Illustrates recursive function definitions and iterative implementation with loop invariants that maintain the factorial relationship.

### 4. Binary Search (04_binary_search.vpr)
Complex example showing reasoning about sorted sequences and correctness of the binary search algorithm.

### 5. GCD (05_gcd.vpr)
Demonstrates the Euclidean algorithm for computing the greatest common divisor with divisibility reasoning.

### 6. Swap (06_swap.vpr)
Simple specification and reasoning about state changes for swapping variables and array elements.

### 7. Absolute Value (07_absolute_value.vpr)
Shows conditional reasoning with if-then-else statements and ensures proper handling of positive and negative integers.

### 8. Array Sum (08_array_sum.vpr)
Demonstrates recursive function definitions and reasoning about array aggregation operations.

### 9. Predicates (09_predicates.vpr)
Illustrates predicate definitions and folding/unfolding for abstract specifications and compositional verification.

### 10. Matrix Operations (10_matrix.vpr)
Demonstrates verification of 2D data structures with nested sequences, including matrix transpose and operations with nested loop invariants.

## How to Verify

### Prerequisites

1. **Java**: OpenJDK 11 or higher
2. **Viper IDE**: Visual Studio Code with Viper extension
   - Or standalone Viper tools (Silicon/Carbon)
3. **Z3 Solver**: Required by Viper backends

### Installation

#### Using Viper IDE (Recommended)

1. Install Visual Studio Code
2. Install the "Viper" extension from the VS Code marketplace
3. Open any `.vpr` file from the `viper-examples/` directory
4. The extension will automatically verify the file

#### Using Command Line

If you have Viper tools installed:

```bash
# Verify with Silicon backend
silicon viper-examples/01_sum.vpr

# Verify with Carbon backend
carbon viper-examples/01_sum.vpr
```

### Verification Results

All examples in this repository are designed to verify successfully with both Silicon and Carbon backends. Each file includes:

- **Preconditions** (`requires`): Conditions that must hold before method execution
- **Postconditions** (`ensures`): Conditions guaranteed after method execution
- **Loop Invariants** (`invariant`): Conditions maintained throughout loop execution
- **Test Methods**: Demonstrate usage and verify specific cases

## Verification Principles Demonstrated

1. **Deductive Reasoning**: Using formal logic to prove program properties
2. **Loop Invariants**: Maintaining properties throughout iterative computation
3. **Quantified Specifications**: Reasoning about all elements in collections
4. **Conditional Reasoning**: Handling different execution paths
5. **Recursive Specifications**: Defining properties recursively
6. **Mathematical Properties**: Proving algorithms match mathematical definitions

## References

- [Viper Official Website](http://viper.ethz.ch/)
- [DTU 02245 Course Page](http://courses.compute.dtu.dk/02245/)
- [Viper Tutorial](http://viper.ethz.ch/tutorial/)

## Course Information

- **Course**: 02245 Program Verification
- **Institution**: Technical University of Denmark (DTU)
- **Focus**: Formal verification using automated deductive verifiers

## License

This project is created for educational purposes as part of DTU course 02245.