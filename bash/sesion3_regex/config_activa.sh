#!/bin/bash

fichero=$1
if [ -z "$fichero" ]; then
 	fichero="/etc/login.defs"
fi

if [ ! -f "$fichero" ]; then 
	echo "error no existe el fichero"
	exit 1
fi

grep -Ev '^(#|$)' "$fichero"
utiles=$(grep -Ev '^(#|$)' "$fichero" | wc -l)
total=$(wc -l < "$fichero")  
	echo "lineas totales: $total"             `
	echo "lineas utiles: $utiles" 
