<becadosNota8>
{
(for $alu in /alumnos/alumno
where $alu/beca = "Sí"
return $alu/nombre)
intersect
(for $alu in /alumnos/alumno
where $alu/nota > 8
return $alu/nombre)
}
</becadosNota8>