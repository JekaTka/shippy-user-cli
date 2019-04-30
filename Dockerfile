FROM golang:latest as builder

ENV GO111MODULE=on
WORKDIR /go/src/github.com/JekaTka/shippy-user-cli

COPY . .

# RUN go get
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo .


FROM alpine:latest

RUN apk --no-cache add ca-certificates

RUN mkdir /app
WORKDIR /app
COPY --from=builder /go/src/github.com/JekaTka/shippy-user-cli .

ENTRYPOINT ["./shippy-user-cli"]

CMD ["./shippy-user-cli"]