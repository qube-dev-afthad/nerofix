import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

class AppThemes {
  static final ThemeData appTheme = ThemeData(
    primaryColor: AppColors.darkGray,
    scaffoldBackgroundColor:Colors.white,
    brightness: Brightness.light,
    fontFamily: 'DM Sans',
    appBarTheme: AppBarTheme(
      
      // backwardsCompatibility: false, // 1
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent),

      //
    ),

    textTheme: TextTheme(),
    scrollbarTheme: ScrollbarThemeData().copyWith(
      thumbColor: MaterialStateProperty.all(AppColors.lightBlue),
      
    ),
    
  );
 
}
