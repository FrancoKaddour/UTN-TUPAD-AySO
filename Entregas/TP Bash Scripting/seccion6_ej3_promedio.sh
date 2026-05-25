#!/bin/bash
# Ejercicio 6.3: Calcular el promedio de 5 números usando bucle for

suma=0

for i in {1..5}; do
    read -p "Ingresá el número $i: " numero
    suma=$((suma + numero))
done

promedio=$((suma / 5))

echo "La suma total es: $suma"
echo "El promedio de los 5 números es: $promedio"
