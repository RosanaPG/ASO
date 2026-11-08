#!/bin/bash

correo="$1"

if [[ $# -eq 0 ]]; then
	echo " Necesitas poner un correo "
	exit 1
elif [[ $1 =~ ^[a-z0-9._-]+@(alu\.)?edu\.gva\.es$ ]]; then

case "$correo" in 
	*@alu.edu.gva.es) 
	echo "$1 es una cuenta alumno"
	;;
	*@edu.gva.es)
	echo "$1 es una cuenta de profesorado"
	;;
esac
else
	echo "$1 no es una cuenta educativa"
fi
