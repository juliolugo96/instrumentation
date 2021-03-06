# Instrumentación 1

## Tabla de contenidos

- [Visión general](#visión-general)
- [Recomendaciones para tener buenas notas](#recomendaciones-para-tener-buenas-notas)
- [Bibliografía recomendada](#bibliografía-recomendada)
- [Contenido del repositorio](#contenido-del-repositorio)
- [Formato de correo](#formato-de-correo)

## Visión general

Todo ingeniero de Sistemas necesita tener interacción con la electrónica y las herramientas que esta ofrece. De manera que este curso está enfocado en estudiar y fortalecer los conceptos básicos de circuitos estudiados en cursos anteriores como Laboratorio de Física General y Física 21. También se estudiarán conceptos de la teoría clásica de Control para entender el funcionamiento y el comportamiento de los circuitos que poseen elementos almacenadores de energía como inductores y capacitores.

## Recomendaciones para tener buenas notas

- **¡Estudia la teoría de circuitos hasta el más mínimo detalle!** No hay otra opción, debes hacerlo si quieres tener esperanzas de aprobar.
- Realiza ejercicios complejos donde te sientas incómodo y seas obligado a enfrentar complejidad.
- Estudia **Teoría de Control** y aplicaciones de la **Transformada de Laplace**. Esto va a serte sumamente útil, pues muchos de los circuitos que verás en el curso pueden ser **resueltos facilmente** haciendo uso de una transformación al dominio de la frecuencia mediante la transformada de Laplace.
- Asiste a clases. El Profesor Miguel Peña es alguien que **valora enormemente** la asistencia y el esfuerzo de sus alumnos en el laboratorio durante el semestre.
- ¡Pregunta tus dudas, no te quedes con ellas!

## Bibliografía recomendada

Te recomiendo **fuertemente** que realices este curso en su totalidad:

https://www.youtube.com/watch?v=AfQxyVuLeCs&list=PLF64997E3C25882F1 (MIT 6.002)

El MIT es el centro de educación superior con mayor prestigio del mundo y el profesor **Anand Agarwal** uno de los ingenieros más reputables del mundo, CEO de **EdX** así que, aprovecha que tienes este curso en línea, **GRATUITO** para subir tu nivel teórico. No te conformes, busca siempre más, **¡haz el curso!**

Además, que estudies del libro *Foundations of AD Circuits* que es el usado en este curso. Como otra opción, te recomiendo el libro *Circuitos Eléctricos* de Dorf-Sbovoda.

## Contenido del repositorio

En este repositorio se encuentran, por prácticas, todos los scripts necesarios
para realizar modelos de simulación.

Cualquier error o novedad en los archivos, por favor notificar. Muchas gracias.

Para hacer uso correcto de los scripts, debe sustituir los datos correspondientes de sus prácticas y trabajar con ellos dentro de los códigos acá proveidos.

En los códigos de las prácticas 3 y 4, se pueden encontrar explícito en el código los valores que deben ser sustituidos por los obtenidos en sus modelos matemáticos, de manera que no les resulte complicado realizar luego las simulaciones.

Para realizar la carga de los datos, debes usar **MATLAB**, y debes cargar los
datos en las variables indicadas. Para hacer eso, se hace click en
**'Import data'**, se selecciona el archivo correspondiente, y se seleccionan
las dos columnas más a la derecha, se les asigna un alias y se cargan en el
espacio de trabajo. La columna más a la derecha son los valores de la curva,
mientras la inmediata a la izquierda de esta son los valores de tiempo de la
medida. 

Para el código de la práctica 3 que se encuentra en este repositorio, encontrarán estas variables a las cuales deben cargarle los datos:
  
  currentTime
  currentInductor
  
  voltageTime
  voltageInductor

Las variables que poseen el sufijo *time* representan los valores de tiempo emitidos por el osciloscopio para cada una de las mediciones tomadas. En el caso de VoltageTime, representa las medidas de tiempo emitidas por el osciloscopio mientras realizaba la medición del voltaje del inductor.
  
Pueden cambiarle el nombre al que deseen, pero debe coincidir con el alias que le asignen cuando realicen la importación usando **'Import data'**.
  
Para el código de la práctica 4:

  oscTime**XY**  --> Representa los valores de tiempo del osciloscopio
  osc**XY**      --> Representa los valores de la curva del osciloscopio

'X' puede tener dos valores: **Ind** o **Cap**
'Y' puede tener dos valores: **Voltage** o **Current**

Ejemplo: **oscTimeIndCurrent**

## Los datos del CSV no cargan correctamente (Creditos a Luis Lezama)

Al momento de exportar los datos del CSV, es posible que los mismos no se muestren correctamente en Excel, de manera que para dar un formato adecuado deben seguir los siguientes pasos:

- Abrir una nueva hoja de calculo.
- Hacer click en la pestana de datos.
- Presionar Importar desde texto (From Text).
- Buscar el archivo CSV correspondiente e importarlo.
- Al abrirse el asistente de Excel, elegir como delimitador la **coma** (Comma), y finalizar.
- Presionar **Ok**.


## Formato de correo

Cuando tu práctica sea validada por el Profesor, debes enviar un correo a *miguel9019@gmail.com* con el siguiente formato:

**ASUNTO:**  *Práctica #n. Instrumentación 1*

**MENSAJE:** 

*Apellido1, Nombre1 C.I.: V-012345678 (Sección x)*

*Apellido2, Nombre2 C.I.: V-012345678 (Sección x)*
