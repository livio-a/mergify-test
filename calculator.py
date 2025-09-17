#!/usr/bin/env python3
"""
Sample Application for Mergify Backporting Demo

This is a simple application that can be modified in PRs to test
the automatic backporting functionality with Mergify.
"""

__version__ = "1.0.0"

class Calculator:
    """A simple calculator class for demonstration purposes."""
    
    def add(self, a: float, b: float) -> float:
        """Add two numbers."""
        return a + b
    
    def subtract(self, a: float, b: float) -> float:
        """Subtract two numbers."""
        return a - b
    
    def multiply(self, a: float, b: float) -> float:
        """Multiply two numbers."""
        return a * b
    
    def divide(self, a: float, b: float) -> float:
        """Divide two numbers."""
        if b == 0:
            raise ValueError("Cannot divide by zero")
        return a / b

def main():
    """Main function to demonstrate the calculator."""
    calc = Calculator()
    
    print(f"Calculator Demo v{__version__}")
    print("=" * 40)
    print(f"2 + 3 = {calc.add(2, 3)}")
    print(f"5 - 1 = {calc.subtract(5, 1)}")
    print(f"4 * 6 = {calc.multiply(4, 6)}")
    print(f"8 / 2 = {calc.divide(8, 2)}")

if __name__ == "__main__":
    main()
