#!/bin/sh

host=$(echo "$1" | cut -d: -f1)
port=$(echo "$1" | cut -d: -f2)

shift

echo "Esperando a $host:$port..."

while ! nc -z "$host" "$port"; do
  sleep 2
done

echo "$host:$port disponible. Iniciando aplicación..."
exec "$@"
