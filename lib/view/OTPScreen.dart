import 'dart:async';

import 'package:client_subscriber/Utils/SharedPref.dart';
import 'package:client_subscriber/bloc/Login/LoginBloc.dart';
import 'package:client_subscriber/bloc/Login/LoginState.dart';
import 'package:client_subscriber/model/LoginResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../bloc/Login/LoginEvent.dart';
import '../utils/AppWidgets.dart';
import '../utils/styles.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OTPScreen> createState() =>
      _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController OTPController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;
  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  var sharedpref=SharedPref();
  LoginResponse loginData=LoginResponse();

  @override
  void initState() {
    getLoginData();
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  Future<LoginResponse> getLoginData()async{
    loginData= LoginResponse.fromJson(await sharedpref.read("loginData"));
    print('loginData --- ${loginData.pmobileno}');
    setState(() {
      AppWidgets.gMobileNo =loginData.pmobileno;
    });
    return loginData;
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
    // var loginBloc= BlocProvider.of<LoginBloc>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    double gapHeight=size.height * 0.025;
    double boxHeight=size.height * 0.06;
    // var verifyBloc = BlocProvider.of<LoginBloc>(context, listen: false);
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
        ),
        body:
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: boxHeight,),
                      SizedBox(height: boxHeight,),
                      // SizedBox(
                      //   // height: MediaQuery.of(context).size.height / 5,
                      //   child: Align(
                      //       alignment: Alignment.topLeft,
                      //       child: Image.asset('assets/images/logo.jpeg', height:  size.height / 5.5 )),
                      // ),
                      const SizedBox(height: 15),
                      const Text(
                        'Phone number \nverification',
                        style: TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      SizedBox(height: gapHeight),
                      RichText(
                        text: TextSpan(
                          text: "Enter the code sent to ",
                          children: [
                            TextSpan(
                              text: "${AppWidgets.gMobileNo}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0
                          ),
                          child: PinCodeTextField(
                            cursorWidth: 0.2,
                            appContext: context,
                            pastedTextStyle: TextStyle(
                              color: Colors.red.shade600,
                              fontWeight: FontWeight.bold,
                            ),
                            length: 6,
                            obscureText: true,
                            obscuringCharacter: '*',
                            // obscuringWidget: const FlutterLogo(
                            //   size: 24,
                            // ),
                            blinkWhenObscuring: true,
                            autovalidateMode: AutovalidateMode.disabled,
                            animationType: AnimationType.fade,
                            validator: (v) {
                              if (v!.length < 5) {
                                return "enter otp";
                              } else {
                                return null;
                              }
                            },
                            pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(10),
                                fieldHeight: 48,
                                fieldWidth: 45,
                                activeBorderWidth: 0.9,
                                disabledBorderWidth: 0.9,
                                inactiveBorderWidth: 0.9,
                                borderWidth: 0.9,
                                selectedBorderWidth: 0.9,
                                // activeColor: Colors.white60,
                                activeFillColor: Colors.transparent,
                                inactiveFillColor: Colors.transparent,
                                inactiveColor: Colors.grey,
                                selectedFillColor: Colors.transparent,
                                selectedColor: Colors.grey.shade500
                            ),
                            cursorColor: Colors.black,
                            animationDuration: const Duration(
                                milliseconds: 300),
                            enableActiveFill: true,
                            errorAnimationController: errorController,
                            controller: OTPController,
                            keyboardType: TextInputType.number,
                            // textStyle: TextStyle(color: Colors.white),
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
                              });
                            },
                            beforeTextPaste: (text) {
                              debugPrint("Allowing to paste $text");
                              return true;
                            },
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text(
                            "Didn't receive the code?",
                            style: TextStyle(fontSize: 13,
                                decorationColor: Colors.grey.shade400),

                          ),
                          TextButton(
                            onPressed: () {
                              OTPController.clear();
                              // loginBloc.add(GetOtpEvent(
                              //     loginData.pmobileno.toString()));
                              snackBar("OTP resend!!");
                            },
                            child: Text(
                              "RESEND",
                              style: TextStyle(
                                color: Colors.cyanAccent.shade400,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: TextButton(
                              child: Text("Clear Pin".toUpperCase(),
                                style: TextStyle(
                                    color: Colors.cyanAccent.shade400),),
                              onPressed: () {
                                OTPController.clear();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 20.0, left: 0, right: 0, top: 5),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 50,
                    width: 160,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.cyan, Colors.cyanAccent],
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0 ),
                      ),
                    ),
                    child:
                    BlocConsumer<LoginBloc,LoginState>(
                      builder: (context, state) {
                        if(state is VerifyLoading){
                          return
                            const Padding(
                              padding: EdgeInsets.all(2),
                              child: Center(child:
                              CircularProgressIndicator(color: Colors.black,)
                              ));
                        }
                        else{
                          return
                          InkWell(
                            onTap: () {
                              if (formKey.currentState!.validate()) {

                              }
                              // conditions for validating
                              if (currentText.length != 6) {
                                errorController!.add(ErrorAnimationType
                                    .shake); // Triggering error shake animation
                                setState(() => hasError = true
                                );
                              } else {
                                // Navigator.push(context, MaterialPageRoute(builder: (context) =>ResetPinScreen()));
                                setState(
                                      () {
                                    BlocProvider.of<LoginBloc>(context).add(VerifyOtpBtn(loginData.pmobileno.toString(),OTPController.text));
                                    BlocProvider.of<LoginBloc>(context).add(
                                    VerifyOtpBtn(loginData.pmobileno.toString(),OTPController.text));
                                    Navigator.of(context).pushNamed('/re');
                                  },
                                );
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                 Text(
                                  "Verify OTP  ",
                                  style: getLoginTextStyle(fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black),
                                ),
                                Image.asset(
                                  'assets/images/right-arrow.png',
                                  height: 16,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          );
                        }
                      },
                       listener: (context, state) {
                         if(state is VerifySucess){
                           AppWidgets.showSnackBar(context, 'OTP Verified!!', Colors.green);
                           Navigator.of(context).pushNamed('/resetPinScreen');
                         }
                        else{
                           AppWidgets.showSnackBar(context, 'Error!! Enter correct pin', Colors.red);
                           Navigator.of(context).pushNamed('/resetPinScreen');
                         }
                       },
                    ),
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}