#!/bin/bash
# Ejercicio 6.2: Leer nombres desde nombres.txt e imprimir saludo personalizado

if [[ ! -e nombres.txt ]]; then
    echo "Error: el archivo nombres.txt no existe."
    exit 1
fi

while read linea; do
    echo "Hola, $linea! Que tengas un excelente día."
done < nombres.txt
