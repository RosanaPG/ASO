#!/bin/bash

# FUNCION PARA MOSTRAR ERRORES

error() {
    echo "Error: $1"
    echo "Uso: $0 alta | baja identificador"
    exit 1
}

# FUNCION PARA GENERAR EL IDENTIFICADOR

generar_identificador() {

    nom=$(echo "$nombre" | cut -c1-2)

    apellido1=$(echo "$apellidos" | cut -d' ' -f1)
    apellido2=$(echo "$apellidos" | cut -d' ' -f2)

    ape1=$(echo "$apellido1" | cut -c1-2)
    ape2=$(echo "$apellido2" | cut -c1)

    identificador=$(echo "alu$nom$ape1$ape2" | tr 'A-Z' 'a-z')
}

# COMPROBAR SI FALTA LA ACCION

if [[ $# -eq 0 ]]; then
    error "Falta indicar alta o baja"
fi

# ALTA DE USUARIO

if [[ "$1" == "alta" ]]; then

    if [[ $# -ne 1 ]]; then
        error "Para alta solo debes indicar la accion"
    fi

    read -p "Nombre: " nombre
    read -p "Apellidos: " apellidos

    # Comprobar nombre

    if [[ ! $nombre =~ ^[a-zA-Z]{2,}$ ]]; then
        error "El nombre no es valido"
    fi

    # Comprobar los dos apellidos

    if [[ ! $apellidos =~ ^[a-zA-Z]{2,}[[:space:]][a-zA-Z]+$ ]]; then
        error "Escribe los dos apellidos separados por un espacio"
    fi

    generar_identificador

    # Comprobar si el usuario ya existe

    if id "$identificador" &>/dev/null; then
        error "El usuario $identificador ya existe"
    fi

    echo "Identificador generado: $identificador"
    echo "Para crearlo: sudo useradd -m -s /bin/bash -c \"$nombre $apellidos\" $identificador"

# BAJA DE USUARIO

elif [[ "$1" == "baja" ]]; then

    if [[ $# -ne 2 ]]; then
        error "Debes indicar un identificador"
    fi

    identificador="$2"

    # Comprobar formato del identificador

    if [[ ! $identificador =~ ^alu[a-z]{5}$ ]]; then
        error "$identificador no tiene el formato aluXXYYZ"
    fi

    # Comprobar si existe

    if ! id "$identificador" &>/dev/null; then
        error "El usuario $identificador no existe"
    fi

    echo "Para eliminarlo: sudo userdel $identificador"

# ACCION INCORRECTA

else
    error "La accion $1 no es valida"
fi
