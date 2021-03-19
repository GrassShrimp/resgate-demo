# build stage
FROM golang:alpine AS build-env
ADD . /src
RUN cd /src && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app

# final stage
FROM alpine
WORKDIR /app
COPY --from=build-env /src/app /app/
COPY --from=build-env /src/templates /app/templates

ENV PORT=8080
ENV RESGATE_URL="localhost:8080"

VOLUME [ "/app" ]

ENTRYPOINT ./app