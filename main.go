package main

import (
	"log"
	"net/http"

	"github.com/maxence-charriere/go-app/v10/pkg/app"
)

func main() {
	app.Route("/", func() app.Composer { return NewHome() })
	app.RunWhenOnBrowser()

	if err := app.GenerateStaticWebsite("./build", &app.Handler{
		Name:        "honorable sudoku",
		Description: "simply sudoku",
		Resources:   app.GitHubPages("honorable_sudoku"),
		Styles: []string{
			"/web/sudoku.css",
		},
	}); err != nil {
		log.Fatal(err)
	}

	http.Handle("/", &app.Handler{
		Name:        "Home",
		Description: "The home page",
		Styles: []string{
			"/web/sudoku.css",
		},
	})
	if err := http.ListenAndServe(":8080", nil); err != nil {
		log.Fatal(err)
	}
}
