import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/core/helpers/app_keys.dart';
import 'app/core/languages/app_translation.dart';
import 'app/core/theme/app_theme.dart';
import 'app/core/theme/theme_service.dart';
import 'app/routes/app_pages.dart';

late SharedPreferences preferences;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //systemNavigationBarTheme
  Get.isDarkMode
      ? SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Colors.black,
          ),
        )
      : SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Colors.black,
          ),
        );
  await GetStorage.init();
  preferences = await SharedPreferences.getInstance();
  runApp(
    GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      theme: AppTheme().lightTheme,
      darkTheme: AppTheme().darkTheme,
      //themeMode: ThemeMode.system,
      themeMode: ThemeService().theme,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      translationsKeys: AppTranslation.translationsKeys,
      locale: Locale(preferences.getString(AppKeys.languageCode) ?? 'en'),
      fallbackLocale:
          Locale(preferences.getString(AppKeys.languageCode) ?? 'en'),
      popGesture: true,
    ),
  );
}
