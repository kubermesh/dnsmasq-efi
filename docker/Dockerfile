FROM alpine:3.4

RUN apk add --no-cache tftp-hpa

EXPOSE 69/udp

ADD ipxe.efi /var/lib/tftproot/

ENTRYPOINT ["in.tftpd"]

CMD ["--foreground", "--verbose", "--secure", "/var/lib/tftproot"]
