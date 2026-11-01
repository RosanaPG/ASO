#!/bin/bash
fichero=$1
sed -E 's/([0-9]{1,3}\.){3}[0-9]{1,3}/X.X.X.X/g' "$fichero" > "${fichero}.anonimo"
