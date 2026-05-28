#!/bin/bash
# Ejercicio 2.1: Variables numéricas y operaciones aritméticas

a=10
b=3

suma=$((a + b))
resta=$((a - b))
multiplicacion=$((a * b))
division=$((a / b))

echo "Valor de a: $a"
echo "Valor de b: $b"
echo "Suma:           $a + $b = $suma"
echo "Resta:          $a - $b = $resta"
echo "Multiplicación: $a * $b = $multiplicacion"
echo "División:       $a / $b = $division"
