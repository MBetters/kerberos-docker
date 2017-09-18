#!/usr/bin/env bash
#
# kinit_test.sh
#
# Execute kinit tests in docker container context.

cd "$(dirname "$0")"
cd ..

kinit_method=${1:-keytab}
container_name=${2:-krb5-machine}

if [[ "${kinit_method}" == "password" ]]; then
  docker exec ${container_name} /bin/bash -c '
    echo "bob" | kinit bob@EXAMPLE.COM
  '
elif [[ "${kinit_method}" == "keytab" ]]; then
  docker exec ${container_name} /bin/bash -c '
    kinit -kt /etc/bob.keytab bob@EXAMPLE.COM
  '
else
  >&2 echo "ERROR: Bad kinit method!"
  exit 1
fi