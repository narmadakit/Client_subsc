import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../Utils/AppStyles.dart';
import '../Utils/AppWidgets.dart';
import '../Utils/SharedPref.dart';
import '../Utils/styles.dart';
import 'HomeScreen.dart';

class ResetPinScreen extends StatefulWidget {
  const ResetPinScreen({super.key});

  @override
  State<ResetPinScreen> createState() => _ResetPinScreenState();
}

class _ResetPinScreenState extends State<ResetPinScreen> {
  var shredPref=SharedPref();
  var pinController=TextEditingController();
  var confirmPinController=TextEditingController();
  final formKey = GlobalKey<FormState>();
  StreamController<ErrorAnimationType>? errorController;
  TextEditingController conPinController = TextEditingController();
  String currentText="";

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double gapHeight=size.height * 0.015;
    double boxHeight=size.height * 0.06;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal:  15.0),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              'assets/images/arrow-left.png',
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ),
        // title: const Text('Reset Pin', style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 1,
              child: Container()),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Image.asset('assets/images/logo.jpeg', height: size.height / 7,),
                      Text('RESET PIN', style: AppStyles.numTxtStyle.copyWith(fontSize: 28),),

                      // Image.asset('assets/images/RKChitsBannerImage.jpg', height: size.height / 10,),
                    ],
                  ),
                  SizedBox(height: gapHeight,),
                  SizedBox(height: gapHeight,),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 70
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PinCodeTextField(
                            autoFocus: true,
                            cursorWidth: 0.2,
                            appContext: context,
                            pastedTextStyle: TextStyle(
                              color: Colors.red.shade600,
                              fontWeight: FontWeight.bold,
                            ),
                            length: 4,
                            obscureText: true,
                            obscuringCharacter: '*',
                            // obscuringWidget: const FlutterLogo(
                            //   size: 24,
                            // ),
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
                            cursorColor: Colors.black,
                            animationDuration: const Duration(milliseconds: 300),
                            enableActiveFill: true,
                            errorAnimationController: errorController,
                            controller: pinController,
                            keyboardType: TextInputType.number,
                            textStyle: TextStyle(color: Colors.white),
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
                            // onTap: () {
                            //   print("Pressed");
                            // },
                            onChanged: (value) {
                              debugPrint(value);
                              setState(() {
                                currentText = value;
                                if(currentText.length == 4) {

                                }
                              });
                              // conditions for validating
                            },
                            beforeTextPaste: (text) {
                              debugPrint("Allowing to paste $text");
                              return true;
                            },
                          ),
                          Text('enter Pin', style: AppStyles.valueTextStyle.copyWith(color: Colors.grey,fontWeight: FontWeight.w500),),
                          SizedBox(height: gapHeight,),
                          SizedBox(height: gapHeight,),
                          SizedBox(height: gapHeight,),
                          PinCodeTextField(
                            autoFocus: true,
                            cursorWidth: 0.2,
                            appContext: context,
                            pastedTextStyle: TextStyle(
                              color: Colors.red.shade600,
                              fontWeight: FontWeight.bold,
                            ),
                            length: 4,
                            obscureText: true,
                            obscuringCharacter: '*',
                            // obscuringWidget: const FlutterLogo(
                            //   size: 24,
                            // ),
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
                            // errorAnimationController: errorController,
                            controller: confirmPinController,
                            keyboardType: TextInputType.number,
                            textStyle: TextStyle(color: Colors.white),
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
                            // onTap: () {
                            //   print("Pressed");
                            // },
                            onChanged: (value) {
                              debugPrint(value);
                              setState(() {
                                currentText = value;
                                if(currentText.length == 4) {

                                }
                              });
                              // conditions for validating
                            },
                            beforeTextPaste: (text) {
                              debugPrint("Allowing to paste $text");
                              return true;
                            },
                          ),
                          Text('enter confirm pin', style: AppStyles.valueTextStyle.copyWith(color: Colors.grey),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 28.0, top: 5,left: 12,right: 12),
            child: GestureDetector(
              onTap: () {
                if(pinController.text == confirmPinController.text){
                  shredPref.save("pin", confirmPinController.text);
                  AppWidgets.showSnackBar(context, 'Pin is confirmed',Colors.white12);
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>const HomeScreen()));
                }
                else{
                  AppWidgets.showSnackBar(context, 'Enter correct pin',Colors.red);
                }
              },
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.cyan, Colors.cyanAccent],
                  ),
                ),
                child: Center(
                  child: Text(
                    "Submit".toUpperCase(),
                    style: getLoginTextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
