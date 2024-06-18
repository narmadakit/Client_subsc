import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:client_subscriber/bloc/BidOffer/BidOfferBloc.dart';
import 'package:client_subscriber/repo/BidRepo.dart';
import 'package:client_subscriber/view/HomeScreen.dart';
import 'package:client_subscriber/view/LoginScreen.dart';
import 'package:client_subscriber/view/OTPScreen.dart';
import 'package:client_subscriber/view/ResetPinScreen.dart';
import 'package:client_subscriber/view/SplashScreen.dart';
import 'package:client_subscriber/view/UsePinScreen.dart';
import 'package:client_subscriber/bloc/AllChit/AllChitsBloc.dart';
import 'package:client_subscriber/bloc/Auction/AuctionBloc.dart';
import 'package:client_subscriber/bloc/ChitDetails/ChitDetailsBloc.dart';
import 'package:client_subscriber/bloc/Login/LoginBloc.dart';
import 'package:client_subscriber/repo/AuctionRepo.dart';
import 'package:client_subscriber/repo/ChitsRepo.dart';
import 'package:client_subscriber/repo/LoginRepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Utils/AppStyles.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return
      MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(create: (context)=>LoginBloc(LoginRepo())),
          BlocProvider<AllChitsBloc>(create: (context)=>AllChitsBloc(ChitsRepo())),
          BlocProvider<ChitDetailsBloc>(create: (context)=>ChitDetailsBloc(ChitsRepo())),
          BlocProvider<AuctionBloc>(create: (context)=>AuctionBloc(AuctionRepo())),
          BlocProvider<BidOfferBloc>(create: (context)=>BidOfferBloc(BidRepo())),
        ],
        child: MaterialApp(
          title: 'Client Subscriber',
          debugShowCheckedModeBanner: false,
          theme: MyAppThemes.lightTheme,
          darkTheme: MyAppThemes.darkTheme,
          themeMode: ThemeMode.system,
          home: const SplashScreen(),
          routes: {
            '/loginScreen':(context) => const LoginScreen(),
            '/otpScreen':(context) => const OTPScreen(),
            '/homeScreen':(context) => const HomeScreen(),
            '/resetPinScreen':(context) => const ResetPinScreen(),
            '/usePinScreen':(context) => const UsePinScreen(),
          },
        ),
      );
  }
}

class MyAppThemes {
  static final lightTheme = ThemeData(
    primaryColor: Colors.lightBlue,
    brightness: Brightness.light,
    scaffoldBackgroundColor:  Colors.blueGrey.shade50,
      indicatorColor: Colors.black,
      splashColor: Colors.white,
      dividerColor: Colors.grey.shade400,
      appBarTheme: AppBarTheme(
          toolbarHeight: 70,
          backgroundColor: Colors.blueGrey.shade50,
          actionsIconTheme: IconThemeData(color: Colors.black),
          iconTheme: IconThemeData(color: Colors.black)
      )

  );

  static final darkTheme = ThemeData(
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppStyles.bgColor,
      splashColor: Colors.black45,
      dividerColor: Colors.grey.shade800,
      indicatorColor: Colors.white,
      appBarTheme: AppBarTheme(
          backgroundColor: AppStyles.bgColor,
          actionsIconTheme: const IconThemeData(color: Colors.white),
          iconTheme: const IconThemeData(color: Colors.white)
      )

  );
}
