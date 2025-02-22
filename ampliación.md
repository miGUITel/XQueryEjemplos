## No entra en el examen de recuperación

### **Agrupar alumnos por curso y calcular estadísticas**  

En este ejemplo reorganizamos los datos creando un nuevo elemento que agrupa los alumnos teniendo en cuenta los valores de un elemento de cada alumno, en este caso curo. 

#### **Objetivo:**  
Crear un **XML estructurado** en el que los alumnos se agrupen por curso, y dentro de cada curso se incluyan estadísticas de notas (mínima, máxima y promedio).  

#### **Ejemplo de salida esperada:**  
```xml
<alumnos_por_curso>
    <curso nombre="1º DAM">
        <estadisticas>
            <nota_minima>6.8</nota_minima>
            <nota_maxima>8.5</nota_maxima>
            <nota_promedio>7.7</nota_promedio>
        </estadisticas>
        <alumnos>
            <alumno>María</alumno>
            <alumno>Carlos</alumno>
            <alumno>Lucía</alumno>
            <alumno>Pablo</alumno>
        </alumnos>
    </curso>
    <curso nombre="2º DAM">
        <estadisticas>
            <nota_minima>5.8</nota_minima>
            <nota_maxima>9.7</nota_maxima>
            <nota_promedio>8.2</nota_promedio>
        </estadisticas>
        <alumnos>
            <alumno>Laura</alumno>
            <alumno>Javier</alumno>
            <alumno>Sergio</alumno>
        </alumnos>
    </curso>
    <curso nombre="3º DAM">
        <estadisticas>
            <nota_minima>5.3</nota_minima>
            <nota_maxima>7.9</nota_maxima>
            <nota_promedio>6.53</nota_promedio>
        </estadisticas>
        <alumnos>
            <alumno>Ana</alumno>
            <alumno>Diego</alumno>
            <alumno>Elena</alumno>
        </alumnos>
    </curso>
</alumnos_por_curso>
```

---

### **Consulta XQuery para resolverlo:**
```xquery
<alumnos_por_curso>
  {
    for $c in distinct-values(/alumnos/alumno/curso)
    let $alumnos := /alumnos/alumno[curso = $c]
    let $notas := $alumnos/nota
    return 
      <curso nombre="{$c}">
        <estadisticas>
            <nota_minima>{min($notas)}</nota_minima>
            <nota_maxima>{max($notas)}</nota_maxima>
            <nota_promedio>{round(avg($notas),2)}</nota_promedio>
        </estadisticas>
        <alumnos>
          {
            for $alu in $alumnos
            return <alumno>{$alu/nombre}</alumno>
          }
        </alumnos>
      </curso>
  }
</alumnos_por_curso>
```

---

### 🔍 **Explicación de la consulta:**
1. **`distinct-values(/alumnos/alumno/curso)`**  
   - Obtiene los cursos únicos (1º DAM, 2º DAM, etc.).
   
2. **Filtra los alumnos de cada curso** con:  
   ```xquery
   let $alumnos := /alumnos/alumno[curso = $c]
   let $notas := $alumnos/nota
   ```
   - `$alumnos`: contiene los alumnos del curso actual.  
   - `$notas`: obtiene todas las notas de ese curso.  

3. **Calcula las estadísticas de notas:**
   ```xquery
   <estadisticas>
       <nota_minima>{min($notas)}</nota_minima>
       <nota_maxima>{max($notas)}</nota_maxima>
       <nota_promedio>{round(avg($notas),2)}</nota_promedio>
   </estadisticas>
   ```
   - `min($notas)`: Encuentra la nota más baja.  
   - `max($notas)`: Encuentra la nota más alta.  
   - `avg($notas)`: Calcula el promedio.  
   - `round(...,2)`: Redondea a dos decimales.  

4. **Lista los alumnos del curso en `<alumnos>`**  
   ```xquery
   <alumnos>
     {
       for $alu in $alumnos
       return <alumno>{$alu/nombre}</alumno>
     }
   </alumnos>
   ```
   - Itera sobre `$alumnos` y genera `<alumno>` con su nombre.  

---


### **Variación del ejercicio:**  
Modifica la consulta para incluir **solo los alumnos con beca** dentro de cada curso.  

🔹 **Modificación:**  
```xquery
<alumnos_becados>
  {
    for $c in distinct-values(/alumnos/alumno/curso)
    let $alumnos := /alumnos/alumno[curso = $c and beca = "Sí"]
    return 
      <curso nombre="{$c}">
        <alumnos>
          {
            for $alu in $alumnos
            return <alumno>{$alu/nombre}</alumno>
          }
        </alumnos>
      </curso>
  }
</alumnos_becados>
```
