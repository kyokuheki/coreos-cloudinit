FROM golang as build
WORKDIR /go/src/github.com/coreos/coreos-cloudinit/
COPY . .
ENV GOBIN=/go/src/github.com/coreos/coreos-cloudinit/bin \
    GOPATH=/go/src/github.com/coreos/coreos-cloudinit/gopath
RUN set -eux \
 && export VERSION=$(git describe --dirty --tags) \
 && export GLDFLAGS="-X main.version=\"${VERSION}\"" \
 && go build -ldflags "${GLDFLAGS}" -o ${GOBIN}/coreos-cloudinit github.com/coreos/coreos-cloudinit

FROM scratch
WORKDIR /
CMD ["/coreos-cloudinit"]
COPY --from=build /go/src/github.com/coreos/coreos-cloudinit/bin/coreos-cloudinit /
