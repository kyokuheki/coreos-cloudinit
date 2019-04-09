FROM golang as build
WORKDIR /go/src/github.com/coreos/coreos-cloudinit/
COPY . .
RUN set -eux \
 && ./build

FROM scratch
WORKDIR /
ENTRYPOINT ["/coreos-cloudinit"]
COPY --from=build /go/src/github.com/coreos/coreos-cloudinit/bin/coreos-cloudinit /
