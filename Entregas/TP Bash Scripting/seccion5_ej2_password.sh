#!/bin/bash
# Ejercicio 5.2: Solicitar contraseña oculta y confirmar ingreso

read -s -p "Ingresá tu contraseña: " contrasena
echo
read -s -p "Confirmá tu contraseña: " confirmacion
echo

if [[ $contrasena == $confirmacion ]]; then
    echo "Contraseña registrada correctamente."
else
    echo "Las contraseñas no coinciden. Intentá de nuevo."
fi
