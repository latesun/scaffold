BINARY="app"
FileList := `go list ./...`

.PHONY: all
.DEFAULT: help

help: ## 查看帮助文档
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: run
run: ## 运行程序
	@go run cmd/main.go

.PHONY: build
build: ## 构建程序
	@CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o ${BINARY} cmd/main.go

.PHONY: tidy
tidy: ## 检查依赖
	@rm go.sum
	@go mod tidy

.PHONY: fmt
fmt: ## 格式化代码
	@go fmt $(wildcard **/*.go) # TODO

.PHONY: clean
clean: ## 清理二进制包
	@if [ -f ${BINARY} ] ; then rm ${BINARY} ; fi


.PHONY: lint
lint: ## 静态检查
	golangci-lint run
