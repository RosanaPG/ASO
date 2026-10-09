#!/bin/bash

pedir_puerto_valido () {

read -p "introduce un puerto : " puerto 

until [[ $puerto =~ ^[0-9]+$ ]] && (( puerto >= 1 && puerto <= 65535 ));
do
	echo "puerto no valido"
	read -p "Introduce un puerto : " puerto
done 
}

pedir_puerto_valido
 echo "puerto valido recibido : $puerto"
