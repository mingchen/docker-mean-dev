#!/bin/sh

echo "mongodb version:"
mongod --version

redis-server --version

/usr/bin/mongod --config /etc/mongod.conf &

redis-server &

sleep 2

mongostat -n 1 --json

redis-cli ping

