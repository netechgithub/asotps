#!/bin/bash

# Clave de API de weatherapi.com (reemplaza con tu propia clave)
apiKEY="8719255a66df4f5792d202736242406"

# Solicitar al usuario que ingrese una ciudad
read -p "Ingrese una ciudad para saber su clima actual: " ciudad_ini

# Reemplazar espacios en la ciudad por %20 para la URL
ciudad_ingresada=$(echo "$ciudad_ini" | tr ' ' '%20')

# Construir la URL de la API
url="http://api.weatherapi.com/v1/current.json?key=$apiKEY&q=$ciudad_ingresada&aqi=no"

# Hacer la solicitud GET a la API y guardar la respuesta en un archivo JSON
curl --silent --request GET "$url" --output respuesta.json

# Verificar si se obtuvo la respuesta correctamente y no está vacía
if [ -s respuesta.json ]; then
    # Comprobar si la respuesta contiene un error
    error=$(jq -r '.error.message' respuesta.json)
    if [ "$error" != "null" ]; then
        echo "Error: $error"
    else
        # Conseguir la temperatura actual del JSON usando jq
        clima=$(jq -r '.current.temp_c' respuesta.json)
        condicion=$(jq -r '.current.condition.text' respuesta.json)

        # Mostrar el clima actual de la ciudad
        echo "El clima actual de $ciudad_ini es: $clima°C y el estado es: $condicion"
    fi
else
    echo "No se pudo obtener el clima para la ciudad: $ciudad_ini."
fi

# Eliminar el archivo temporal
rm respuesta.json
