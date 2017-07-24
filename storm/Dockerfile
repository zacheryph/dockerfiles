FROM alpine:edge
LABEL maintainer="Zachery Hostens <zacheryph@gmail.com>"

RUN apk add --no-cache \
  ca-certificates \
  python3 \
  py3-pynacl \
  py3-cffi \
  py3-cryptography \
  py3-bcrypt \
  py3-click \
  py3-flask \
  py3-idna \
  py3-itsdangerous \
  py3-asn1crypto \
  py3-jinja2 \
  py3-markupsafe \
  py3-paramiko \
  py3-asn1 \
  py3-cparser \
  py3-six \
  py3-termcolor \
  py3-werkzeug \
  && pip3 install stormssh

ENV HOME /home
RUN adduser -S -h /home user \
  && chown -R user $HOME

WORKDIR $HOME
USER user

ENTRYPOINT [ "storm" ]
