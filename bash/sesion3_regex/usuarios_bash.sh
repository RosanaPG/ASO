#!/bin/bash
usuarios_bash=0

while read -r linea
do 
	if [[ "$linea" =~ bash$ ]]; then
	echo "${linea%%:*}"
	((usuarios_bash++))
fi

done < /etc/passwd

echo "usuarios con bash: $usuarios_bash"
