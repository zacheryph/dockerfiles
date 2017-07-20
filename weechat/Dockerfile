FROM alpine:latest
LABEL maintainer="Zachery Hostens <zacheryph@gmail.com>"

RUN apk add --no-cache \
  ca-certificates \
  weechat \
  weechat-lua \
  weechat-perl \
  weechat-ruby

ENV HOME /home
RUN adduser -S -h /home user \
  && chown -R user $HOME

WORKDIR $HOME
USER user

ENTRYPOINT [ "weechat" ]
