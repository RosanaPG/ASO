#!/bin/bash

existe_usuario () {
usuario=$1
if id "$1" &>/dev/null; then
	echo "El usuario $usuario existe"
else 
	echo "El usuario $usuario no existe"
fi
}

existe_usuario $1
