import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/firebase_options.dart';
import 'package:weatherapp/view_models/phoneauth_view_model.dart';
import 'package:weatherapp/view_models/weather_view_model.dart';
import 'package:weatherapp/views/home_view.dart';
import 'package:weatherapp/views/otp_view.dart';
import 'package:weatherapp/views/phoneauth_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => WeatherViewModel()),
      ChangeNotifierProvider(
        create: (_) => PhoneauthViewModel(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PhoneauthView(),
      routes: {
        '/otp': (context) => const OtpView(),
        '/home': (context) => HomeView(),
      },
    );
  }
}
