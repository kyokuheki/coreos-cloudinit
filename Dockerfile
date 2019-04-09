FROM golang as build
WORKDIR /go/src/github.com/coreos/coreos-cloudinit/
COPY . .
RUN set -eux \
 && sh ./build

#FROM scratch
FROM alpine
WORKDIR /
ENTRYPOINT ["/coreos-cloudinit"]
COPY --from=build /go/src/github.com/coreos/coreos-cloudinit/bin/coreos-cloudinit /
