class Conductor {
 String licencia ='';
 String foto ='';
 String nombre ='';
 String apellido ='';
 late DateTime nacimiento;
 String direccion ='';
 late int telefono;

 Conductor(
    {
      required this.licencia,
      required this.foto,
      required this.nombre,
      required this.apellido,
      required this.nacimiento,
      required this.direccion,
      required this.telefono
    }
  );
}