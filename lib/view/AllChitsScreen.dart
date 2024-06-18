import 'dart:collection';

import 'package:animations/animations.dart';
import 'package:client_subscriber/bloc/AllChit/AllChitsBloc.dart';
import 'package:client_subscriber/bloc/AllChit/AllChitsEvent.dart';
import 'package:client_subscriber/bloc/AllChit/AllChitsState.dart';
import 'package:client_subscriber/model/LoginResponse.dart';
import 'package:client_subscriber/view/ConfirmationScreen.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import '../Utils/AppStyles.dart';
import '../Utils/AppWidgets.dart';
import '../Utils/SharedPref.dart';
import '../Utils/ShimmerScreens.dart';
import '../Utils/styles.dart';
import '../utils/ShowUtils.dart';
import 'ChitDetailsTab.dart';

class AllChitsScreen extends StatefulWidget {
  const AllChitsScreen({Key? key, this.includeMarkAsDoneButton = true}) : super(key: key);

  final bool includeMarkAsDoneButton;

  @override
  State<AllChitsScreen> createState() => _AllChitsScreenState();
}

class _AllChitsScreenState extends State<AllChitsScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  final ContainerTransitionType _transitionType = ContainerTransitionType.fadeThrough;
  bool isPlaying = false;

  HashMap<int, String> payingAmountHashmap = HashMap();
  num totalPayingAmount = 0;
  num totalDueAmt = 0;
  num remainigTotAmt = 0;
  final List<TextEditingController> controllers = [];

  final checked = false;
  var prefs=SharedPref();
  LoginResponse loginData=LoginResponse();
  late num remainingAmt;

  @override
  initState() {
    super.initState();
    getLogindata();

    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
  }
  getLogindata()async{
    loginData = LoginResponse.fromJson(await prefs.read("loginData"));
    AppWidgets.gMobileNo = loginData.pmobileno;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppWidgets.appbarWidget('Chits', () => Navigator.pop(context),context),
        bottomNavigationBar: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              color: Colors.black,
                height: size.height * 0.17,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('₹${AppWidgets.formatCurrency.format(totalDueAmt)}', style: TextStyle(color: AppStyles.fadePinkColor, fontWeight: FontWeight.w600)),
                                Text('Total Due', style: TextStyle(fontSize: 12)),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('₹${AppWidgets.formatCurrency.format(remainigTotAmt)}', style: TextStyle(color:AppStyles.fadePinkColor, fontWeight: FontWeight.w600)),
                                Text('Remaining', style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        GestureDetector(
                          onTap: () {
                            if(totalPayingAmount == 0){
                              AppWidgets.showSnackBar(context, 'Enter your subscription amount',AppStyles.fadePinkColor);
                            }
                            else{
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>const ConfirmationScreen()));
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
                                totalPayingAmount == 0 ? "Pay Now".toUpperCase() : "PAY ${ShowUtils.getAmountWithCommas(totalPayingAmount)}",
                                style: getLoginTextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            )),
        body: BlocBuilder<AllChitsBloc,AllChitsState>(
          builder: (BuildContext context, AllChitsState state) {
            if (state is ChitsInitialState) {
              BlocProvider.of<AllChitsBloc>(context).add(
                  GetChitDetailsEvent(AppWidgets.gMobileNo.toString()));
              return
                ShimmerScreens.shimmerLoader();
            }
            if (state is ChitLoadedState) {
              return
                buildBody(state);
            }
            else {
              return Container();
            }

          },

        ),
      ),
    );
  }

  Padding buildBody(ChitLoadedState state) {
    return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        physics: const RangeMaintainingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.model.length,
                        itemBuilder: (context, index) {
                          controllers.add(TextEditingController());
                          num totDue=0;
                          for(var a in state.model){
                            totDue += (a.pdue != null)?a.pdue!:0;
                            totalDueAmt = totDue;
                          }
                          remainigTotAmt = totalDueAmt;
                          return Padding(
                            padding: AppStyles.screenPaddingH.copyWith(bottom: 10),
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    border: Border.all(
                                        color:Theme.of(context).dividerColor,
                                        width:  0.7,
                                      style: BorderStyle.solid
                                    ),
                                    borderRadius: const BorderRadius.all(Radius.circular(12.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${state.model[index].psubscribername}',
                                                    style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            OpenContainer(
                                                closedColor: AppStyles.bgColor,
                                                // middleColor: (index.isOdd)?Colors.black:Colors.black12,
                                                transitionType: _transitionType,
                                                openBuilder: (BuildContext _, VoidCallback openContainer) {
                                                  return ChitDetailsTab(chitNo: state.model[index].pchitno,);
                                                },
                                                tappable: false,
                                                transitionDuration: const Duration(milliseconds: 500),
                                                // closedShape: const RoundedRectangleBorder(),
                                                closedElevation: 5.0,
                                                closedBuilder: (BuildContext _, VoidCallback openContainer) {
                                                  return SizedBox(
                                                    // color: Colors.black,
                                                    width: 90,
                                                    height: 36,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(2.0),
                                                      child: InkWell(
                                                        onTap: openContainer,
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              'Details  '.toUpperCase(),
                                                              style: const TextStyle(
                                                                color: Colors.white,
                                                                decoration: TextDecoration.underline,
                                                                decorationColor: Colors.white,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                            Image.asset(
                                                              'assets/images/right-arrow.png',
                                                              height: 16,
                                                              color: Colors.white,
                                                            ),
                                                            // Lottie.asset('assets/lotties/Right.json'),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                })
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${state.model[index].pchitno}',
                                                  style: const TextStyle(color: Colors.white, fontSize: 11,fontWeight: FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  '₹${AppWidgets.formatCurrency.format(state.model[index].psubscriptionamt)}',
                                                  style: const TextStyle(color: Colors.white, fontSize: 11),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 25,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'DUE AMOUNT',
                                                  style: TextStyle(color: AppStyles.fadePinkColor, fontSize: 11),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  '₹${AppWidgets.formatCurrency.format(state.model[index].pdue)}',
                                                  style: TextStyle(color: AppStyles.fadePinkColor, fontSize: 11,fontWeight: FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SimpleCircularProgressBar(
                                              backColor: Colors.cyan.withOpacity(0.2),
                                              backStrokeWidth: 7,
                                              size: 50,
                                              progressStrokeWidth: 7,
                                              maxValue: double.parse(state.model[index].pnoofauctions.toString()),
                                              mergeMode: false,
                                              valueNotifier: ValueNotifier(double.parse(state.model[index].pauctionmonth.toString())),
                                              progressColors: [Colors.cyan, Colors.cyan.shade300, Colors.cyanAccent],
                                              onGetText: (double value) {
                                                return Text(
                                                  '${state.model[index].pauctionmonth}/${state.model[index].pnoofauctions} ',
                                                  style: TextStyle(
                                                    fontSize: 9,
                                                    color: AppStyles.fadePinkColor,
                                                  ),
                                                );
                                              },
                                            ),
                                            const SizedBox(width: 15,),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Branch'.toUpperCase(),
                                                    style: const TextStyle(color: Colors.grey, fontSize: 11),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    '${state.model[index].pvchbranch}',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(color: Colors.white, fontSize: 11),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 15,),
                                            SizedBox(
                                              width: 100,
                                              height: 40,
                                              child: TextField(
                                                inputFormatters: [
                                                 CurrencyTextInputFormatter.currency(locale: "en_US",decimalDigits: 0, name: "")
                                                ],
                                                onChanged: (value) {
                                                  value = value.replaceAll(',', '');
                                                  updatePayingAmount(index, value);
                                                },
                                                controller: controllers[index],
                                                keyboardType: TextInputType.number,
                                                cursorColor: Colors.white70,
                                                maxLength: 10,
                                                textAlign: TextAlign.center,
                                                decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.zero,
                                                    counterText: '',
                                                    hintText: "₹ amount",
                                                    fillColor: Colors.black54,
                                                    filled: true,
                                                    hintStyle: TextStyle(color: Colors.grey.shade800, fontSize: 12, fontWeight: FontWeight.w600),
                                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).dividerColor,width: 0.7), borderRadius: BorderRadius.circular(2.0)),
                                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Theme.of(context).dividerColor, width: 1), borderRadius: BorderRadius.circular(2.0))),
                                                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
  }

  updatePayingAmount(int index, String amount) {
    if (amount == "") {
      amount = "0";
    }
    if (payingAmountHashmap.containsKey(index)) {
      payingAmountHashmap.update(index, (value) => amount);
    } else {
      payingAmountHashmap.putIfAbsent(index, () => amount);
    }
    totalPayingAmount = 0;
    payingAmountHashmap.forEach((key, value) {
      totalPayingAmount = totalPayingAmount + double.parse(value);
    });
    setState(() {
      totalPayingAmount;
    });
    if (payingAmountHashmap.containsKey(index)) {
      var value = payingAmountHashmap[index];
      if (value == "0") {
        payingAmountHashmap.remove(index);
      }
    }
    print("amount>> : ${payingAmountHashmap}");
  }

  checkAndNavigateToPayAckPage(List<dynamic>? chits) {
    List<dynamic> payingChits = [];
    if (chits == null) {
      return;
    }
    if (totalPayingAmount == 0) {
      ShowUtils.showMessage("Please enter amount to proceed further");
    } else {
      if (chits.isNotEmpty) {
        payingAmountHashmap.forEach((key, value) {
          chits[key].payingAmount = double.parse(value);
          payingChits.add(chits[key]);
        });
      }
    }
  }

  Widget dropDownsheet(StateSetter state, context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)), color: Colors.black),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Settings",
              style: getLoginTextStyle(color: Colors.grey, fontSize: 25),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

}
