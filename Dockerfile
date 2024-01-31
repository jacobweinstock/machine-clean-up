# docker build -t cleanup .
# docker run -it --rm -e EFI_DEV_NAME=<name here> --privileged cleanup 
FROM alpine

RUN apk add efibootmgr

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

