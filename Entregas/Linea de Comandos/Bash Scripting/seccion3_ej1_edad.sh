#!/bin/bash
# Ejercicio 3.1: Pedir edad y determinar si es mayor o menor de edad

read -p "Ingresá tu edad: " edad

if [[ $edad -ge 18 ]]; then
    echo "Sos mayor de edad."
else
    echo "Sos menor de edad."
fi
