#!/bin/bash

PORTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

read -r -d '' USAGE <<EOF
port.sh: container port management

usage: port.sh command [flags]

commands:
  build [app ...]   - build app (or all if not given)
  install           - install stubs into ${HOME}/bin
  new <app>         - create a new dockerfile/run from template
  push <app>        - push latest version and its tag to hub.docker.com
  tag <app>         - attempt to tag latest version
EOF

usage() {
  echo "$USAGE"
  exit
}

port_build() {
  # need to get Username from: docker system info
  echo "not implemented"
}

port_install() {
  for runner in $(find $PORTDIR -type f -name run -not -wholename '*/template/run'); do
    app=$(basename $(dirname $runner))
    echo "== linking ${app}"
    ln -sf $runner ${HOME}/bin/${app}
  done
}

port_new() {
  if [[ -d "$app" ]]; then
    echo "$app dockerfile already exists"
    exit
  fi

  mkdir $app
  for f in $(ls template); do
    cat template/$f \
      | sed "s|__NAME__|$app|" \
      > $app/$f

    chmod --reference=template/$f $app/$f
  done

  echo "== created $app for editing"
}

port_push() {
  echo "not implemented"
}

port_tag() {
  # run latest with --version, docker tag
  echo "not implemented"
}

cmd=$1 ; shift

[[ -z "$cmd" ]] && usage

case "$cmd" in
  build)
    port_build $*
    ;;
  install)
    port_install
    ;;
  new)
    port_new $*
    ;;
  push)
    port_push $*
    ;;
  tag)
    port_tag $*
    ;;
  *)
    usage
    ;;
esac
