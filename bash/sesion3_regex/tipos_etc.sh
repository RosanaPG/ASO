#!/bin/bash
echo "ficheros de configuracion: "
contador_conf=0
contador_bak=0
for fichero in /etc/*;
	do 
if [[ $fichero =~ \.conf$ ]]; then
	echo $fichero 
	((contador_conf++))
	
elif [[ $fichero =~ (\.bak$|~) ]]; then
	((contado_bak++))
fi
done 
	echo "configuracion: $contador_conf"
	echo "Copias de seguridad : $contador_bak" 


