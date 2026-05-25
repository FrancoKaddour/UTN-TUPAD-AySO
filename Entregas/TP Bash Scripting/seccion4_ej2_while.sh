#!/bin/bash
# Ejercicio 4.2: Sumar números del 1 al 100 con bucle while

suma=0
i=1

while [[ $i -le 100 ]]; do
    suma=$((suma + i))
    i=$((i + 1))
done

echo "La suma de los números del 1 al 100 es: $suma"
