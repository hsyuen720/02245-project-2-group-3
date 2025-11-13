# Getting Started with Viper Verification

This guide will help you get started with the Viper verification examples in this repository.

## Quick Start

### Option 1: Using Viper IDE (Recommended for Beginners)

This is the easiest way to get started with Viper verification.

1. **Install Visual Studio Code**
   - Download from: https://code.visualstudio.com/

2. **Install Viper Extension**
   - Open VS Code
   - Go to Extensions (Ctrl+Shift+X or Cmd+Shift+X)
   - Search for "Viper"
   - Click Install on the "Viper" extension by the Viper Project

3. **Open a Viper File**
   - Open this repository in VS Code
   - Navigate to `viper-examples/`
   - Open any `.vpr` file (e.g., `01_sum.vpr`)
   - The extension will automatically verify the file
   - Look for green checkmarks (✓) for successful verification
   - Red marks (✗) indicate verification errors

4. **Configure Backend (Optional)**
   - By default, the extension uses Silicon
   - You can switch to Carbon in VS Code settings
   - Open Settings → Extensions → Viper
   - Change "Viper > Verification Backend"

### Option 2: Command Line with ViperServer

If you prefer command-line tools:

1. **Download ViperServer**
   - Visit: https://github.com/viperproject/viperserver/releases
   - Download the latest `viperserver.jar`
   - Place it in `./viper-tools/viperserver.jar`

2. **Run the Verification Script**
   ```bash
   ./verify.sh
   ```

3. **Verify Files**
   - With ViperServer running, you can send HTTP requests
   - Or use the Viper IDE to connect to your local server

### Option 3: Install Silicon/Carbon Directly

For advanced users who want standalone verifiers:

1. **Install Prerequisites**
   ```bash
   # Java 11 or higher
   sudo apt install openjdk-11-jdk
   
   # Mono (for Carbon only)
   sudo apt install mono-runtime
   ```

2. **Download Verifiers**
   - Silicon: https://github.com/viperproject/silicon/releases
   - Carbon: https://github.com/viperproject/carbon/releases
   - Download the JAR files

3. **Run Verification**
   ```bash
   # Using Silicon
   java -jar silicon.jar viper-examples/01_sum.vpr
   
   # Using Carbon
   java -jar carbon.jar viper-examples/01_sum.vpr
   ```

## Learning Path

We recommend following this learning path:

### Week 1: Basics
Start with simple examples to understand core concepts:
- `01_sum.vpr` - Loop invariants
- `06_swap.vpr` - State changes
- `07_absolute_value.vpr` - Conditional reasoning

**What to learn:**
- How to write preconditions (`requires`)
- How to write postconditions (`ensures`)
- Basic loop invariants

### Week 2: Intermediate
Move to more complex specifications:
- `02_array_max.vpr` - Quantifiers
- `03_factorial.vpr` - Recursive specifications
- `08_array_sum.vpr` - Recursive functions

**What to learn:**
- Universal quantifiers (`forall`)
- Existential quantifiers (`exists`)
- Recursive function definitions
- Relating iterative code to recursive specs

### Week 3: Advanced
Tackle complex algorithms and data structures:
- `04_binary_search.vpr` - Search algorithms
- `05_gcd.vpr` - Mathematical properties
- `09_predicates.vpr` - Abstract specifications

**What to learn:**
- Complex loop invariants
- Sorted sequences
- Predicate definitions
- Fold/unfold operations

### Week 4: Expert
Master complex data structures:
- `10_matrix.vpr` - 2D reasoning

**What to learn:**
- Nested sequences
- Nested loop invariants
- Multi-dimensional reasoning

## Understanding Verification Output

### Successful Verification

When a file verifies successfully, you'll see:
```
Verification successful (Silicon)
No errors found
```

### Verification Errors

Common error types:

1. **Postcondition might not hold**
   - The method doesn't guarantee its postcondition
   - Check your loop invariants
   - Add intermediate assertions

2. **Loop invariant might not be preserved**
   - Invariant true before loop but not maintained
   - Strengthen the invariant
   - Check boundary conditions

3. **Precondition might not hold**
   - Method called without required precondition
   - Add precondition to caller
   - Or prove precondition holds

4. **Assertion might not hold**
   - Explicit assertion fails
   - Check your logic
   - Add intermediate steps

## Tips for Success

### 1. Start Simple
Begin with basic specifications and gradually add complexity:
```viper
// Start with just types
method example(n: Int) returns (r: Int)

// Add basic bounds
method example(n: Int) returns (r: Int)
  requires n >= 0
  ensures r >= 0

// Add precise specification
method example(n: Int) returns (r: Int)
  requires n >= 0
  ensures r == n * 2
```

### 2. Use Assertions for Debugging
Add intermediate assertions to help the verifier:
```viper
var x: Int := compute_something()
assert x > 0  // Helps verifier know x is positive
var y: Int := x * 2
assert y > 0  // Now this should verify
```

### 3. Think About Loop Invariants
A loop invariant should:
- Be true before the loop starts
- Be maintained by each iteration
- Be strong enough to prove the postcondition

### 4. Understand Quantifiers
- Use `forall` when a property must hold for ALL elements
- Use `exists` when a property must hold for AT LEAST ONE element
- Make sure quantifier ranges are bounded

### 5. Read Error Messages Carefully
Viper error messages point to:
- The line where verification failed
- What property couldn't be proven
- Sometimes a suggestion for what might be wrong

## Common Patterns

### Pattern: Accumulator Loop
```viper
method accumulate(n: Int) returns (sum: Int)
  requires n >= 0
{
  sum := 0
  var i: Int := 0
  while (i < n)
    invariant 0 <= i && i <= n
    invariant sum == i * (i + 1) / 2
  {
    i := i + 1
    sum := sum + i
  }
}
```

### Pattern: Array Search
```viper
method search(a: Seq[Int], key: Int) returns (found: Bool)
{
  found := false
  var i: Int := 0
  while (i < |a| && !found)
    invariant 0 <= i && i <= |a|
    invariant !found ==> forall j: Int :: 0 <= j && j < i ==> a[j] != key
  {
    if (a[i] == key) { found := true }
    i := i + 1
  }
}
```

## Next Steps

1. **Read the Examples**
   - Start with `viper-examples/README.md`
   - Study each example file
   - Try to understand why each specification is needed

2. **Experiment**
   - Try removing a precondition - see what fails
   - Weaken a loop invariant - see where it breaks
   - Add your own test methods

3. **Create Your Own**
   - Implement a simple algorithm
   - Write specifications
   - Try to verify it
   - Debug verification errors

4. **Study Course Materials**
   - Read the VERIFICATION_GUIDE.md
   - Review DTU 02245 course materials
   - Study the Viper tutorial

## Getting Help

### Resources
- **Viper Website**: http://viper.ethz.ch/
- **Viper Tutorial**: http://viper.ethz.ch/tutorial/
- **DTU 02245 Course**: http://courses.compute.dtu.dk/02245/
- **This Repository**: Check the documentation files

### Common Issues

**"Java not found"**
- Install Java 11 or higher
- Set JAVA_HOME environment variable

**"Verification timeout"**
- Try simplifying specifications
- Add intermediate assertions
- Try different backend (Silicon vs Carbon)

**"Cannot parse file"**
- Check for syntax errors
- Run `./check_syntax.sh` for basic checks
- Look for unbalanced braces or parentheses

## Contributing

If you find issues or want to add more examples:
1. Create a new `.vpr` file in `viper-examples/`
2. Ensure it passes syntax checks
3. Test verification with both backends if possible
4. Document the example in the README

## Summary

This repository provides:
- ✅ 10 complete Viper examples
- ✅ Comprehensive documentation
- ✅ Helper scripts for syntax checking
- ✅ Learning path from beginner to expert
- ✅ All examples designed to verify successfully

Start with the Viper IDE for the easiest experience, then progress to command-line tools as you become more comfortable. Happy verifying!
