## FUNCIÓN % aciertos sobre el total
tot_prct <- function(aciertos){
  tot_prct <- 100 * (nrow(aciertos) / N_TOTAL_ESTACIONES)
  return(round(tot_prct, digits = 2))
}

## FUNCIÓN % de aciertos por líneas
line_prct <- function(aciertos){
  prct_aciertos <- c()
  n_aciertos <- c()
  
  N_ESTACIONES_POR_LINEA <- c(40, 33, 27, 33, 18, 21, 16, 4, 23, 8)
  N_LINEAS <- 10
  
  for (i in 1:N_LINEAS){
    aciertos_lineas <- unlist(strsplit(as.character(aciertos$lineas), split = ","))
    
    num <- sum(as.numeric(aciertos_lineas) == i)
    n_aciertos <- append(n_aciertos, num)
    prct <- 100 * (num / N_ESTACIONES_POR_LINEA[i])
    prct_aciertos <- append(prct_aciertos, round(prct, digits = 2))
  }
  
  line_prct <- data.frame(linea = 1:N_LINEAS, n_aciertos, prct_aciertos, N_ESTACIONES_POR_LINEA)
  return(line_prct) 
}

# ### Ejemplo
# N_TOTAL_ESTACIONES <- 147
# 
# id_aciertos <- data.frame(id = c(13, 18, 47, 59))
# aciertos <- id_aciertos %>%
#   left_join(estaciones, by = "id")
# 
# # Obtenemos los resultados
# p_t <- tot_prct(aciertos)
# p_l <- line_prct(aciertos)
# 
# # Imprimimos el resultado
# cat("Porcentaje respuestas sobre el total",p_t,"%","\n")
# 
# p_l

