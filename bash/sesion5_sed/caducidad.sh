#/bin/bash

dias=$1

if [[ ! $dias =~ ^[0-9]{1,3}$ ]]; then
	echo "ERROR"
	exit 1
fi
antes=$(grep '^PASS_MAX_DAYS' login.defs)

sed -i.bak "s/^PASS_MAX_DAYS.*/PASS_MAX_DAYS $dias/" login.defs

despues=$(grep '^PASS_MAX_DAYS' login.defs)

	echo "Antes: $antes"
	echo "Despues: $despues"
