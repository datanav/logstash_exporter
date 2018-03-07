FROM golang as build

COPY . /build
WORKDIR /build

RUN go get -d
RUN go build -o logstash_exporter

FROM gcr.io/distroless/base

COPY --from=build /build/logstash_exporter /bin/logstash_exporter

EXPOSE 9198
ENTRYPOINT ["/bin/logstash_exporter"]
