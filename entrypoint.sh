#!/bin/bash
set -e

if [ $(echo "$1" | cut -c1) = "-" ]; then
  set -- drivechaind "$@"
fi

if [ "$1" = "drivechaind" ] || [ "$1" = "drivechain-cli" ]; then
  echo
  exec gosu bitcoin "$@"
fi

echo
exec "$@"

