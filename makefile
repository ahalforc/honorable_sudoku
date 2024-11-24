serve-local: build-client build-server
	./honorable_sudoku

serve-github-page: build-client build-server
	./honorable_sudoku --generate true

build-client:
	GOARCH=wasm GOOS=js go build -o web/app.wasm

build-server:
	go build
