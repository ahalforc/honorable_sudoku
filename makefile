serve-local: build-client build-server
	./honorable_sudoku

build-client:
	GOARCH=wasm GOOS=js go build -o web/app.wasm

build-server:
	go build

build-github-page:
	./honorable_sudoku --generate true
