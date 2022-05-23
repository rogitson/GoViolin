# syntax=docker/dockerfile:1

FROM golang:1.16-alpine AS build

WORKDIR /goviolin
COPY . .
RUN go mod init 

ENV GO111MODULE=on
RUN export CGO_ENABLED=0 
# build app
RUN go build -o goviolin .

# multistage build
FROM alpine
# copy from build
COPY --from=build /goviolin /goviolin

WORKDIR /goviolin
EXPOSE 8080
CMD ["./goviolin"]
