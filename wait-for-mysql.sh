
#!/bin/sh

host="$1"
port="$2"
shift 2

echo "⏳ Esperando que MySQL esté disponible en $host:$port..."

while ! nc -z $host $port; do
  echo "❌ Aún no está disponible..."
  sleep 2
done

echo "✅ MySQL disponible, arrancando app..."
exec "$@"
