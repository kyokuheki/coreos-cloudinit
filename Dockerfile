FROM golang as build
WORKDIR /go/src/github.com/kyokuheki/coreos-cloudinit/
GLDFLAGS="-X main.version=\"${VERSION}\""
ENV GOBIN=/go/src/github.com/kyokuheki/coreos-cloudinit/bin \
    GOPATH=/go/src/github.com/kyokuheki/gopath
RUN go build -ldflags "${GLDFLAGS}" -o ${GOBIN}/coreos-cloudinit github.com/kyokuheki/coreos-cloudinit

FROM scratch
WORKDIR /
CMD ["/coreos-cloudinit"]
COPY --from=build /go/src/github.com/kyokuheki/coreos-cloudinit /
