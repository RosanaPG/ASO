#!/bin/bash
ip=$1
if [[ $# -eq 0 ]]; then 
	echo "Necesitas poner una ip"
	exit 1 
elif [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then 
	echo "la ip es valida"
else 	echo "ip no valida"
fi 
