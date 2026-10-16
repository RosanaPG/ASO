#!/bin/bash
while true
do
read -p "nombre de usuario: " usuario 
if [[ $usuario =~ ^[a-z][a-z0-9]*$ ]]; then
	break
else 
	echo "nombre no valido."
fi
done

if grep -q "^$usuario:" /etc/passwd; then 
	echo "El usuario $usuario ya existe"

else
	echo "sudo useradd -m -s /bin/bash $usuario"
fi
