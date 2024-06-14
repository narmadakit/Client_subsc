import 'package:flutter/material.dart';

import '../Utils/AppStyles.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyles.bgColor,
        title: Text('Confirm to Pay',style: AppStyles.headingTxtStyle,),
        toolbarHeight: 50,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal:  15.0),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              'assets/images/arrow-left.png',
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
