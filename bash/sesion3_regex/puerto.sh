#!/bin/bash 

puerto="$1"

if [[ -z  $puerto ]]; then 
	echo "uso: $0 numero "
	exit 1
	
elif [[ ! $puerto =~ ^[0-9]+$ ]]; then 
	echo "no es un numero" 
elif (( puerto >= 1 )) && (( puerto <= 65535 )); then 
	echo "$puerto es un puerto valido"
else 
	echo "$puerto esta fuera de rango" 
fi
