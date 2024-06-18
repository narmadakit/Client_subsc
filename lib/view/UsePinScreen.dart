import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:lottie/lottie.dart';

import '../Utils/AppStyles.dart';
import '../Utils/AppWidgets.dart';
import '../Utils/SharedPref.dart';

class UsePinScreen extends StatefulWidget {
  const UsePinScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UsePinScreen> createState() =>
      _UsePinScreenState();
}

class _UsePinScreenState extends State<UsePinScreen> {
  TextEditingController OTPController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;
  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  var sharedpref=SharedPref();
  var pin;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    getLoginData();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  getLoginData()async{
    pin  = await sharedpref.read("pin");
    print('pin --- ${pin}');
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double gapHeight=size.height * 0.025;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/resetPinScreen');
              },
              child: Row(
                children: [
                  const Text('Reset pin ',),
                  Image.asset(
                    'assets/images/reset-pin.png',
                    height: 22,
                    color: Colors.amber,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            child: Align(
                alignment: Alignment.topLeft,
                child:
                Lottie.asset("assets/lotties/spark.json",height:  size.height / 4)
              // Image.asset('assets/images/logo.jpeg', height:  size.height / 7 )),
            ),),
          SizedBox(height: gapHeight),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Enter Pin',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const SizedBox(height: 5),
                Text(
                  'enter your 4 digit pin',
                  style: AppStyles.headingTxtStyle1.copyWith(fontWeight: FontWeight.w400,fontSize: 15,),
                ),
                SizedBox(height: gapHeight),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 50
                    ),
                    child: PinCodeTextField(
                      autoFocus: true,
                      cursorWidth: 0.2,
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.red.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                      length: 4,
                      obscureText: true,
                      obscuringCharacter: '*',
                      blinkWhenObscuring: true,
                      autovalidateMode: AutovalidateMode.disabled,
                      animationType: AnimationType.fade,
                      validator: (v) {
                        if (v!.length < 4) {
                          return "enter otp";
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          activeBorderWidth: 0.9,
                          disabledBorderWidth: 0.9,
                          inactiveBorderWidth: 0.9,
                          borderWidth: 0.9,
                          selectedBorderWidth: 0.9,
                          borderRadius: BorderRadius.circular(2),
                          fieldHeight: 40,
                          fieldWidth: 40,
                          activeColor: Theme.of(context).iconTheme.color,
                          activeFillColor: Colors.black,
                          inactiveFillColor: Colors.transparent,
                          inactiveColor: Colors.grey,
                          selectedFillColor: Colors.transparent,
                          selectedColor: Colors.grey.shade500
                      ),
                      cursorColor: Colors.white,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: OTPController,
                      keyboardType: TextInputType.number,
                      textStyle: const TextStyle(color: Colors.white),
                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) {
                        debugPrint("Completed");
                      },
                      onChanged: (value) {
                        setState(() {
                          currentText = value;
                          if(currentText.length == 4) {
                            if (pin == OTPController.text) {
                              hasError = false;
                              Navigator.of(context).pushReplacementNamed('/homeScreen');
                            }
                            else {
                              AppWidgets.showSnackBar (context,"Error!! Wrong pin", Colors.red);
                            }
                          }
                        });
                        // conditions for validating
                      },
                      beforeTextPaste: (text) {
                        debugPrint("Allowing to paste $text");
                        return true;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}