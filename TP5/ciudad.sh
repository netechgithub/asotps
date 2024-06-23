#!/bin/bash

# Clave de API
apiKEY="8719255a66df4f5792d202736242406"

# Función para imprimir en color
print_color() {
    color_code=$1
    message=$2
    echo -e "\e[${color_code}m${message}\e[0m"
}

# Solicitar al usuario que ingrese la ciudad
read -p "Ingrese una ciudad para saber su clima actual: " ciudad_ini

ciudad_ingresada=$(echo "$ciudad_ini" | tr ' ' '%20')

# URL de la API
url="http://api.weatherapi.com/v1/current.json?key=$apiKEY&q=$ciudad_ingresada&aqi=no&lang=es"

curl --silent --request GET "$url" --output respuesta.json

if [ -s respuesta.json ]; then
    # Comprobar si la respuesta contiene un error
    error=$(jq -r '.error.message' respuesta.json)
    if [ "$error" != "null" ]; then
        print_color "31" "Error: $error"
    else
        # Conseguir la temperatura actual del JSON usando jq
        clima=$(jq -r '.current.temp_c' respuesta.json)
        condicion=$(jq -r '.current.condition.text' respuesta.json)

        # Mostrar el clima actual de la ciudad
        print_color "32" "El clima actual de $ciudad_ini es: $clima°C"
        print_color "34" "Estado: $condicion"
    fi
else
    print_color "31" "No se pudo obtener el clima para la ciudad: $ciudad_ini."
fi

# Eliminar el archivo temporal
rm respuesta.json