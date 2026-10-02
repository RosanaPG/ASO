#!/bin/bash 
for entrada in ~/prueba_bash/*
	do 
		if [ -f "$entrada" ]; then 

		echo "$(basename "$entrada"): fichero"
	elif [ -d "$entrada" ]; then
		echo "$(basename "$entrada"): directorio"
		fi
done	
