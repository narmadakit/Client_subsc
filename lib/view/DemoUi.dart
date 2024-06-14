import 'package:animations/animations.dart';
import 'package:client_subscriber/model/ChitDetailsModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '../Utils/AppStyles.dart';
import '../Utils/AppWidgets.dart';
import '../Utils/hexcolor.dart';
import 'BidOfferScreen.dart';

class DemoUI extends StatefulWidget {
  final String? chitNo;
  final ChitDetailsModel? model;
  const   DemoUI({Key? key, this.chitNo,this.model}) : super(key: key);

  @override
  _DemoUIState createState() => _DemoUIState();
}

class _DemoUIState extends State<DemoUI>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  final ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  @override
  void initState() {
    super.initState();
    _initScaleAnimation();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _initScaleAnimation() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() => setState(() {}));
    animation = Tween<double>(begin: 0, end: 1.0).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double lineGaps=size.height * 0.005;
    return
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Value  '.toUpperCase(), style: AppStyles.headingTxtStyle1.copyWith(color: Colors.grey)),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade700.withOpacity(0.30),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      child:  Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text('  ₹${AppWidgets.formatCurrency.format(widget.model!.psubscriptionamt)}  ', style: const TextStyle(color: Colors.grey,fontSize: 11, fontWeight: FontWeight.w600),),
                      )),
                  const Spacer(),
                  Center(
                    child: Text((widget.model!.pchitstatus=="P"?"PRIZED":"NON PRIZED"),style: AppStyles.headingTxtStyle1.copyWith(color: AppStyles.primaryColor)),
                  ),
                ],
              ),
              SizedBox(height: lineGaps),
              Container(
                decoration: BoxDecoration(
                  color: AppStyles.fadePinkColor,
                ),
                child: Padding(
                  padding:AppStyles.screenPaddingH.copyWith(bottom: 10,top: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${widget.model!.psubscribername}',
                              style: AppStyles.headingTxtStyle1),
                          Text('${widget.model!.pchitno}', style: AppStyles.headingTxtStyle1.copyWith(fontWeight: FontWeight.w600),),
                        ],
                      ),
                    SizedBox(height: lineGaps),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            decoration:BoxDecoration(
                                border: Border.all(color:Colors.white12),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Branch'.toLowerCase(),
                                      style: AppStyles.labelTxtStyle),
                                  Text('${widget.model!.pvchbranch}',
                                      style: AppStyles.valueTextStyle),
                                  SizedBox(height: lineGaps),
                                  Text('period',
                                      style: AppStyles.labelTxtStyle),
                                  Text('${widget.model!.pauctionmonth} months',
                                      style: AppStyles.valueTextStyle),
                                  SizedBox(height: lineGaps),
                                  Text('Due date'.toLowerCase(),
                                      style: AppStyles.labelTxtStyle),
                                  Text('${widget.model!.pduedate}',
                                      style: AppStyles.valueTextStyle),
                                ],
                              ),
                            ),
                          ),
                        ),
                      SizedBox(width: 10,),
                        Expanded(
                          child: Container(
                            decoration:BoxDecoration(
                                border: Border.all(color:Colors.white12),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('previuos due',
                                      style: AppStyles.labelTxtStyle),
                                  Text('₹${widget.model!.previousdue}',
                                      style: AppStyles.valueTextStyle),
                                  SizedBox(height: lineGaps),
                                  Text('current EMI',
                                      style: AppStyles.labelTxtStyle),
                                  Text('₹${widget.model!.pcurrentmonthinstallment}',
                                      style: AppStyles.valueTextStyle),
                                  SizedBox(height: lineGaps),
                                  Text('Sum at credit'.toLowerCase(),
                                      style: AppStyles.labelTxtStyle),
                                  Text('₹${widget.model!.psumatcredit}',
                                      style: AppStyles.valueTextStyle),

                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                      // const SizedBox(width: 10,),
                      // Expanded(
                      //   flex: 3,
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(top:25.0),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.stretch,
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Container(
                      //           height: 75,
                      //           color: Colors.black,
                      //           child: Padding(
                      //             padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      //             child: Column(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 Text('advance', style: AppStyles.greyTxtStyle1,),
                      //                 Text('₹${AppWidgets.formatCurrency.format(widget.model!.padvance)}', style: AppStyles.numTxtStyle1,),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //         const SizedBox(height: 30,),
                      //         Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Container(
                      //                 decoration:BoxDecoration(
                      //                     border: Border.all(color:Colors.white38)
                      //                 ),
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.all(2.0),
                      //                   child: Center(child: Text('summit at credit', style: AppStyles.contentTxtStyle.copyWith(color: Colors.white))),
                      //                 )),
                      //             SizedBox(height: lineGaps),
                      //             Text('₹${AppWidgets.formatCurrency.format(widget.model!.psumatcredit)}',style:AppStyles.numTxtStyle1),
                      //           ],
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Previous Auction'.toUpperCase(), style: AppStyles.headingTxtStyle1.copyWith(color: Colors.grey)),
                  const Spacer(),
                  Text('Subscription '.toUpperCase(), style: TextStyle(color: Colors.grey,fontSize: 13),),
                  Container(
                      width: 65,
                      decoration: BoxDecoration(
                        color: AppStyles.fadePinkColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text('₹${AppWidgets.formatCurrency.format(widget.model!.psubscriptionamt)}',style: const TextStyle(color: Colors.white, fontSize: 11,fontWeight: FontWeight.w600)),
                        ),
                      )),
                ],
              ),
              SizedBox(height: lineGaps),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    border: Border.all(color: AppStyles.fadePinkColor.withOpacity(0.1))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: 105,
                                    height:18,
                                    color:AppStyles.fadePinkColor,
                                    child: Text(' previous auction ',
                                      textAlign: TextAlign.center,
                                      style: AppStyles.contentTxtStyle,)),
                                const SizedBox(height: 2,),
                                Text(DateFormat('dd-MMM-yyyy').format(DateTime.parse(widget.model!.pduedate.toString())), style: AppStyles.numTxtStyle1,)
                              ],
                            ),
                          ),
                          Container(
                              height: 75,
                              color: AppStyles.fadePinkColor,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('auction month', style: AppStyles.greyTxtStyle1),
                                      const SizedBox(height: 2,),
                                      Text('${widget.model!.pauctionmonth}', style: AppStyles.numTxtStyle1,),
                                    ],
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('discount', style: AppStyles.greyTxtStyle1,),
                                const SizedBox(height: 2,),
                                Text(
                                  '₹${widget.model!.bidPayableAmount??'0'}',
                                  style: AppStyles.numTxtStyle1,
                                ),
                                const SizedBox(height: 10,),
                                Text('dividend', style:AppStyles.greyTxtStyle1),
                                const SizedBox(height: 2,),
                                Text('₹${AppWidgets.formatCurrency.format(widget.model!.pnumdividend)}',style:AppStyles.numTxtStyle1,),
                                const SizedBox(height: 10,),
                                Text('bid payable', style:AppStyles.greyTxtStyle1),
                                const SizedBox(height: 2,),
                                Text('₹${widget.model!.bidAmount??'0'}',style: AppStyles.numTxtStyle1),
                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('NEXT AUCTION'.toUpperCase(), style: const TextStyle(
                      fontSize: 14, color: Colors.grey,fontWeight: FontWeight.w600)),
                ],
              ),
              SizedBox(height: lineGaps),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    border: Border.all(color: AppStyles.fadePinkColor.withOpacity(0.1))
                ),
                child:   Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex:3,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: 18,
                                // width: 90,
                                color: AppStyles.fadePinkColor,
                                child: Center(child: Text(' auction date ', style: AppStyles.contentTxtStyle,))),
                            const SizedBox(height: 2,),
                            Text(widget.model!.nextAuctionDate??'N/A', style:AppStyles.numTxtStyle1,),
                            const SizedBox(height: 10,),
                            Container(
                                height:18,
                                decoration:BoxDecoration(
                                    color:AppStyles.fadeGreenColor
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(' bid offer ', style:AppStyles.contentTxtStyle),
                                )),
                            const SizedBox(height: 2,),
                            Text((widget.model!.nextOfferAmount != null)?'₹${widget.model!.nextOfferAmount}':'₹0',style: AppStyles.numTxtStyle1),

                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 30,),
                    Expanded(
                        flex: 3,
                        child: Container(
                          height: 75,
                          color:AppStyles.fadePinkColor,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('auction time', style: AppStyles.greyTxtStyle1,),
                                Text(widget.model!.nextAuctionTime??'N/A', style: AppStyles.numTxtStyle1,),
                              ],
                            ),
                          ),
                        )
                    ),
                  ],
                ),

              ),
            ],
          )
          ],
        ),
      );
  }
}