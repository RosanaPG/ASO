#!/bin/bash

# Comprobar que recibe un parámetro
if [ $# -eq 0 ]; then
    echo "Uso: $0 carpeta_remota"
    exit 1
fi

carpeta=$1
fecha=$(date +%F_%H-%M)
nombre=$(basename "$carpeta")
destino="$HOME/backups/espejo"

# Crear carpeta para las copias
mkdir -p "$destino"

# Función para guardar el resultado
registrar() {
    echo "$fecha - $carpeta - $1" >> "$HOME/backups/backup.log"
}

# Comprobar conexión SSH
if ! ssh -o BatchMode=yes servidor true; then
    echo "Error: no se puede conectar al servidor"
    registrar "ERROR DE CONEXION"
    exit 1
fi

# Realizar la copia
if rsync -av "servidor:$carpeta/" "$destino"; then
    echo "Copia realizada correctamente"
    registrar "CORRECTO"
else
    echo "Error al realizar la copia"
    registrar "ERROR"
    exit 1
fi

