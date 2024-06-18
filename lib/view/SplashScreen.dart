import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Utils/SharedPref.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool isLogin = false;
  var prefs=SharedPref();

  @override
  void initState() {
    getLogindata();
    super.initState();
  }

  getLogindata()async{
    var data= await prefs.read("loginData");
    print('----------data   $data');
    await Future.delayed(const Duration(seconds: 2));
    if(data == null) {
      setState(() {
      isLogin = false;
      Navigator.of(context).pushReplacementNamed('/loginScreen');
      });
    }
    else{
      isLogin = true;
      Navigator.of(context).pushReplacementNamed('/usePinScreen');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/RKChitsBannerImage.jpg',
                  height: 250.0,
                ),
              ),
               Positioned(
                  bottom: 200,
                  child: SpinKitPulse(color: Theme.of(context).primaryColor)) ,
            ],
          ),
        ));
  }
}

