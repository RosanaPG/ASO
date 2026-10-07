#!/bin/bash 

bytes_a_gb () {

bytes=$1 

   resultado=$(echo "scale=2; $bytes / 107341824" | bc)
	echo "bytes_a_gb "$1" $resultado : GB"
} 

bytes_a_gb "$1"
