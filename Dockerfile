# A Go multistage docker file
FROM golang:alpine as builder
RUN mkdir /build 
ADD . /build/
WORKDIR /build 
RUN apk add git
RUN go mod init run
RUN go build -o main .
FROM alpine
ENV PORT 8080
EXPOSE 8080
RUN adduser -S -D -H -h /app appuser
USER appuser
COPY --from=builder /build/main /app/
WORKDIR /app
CMD ["./main"]
