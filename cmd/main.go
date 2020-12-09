package main

import (
	"fmt"

	"github.com/latesun/scaffold/configs"
)

func main() {
	configs.Init()
	fmt.Println("Hello World")
}

func Hello() {
	fmt.Println("Hello World")
}
