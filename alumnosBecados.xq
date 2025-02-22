<alumnos>
<becados>{
for $alu in /alumnos/alumno
where $alu/beca ="Sí"
return
<alumno>
<nombre>{$alu/nombre/text()}</nombre>
<nota_8>{$alu/nota/text()}</nota_8>
<becado>{$alu/beca/text()}</becado>
</alumno>
}</becados>
<NObecados>{
for $alu in /alumnos/alumno
where $alu/beca ="Sí"
return
<alumno>
<nombre>{$alu/nombre/text()}</nombre>
<nota_8>{$alu/nota/text()}</nota_8>
<becado>{$alu/beca/text()}</becado>
</alumno>
}</NObecados>
</alumnos>