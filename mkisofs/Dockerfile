FROM alpine:latest AS build
LABEL maintainer="Zachery Hostens <zacheryph@gmail.com>"

RUN mkdir -p /out/etc/apk && cp -r /etc/apk/* /out/etc/apk
RUN apk add --no-cache --initdb -p /out \
  alpine-baselayout \
  busybox \
  cdrkit

RUN rm -rf /out/etc/apk /out/lib/apk /out/var/cache


FROM scratch
COPY --from=build /out/ /
ENV HOME /home
RUN adduser -S -h /home user \
  && chown -R user $HOME

WORKDIR $HOME
USER user

ENTRYPOINT [ "mkisofs" ]
