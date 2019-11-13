package main

import (
	"fmt"
	r "runtime"
)

func main() {
	fmt.Println("TEST SANITY")
	PrintMemUsage()
}

func PrintMemUsage() {
	var m r.MemStats
	r.ReadMemStats(&m)
	// For info on each, see: https://golang.org/pkg/runtime/#MemStats
	fmt.Println(m.Alloc)
	// fmt.Printf("\tSys = %v MiB", bToMb(m.Sys))
	// fmt.Printf("\tNumGC = %v\n", m.NumGC)
}
