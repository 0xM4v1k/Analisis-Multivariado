library(nnet)

### Cargar dataset diabetes

# Escalar los datos/normalizar (solo predictores)
diabetes$Pregnancies = scale(diabetes$Pregnancies)
diabetes$Glucose = scale(diabetes$Glucose)
diabetes$BloodPressure = scale(diabetes$BloodPressure)
diabetes$SkinThickness = scale(diabetes$SkinThickness)
diabetes$Insulin = scale(diabetes$Insulin)
diabetes$BMI = scale(diabetes$BMI)
diabetes$DiabetesPedigreeFunction = scale(diabetes$DiabetesPedigreeFunction)
diabetes$Age = scale(diabetes$Age)

# Creamos el modelo
modelo = nnet(Outcome ~ Pregnancies + Glucose + BloodPressure + SkinThickness + Insulin + BMI + DiabetesPedigreeFunction + Age, 
              data = diabetes, size = 9, maxit = 500, decay = 0.01, linout = FALSE) 

# Mostrar modelo
print(modelo)

# Hacer predicciones
predicciones = predict(modelo, diabetes, type = "raw")
print(predicciones)

# Convertir probabilidades a clasificaciones
clasificaciones = ifelse(predicciones > 0.5, 1, 0)

# Contar manualmente cada categoría
verdaderos_negativos = sum(clasificaciones == 0 & diabetes$Outcome == 0)
verdaderos_positivos = sum(clasificaciones == 1 & diabetes$Outcome == 1)
falsos_positivos = sum(clasificaciones == 1 & diabetes$Outcome == 0)
falsos_negativos = sum(clasificaciones == 0 & diabetes$Outcome == 1)


# Crear matriz de resultados con data.frame
matriz_resultados = data.frame(
  Prediccion = c("Predijo = 0", "Predijo = 1"),
  Real_0 = c(verdaderos_negativos, falsos_positivos),
  Real_1 = c(falsos_negativos, verdaderos_positivos)
)

print(matriz_resultados)


# Prediccion   | Real_0 |  Real_1
# ------------------------------
# Predijo = 0  |  465  |   40
# Predijo = 1  |  35   |  228

# Interpretación:
# 465 verdaderos negativos: Predijo "No Diabetes" (0) y realmente era "No Diabetes" (0)  
# 228 verdaderos positivos: Predijo "Diabetes" (1) y realmente era "Diabetes" (1) 
# 35 falsos negativos: Predijo "No Diabetes" (0) pero realmente era "Diabetes" (1)
# 40 falsos positivos: Predijo "Diabetes" (1) pero realmente era "No Diabetes" (0)