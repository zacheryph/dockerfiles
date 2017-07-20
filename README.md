# dockerfiles

[![Build Status](https://travis-ci.org/zacheryph/dockerfiles.svg?branch=master)](https://travis-ci.org/zacheryph/dockerfiles)

dockerfiles for... stuff. `port.sh` makes maintaining stubs very easy

## usage

```console
$ ./port.sh
port.sh: container port management

usage: port.sh command [flags]

commands:
  build [app ...]   - build app (or all if not given)
  install           - install stubs into /home/context/bin
  new <app>         - create a new dockerfile/run from template
  push <app>        - push latest version and its tag to hub.docker.com
  tag <app>         - attempt to tag latest version
```
