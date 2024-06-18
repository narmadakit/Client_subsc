import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'AppStyles.dart';

class AppWidgets{
  static final formatCurrency =  NumberFormat.simpleCurrency(locale: "HI",decimalDigits: 0, name: "");
  static String? gMobileNo;

  static Widget settingslisTile(String image,String text,Function() ontap){
    return Card(
      color:  Colors.grey.shade900.withOpacity(0.50),
      shape:  const RoundedRectangleBorder(
      ),
      child: InkWell(
        onTap: ontap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 22),
          child: Row(
            children: [
              Image.asset(image,color: Colors.white,height: 18,),
              Text('  $text', style: AppStyles.headingTxtStyle1,),
              const Spacer(),
              Icon(Icons.chevron_right_outlined,size: 18, color: Colors.grey.shade700,)
            ],
          ),
        ),
      ),
    );
  }

  static PreferredSizeWidget appbarWidget(String title,Function() ontap,BuildContext context){
    return AppBar(
      toolbarHeight: 50,
      elevation: 0.4,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal:  15.0),
        child: InkWell(
          onTap: ontap,
          child: Image.asset(
            'assets/images/arrow-left.png',
            // color: Colors.white,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
      title: Text(
        title,
        style:AppStyles.headingTxtStyle.copyWith(color:  Theme.of(context).iconTheme.color),
      ),
    );
  }

  static Widget miniCardWidget(BuildContext context, IconData icon, String text1, text2,text3){
    return Container(
      height: 90,
      width: 110,
      decoration: BoxDecoration(
        color:Colors.cyanAccent.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(icon,size: 22,color: Colors.white,),
                SizedBox(width: 10,),
                Text('$text1$text2',style: AppStyles.numTxtStyle)
              ],
            ),
            SizedBox(height: 8),
            Align(
                alignment: Alignment.center,
                child: Text(text3,style: AppStyles.greyTxtStyle, textAlign: TextAlign.center,)),
          ],
        ),
      ),
    );
  }

  static showSnackBar(BuildContext context, String content, Color color) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(content,style: TextStyle(color: Colors.white),),
        backgroundColor: color,
        duration: const Duration(seconds: 5),
      ));
  }

  static showSnackBarDismiss(BuildContext context, String content, Color color) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(content,style: TextStyle(color: Colors.white),),
        backgroundColor: color,
        duration: const Duration(seconds: 5),
      ));
  }
}