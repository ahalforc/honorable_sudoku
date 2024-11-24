package main

import (
	"math/rand/v2"
)

type Sudoku struct {
	Grid [][]int
}

func NewSudoku() *Sudoku {
	grid := make([][]int, 9)
	for i := range grid {
		grid[i] = make([]int, 9)
	}
	return &Sudoku{
		Grid: grid,
	}
}

func (s *Sudoku) Generate(c int) []struct {
	r int
	c int
} {
	s.fillBlock(0)
	s.fillBlock(4)
	s.fillBlock(8)
	s.fillEmptyCells(0, 0)
	s.removeRandomCells(c)

	hints := make([]struct {
		r int
		c int
	}, 0)
	for r := range s.Grid {
		for c := range s.Grid[r] {
			if s.Grid[r][c] != 0 {
				hints = append(hints, struct {
					r int
					c int
				}{r, c})
			}
		}
	}
	return hints
}

func (s *Sudoku) SetCell(r, c, v int) {
	s.Grid[r][c] = v
}

func (s *Sudoku) IsComplete() bool {
	isAllUniqueWithoutZeroes := func(vs []int) bool {
		m := make(map[int]bool)
		for _, v := range vs {
			if v == 0 {
				return false
			} else if _, ok := m[v]; ok {
				return false
			}
			m[v] = true
		}
		return true
	}

	for i := 0; i < 9; i++ {
		if !isAllUniqueWithoutZeroes(s.valuesInRow(i)) {
			return false
		}
		if !isAllUniqueWithoutZeroes(s.valuesInColumn(i)) {
			return false
		}
		br := (i / 3) * 3
		bc := (i % 3) * 3
		if !isAllUniqueWithoutZeroes(s.valuesInBlock(br, bc)) {
			return false
		}
	}

	return true
}

func (s *Sudoku) fillBlock(bi int) {
	values := getShuffledValues()
	for r := 0; r < 3; r++ {
		for c := 0; c < 3; c++ {
			v := values[0]
			values = values[1:]
			s.Grid[r+(bi%3)*3][c+(bi/3)*3] = v
		}
	}
}

func (s *Sudoku) fillEmptyCells(r, c int) bool {
	if r == 8 && c == 9 {
		return true
	}

	if c == 9 {
		r++
		c = 0
	}

	if s.Grid[r][c] != 0 {
		return s.fillEmptyCells(r, c+1)
	}

	values := getShuffledValues()
	for len(values) > 0 {
		v := values[0]
		values = values[1:]
		if s.isSafe(r, c, v) {
			s.Grid[r][c] = v
			if s.fillEmptyCells(r, c+1) {
				return true
			} else {
				s.Grid[r][c] = 0
			}
		}
	}

	return false
}

func (s *Sudoku) removeRandomCells(c int) {
	m := make(map[int]bool)
	getUnseenRandomInt := func() int {
		for {
			v := rand.IntN(9 * 9)
			_, ok := m[v]
			if !ok {
				m[v] = true
				return v
			}
		}
	}
	for i := 0; i < c; i++ {
		v := getUnseenRandomInt()
		s.Grid[v/9][v%9] = 0
	}
}

func (s *Sudoku) isSafe(r, c, v int) bool {
	return s.isSafeInRow(r, v) && s.isSafeInColumn(c, v) && s.isSafeInBlock(r, c, v)
}

func (s *Sudoku) isSafeInRow(r, v int) bool {
	for _, rv := range s.valuesInRow(r) {
		if rv == v {
			return false
		}
	}
	return true
}

func (s *Sudoku) isSafeInColumn(c, v int) bool {
	for _, cv := range s.valuesInColumn(c) {
		if cv == v {
			return false
		}
	}
	return true
}

func (s *Sudoku) isSafeInBlock(r, c, v int) bool {
	for _, bv := range s.valuesInBlock(r, c) {
		if bv == v {
			return false
		}
	}
	return true
}

func (s *Sudoku) valuesInRow(r int) []int {
	return s.Grid[r]
}

func (s *Sudoku) valuesInColumn(c int) []int {
	result := make([]int, 0)
	for r := range s.Grid {
		result = append(result, s.Grid[r][c])
	}
	return result
}

func (s *Sudoku) valuesInBlock(r, c int) []int {
	result := make([]int, 0)
	for i := 0; i < 3; i++ {
		for j := 0; j < 3; j++ {
			br := (r/3)*3 + i
			bc := (c/3)*3 + j
			result = append(result, s.Grid[br][bc])
		}
	}
	return result
}

func getShuffledValues() []int {
	vs := make([]int, 9)
	for i := range vs {
		vs[i] = i + 1
	}
	for i := range vs {
		j := rand.IntN(i + 1)
		vs[i], vs[j] = vs[j], vs[i]
	}
	return vs
}
