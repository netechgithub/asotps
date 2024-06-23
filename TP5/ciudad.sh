#!/bin/bash

API_KEY="tu_api_key_de_weatherapi"
BASE_URL="http://api.weatherapi.com/v1/current.json"

read -p "Introduce el nombre de la ciudad: " ciudad

response=$(curl -s "${BASE_URL}?key=${API_KEY}&q=${ciudad}")

temperatura=$(echo $response | jq '.current.temp_c')
condicion=$(echo $response | jq -r '.current.condition.text')

echo "La temperatura en $ciudad es ${temperatura}°C y el clima es ${condicion}."
