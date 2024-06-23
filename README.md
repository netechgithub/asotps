Respuestas trabajo practico n*3 :


1)A) Podemos notar que es predecible ya que no varia demasiado el tiempo entre una ejecución y otra del código.

1)B) No, son similares los tiempos de ejecución.

1)C) Hice una serie de pruebas ejecutando el archivo suma_resta con argumentos. Al principio, al ejecutar el programa 10 veces, siempre obtenía el mismo resultado, que era 0, con un tiempo de ejecución promedio de 0.024 segundos. Sin embargo, al descomentar ciertas partes del código, el comportamiento cambió drásticamente. El tiempo de ejecución promedio se disparó a 7.3 segundos, y el resultado final se volvió impredecible.

La razón de esta variación se debe a que el programa lanza dos hilos que suman y restan simultáneamente una cierta cantidad de veces a una variable compartida llamada "acumulador". Sin restricciones o mecanismos de exclusión mutua, como los bloqueos (locks), los hilos acceden y modifican la variable "acumulador" al mismo tiempo, lo que genera una condición de carrera (race condition).

Una condición de carrera ocurre cuando el resultado de una operación depende del orden y la velocidad en que se ejecutan los hilos. Dado que los hilos pueden interferir entre sí al modificar la variable compartida, el resultado final es impredecible y varía con cada ejecución. Este fenómeno es debido a las diferencias en los tiempos de ejecución internos y a la velocidad con la que cada hilo realiza sus tareas.

Para ilustrarlo mejor, imagina dos personas intentando escribir en la misma hoja de papel al mismo tiempo sin coordinarse entre sí. El resultado final en el papel dependerá de quién escribió más rápido o quién interfirió con el otro en un momento dado. De manera similar, sin una coordinación adecuada en el acceso a la variable "acumulador", los hilos pueden sobrescribir los cambios de los otros, causando resultados inconsistentes.


2)A) #include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#define NUMBER_OF_THREADS 2
#define CANTIDAD_INICIAL_HAMBURGUESAS 20
int cantidad_restante_hamburguesas = CANTIDAD_INICIAL_HAMBURGUESAS;
int turno = 0; // int turno = 0;
void *comer_hamburguesa(void *tid)
{
    while (1 == 1)
    {
        while (turno != (int)tid)
            ; // while(turno!=(int)tid);
        // INICIO DE LA ZONA CRÍTICA
        if (cantidad_restante_hamburguesas > 0)
        {
            printf("Hola! soy el hilo(comensal) %d , me voy a comer una hamburguesa ! ya que todavia queda/n %d \n", (int)tid, cantidad_restante_hamburguesas);
            cantidad_restante_hamburguesas--; // me como una hamburguesa
        }
        else
        {
            printf("SE TERMINARON LAS HAMBURGUESAS :( \n");
            turno = (turno + 1) % NUMBER_OF_THREADS; // turno = (turno + 1)% NUMBER_OF_THREADS;
            pthread_exit(NULL);                      // forzar terminacion del hilo
        }
        // SALIDA DE LA ZONA CRÍTICA
        turno = (turno + 1) % NUMBER_OF_THREADS; // turno = (turno + 1)% NUMBER_OF_THREADS;
    }
}

int main(int argc, char *argv[])
{
    pthread_t threads[NUMBER_OF_THREADS];
    int status, i, ret;
    for (int i = 0; i < NUMBER_OF_THREADS; i++)
    {
        printf("Hola!, soy el hilo principal. Estoy creando el hilo %d \n", i);
        status = pthread_create(&threads[i], NULL, comer_hamburguesa, (void *)i);
        if (status != 0)
        {
            printf("Algo salio mal, al crear el hilo recibi el codigo de error %d \n", status);
            exit(-1);
        }
    }

    for (i = 0; i < NUMBER_OF_THREADS; i++)
    {
        void *retval;
        ret = pthread_join(threads[i], &retval); // espero por la terminacion de los hilos que cree
    }
    pthread_exit(NULL); // como los hilos que cree ya terminaron de ejecutarse, termino yo tambien.
}

// while(turno!=(int)tid);
// turno = (turno + 1)% NUMBER_OF_THREADS;
// int turno = 0;
// turno = (turno + 1)% NUMBER_OF_THREADS;