package main

import "errors"

// Calculator provides basic arithmetic operations for demonstration purposes.
type Calculator struct{}

// NewCalculator creates a new Calculator instance.
func NewCalculator() *Calculator {
	return &Calculator{}
}

// Add two numbers.
func (c *Calculator) Add(a, b float64) float64 {
	return a + b
}

// Subtract two numbers.
func (c *Calculator) Subtract(a, b float64) float64 {
	return a - b
}

// Multiply two numbers.
func (c *Calculator) Multiply(a, b float64) float64 {
	return a * b
}

// Divide two numbers.
func (c *Calculator) Divide(a, b float64) (float64, error) {
	if b == 0 {
		return 0, errors.New("cannot divide by zero")
	}
	return a / b, nil
}