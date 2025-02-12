import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class CustomCheckBoxTheme{
  CustomCheckBoxTheme._();

//Light CheckBox Theme -----------------------------

static CheckboxThemeData lightCheckBoxTheme = CheckboxThemeData(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  checkColor: WidgetStateProperty.resolveWith((states) {
    if(states.contains(WidgetState.selected)){
      return Colors.white;
    }else{
      return Colors.black;
    }
  }),
  fillColor: WidgetStateProperty.resolveWith((states) {
    if(states.contains(WidgetState.selected)){
      return AppColors.primary;
    }else{
      return Colors.transparent;
    }
  })
);


//Dark CheckBox Theme -----------------------------

  static CheckboxThemeData darkCheckBoxTheme = CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      checkColor: WidgetStateProperty.resolveWith((states) {
        if(states.contains(WidgetState.selected)){
          return Colors.white;
        }else{
          return Colors.black;
        }
      }),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if(states.contains(WidgetState.selected)){
          return AppColors.primary;
        }else{
          return Colors.transparent;
        }
      })
  );

}