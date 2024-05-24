# datosBCCR_Cuadrados_a_Series
Convertir datos de Banco Central de Costa Rica (BCCR) de forma cuadrado a Serie de Tiempo, por ejemplo: Prime Rate de EE.UU., la Tasa Básica Pasiva (TBP) y la Tasa Política Monetaria (TPM).


## 1.1 Contexto
Los datos de Banco Central de Costa Rica(BCCR), especialmente varios datos de tasa está organizado en forma cuadrado, es decir, hay una columna que indica la combinacion de dia y mes y los columnas en años, lo cual dificualta los análisis de datos en forma de serie de tiempo. Un ejemplo de data se ilustra en siguiente:

![](D:/Users/Liang/Documents/DevelopeCenter/MyCode_R/datosBCCR_Cuadrados_a_Series/EjemploProblema.png)

Para solucionar este problema se propone convertir esta forma cuadrado en un serie de tiempo y guardarlos en formato `.csv` para facilitar la importación de datos en futuro.

### 1.1.1 Preparativo previo:
Hay que bajar los datos desde la página de Banco central de Costa Rica y abrilo en MS Excel y habilitar la edición, luego guardarlo en un archivo nuevo con formato `.xls`.

![](D:/Users/Liang/Documents/DevelopeCenter/MyCode_R/datosBCCR_Cuadrados_a_Series/habilitarEdicion.png)

### 1.1.2 Paquetes necesartios de R:
* `readxl`
* `stringr`
* `lubridate`
* `dplyr`
* `tidyr`

# 2 Prueba
Los datos de Prime Rate, Tasa Básica Pasiva y Tasa Política Monetaria
```{r}
prueba <- "C:/Users/Public/Downloads"
datosBCCR_Cuadrados_a_Seriess(prueba)
```

Los archivos `.xls` son archivos originales, y los archivos `.csv` son resultados generados.
![](D:/Users/Liang/Documents/DevelopeCenter/MyCode_R/datosBCCR_Cuadrados_a_Series/Prueba3.png)

