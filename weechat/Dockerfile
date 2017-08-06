FROM alpine:latest AS build

RUN mkdir -p /out/etc/apk && cp -r /etc/apk/* /out/etc/apk
RUN apk add --no-cache --initdb -p /out \
  alpine-baselayout \
  busybox \
  ca-certificates \
  weechat \
  weechat-lua \
  weechat-perl \
  weechat-ruby
RUN rm -rf /out/etc/apk /out/lib/apk /out/var/cache


FROM scratch
LABEL maintainer="Zachery Hostens <zacheryph@gmail.com>"

COPY --from=build /out/ /
ENV HOME /home
RUN adduser -S -h /home user \
  && chown -R user $HOME

WORKDIR $HOME
USER user

ENTRYPOINT [ "weechat" ]
