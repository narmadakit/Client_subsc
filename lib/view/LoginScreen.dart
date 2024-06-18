import 'package:client_subscriber/view/OTPScreen.dart';
import 'package:client_subscriber/bloc/Login/LoginBloc.dart';
import 'package:client_subscriber/bloc/Login/LoginState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/Login/LoginEvent.dart';
import '../utils/AppWidgets.dart';
import '../utils/styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _mobileText = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    var loginBloc= BlocProvider.of<LoginBloc>(context, listen: false);
    return Scaffold(
      // backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child:  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Enter your mobile\nnumber',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25.0,horizontal: 0),
                          child:  SizedBox(
                            height: 50,
                            child: TextFormField(
                              controller: _mobileText,
                              // style: const TextStyle(color: Colors.black),
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  labelText: 'Mobile number'.toLowerCase(),
                                  labelStyle: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                  hintStyle: const TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 0.5,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 0.5,
                                    ),
                                  ),
                                  counterText: ''),
                              maxLength: 10,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter mobile no.';
                                } else if (value.length < 10) {
                                  return 'Please enter 10 digit mobile no.';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
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
                      if(state is LoginInitialState) {
                        return InkWell(
                          onTap: () async {
                            loginBloc.add(GetOtpEvent(_mobileText.text));
                            await Future.delayed(const Duration(seconds: 2));
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>const OTPScreen()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Get OTP  ",
                                style: getLoginTextStyle(fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Image.asset(
                                'assets/images/right-arrow.png',
                                height: 16,
                              ),
                              // Icon(Icons.arrow_forward,color: Colors.black,)
                            ],
                          ),
                        );
                      }
                      else if(state is LoginLoadingState){
                        return const Padding(
                            padding: EdgeInsets.all(2),
                            child: Center(child:
                            CircularProgressIndicator(color: Colors.black,)
                            ));
                      }
                      else{
                        return InkWell(
                          onTap: () async {
                            loginBloc.add(GetOtpEvent(_mobileText.text));
                            await Future.delayed(const Duration(seconds: 2));
                            // Navigator.push(context, MaterialPageRoute(builder: (context) =>OTPScreen()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Get OTP  ",
                                style: getLoginTextStyle(fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black),
                              ),
                              Image.asset(
                                'assets/images/right-arrow.png',
                                height: 16,
                                color: Colors.black,
                              ),
                              // Icon(Icons.arrow_forward,color: Colors.black,)
                            ],
                          ),
                        );
                      }
                    },
                    listener: (context, state) {
                      if(state is LoginSuccessState){
                        print('login Success state');
                        Navigator.of(context).pushNamed('/otpScreen');
                      }
                      if(state is LoginErrorState){
                        print('login Error state');
                        AppWidgets.showSnackBar(context, 'Enter registered mobile number',Colors.red);
                      }
                      if(state is LoginFailure){
                        print('login Failure state');
                        AppWidgets.showSnackBar(context, 'Something went wrong', Colors.red);
                        // Navigator.of(context).pushNamed('/otpScreen',arguments: {"phoneNumber":mobileController.text});
                      }
                    },
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
