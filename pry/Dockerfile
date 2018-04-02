FROM ruby:alpine3.6
LABEL maintainer="Zachery Hostens <zacheryph@gmail.com>"

RUN gem install --no-ri --no-rdoc pry

ENV HOME /home
RUN adduser -S -h /home user \
  && chown -R user $HOME

WORKDIR $HOME
USER user

ENTRYPOINT [ "pry" ]
