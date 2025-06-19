
#!/bin/sh


host="$1"
port="$2"
user="$3"
password="$4"
database="$5"
shift 5

echo "Esperando a que MySQL esté listo en $host:$port con usuario $user..."

until mysql -h "$host" -P "$port" -u"$user" -p"$password" "$database" -e "SELECT 1" >/dev/null 2>&1; do
  echo "Esperando..."
  sleep 2
done

echo "MySQL está listo. Iniciando aplicación..."
exec "$@"
