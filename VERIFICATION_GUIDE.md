# Viper Verification Guide

## Understanding Viper Specifications

This guide explains the key concepts used in the Viper examples in this repository.

## Core Specification Elements

### 1. Preconditions (`requires`)

Preconditions specify what must be true before a method can be called:

```viper
method sum(n: Int) returns (res: Int)
  requires 0 <= n  // n must be non-negative
```

### 2. Postconditions (`ensures`)

Postconditions specify what the method guarantees after execution:

```viper
method sum(n: Int) returns (res: Int)
  requires 0 <= n
  ensures res == n * (n + 1) / 2  // result matches mathematical formula
```

### 3. Loop Invariants (`invariant`)

Loop invariants are properties that hold:
- Before the loop starts
- After each iteration
- When the loop terminates

```viper
while (i < n)
  invariant 0 <= i && i <= n  // bounds check
  invariant sum == i * (i + 1) / 2  // maintains sum formula
{
  // loop body
}
```

## Reasoning Patterns

### Forward Reasoning

Start from preconditions and work towards postconditions:

```viper
method forward_example(x: Int) returns (y: Int)
  requires x > 0
{
  // We know: x > 0
  y := x + 1
  // We can deduce: y > 1
  assert y > 1  // This will verify
}
```

### Backward Reasoning

Start from desired postcondition and work backwards:

```viper
method backward_example(x: Int) returns (y: Int)
  ensures y > 0
{
  // Need: y > 0
  // So we need: x + 1 > 0, which means x > -1
  y := x + 1
  assume x > -1  // This assumption is needed
}
```

## Quantifiers

### Universal Quantification (`forall`)

Expresses that a property holds for all elements:

```viper
// All elements in array are positive
ensures forall i: Int :: 0 <= i && i < |a| ==> a[i] > 0
```

### Existential Quantification (`exists`)

Expresses that there exists at least one element satisfying a property:

```viper
// There exists an element equal to max
ensures exists i: Int :: 0 <= i && i < |a| && a[i] == max
```

## Sequences

Viper provides built-in sequence types:

```viper
var s: Seq[Int] := Seq(1, 2, 3, 4, 5)

// Length
assert |s| == 5

// Indexing
assert s[0] == 1

// Update
var s2: Seq[Int] := s[0 := 10]
assert s2[0] == 10
assert s[0] == 1  // original unchanged

// Concatenation
var s3: Seq[Int] := Seq(1, 2) ++ Seq(3, 4)
assert |s3| == 4
```

## Functions vs Methods

### Functions
- Pure (no side effects)
- Can be used in specifications
- Must terminate
- Can be recursive

```viper
function factorial(n: Int): Int
  requires n >= 0
{
  n == 0 ? 1 : n * factorial(n - 1)
}
```

### Methods
- Can have side effects
- Cannot be used in specifications
- Verified separately
- Can call functions

```viper
method compute_factorial(n: Int) returns (result: Int)
  requires n >= 0
  ensures result == factorial(n)
{
  // implementation
}
```

## Common Verification Patterns

### Pattern 1: Array Bounds

Always verify array indices are in bounds:

```viper
method safe_access(a: Seq[Int], i: Int) returns (val: Int)
  requires 0 <= i && i < |a|  // bounds check in precondition
{
  val := a[i]  // safe access
}
```

### Pattern 2: Loop with Accumulator

```viper
method accumulate(n: Int) returns (sum: Int)
  requires n >= 0
{
  sum := 0
  var i: Int := 0
  
  while (i < n)
    invariant 0 <= i && i <= n
    invariant sum == i * (i + 1) / 2  // relates sum to i
  {
    i := i + 1
    sum := sum + i
  }
}
```

### Pattern 3: Conditional Updates

```viper
method conditional_max(a: Int, b: Int) returns (max: Int)
  ensures max >= a && max >= b
  ensures max == a || max == b
{
  if (a >= b) {
    max := a
  } else {
    max := b
  }
}
```

## Verification Strategies

### Strategy 1: Start Simple

Begin with basic specifications and gradually add detail:

```viper
// Step 1: Basic type
method example(n: Int) returns (r: Int)

// Step 2: Add basic bounds
method example(n: Int) returns (r: Int)
  requires n >= 0
  ensures r >= 0

// Step 3: Add precise relationship
method example(n: Int) returns (r: Int)
  requires n >= 0
  ensures r == n * 2
```

### Strategy 2: Use Intermediate Assertions

Add assertions to help the verifier understand intermediate states:

```viper
method complex_computation(x: Int) returns (y: Int)
  requires x > 0
  ensures y > 0
{
  var temp: Int := x + 1
  assert temp > 1  // intermediate assertion
  y := temp * 2
  assert y > 2  // helps verifier
}
```

### Strategy 3: Strengthen Loop Invariants

If a loop doesn't verify, try adding more invariants:

```viper
while (i < n)
  invariant 0 <= i && i <= n  // basic bounds
  invariant sum >= 0  // value property
  invariant sum == f(i)  // relationship to function
{
  // body
}
```

## Debugging Verification Failures

### Common Issues

1. **Missing Precondition**: Method requires something not specified
2. **Weak Loop Invariant**: Invariant doesn't maintain necessary property
3. **Off-by-One Error**: Loop bounds not correctly specified
4. **Incomplete Case Analysis**: Not all branches proven

### Debugging Approach

1. Check error message for line number
2. Verify preconditions are sufficient
3. Check loop invariants hold initially and are maintained
4. Ensure postconditions follow from loop invariants
5. Add intermediate assertions to narrow down the issue

## Tips for Writing Verifiable Code

1. **Keep it simple**: Simpler code is easier to verify
2. **Write specifications first**: Design contracts before implementation
3. **Use meaningful invariants**: Make them express the algorithm's logic
4. **Test with concrete values**: Use test methods to verify behavior
5. **Build incrementally**: Start with partial verification and expand

## Resources

- Viper Language Reference: http://viper.ethz.ch/documentation/
- Verification examples: http://viper.ethz.ch/examples/
- DTU 02245 course materials: http://courses.compute.dtu.dk/02245/

## Backend Differences

### Silicon
- Uses symbolic execution
- Generally faster for smaller programs
- Better error messages
- May timeout on complex properties

### Carbon
- Uses verification condition generation
- More predictable performance
- Better for larger programs
- Different error reporting style

Both backends should verify the same correct programs, though with different performance characteristics.
