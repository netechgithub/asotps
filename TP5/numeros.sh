#!/bin/bash

# Leer dos números
read -p "Introduce el primer número: " numero1
read -p "Introduce el segundo número: " numero2

# Leer la operación
read -p "Introduce la operación (+, -, *, /): " operacion

# Calcular el resultado
case $operacion in
    +)
        resultado=$((numero1 + numero2))
        ;;
    -)
        resultado=$((numero1 - numero2))
        ;;
    \*)
        resultado=$((numero1 * numero2))
        ;;
    /)
        if [[ $numero2 -ne 0 ]]; then
            resultado=$((numero1 / numero2))
        else
            echo "Error: División por cero"
            exit 1
        fi
        ;;
    *)
        echo "Operación no válida"
        exit 1
        ;;
esac

# Mostrar el resultado
echo "El resultado es: $resultado"
