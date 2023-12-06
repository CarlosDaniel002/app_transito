import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

// ignore: non_constant_identifier_names
String ConductorImagePath = ''; //Variable que almacena el Path de la imagen del conductor en Firebase

// ignore: non_constant_identifier_names
String EvidenciaImagePath = ''; //Variable que almacena el Path de la imagen de la evidencia en Firebase


//inicializador para Firebase
final FirebaseStorage storage =FirebaseStorage.instance;


//Funcion para subir imagen del conductor a Firebase Storage
Future<bool> uploadConductorImage(File image) async {

  final String namefile = image.path.split("/").last;

  final Reference ref = storage.ref().child("Conductor").child(namefile);
  final UploadTask uploadTask = ref.putFile(image);
  final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);
  final String url = await snapshot.ref.getDownloadURL();

  ConductorImagePath = url;
  if (snapshot.state == TaskState.success){
    return true;
  }else {
    return false;
  }
}

//Funcion para subir imagen de la evidencia a Firebase Storage
Future<bool> uploadEvidenciaImage(File image) async {

  final String namefile = image.path.split("/").last;
  
  final Reference ref = storage.ref().child("Evidencia").child(namefile);
  final UploadTask uploadTask = ref.putFile(image);
  final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);

  final String url = await snapshot.ref.getDownloadURL();
  EvidenciaImagePath = url;

  if (snapshot.state == TaskState.success){
    return true;
  }else {
    return false;
  }
}