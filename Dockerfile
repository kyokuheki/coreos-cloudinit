FROM golang as build
ENV GOBIN=/go/src/github.com/coreos/coreos-cloudinit/bin \
    GOPATH=/go/src/github.com/coreos/coreos-cloudinit/gopath
WORKDIR /go/src/github.com/coreos/coreos-cloudinit/
COPY . .
RUN set -eux \
 && export GLDFLAGS="-X main.version=\"$(git describe --dirty --tags)\" -extldflags -static" \
 && go build -ldflags "${GLDFLAGS}" -o ${GOBIN}/coreos-cloudinit github.com/coreos/coreos-cloudinit

FROM scratch
WORKDIR /
ENTRYPOINT ["/coreos-cloudinit"]
COPY --from=build /go/src/github.com/coreos/coreos-cloudinit/bin/coreos-cloudinit /
