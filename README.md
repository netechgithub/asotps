Respuestas trabajo practico n*3 :


1)A) Podemos notar que es predecible ya que no varia demasiado el tiempo entre una ejecución y otra del código.

1)B) No, son similares los tiempos de ejecución.

1)C) Hice una serie de pruebas ejecutando el archivo suma_resta con argumentos. Al principio, al ejecutar el programa 10 veces, siempre obtenía el mismo resultado, que era 0, con un tiempo de ejecución promedio de 0.024 segundos. Sin embargo, al descomentar ciertas partes del código, el comportamiento cambió drásticamente. El tiempo de ejecución promedio se disparó a 7.3 segundos, y el resultado final se volvió impredecible.

La razón de esta variación se debe a que el programa lanza dos hilos que suman y restan simultáneamente una cierta cantidad de veces a una variable compartida llamada "acumulador". Sin restricciones o mecanismos de exclusión mutua, como los bloqueos (locks), los hilos acceden y modifican la variable "acumulador" al mismo tiempo, lo que genera una condición de carrera (race condition).

Una condición de carrera ocurre cuando el resultado de una operación depende del orden y la velocidad en que se ejecutan los hilos. Dado que los hilos pueden interferir entre sí al modificar la variable compartida, el resultado final es impredecible y varía con cada ejecución. Este fenómeno es debido a las diferencias en los tiempos de ejecución internos y a la velocidad con la que cada hilo realiza sus tareas.

Para ilustrarlo mejor, imagina dos personas intentando escribir en la misma hoja de papel al mismo tiempo sin coordinarse entre sí. El resultado final en el papel dependerá de quién escribió más rápido o quién interfirió con el otro en un momento dado. De manera similar, sin una coordinación adecuada en el acceso a la variable "acumulador", los hilos pueden sobrescribir los cambios de los otros, causando resultados inconsistentes.
