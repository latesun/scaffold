BINARY="app"

.PHONY: run
run:
	@go run cmd/main.go

.PHONY: build
build:
	@CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o ${BINARY} cmd/main.go

.PHONY: tidy
tidy:
	@rm go.sum
	@go mod tidy

.PHONY: fmt
fmt:
	@go fmt $(wildcard **/*.go) # TODO

.PHONY: clean
clean:
	@if [ -f ${BINARY} ] ; then rm ${BINARY} ; fi

