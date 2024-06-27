
import  "package:flutter/material.dart";
import "package:notiday_1/main.dart";
import "package:notiday_1/screens/inicio.dart";


mostrarSnackBar({
required BuildContext context,
required String texto,
bool isErro = false
}){
  SnackBar snackBar = SnackBar(content: Text(texto),
  backgroundColor:( isErro) ? Colors.red : Colors.green,
  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top:Radius.circular(20),),),
  duration: const Duration(seconds: 4),);
 
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  Future.delayed(const Duration(seconds: 4), () {
   
    Navigator.pop(context);
  });
}
mostrarSnackBarLogin({
required BuildContext context,
required String texto,
bool isErro = false
}){
  SnackBar snackBar = SnackBar(content: Text(texto),
  backgroundColor: (!isErro) ? Colors.red : Colors.green,
  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top:Radius.circular(20),),),
  duration: const Duration(seconds: 4),);
 
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  
}
mostrarSnackBarRegistrar({
required BuildContext context,
required String texto,
bool isErro = false
}){
  SnackBar snackBar = SnackBar(content: Text(texto),
  backgroundColor:( isErro) ? Colors.red : Colors.green,
  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top:Radius.circular(20),),),
  duration: const Duration(seconds: 4),);
 
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  Future.delayed(const Duration(seconds: 4), () {
   
      Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => RoteadorTela(),
                          ),
                        );
  });
}