datosBCCR_Cuadrados_a_Series <- function(diretorioDatos = "C:/%HOMEPATH%/Downloads"){
  #@Author                Liang-Yun Hsueh<lhsueh8@gmail.com>
  #@Version               1.0.0
  #@date                  20220526
  #@remarks               My favorite function
  #@Since                 1.0
  #@param                 directorio: directorio donde guardar los archivos xls guardados
  #@return                guardar serie en formatos csv.
  #@throws                Non
  #@See  
  
  
  
  # Insumo: directorio: directorio donde guardar los archivos xls guardados
  # Retornar: guardar serie en formatos csv.
  
  
  # Cargar los paquetes necesarios
  suppressWarnings(suppressMessages(library(readxl)))
  suppressWarnings(suppressMessages(library(stringr)))
  suppressWarnings(suppressMessages(library(lubridate)))
  suppressWarnings(suppressMessages(library(dplyr)))
  suppressWarnings(suppressMessages(library(tidyr)))
  
  # Directorio de los datos
  # diretorioDatos <- "D:/Users/Liang/Downloads"
  # nombreArchivo <- "frmVerCatCuadroNP2.xls"
  #diretorioArchivoDatos <- paste0(diretorioDatos, "/", nombreArchivo )
  
  # Respaldo de configuracion original 
  wd_orig <- getwd() # Directorio default de trabajo
  localeConfig_orig <- Sys.getlocale("LC_TIME") #de tiempo local
  
  # Configuracion necesarios
  setwd(diretorioDatos)
  Sys.setlocale("LC_TIME", "Spanish")
  
  
  listaArchivo <- list.files()
  listaArchivo <- listaArchivo[str_count(listaArchivo, ".*\\.xls$") == 1] # filtrar todos lod archovos xls
  
  
  for (nombreArchivo in listaArchivo){
    # Leer archivos
    print(listaArchivo)
    print(nombreArchivo)
    datos <- readxl::read_excel(nombreArchivo,
                                na = "",
                                sheet = 1,
                                skip = 4,
                                n_max = 371)
    
    datos <- gather(data=datos, key = "agno", value = "valores", 
                    2:(dim(datos)[2]) )
    
    colnames(datos)[1] <- "diaMes"
    
    # Cambiar Set por Sep para reconoce mejor el mes 9 en español
    datos$diaMes <- str_replace(datos$diaMes, "Set", "Sep")
    
    # crear la columna fecha y eliminar los insumos
    datos <- unite(datos, col="fecha", diaMes, agno, sep= ". ", remove = TRUE) # en Español, lleva un . después de abreviatura de mes, si no hay , no funciona
    
    datos$fecha <- dmy(datos$fecha)
    
    # Elimina los 29 de febrero de los años no bicietro
    datos <- datos[-c(which(is.na(datos$fecha ))),]
    
    
    # Limpiar los datos
    datos <- na.omit(datos) # Limpiar los nas
    datos <- datos[wday(datos$fecha, week_start=1)<6, ] # limpiar los fin de semanas
    datos <- datos[datos$valores != 0, ] # limpiar los valores == 0
    
    nombreArchivoSinExt <- str_replace(nombreArchivo, "\\.xls", "")
    
    write.table(datos, 
                file = paste0(diretorioDatos, "/", nombreArchivoSinExt,".csv" ),
                append = FALSE,
                quote = FALSE,
                na = "NA",
                sep = ",",
                dec = ".", 
                row.names = FALSE,
                col.names = c("Fecha", nombreArchivoSinExt ), 
                fileEncoding = "UTF-8")
    
    
    
  }# fin de for para cada archivo xls
  
  
  
  
  
  
  # Regreso a configuración original
  setwd(wd_orig)
  Sys.setlocale("LC_TIME", localeConfig_orig)
  
  print("Conversión de datos con éxito!")
} # fin de funcion de datosBCCR_Cuadrados_a_Series