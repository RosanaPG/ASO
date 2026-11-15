#!/bin/bash

#Implementar su propia funcion 
# 1_  listar los procesos

listar_usuario () {
read -p "Introduce un usuario: " usuario
if id "$usuario" > /dev/null 2>&1; then 
	echo "el usuario $usuario existe"
	ps -u "$usuario"
else 
	echo "el usuario no existe"
fi 
}
#listar_usuario

# 2_   Buscar un proceso por nombre 
buscar_proceso () {
read -p "introduce el nombre del proceso:" nombre
if [[ -z "$nombre" ]]; then
	echo "Debes introducir un nombre"
	return 1
fi 
if ps -C "$nombre" > /dev/null 2>&1; then 
	ps -C "$nombre" -o pid,user,%cpu,comm
else
	echo "error: no existe el proceso"
fi
}
#buscar_proceso

# 3_  Mostrar los N procesos que mas CPU consumen 

top_cpu () {
n="${1:-5}"
lineas=$((n+1))
ps -eo pid,user,%cpu,comm --sort=-%cpu | head -n "$lineas"
}
#top_cpu "$1"


#VALIDAR PID LA FUNCION QUE NECESITO PARA EL PUNTO 4 Y 5 FUNCION DENTRO OTRA FUNCION (primero la creo)

validar_pid () {
if [[ "$1" =~ ^[0-9]+$ ]]; then 

	if ps -p "$1" > /dev/null 2>&1; then
	return 0
	fi
fi 
	return 1
}
#validar_pid
 



#  4__  cambiar prioridad pidiendo el PID


cambiar_prioridad () {

read -p "introduce un PID: " pid
read -p "Introduce un valor nice: " nice
if [[ -z "$pid" ]]; then 
	echo " Debes introducir un PID"
	return 1
elif [[ -z "$nice" ]]; then
	echo "introduce un valor"
	return 1
fi
if validar_pid "$pid"; then 
	echo "PID: $pid"
	else
		echo "error: pid no valido"
		return 1
fi 
                # NICE SUS VALORES Y QUE ES UN NUMERO 
if [[ ! "$nice" =~ ^-?[0-9]+$ ]]; then 
	echo "Error:debes introducir un numero"
	return 1
fi 
if [[ "$nice" -lt -20 || "$nice" -gt 19 ]]; then 	
	echo "Error: nice debe estar entre -20 y 19"
	return 1
fi 
               # SI NO SE EJECUTA COMO ROOT SOLO PERMITE VALORES DE 0 A 19 
if [[ "$EUID" -ne 0 && "$nice" -lt 0 ]]; then 
	echo "el valor debe estar entre 0 o 19"
	return 1
fi
                       #GUARDAR EL NOMBRE DEL PROCESO
nombre=$(ps -p "$pid" -o comm=)
                      #CAMBIAR PRIORIDAD *registrar el cambio gestion_procesos.log
if renice -n "$nice" -p "$pid" ; then     
	echo "prioridad cambiada correctamente"
	echo "$(date '+%Y-%m-%d %H:%M:%S') - renice $nice - $pid - $nombre" >> ~/gestion_procesos.log 
else
	echo "Error: no se puede cambiar la prioridad"
	return 1
fi
}
#cambiar_prioridad


               #  5___ FINALIZAR UN PROCESO 
finalizar_proceso () {
read -p "introduce un pid:" pid

if ! validar_pid "$pid"; then 
	echo "error: no existe el pid"
	return 1
fi
#FINALIZA SI ES SI
nombre=$(ps -p "$pid" -o comm=)
read -p "¿finaliza $pid ($nombre) ? (S/N):" respuesta
if [[ $respuesta == "S" ]]; then 
	
# FORZAR LA FINALIZACION
	if ! kill -SIGTERM "$pid"; then
		echo "error al enviar SIGTERM"
		return 1
	fi 
	sleep 3
		if ps -p "$pid" > /dev/null >2&1; then
			if ! kill -SIGKILL "$pid"; then 
				echo "error al enviar el SIGKILL"
				return 1
			fi
	echo "proceso finalizado con SIGKILL"
	accion="SIGKILL"
		else
		echo "proceso finaliza con SIGTERM"
		accion="SIGTERM"
		fi
#registrar en gestion_procesos.log
echo "$(date '+%Y-%m-%d %H:%M:%S') - $accion -$pid -$nombre" >> ~/gestion_procesos.log

else 
	echo "operacion cancelada"
fi
}
#finalizar_proceso

while true; do

    echo "===== GESTIÓN DE PROCESOS ====="
    echo "1) Listar los procesos de un usuario"
    echo "2) Buscar un proceso por nombre"
    echo "3) Mostrar los N procesos que más CPU consumen"
    echo "4) Cambiar la prioridad de un proceso"
    echo "5) Finalizar un proceso"
    echo "6) Salir"

    read -p "Opción: " opcion
  case "$opcion" in
        1) listar_usuario ;;
        2) buscar_proceso ;;
        3)
            read -p "Número de procesos (Enter = 5): " n
            top_cpu "$n"
            ;;
        4) cambiar_prioridad ;;
        5) finalizar_proceso ;;
        6)
            echo "Saliendo..."
            break
            ;;
        *) echo "Opción incorrecta" ;;
    esac

done
