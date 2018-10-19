#!/bin/bash
set -e

stop_tools () {
  if [ -x /etc/init.d/prltoolsd ]; then
    echo "Stopping tools..."
    /etc/init.d/prltoolsd stop
    sleep 1
  fi
  exit
}

if [ "$1" = 'start' ]; then
  trap stop_tools SIGHUP SIGINT SIGTERM

  echo "Installing parallels tools ..."
  cd /
  tar -Jxf prl-tools-lin.tar.xz
  cd prl-tools-lin

  ./install --install-unattended --verbose

  while true; do sleep 1000; done
else
  exec "$@"
fi
