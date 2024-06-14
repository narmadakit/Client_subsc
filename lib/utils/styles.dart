import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
// import 'package:package_info_plus/package_info_plus.dart';
// import 'ShowUtils.dart';
// import 'TimeUtils.dart';

// Future<String> getVersionName() async {
//   PackageInfo packageInfo = await PackageInfo.fromPlatform();
//   String version = packageInfo.version;
//   return "version $version";
// }

TextStyle subTitleTextWithBold() {
  return GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 14.0,
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
  );
}


getThemeButton(Function()? onTap, {String buttonName = "", backGroundColor = Colors.black}) {
  return GestureDetector(
    onTap: onTap,
    child: Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 5,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: backGroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonName,
              style: _ediTextHintStyle(color: Colors.white),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ],
        ),
      ),
    ),
  );
}

getLoginTextStyle({double fontSize = 32, Color color = Colors.black, FontWeight fontWeight = FontWeight.bold, double height = 0}) {
  return GoogleFonts.poppins(
      textStyle: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
        height: height,
      ));
}

getDefaultBoldTextStyle({Color color = Colors.black}) {
  return GoogleFonts.poppins(
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: color,
      ));
}

getDefaultTextStyle({Color color = Colors.black, TextDecoration decoration = TextDecoration.none}) {
  return GoogleFonts.poppins(textStyle: TextStyle(fontWeight: FontWeight.w600, color: color, decoration: decoration, decorationColor: color));
}

getHeadingTextStyle({Color color = Colors.black}) {
  return GoogleFonts.poppins(textStyle: TextStyle(fontWeight: FontWeight.w800, fontSize: 24, color: color));
}

getAppbarTextStyle() {
  return TextStyle(fontWeight: FontWeight.w600,color: Colors.grey.shade700);
}

getNewEnrollmentTextField(Function(dynamic) onchanged, {String hint = "", TextInputType textInputType = TextInputType.name}) {
  return SizedBox(
    height: 50,
    child: TextFormField(
      onChanged: onchanged,
      textInputAction: TextInputAction.next,
      keyboardType: textInputType,
      style: subTitleTextWithBold(),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 20),
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 0.5, color: Colors.black),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 0.5, color: Colors.black),
        ),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.5, color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        hintStyle: _ediTextHintStyle(),
        hintText: hint,
      ),
    ),
  );
}

Center getDropDownTextField(List<DropdownMenuItem> list, Function(dynamic) param0, {hint = "", double leftPadding = 0.0, double rightPadding = 0.0, Null Function()? onpress, int selection = 0}) {
  return Center(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black, // You can set the color of the stroke here
          width: 0.5, // You can set the width of the stroke here
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: DropdownButtonFormField(value: list[selection].value, items: list, dropdownColor: Colors.white, decoration: _dropDownLabelDecorationStyle(hintValue: ""), onChanged: param0),
      ),
    ),
  );
}

InputDecoration _dropDownLabelDecorationStyle({String hintValue = ""}) {
  return InputDecoration(
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.all(10),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(width: 1, color: Colors.white),
    ),
    filled: true,
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 1, color: Colors.white),
      borderRadius: BorderRadius.circular(10.0),
    ),
    hintStyle: _ediTextHintStyle(),
    hintText: hintValue,
  );
}

TextStyle _ediTextHintStyle({Color color = Colors.black}) {
  return GoogleFonts.poppins(
    textStyle: TextStyle(fontWeight: FontWeight.w300, color: color),
  );
}

TextStyle ediTextHintStyle({Color color = Colors.black}) {
  return GoogleFonts.poppins(
    textStyle: TextStyle(fontWeight: FontWeight.w300, color: color),
  );
}

addSpaceInLoginPage() {
  return const SizedBox(height: 24);
}

getLoginScreensImageHeight() {
  return 200.0;
}

addPaddingForLoginScreens() {
  return const EdgeInsets.fromLTRB(24, 100, 24, 40);
}

addSpaceInPinSetPage() {
  return const SizedBox(height: 20);
}

getButtonHeight() => 50.0;

Color getGradientStartColorOfLoginButton() {
  return const Color(0xFFF868AB);
}

Color getGradientEndColorOfLoginButton() {
  return const Color(0XFFFE6870);
}

getLoginTextFieldDecoration(String label) {
  return InputDecoration(
    enabledBorder: const OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: Color(0xD8989898)), borderRadius: BorderRadius.all(Radius.zero), gapPadding: 0),
    hintText: label,
    hintStyle: GoogleFonts.poppins(),
    isDense: true,
    focusedBorder: const OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: Color(0xD8989898)), borderRadius: BorderRadius.all(Radius.zero), gapPadding: 0),
  );
}

getLoadingIndicator() {
  return Center(child: Lottie.asset("assets/chit_search_loading.json", height: 70, width: 70));
}



void vibrate() {
  // final player = AudioPlayer();
  HapticFeedback.mediumImpact();
  // player.play(AssetSource("button_click.mp3")); // Replace with the actual sound file path
}

String getFormattedDate(DateTime selectedDate) {
  return DateFormat("yyyy-MMM-dd hh:mm ss").format(selectedDate);
}

String getFormattedForCheque(DateTime selectedDate) {
  return DateFormat("dd/MM/yyyy").format(selectedDate);
}

String getFormattedDateForDisplay(DateTime selectedDate) {
  return DateFormat("dd-MMM-yyyy").format(selectedDate);
}

String getApiFormattedDateReports(DateTime selectedDate) {
  return DateFormat("dd-MM-yyyy").format(selectedDate);
}

String getApiFormattedDateForCommissions(DateTime selectedDate) {
  return DateFormat("dd/MM/yyyy").format(selectedDate);
}

// showReportsCumReprintView({String totalAmount = "5,000", Function()? datePickerCLick, Function()? searchButtonClicked, required Function() printButtonClick, String printButtonText = "PRINT", bool searchButtonVisibility = true, String selectedDate = "09-JAN-2024", List<dynamic>? data}) {
//   return Padding(
//     padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
//     child: Column(
//       children: [
//         Container(
//           height: 50,
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0XFF8F92A1), width: 0.9)),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Visibility(
//                 visible: searchButtonVisibility,
//                 child: Container(
//                   width: 50,
//                 ),
//               ),
//               GestureDetector(
//                 onTap: datePickerCLick,
//                 child: Text(
//                   selectedDate,
//                   style: getLoginTextStyle(fontSize: 15, fontWeight: FontWeight.w800),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: searchButtonClicked,
//                 child: Visibility(
//                   visible: searchButtonVisibility,
//                   child: Container(
//                     height: 50,
//                     width: 50,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.black),
//                       color: Colors.black,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: const Icon(
//                       Icons.search,
//                       color: Colors.white,
//                       size: 30,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         Column(
//           children: [
//             Text(
//               "Total Amount",
//               style: getLoginTextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//             ),
//             Text(
//               ShowUtils.getAmountWithCommas(totalAmount),
//               style: getLoginTextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.green),
//             ),
//           ],
//         ),
//         Expanded(
//           child: ListView.separated(
//               shrinkWrap: true,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.only(top: 30),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             TimeUtils.dBTimeToNormalTime(data[index].transactiondate.toString()),
//                             style: getLoginTextStyle(fontWeight: FontWeight.bold, fontSize: 13),
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Text(
//                             ShowUtils.getChitNameAfterRemovingZero(data[index].chitno.toString()),
//                             style: getLoginTextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: Colors.grey),
//                           )
//                         ],
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Text("Paid: ",
//                                   style: getLoginTextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 13,
//                                   )),
//                               Text(ShowUtils.getAmountWithCommas(data?[index].receiptamount), style: getLoginTextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.green)),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Row(
//                             children: [
//                               Text("Mode: ", style: getLoginTextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey)),
//                               Text(data[index].paymentmode.toString(), style: getLoginTextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black)),
//                             ],
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 );
//               },
//               separatorBuilder: (BuildContext context, int index) => const Divider(
//                 height: 2,
//                 endIndent: 0,
//               ),
//               itemCount: data!.length),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(bottom: 10, top: 10),
//           child: getThemeButton(
//             printButtonClick,
//             buttonName: printButtonText,
//           ),
//         ),
//       ],
//     ),
//   );
// }



String getFirstLetter(String s) {
  return s.characters.first.toUpperCase();
}




void androidAlertDialog(BuildContext context, {required Function() onYesClick, required Function() onNoClick}) {
  showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('would you like to logout from app?'),
        actions: <Widget>[
          TextButton(
            onPressed: onNoClick,
            child: const Text('No'),
          ),
          TextButton(
            onPressed: onYesClick,
            child: const Text('Yes'),
          ),
        ],
      ));
}

void showAlertDialog(BuildContext context, {required Function() onYesClick, required Function() onNoClick}) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('Logout'),
      content: const Text('would you like to logout from the app'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          /// This parameter indicates this action is the default,
          /// and turns the action's text to bold text.
          isDefaultAction: true,
          onPressed: onNoClick,
          child: const Text('No'),
        ),
        CupertinoDialogAction(
          /// This parameter indicates the action would perform
          /// a destructive action such as deletion, and turns
          /// the action's text color to red.
          isDestructiveAction: true,
          onPressed: onYesClick,
          child: const Text('Yes'),
        ),
      ],
    ),
  );
}

// Future<bool> logout(BuildContext context) async {
//   return await SharedPreferencesUtils.clearPreferences();
// }

//
// void checkAndLogOut(context) async {
//   var status = await logout(context);
//   if (status) {
//     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginPage()), (_) => false);
//   } else {
//     ShowUtils.showSnackBar(context, "Unable to logout");
//   }
// }

getPaymentModeSelected(String paymentMode) {
  return Container(
    decoration: BoxDecoration(color: const Color(0xFFF868AB), borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xff8F92A1), width: 0.5)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
      child: Center(
          child: Text(
            paymentMode,
            style: getLoginTextStyle(fontWeight: FontWeight.normal, fontSize: 15, color: Colors.white),
          )),
    ),
  );
}

getPaymentModeUnSelected(String paymentMode) {
  return Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xff8F92A1), width: 0.5)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
      child: Center(
          child: Text(
            paymentMode,
            style: getLoginTextStyle(fontWeight: FontWeight.normal, fontSize: 15),
          )),
    ),
  );
}
