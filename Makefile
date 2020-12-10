BINARY = "app"

.PHONY: clean fmt lint build run test all help

.DEFAULT_GOAL = help

clean: ## 清理二进制包
	@echo "清理二进制包..."
	@if [ -f ${BINARY} ] ; then rm ${BINARY} ; fi

fmt: ## 格式化代码
	@echo "格式化代码..."
	@hash goimports 2>&- || go get -u golang.org/x/tools/cmd/goimports
	@goimports -l -w .

lint: ## 静态检查
	@echo "静态检查..."
	@hash golangci-lint 2>&- || go get -u github.com/golangci/golangci-lint
	@golangci-lint run

test: ## 检查测试覆盖率
	@echo "检查测试覆盖率..."
	@go test -race -cover -coverprofile=cover.out ./...
	@go tool cover -func=cover.out

build: ## 构建程序
	@echo "构建程序..."
	@CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o ${BINARY} cmd/main.go

run: ## 运行程序
	@echo "运行程序..."
	@sh -c GODEBUG='gctrace=1' ./${BINARY}

all: clean fmt lint test build run ## 等同 clean fmt lint test build run

help: ## 查看帮助文档
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}'

