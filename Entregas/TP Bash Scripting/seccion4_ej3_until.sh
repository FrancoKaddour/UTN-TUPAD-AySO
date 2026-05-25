#!/bin/bash
# Ejercicio 4.3: Pedir contraseña hasta que el usuario escriba "secreto"

contrasena=""

until [[ $contrasena == "secreto" ]]; do
    read -p "Ingresá la contraseña: " contrasena
    if [[ $contrasena != "secreto" ]]; then
        echo "Contraseña incorrecta. Intentá de nuevo."
    fi
done

echo "Contraseña correcta. Acceso concedido."
