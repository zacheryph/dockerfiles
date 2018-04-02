FROM alpine:edge AS build
LABEL maintainer="Zachery Hostens <zacheryph@gmail.com>"

RUN apk add --no-cache \
  alpine-baselayout \
  busybox \
  ca-certificates \
  weechat \
  weechat-lua \
  weechat-perl \
  weechat-ruby

# FROM scratch
# 
# COPY --from=build /out/ /
ENV HOME /home
# RUN adduser -S -h /home user \
#   && chown -R user $HOME

WORKDIR $HOME
# USER user

ENTRYPOINT [ "weechat" ]
