package main

import (
	"testing"
)

func TestCalculatorAdd(t *testing.T) {
	calc := NewCalculator()
	result := calc.Add(2, 3)
	expected := 5.0
	if result != expected {
		t.Errorf("Add(2, 3) = %f; expected %f", result, expected)
	}
}

func TestCalculatorSubtract(t *testing.T) {
	calc := NewCalculator()
	result := calc.Subtract(5, 1)
	expected := 4.0
	if result != expected {
		t.Errorf("Subtract(5, 1) = %f; expected %f", result, expected)
	}
}

func TestCalculatorMultiply(t *testing.T) {
	calc := NewCalculator()
	result := calc.Multiply(4, 6)
	expected := 24.0
	if result != expected {
		t.Errorf("Multiply(4, 6) = %f; expected %f", result, expected)
	}
}

func TestCalculatorDivide(t *testing.T) {
	calc := NewCalculator()
	result, err := calc.Divide(8, 2)
	expected := 4.0
	if err != nil {
		t.Errorf("Divide(8, 2) returned error: %v", err)
	}
	if result != expected {
		t.Errorf("Divide(8, 2) = %f; expected %f", result, expected)
	}
}

func TestCalculatorDivideByZero(t *testing.T) {
	calc := NewCalculator()
	_, err := calc.Divide(5, 0)
	if err == nil {
		t.Error("Divide(5, 0) should return an error")
	}
	expectedError := "cannot divide by zero"
	if err.Error() != expectedError {
		t.Errorf("Divide(5, 0) error = %q; expected %q", err.Error(), expectedError)
	}
}