import 'package:client_subscriber/Utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart' as AmountFormatter;
import 'package:intl/intl.dart';

class ShowUtils {

  static getChitName(String groupCode, int ticketNo){
    if(groupCode.contains("VACANT")){
      return groupCode;
    }else{
      return "$groupCode - $ticketNo";
    }
  }

  static getChitNameAfterRemovingZero(String chitName){
    if(chitName.contains("VACANT")){
      int lastIndex = chitName.length -2;
      return chitName.substring(0,lastIndex);
    }
    return chitName;
  }

  static bool shouldRefreshDashBoard=false;
  static showMessage(String message) {
    Fluttertoast.showToast(msg: message);
  }

  static showServerError() {
    Fluttertoast.showToast(msg: "Server error, Please try again");
  }

  static showSnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(
          content,
          style: getLoginTextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.normal),
        ),
        duration: const Duration(seconds: 2),
      ));
  }

  static bool isValidMobileNumber(String input) {
    RegExp regex = RegExp(r"^(?:[+0]9)?(?!0+$)[0-9]{10}$");
    return regex.hasMatch(input);
  }

  static void showDatePicker({DateTime? date, required Function(DateTime) onNewDate, BuildContext? context, DateTime? minimumDate, DateTime? maximum, DateTime? initialDateTime, DateTime? maximumYear, CupertinoDatePickerMode mode = CupertinoDatePickerMode.date}) {
    _showDialog(
        CupertinoDatePicker(
          minimumDate: minimumDate,
          maximumDate: maximum,

          dateOrder: DatePickerDateOrder.dmy,
          initialDateTime: initialDateTime,
          mode: mode,
          use24hFormat: false,
// This shows day of week alongside day of month
          showDayOfWeek: true,
// This is called when the user changes the date.
          onDateTimeChanged: onNewDate,
        ),
        context!);
  }

  static void _showDialog(Widget child, BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
// The Bottom margin is provided to align the popup above the system
// navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
// Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
// Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  static Future<DateTime?> showDatePickerAndroid({
    required BuildContext context,
    DateTime? initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    DateTime? currentDate,
    DatePickerEntryMode initialEntryMode = DatePickerEntryMode.calendar,
    SelectableDayPredicate? selectableDayPredicate,
    String? helpText,
    String? cancelText,
    String? confirmText,
    Locale? locale,
    bool barrierDismissible = true,
    Color? barrierColor,
    String? barrierLabel,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    TextDirection? textDirection,
    TransitionBuilder? builder,
    DatePickerMode initialDatePickerMode = DatePickerMode.day,
    String? errorFormatText,
    String? errorInvalidText,
    String? fieldHintText,
    String? fieldLabelText,
    TextInputType? keyboardType,
    Offset? anchorPoint,
    final ValueChanged<DatePickerEntryMode>? onDatePickerModeChange,
    final Icon? switchToInputEntryModeIcon,
    final Icon? switchToCalendarEntryModeIcon,
  }) async {
    initialDate = initialDate == null ? null : DateUtils.dateOnly(initialDate);
    firstDate = DateUtils.dateOnly(firstDate);
    lastDate = DateUtils.dateOnly(lastDate);
    assert(
    !lastDate.isBefore(firstDate),
    'lastDate $lastDate must be on or after firstDate $firstDate.',
    );
    assert(
    initialDate == null || !initialDate.isBefore(firstDate),
    'initialDate $initialDate must be on or after firstDate $firstDate.',
    );
    assert(
    initialDate == null || !initialDate.isAfter(lastDate),
    'initialDate $initialDate must be on or before lastDate $lastDate.',
    );
    assert(
    selectableDayPredicate == null || initialDate == null || selectableDayPredicate(initialDate),
    'Provided initialDate $initialDate must satisfy provided selectableDayPredicate.',
    );
    assert(debugCheckHasMaterialLocalizations(context));

    Widget dialog = DatePickerDialog(
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      currentDate: currentDate,
      initialEntryMode: initialEntryMode,
      selectableDayPredicate: selectableDayPredicate,
      helpText: helpText,
      cancelText: cancelText,
      confirmText: confirmText,
      initialCalendarMode: initialDatePickerMode,
      errorFormatText: errorFormatText,
      errorInvalidText: errorInvalidText,
      fieldHintText: fieldHintText,
      fieldLabelText: fieldLabelText,
      keyboardType: keyboardType,
      onDatePickerModeChange: onDatePickerModeChange,
      switchToInputEntryModeIcon: switchToInputEntryModeIcon,
      switchToCalendarEntryModeIcon: switchToCalendarEntryModeIcon,
    );

    /* if (textDirection != null) {
      dialog = Directionality(
        textDirection: textDirection,
        child: dialog,
      );
    }*/

    if (locale != null) {
      dialog = Localizations.override(
        context: context,
        locale: locale,
        child: dialog,
      );
    }


    return showDialog<DateTime>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      builder: (BuildContext context) {
        return builder == null ? dialog : builder(context, dialog);
      },
      anchorPoint: anchorPoint,
    );
  }
  static String getAmountWithCommasForPrint(dynamic amount) {
    final formatter = AmountFormatter.NumberFormat("#,##,##,###");
    return "Rs ${formatter.format(amount)}/-";
  }
  static final indianRupeesFormat = NumberFormat.currency(
    name: "INR",
    locale: 'en_IN',
    decimalDigits: 0, // change it to get decimal places
    symbol: '₹ ',
  );

  static String getAmountWithCommas(dynamic amount) {
    if(amount is String){
      return indianRupeesFormat.format(double.parse(amount));
    }else{
      return indianRupeesFormat.format(amount);
    }
  }
  static int getAmountWithoutCommas(String formattedAmount) {
    String unformatted = formattedAmount.replaceAll(',', '');
    return int.parse(unformatted);
  }
  static String removeStringAfterHyphen(String originalString) {
    int indexOfHyphen = originalString.indexOf('-');
    if (indexOfHyphen != -1) {
      return originalString.substring(0, indexOfHyphen);
    } else {
      return originalString;
    }
  }
  static String getBalanceAmount(String dueInString, String amountPaidInString) {
    String toReturn = "";
    try {
      int due = int.parse(dueInString.replaceAll(",", ""));
      int amountPaid = int.parse(amountPaidInString.replaceAll(",", ""));
      int balance = due - amountPaid;
      String balanceInString = balance.toString();
      if (balance >= 0) {
        var frekjf = balanceInString.replaceAll(".00", "");
        int balanceToShow = getAmountWithoutCommas(frekjf);
        toReturn = getAmountWithCommasForPrint(balanceToShow);
      } else {
        int balanceToShow = getAmountWithoutCommas(balanceInString.replaceAll("-", "").replaceAll(".00", ""));
        toReturn = "( ${getAmountWithCommasForPrint(balanceToShow)} )";
      }
    } catch (e) {
      print('EXCEPTION  $e');
    }
    return toReturn;
  }
  static String numberToWords(dynamic number) {
    if (number == 0) return 'zero';

    final List<String> units = [
      '', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'
    ];

    final List<String> teens = [
      'ten', 'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen',
      'seventeen', 'eighteen', 'nineteen'
    ];

    final List<String> tens = [
      '', '', 'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety'
    ];

    String words = '';

    if ((number / 1000000).floor() > 0) {
      words += '${numberToWords((number / 1000000).floor())} million ';
      number %= 1000000;
    }

    if ((number / 1000).floor() > 0) {
      words += '${numberToWords((number / 1000).floor())} thousand ';
      number %= 1000;
    }

    if ((number / 100).floor() > 0) {
      words += '${numberToWords((number / 100).floor())} hundred ';
      number %= 100;
    }

    if (number > 0) {
      if (words.isNotEmpty) {
        words += 'and ';
      }

      if (number < 10) {
        words += units[number];
      } else if (number < 20) {
        words += teens[number - 10];
      } else {
        words += tens[(number / 10).floor()];
        if ((number % 10) > 0) {
          words += '-${units[number % 10]}';
        }
      }
    }
    String numberToWordsTrimmed = words.trim();
    String capitalLetter = numberToWordsTrimmed.substring(0,1).toUpperCase();
    String remainingText = numberToWordsTrimmed.substring(1,numberToWordsTrimmed.length);
    return capitalLetter + remainingText;
  }
  static String convertToCamelCase(String input) {
    // Split the input string into words
    List<String> words = input.split(' ');

    // Capitalize the first letter of each word except the first one
    for (int i = 0; i < words.length; i++) {
      String word = words[i];
      print(' LLLL   $word}');
      words[i] = word[0].toUpperCase() + word.substring(1).toLowerCase();
    }

    // Join the words back together
    String camelCase = words.join(' ');

    // Make sure the first letter is lowercase
    camelCase = camelCase[0].toUpperCase() + camelCase.substring(1);

    return camelCase;
  }

}