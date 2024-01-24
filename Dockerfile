# Build stage
FROM golang:1.21.4-bullseye as builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN go build -o main .

# Final stage
FROM gcr.io/distroless/base-debian11:nonroot

WORKDIR /app
COPY --from=builder /app/main /app/main

EXPOSE 8888

CMD ["/app/main"]
