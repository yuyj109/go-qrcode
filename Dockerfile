# Build stage
FROM golang:1.24.3-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN go build -o main .

# Final stage
FROM gcr.io/distroless/base-debian12:nonroot

WORKDIR /app
COPY --from=builder /app/main /app/main

EXPOSE 8000

CMD ["/app/main"]
