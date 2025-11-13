#!/bin/bash

# Basic syntax checking for Viper files
# This script performs simple validation checks

echo "=== Viper Files Syntax Check ==="
echo ""

VIPER_DIR="./viper-examples"
ERROR_COUNT=0

for file in "$VIPER_DIR"/*.vpr; do
    echo "Checking: $(basename "$file")"
    
    # Check if file exists and is not empty
    if [ ! -s "$file" ]; then
        echo "  ❌ Error: File is empty"
        ((ERROR_COUNT++))
        continue
    fi
    
    # Check for basic Viper syntax patterns
    errors=()
    
    # Check for balanced braces
    open_braces=$(grep -o '{' "$file" | wc -l)
    close_braces=$(grep -o '}' "$file" | wc -l)
    if [ "$open_braces" -ne "$close_braces" ]; then
        errors+=("Unbalanced braces (open: $open_braces, close: $close_braces)")
    fi
    
    # Check for balanced parentheses
    open_parens=$(grep -o '(' "$file" | wc -l)
    close_parens=$(grep -o ')' "$file" | wc -l)
    if [ "$open_parens" -ne "$close_parens" ]; then
        errors+=("Unbalanced parentheses (open: $open_parens, close: $close_parens)")
    fi
    
    # Check for method/function definitions
    if ! grep -q "method\|function" "$file"; then
        errors+=("No method or function definitions found")
    fi
    
    # Report results
    if [ ${#errors[@]} -eq 0 ]; then
        echo "  ✓ Basic syntax checks passed"
    else
        echo "  ❌ Potential issues found:"
        for error in "${errors[@]}"; do
            echo "     - $error"
        done
        ((ERROR_COUNT++))
    fi
    echo ""
done

echo "=== Summary ==="
FILE_COUNT=$(ls -1 "$VIPER_DIR"/*.vpr 2>/dev/null | wc -l)
PASS_COUNT=$((FILE_COUNT - ERROR_COUNT))

echo "Files checked: $FILE_COUNT"
echo "Passed: $PASS_COUNT"
echo "Failed: $ERROR_COUNT"
echo ""

if [ $ERROR_COUNT -eq 0 ]; then
    echo "✓ All files passed basic syntax checks"
    echo ""
    echo "Note: These are only basic syntax checks."
    echo "For full verification, use Viper IDE or Silicon/Carbon backends."
    exit 0
else
    echo "❌ Some files have potential issues"
    exit 1
fi
