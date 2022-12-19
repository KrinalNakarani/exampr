
import 'package:exampr/Screen/View/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    routes: {
      '/':(context)=>HomeScreen()
    },
  ));
}