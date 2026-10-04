#!/bin/bash

for carpeta in "$1"/*.log
	do 

	warning=$(grep -c WARNING "$carpeta")
	error=$(grep -c ERROR "$carpeta")
echo "$(basename "$carpeta"): $warning WARNING $error ERROR"
done  
