import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:news_app_flutter_api/controller/provider/theme_provider.dart';
import 'package:news_app_flutter_api/views/screens/home_page.dart';
import 'package:news_app_flutter_api/views/screens/splash_screen.dart';
import 'package:news_app_flutter_api/views/screens/view_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(
            useMaterial3: true,
          ),
          darkTheme: ThemeData.dark(
            useMaterial3: true,
          ),
          themeMode: Provider.of<ThemeProvider>(context).themeModal.isDark
              ? ThemeMode.dark
              : ThemeMode.light,
          initialRoute: 'splashScreen',
          routes: {
            '/': (context) => HomePage(),
            'viewPage': (context) => ViewPage(),
            'splashScreen': (context) => SplashScreen(),
          },
        );
      },
    );
  }
}
