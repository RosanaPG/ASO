#!/bin/bash

ip="$1"

if [[ $# -eq 0 ]]; then 
 	exit 1
elif [[ $ip =~ ^127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then 
	echo " $ip es una direccion loopback"
	
elif [[ $ip =~ ^(10\.|192\.168\.|172.(1[6-9]|2[0-9]|3[0-1]\.)) ]]; then
	echo "$ip es una direccion privada"
else 
	echo " $ip es una direccion publica"
fi 

#Para sacar el rango restringido lo averigue buscando informacion para restringir las ip que es 0-255 ya que en la primera condicion me podria dar hasta 999 entraria .  
