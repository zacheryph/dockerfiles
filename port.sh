#!/bin/bash

PORTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

USERNAME=$(docker system info 2>/dev/null | grep "^Username:" | sed 's|^Username: *||')

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

ensure_app() {
  app="$1"

  if [[ -z "$app" ]] || [[ ! -d "$app" ]]; then
    echo "!! $app not found or not given"
    exit
  fi
}

pull_image_id() {
  name="$1"
  tag=${2:-latest}

  docker images -q "${USERNAME}/${name}:${tag}"
}

port_build() {
  app=$1
  ensure_app "$app"

  docker build -t "${USERNAME}/${app}" "$app"
}

port_install() {
  find "$PORTDIR" -type f -name run -not -wholename "*/template/run" |
  while read -r runner; do
    app=$(basename $(dirname $runner))
    echo "== linking ${app}"
    ln -sf $runner ${HOME}/bin/${app}
  done

  # TODO: remove stubs that no longer exist
}

port_new() {
  app="$1"
  if [[ -d "$app" ]]; then
    echo "$app dockerfile already exists"
    exit
  fi

  mkdir $app

  for f in $(ls template); do
    cat template/$f \
      | sed "s|__NAME__|$app|" \
      > $app/$f

    chmod --reference="template/$f" "$app/$f"
  done

  echo "== created $app for editing"
}

port_push() {
  app="$1"
  ensure_app "$app"
  id=$(pull_image_id "${app}")
  if [[ -z "$id" ]]; then
    echo "!! image not found for ${app}"
    exit
  fi

  docker images --format '{{.ID}} {{.Tag}}' "${USERNAME}/${app}" | \
    grep "^${id}" | \
    awk '{{print $2}}' | \
    while read -r tag; do
      echo "== pushing ${app}:${tag}"
      docker push "${USERNAME}/${app}:${tag}"
    done
}

port_tag() {
  app=$1
  ensure_app "$app"

  id_latest=$(pull_image_id "${app}")
  if [[ -z "$id_latest" ]]; then
    echo "!! need to build image first"
    exit
  fi

  if ! version=$(docker run --rm "${USERNAME}/${app}" --version); then
    echo "!! failed to retrieve version with --version. must manually tag"
    exit
  fi

  id_version=$(pull_image_id "${app}" "${version}")
  if [[ -n "$id_version" ]]; then
    echo "!! ${app}:${version} already tagged"
    exit
  fi

  echo "== tagging ${USERNAME}/${app}:${version} => ${id_latest}"
  docker tag "${USERNAME}/${app}:latest" "${USERNAME}/${app}:${version}"
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
