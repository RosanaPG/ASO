#/bin/bash
fichero="$1"
if [[ $# -eq 0 ]];  then 
	echo "Debes introuducir ./config_limpia.sh login.defs"
	exit 1
elif [[ ! -f $fichero ]]; then 
	echo "error"
	exit 1
fi
 sed '/^#/d; /^$/d' "$fichero"

