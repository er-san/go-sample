FROM --platform=linux/amd64 golang:1.20.4-bullseye as base
WORKDIR /app

COPY go.mod src/*.go ./
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o main

FROM alpine:latest
WORKDIR /root/
COPY --from=base /app/main ./

EXPOSE 8080

CMD ["./main"]