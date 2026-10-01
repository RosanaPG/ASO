#!/bin/bash

n=$(( $1 * 100 / $2 ))

if [ "$n" -lt 70 ]; then 
	echo "OK"
elif [ "$n" -lt 90 ]; then
	echo "AVISO (cuidado con el limite exacto)"
else
	echo "CRITICO"
fi
	echo "nivel del disco finalizado" 
	

