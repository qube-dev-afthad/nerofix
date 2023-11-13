import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:nerofix/bindings/onboarding_bindings.dart';
import 'package:nerofix/routes/app_routes.dart';
import 'package:path_provider/path_provider.dart';

import 'constants/app_themes.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initDeepLinks();
  //Set Orientation
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  var appDocDir = await getApplicationDocumentsDirectory();
  cameras = await availableCameras(); // Camera

  // Hive
  Hive.init('${appDocDir.path}/db');
  await Hive.openBox('prefs');

  runApp(const MyApp());

  //Easy Localization
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return GetMaterialApp(
      theme: AppThemes.appTheme,
      debugShowCheckedModeBanner: false,
      getPages: getPages,
  
      themeMode: ThemeMode.light,    
      initialRoute: intialRoutes,
      initialBinding: OnboardingBindings(),
  
    );
  }
}
List<CameraDescription> cameras = <CameraDescription>[];