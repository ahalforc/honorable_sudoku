package main

import (
	"strconv"

	"github.com/maxence-charriere/go-app/v10/pkg/app"
)

type home struct {
	app.Compo

	// The rendered sudoku
	sudoku *Sudoku

	// The sudoku's baseline hint cells
	disabledCells []struct {
		r int
		c int
	}

	// True if the sudoku is done and correct
	isComplete bool

	// True if an update for the website is available, false otherwise.
	updateAvailable bool
}

func NewHome() *home {
	s := NewSudoku()
	return &home{
		sudoku:          s,
		disabledCells:   s.Generate(50),
		updateAvailable: false,
	}
}

func (h *home) OnAppUpdate(ctx app.Context) {
	h.updateAvailable = ctx.AppUpdateAvailable()
}

func (h *home) Render() app.UI {
	return app.Div().Body(
		h.renderTitle(),
		h.renderAppUpdateButton(),
		h.renderSudokuBoard(),
		h.renderCompletionTag(),
		h.renderDifficultyButtons(),
	)
}

func (h *home) renderTitle() app.UI {
	return app.H1().Text("honorable sudoku")
}

func (h *home) renderAppUpdateButton() app.UI {
	return app.If(h.updateAvailable, func() app.UI {
		return app.Button().Text("Update!").OnClick(func(ctx app.Context, e app.Event) {
			ctx.Reload()
		})
	})
}

func (h *home) renderSudokuBoard() app.UI {
	rows := make([]app.UI, len(h.sudoku.Grid))
	for i, r := range h.sudoku.Grid {
		cells := make([]app.UI, len(r))
		for j, c := range r {
			class := "offset2"
			if (i/3)%2 == (j/3)%2 {
				class = "offset1"
			}
			value := ""
			if c != 0 {
				value = strconv.Itoa(c)
			}
			disabled := false
			for _, rc := range h.disabledCells {
				if rc.r == i && rc.c == j {
					disabled = true
					break
				}
			}
			cells[j] = app.Td().Body(
				app.Input().Class(class).Type("text").MaxLength(1).Value(value).Disabled(disabled).OnInput(func(ctx app.Context, e app.Event) {
					if v, err := strconv.Atoi(ctx.JSSrc().Get("value").String()); err == nil {
						h.sudoku.SetCell(i, j, v)
					}
					h.isComplete = h.sudoku.IsComplete()
				}),
			)
		}
		rows[i] = app.Tr().Body(cells...)
	}
	return app.Table().Body(rows...)
}

func (h *home) renderCompletionTag() app.UI {
	s := "incomplete"
	if h.isComplete {
		s = "good job"
	}
	return app.Div().Class("centered").Body(
		app.Text(s),
	)
}

func (h *home) renderDifficultyButtons() app.UI {
	configs := []struct {
		s string
		c int
	}{
		{
			"Easy",
			1,
		},
		{
			"Medium",
			40,
		},
		{
			"Hard",
			50,
		},
		{
			"Extreme",
			60,
		},
	}

	btns := make([]app.UI, len(configs))
	for i, c := range configs {
		btns[i] = app.Button().Text(c.s).OnClick(func(ctx app.Context, e app.Event) {
			h.sudoku = NewSudoku()
			h.disabledCells = h.sudoku.Generate(c.c)
			h.isComplete = false
		})
	}
	return app.Div().Class("centered").Body(
		btns...,
	)
}
