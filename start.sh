#!/bin/sh

/usr/bin/mongod --quiet --config /etc/mongod.conf &
redis-server &

echo "mongodb version:"
mongod --version

redis-server --version

redis-cli ping
