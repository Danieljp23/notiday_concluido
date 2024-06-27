import 'package:flutter/material.dart';

InputDecoration getDecorationInput(String label, {Icon? icon} ) {
  return InputDecoration(
    icon: icon,
    label: Text(label),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.blue)),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: Color.fromARGB(255, 243, 166, 0), width: 2),
    ),
    
  );
}
