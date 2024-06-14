import 'package:flutter/material.dart';

import '../Utils/AppStyles.dart';
import '../Utils/AppWidgets.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  ThemeMode _themeMode = ThemeMode.system;
  _toggleTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
  bool _value = false;


  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      // backgroundColor: AppStyles.bgColor,
      appBar: AppWidgets.appbarWidget('See More', () => Navigator.pop(context),context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 0,
                        color: Colors.grey.shade900.withOpacity(0.90),
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child:Image.asset('assets/images/about-us.png',color: Colors.white,height: 18,),
                        ),
                      ),
                    ),
                    Text('  about us', style: AppStyles.headingTxtStyle1,),
                    Spacer(),
                    Icon(Icons.chevron_right_outlined,size: 18,)
                  ],
                ),
              ),
              Divider(color: Colors.grey,),
              InkWell(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 0,
                        color: Colors.grey.shade900.withOpacity(0.90),
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child:Image.asset('assets/images/verified.png',color: Colors.white,height: 18,),
                        ),
                      ),
                    ),
                    Text('  T&C', style: AppStyles.headingTxtStyle1,),
                    Spacer(),
                    Icon(Icons.chevron_right_outlined,size: 18,)
                  ],
                ),
              ),
              Divider(color: Colors.grey,),
              InkWell(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 0,
                        color: Colors.grey.shade900.withOpacity(0.90),
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child:Image.asset('assets/images/help.png',color: Colors.white,height: 18,),
                        ),
                      ),
                    ),
                    Text('  privacy policy', style: AppStyles.headingTxtStyle1,),
                    Spacer(),
                    Icon(Icons.chevron_right_outlined,size: 18,)
                  ],
                ),
              ),
              // Divider(color: Colors.grey,),
              // InkWell(
              //   child: Row(
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Card(
              //           elevation: 0,
              //           color: Colors.grey.shade900.withOpacity(0.90),
              //           child: Padding(
              //             padding: EdgeInsets.all(0),
              //             child:Image.asset('assets/images/help.png',color: Colors.white,height: 18,),
              //           ),
              //         ),
              //       ),
              //       Text('  enquiry', style: AppStyles.headingTxtStyle1,),
              //       Spacer(),
              //       Icon(Icons.chevron_right_outlined,size: 18,)
              //     ],
              //   ),
              // ),
    //           Divider(color: Colors.grey,),
    //           InkWell(
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Padding(
    //                   padding: const EdgeInsets.all(8.0),
    //                   child: Card(
    //                     elevation: 0,
    //                     color: Colors.grey.shade900.withOpacity(0.90),
    //                     child: Padding(
    //                         padding: EdgeInsets.all(0),
    //                         // child:Image.asset('assets/images/help.png',color: Colors.white,height: 18,),
    //                         child: Icon(Icons.dark_mode, color: Colors.white,)
    //                     ),
    //                   ),
    //                 ),
    //                 Text('themes', style: AppStyles.headingTxtStyle1,),
    //                 Spacer(),
    // Container(
    // child: Transform.scale(
    // scale: 1.0,
    // child: Switch(
    // activeColor : Colors.greenAccent,
    // inactiveThumbColor: Colors.redAccent,
    // value: _value,
    // // activeThumbImage: AssetImage("images/cnw.png"),
    // // inactiveThumbImage : AssetImage("images/simple_interest.png"),
    // onChanged: (bool value){
    // setState(() {
    // _value = value;
    // });
    // },
    // ),
    // ),
    // )
    //               ],
    //             ),
    //           ),
            ],
          ),
        ),
      ),
    );
  }
}
