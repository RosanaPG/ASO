#!/bin/bash

# PUNTO 5. FUNCION PARA REGISTRAR MENSAJES

registrar() {
    echo "$1"
    logger -t aso-backup "$1"
}


# PUNTO 1. PARAMETROS OPCIONALES

if [[ $# -eq 0 ]]; then
    destino="/var/backups"
else
    destino="$1"
fi

if [[ $# -lt 2 ]]; then
    maximo=7
else
    maximo="$2"
fi


# PUNTO 2. COMPROBAR DIRECTORIO Y NUMERO MAXIMO

if [[ ! -d "$destino" ]]; then
    registrar "Error: el directorio $destino no existe"
    exit 1

elif [[ ! $maximo =~ ^[0-9]+$ ]]; then
    registrar "Error: $maximo no es un numero"
    exit 1

elif [[ $maximo -le 0 ]]; then
    registrar "Error: el numero maximo de copias debe ser mayor que 0"
    exit 1

fi


# PUNTO 3. GENERAR FECHA Y CREAR COPIA COMPRIMIDA

fecha=$(date +%Y%m%d-%H%M%S)

archivo="etc-$fecha.tar.gz"

ruta="$destino/$archivo"

if tar -czf "$ruta" -C / etc; then

    registrar "$(date +%T) Copia creada: $ruta"

else

    registrar "Error: no se pudo crear la copia"
    exit 1

fi


# PUNTO 4. CONTAR LAS COPIAS CON FORMATO CORRECTO

copias=$(find "$destino" -maxdepth 1 -type f -printf '%f\n' |
         grep -Ec '^etc-[0-9]{8}-[0-9]{6}\.tar\.gz$')


# COMPROBAR SI SUPERAN EL MAXIMO RECOMENDADO

if [[ $copias -gt $maximo ]]; then

    registrar "$(date +%T) Aviso: hay $copias copias y el maximo recomendado es $maximo"

fi
