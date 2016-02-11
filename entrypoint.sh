#!/usr/bin/dumb-init /bin/sh
set -e

echo "Installing parallels tools ..."
cd /
tar -Jxf prl-tools-lin.tar.xz
cd prl-tools-lin
./install --install-unattended
cd /

# Disable starting service
sed -i -e 's|^PRLTOOLSD_OPTIONS=.*|PRLTOOLSD_OPTIONS="-h"|' /etc/init.d/prltoolsd

if [ "$1" = 'start' ]; then
  # Stop background service
  /etc/init.d/prltoolsd stop

  # Wait for service to finish exiting
  sleep 1

  # Start service in foreground
  echo 'Starting parallels tools service'
  set -x
  /usr/bin/prltoolsd -f
else
  exec "$@"
fi
