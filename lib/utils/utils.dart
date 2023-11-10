import 'package:flutter/material.dart';

enum NavigationType { replace, push }

enum AuthStatus { authenticated, unauthenticated }

navigate(BuildContext context, {required Widget screen, NavigationType type = NavigationType.push}) {
  if(type == NavigationType.replace){
   Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => screen));
  }else {
     Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => screen));
  }
}


SizedBox verticalSpacer(double size){
  return SizedBox(height: size);
}

SizedBox horizontalSpacer(double size){
  return SizedBox(width: size);
}