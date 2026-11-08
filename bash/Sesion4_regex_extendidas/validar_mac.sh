#!/bin/bash 

mac=$1
if [[ $# -eq $mac ]]; then

elif [[ $mac =~ ^[a-zA-Z0-9]{2}\:[a-zA-Z0-9]{2}\:[a-zA-Z0-9]{2}\:[a-zA-Z0-9]{2}\:[a-zA-Z0-9]\:[a-zA-Z0-9]{2}$ ]]; then
	echo "Direccion mac valida"
else 
	echo "Direccion mac no valida"
fi 
