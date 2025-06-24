.DEFAULT_GOAL := build
fmt:
 go fmt ./...
.PHONY:fmt
lint: fmt
 golint ./...
.PHONY:lint
vet: fmt
 go vet ./...
.PHONY:vet
Makeles | 13
build: vet
 go build hello.go
.PHONY:build