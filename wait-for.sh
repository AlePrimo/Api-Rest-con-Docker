

#!/bin/bash

#!/bin/sh

host="$1"
port="$2"
user="$3"
password="$4"
database="$5"
shift 5

echo "Esperando a MySQL en $host:$port con usuario $user..."

for i in $(seq 1 20); do
  echo "⏳ Intento $i..."
  if mysql -h "$host" -P "$port" -u"$user" -p"$password" -e "USE $database;" > /dev/null 2>&1; then
    echo "✅ MySQL está listo."
    exec "$@"
    exit
  fi
  sleep 3
done

echo "❌ Error: No se pudo conectar a MySQL después de múltiples intentos."
exit 1

