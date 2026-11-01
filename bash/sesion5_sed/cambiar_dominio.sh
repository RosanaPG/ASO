#!/bin/bash
fichero=$1
sed -E 's/@(gmail|hotmail)\.com$/@alu.edu.gva.es/' "$fichero"
