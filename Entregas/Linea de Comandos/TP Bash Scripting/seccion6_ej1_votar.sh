#!/bin/bash
# Ejercicio 6.1: Nombre y edad, verificar si puede votar (mayor de 16)

read -p "Ingresá tu nombre: " nombre
read -p "Ingresá tu edad: " edad

if [[ $edad -gt 16 ]]; then
    echo "Hola $nombre, tenés $edad años. Podés votar."
else
    echo "Hola $nombre, tenés $edad años. No podés votar todavía."
fi
