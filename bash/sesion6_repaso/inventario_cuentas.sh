#!/bin/bash
shell=$1

if [[ $# -eq 0 ]]; then 
	shell="/bin/bash"
else
	shell="$1"

fi

if [[ ! "$shell" =~ ^(/[a-z]+)+$ ]]; then 
	 echo "Error: $shell no es una ruta valida"
	exit 1
fi

#ESTE PASO NO SE SEGUIR COMO SACRLO(LO HE BUSCADO IA) 
total=0
mayores=0
while  IFS=':' read -r usuario x uid gid descripcion home shell_usuario;
do
	if [[ "$shell" == "$shell_usuario" ]]; then
	echo "$usuario:$uid:$home:$shell_usuario"
	total=$((total+1))
		if [[ $uid -ge 1000 ]]; then 
		mayores=$((mayores +1))
		fi
	fi
done < /etc/passwd
# MOSTRAR EL RESUMEN
	echo "--"
	echo "Cuentas listadas: $total"
	echo "Con UID >= 1000: $mayores"
