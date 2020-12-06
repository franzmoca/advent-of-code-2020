package main

import (
	"fmt"
	"io/ioutil"
	"strings"
)

func treesVisited(grid []string, right int, down int) int {
	rowNumber := len(grid)
	currentX := 0
	currentY := 0

	treeNumber := 0

	for currentY < rowNumber {
		currentLine := grid[currentY]
		currentPosition := currentLine[currentX]
		if string(currentPosition) == "#" {
			treeNumber++
		}
		currentX = (currentX + right) % len(currentLine)
		currentY = currentY + down
	}

	return treeNumber
}

func main() {

	inputFile, _ := ioutil.ReadFile("input")
	grid := strings.Split(string(inputFile), "\n")

	part1Solution := treesVisited(grid, 3, 1)
	fmt.Println("Part 1 solution is: ", part1Solution)

	part2Solution := treesVisited(grid, 1, 1) * treesVisited(grid, 3, 1) * treesVisited(grid, 5, 1) * treesVisited(grid, 7, 1) * treesVisited(grid, 1, 2)
	fmt.Println("Part 2 solution is: ", part2Solution)

}
