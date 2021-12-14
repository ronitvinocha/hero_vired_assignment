import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_vired/bl/blocs/authblock.dart';
import 'package:hero_vired/bl/blocs/homepagebloc.dart';
import 'package:hero_vired/bl/network/apiclient.dart';
import 'package:hero_vired/ui/pages/homepage.dart';
import 'package:hero_vired/ui/pages/loginpage.dart';
import 'package:hero_vired/ui/widgets/loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Color.fromRGBO(248, 248, 248, 1),
        statusBarIconBrightness: Brightness.dark));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: const Color.fromRGBO(53, 117, 165, 1),
          backgroundColor: const Color.fromRGBO(248, 248, 248, 1),
          hintColor: const Color.fromRGBO(228, 228, 228, 1),
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontFamily: "Manrope",
              fontWeight: FontWeight.w800,
              fontSize: 25,
            ),
            headline2: TextStyle(
              fontFamily: "Manrope",
              fontWeight: FontWeight.w700,
              fontSize: 22,
            ),
            headline3: TextStyle(
              fontFamily: "Manrope",
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
            bodyText1: TextStyle(
              fontFamily: "Manrope",
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          )),
      home: FutureBuilder(
          future: SharedPreferences.getInstance(),
          builder: (ctx, snap) {
            if (snap.hasData) {
              SharedPreferences pref = snap.data as SharedPreferences;
              var userToken = pref.getString("userToken");
              if (userToken != null) {
                return BlocProvider(
                    create: (_) => HomePageBloc(apiClient: ApiClient()),
                    child: const HomePage());
              } else {
                return BlocProvider(
                  create: (_) => AuthBloc(apiClient: ApiClient()),
                  child: const LoginPage(),
                );
              }
            } else {
              return Loader();
            }
          }),
    );
  }
}
