import 'package:beauty_zone/presentation/pages/initial_splash_screen.dart';
import 'package:beauty_zone/presentation/pages/otp_screen.dart';
import 'package:beauty_zone/screen/account/component/LoginPage.dart';
import 'package:beauty_zone/screen/account/component/SignUpPage.dart';
import 'package:beauty_zone/screen/home/component/HairStyleDetail.dart';
import 'package:beauty_zone/screen/home/component/HomePage.dart';
import 'package:beauty_zone/screen/home/component/OtherHome.dart';
import 'package:beauty_zone/screen/home/component/bookings.dart';
import 'package:beauty_zone/screen/home/component/favorites.dart';
import 'package:beauty_zone/screen/home/component/payment_screen.dart';
import 'package:beauty_zone/screen/profil/component/OrdersHairSreen.dart';
import 'package:beauty_zone/screen/profil/component/ProfilPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR', null);
  runApp(MyApp());
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
      initialRoute: '/',
      routes: {

        '/': (context) => const InitialSplashScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/login': (context) => const LoginScreen(),
        '/otp': (context) => const OtpVerificationScreen(),
        '/home': (context) => const BeautyHomePage(),
        '/hairStyle': (context) => const HairStyleDetailScreen(item: {},),
        '/payment': (context) => const PaymentScreen(item: {},),
        '/profil': (context) => const ProfileScreen(),
        '/favorites': (context) => const FavoritePage(),
        '/bookings': (context) => const BookingPage(),
        '/orderList': (context) => const OrderListScreen(),
      },
    );
  }
} 
