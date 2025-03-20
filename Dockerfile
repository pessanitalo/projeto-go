FROM golang:1.22-alpine AS build

WORKDIR /app

COPY ./controllers/ /app/controllers/
COPY ./database/ /app/database/
COPY ./models/ /app/models/
COPY ./routes/ /app/routes/
COPY ./main.go /app/main.go
COPY ./go.mod /app/go.mod
COPY ./go.sum /app/go.sum

RUN go build main.go

FROM alpine:latest AS production

EXPOSE 8080

WORKDIR /app

COPY ./assets/ /app/assets/
COPY ./templates/ /app/templates/

COPY --from=build /app/main /app/main

CMD [ "./main" ]