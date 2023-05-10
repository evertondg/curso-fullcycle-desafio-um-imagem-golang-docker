FROM golang:1.12-alpine AS build_base

RUN apk add --no-cache git

WORKDIR /app

COPY . .

RUN go mod download

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -ldflags="-w -s" -o ./app .

FROM scratch

WORKDIR /app

COPY --from=build_base /app /app

CMD [ "./app" ]
