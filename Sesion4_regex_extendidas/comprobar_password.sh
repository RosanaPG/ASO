#!/bin/bash

password="$1"
cumple=0
if [[ $# -eq 0 ]]; then
	echo "introduce una contraseña"
	exit 1
fi 
if [[ $1 =~ ^.{12,}$ ]]; then 
	echo "Tiene al menos 12 caracteres : SI"
	((cumple++))
else 
	echo "Tiene al menos 12 caracteres : NO"
fi
if [[ $1 =~ [0-9] ]]; then 
	echo "Contiene algun digito: SI"
	((cumple++))
else 
	echo "Contiene algun digito: NO"
fi
if [[ $1 =~ [A-Z] ]]; then 
	echo "Contiene alguna mayuscula: SI"
	((cumple++))
else 
	echo "Contiene alguna mayuscula: NO"
fi 
 
if [[ $1 =~ [^a-zA-Z0-9] ]]; then
	echo "Contiene algun simbolo: SI"
	((cumple++))
else
	echo "Contiene algun simbolo: NO"
fi 
if  grep -Fixq "$1" /usr/share/dict/spanish; then
	echo "No es una palabra del diccionario: NO"
else
	echo "No es una palabra del diccionario: SI"
	((cumple++))
fi
if [[ $cumple -eq 5 ]]; then 
 	echo "La contraseña es segura"
else
	echo "la contraseña no es segura"
fi 
