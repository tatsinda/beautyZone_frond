import 'package:beauty_zone/presentation/pages/initial_splash_screen.dart';
import 'package:beauty_zone/screen/account/component/LoginPage.dart';
import 'package:beauty_zone/screen/account/component/SignUpPage.dart';
import 'package:beauty_zone/screen/home/component/HairStyleDetail.dart';
import 'package:beauty_zone/screen/home/component/HomePage.dart';
import 'package:beauty_zone/screen/home/component/OtherHome.dart';
import 'package:beauty_zone/screen/home/component/payment_screen.dart';
import 'package:beauty_zone/screen/profil/component/OrdersHairSreen.dart';
import 'package:beauty_zone/screen/profil/component/ProfilPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beauty Zone',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/payment',
      routes: {
        
        '/splash': (context) => const InitialSplashScreen(),
                '/payment': (context) => const PaymentScreen(),


        '/login': (context) => const LoginScreen(),

        '/signup': (context) => const SignUpScreen(),
        '/orderList': (context) => const OrderListScreen(),

        '/profil': (context) => const ProfileScreen(),
        '/home2': (context) => const BeautyHomePage(),
        //'/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/hairStyle': (context) => const HairStyleDetailScreen(),
      },
    );
  }
} 
/*
void main() {
  runApp(const BeautyZoneApp());
}

class BeautyZoneApp extends StatelessWidget {
  const BeautyZoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const HairStyleDetailScreen(),
    );
  }
}*/