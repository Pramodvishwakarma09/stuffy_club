import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stuffy_club/screen/getstart_screens/Splash_Screen.dart';
import 'dart:core';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GetMaterialApp(

      debugShowCheckedModeBanner: false,
      home: SplashScreen()),
 );
}



