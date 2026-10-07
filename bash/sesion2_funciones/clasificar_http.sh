#!/bin/bash

clasificar_http () {
codigo=$1

if [[ $codigo -ge 200 && $codigo -le 299 ]]; then 
	echo "Clasificar_http $codigo : EXITO"
elif [[ $codigo -ge 300 && $codigo -le 399 ]]; then 
	echo " Clasificar_http $codigo : REDIRECCION"
elif [[ $codigo -ge 400 && $codigo -le 499 ]]; then
	echo "Clasificar_http $codigo : ERROR CLIENTE"
elif [[ $codigo -ge 500 && $codigo -le 599 ]]; then
	echo "Clasificar_http $codigo : ERROR SERVIDOR" 
fi 


}
clasificar_http $1 
