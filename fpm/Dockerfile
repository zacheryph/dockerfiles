FROM ruby:2.4.2-alpine3.6
LABEL maintainer="Zachery Hostens <zacheryph@gmail.com>"

RUN apk add --no-cache make gcc libc-dev rpm \
  && gem install --no-ri --no-rdoc fpm \
  && apk del make gcc libc-dev \
  && rm -rf /usr/local/bundle/cache/*

ENV HOME /home
RUN adduser -S -h /home user \
  && chown -R user $HOME

WORKDIR $HOME
USER user

ENTRYPOINT [ "/usr/local/bundle/bin/fpm" ]
