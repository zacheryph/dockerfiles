FROM debian:unstable-slim
LABEL maintainer="Zachery Hostens <zacheryph@gmail.com>"

RUN apt update && apt install -y --no-install-recommends \
  file \
  shellcheck

ENTRYPOINT [ "shellcheck" ]
