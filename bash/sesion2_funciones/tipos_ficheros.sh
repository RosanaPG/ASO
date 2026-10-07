#!/bin/bash

contar_por_extension () {

carpeta=$1
ext=$2
cantidad=$(find "$carpeta" -maxdepth 1 -type f -name "*.$ext" | wc -l)
	echo "$ext : $cantidad"
}
for ext in log txt csv 
do
contar_por_extension ~/prueba_bash/datos $ext 
done
echo "$ext : $cantidad" 


