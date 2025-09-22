package main

import (
	"fmt"
	"strings"
)

const version = "1.0.0"

func main() {
	calc := NewCalculator()

	fmt.Printf("Calculator Demo3 v%s\n", version)
	fmt.Println(strings.Repeat("=", 30))

	fmt.Printf("2 + 3 = %.0f\n", calc.Add(2, 3))
	fmt.Printf("5 - 1 = %.0f\n", calc.Subtract(5, 1))
	fmt.Printf("4 * 6 = %.0f\n", calc.Multiply(4, 6))

	result, err := calc.Divide(8, 2)
	if err != nil {
		fmt.Printf("8 / 2 = Error: %v\n", err)
	} else {
		fmt.Printf("8 / 2 = %.1f\n", result)
	}
}
