FROM golang:1.21-alpine AS builder

WORKDIR /app
COPY main.go .

# Inicializar módulo Go e compilar binário estático
RUN go mod init fullcycle && \
    CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

# Runtime - usando scratch (imagem raiz)
FROM scratch

COPY --from=builder /app/main /main

ENTRYPOINT ["/main"]