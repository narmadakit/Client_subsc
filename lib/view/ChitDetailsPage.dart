import 'package:animations/animations.dart';
import 'package:client_subscriber/model/ChitDetailsModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Utils/AppStyles.dart';
import '../Utils/AppWidgets.dart';
import 'BidOfferScreen.dart';

class ChitDetailsPage extends StatefulWidget {
  final String? chitNo;
  final ChitDetailsModel? model;
  const ChitDetailsPage({Key? key, this.chitNo,this.model}) : super(key: key);

  @override
  _ChitDetailsPageState createState() => _ChitDetailsPageState();
}

class _ChitDetailsPageState extends State<ChitDetailsPage>
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
    return
      SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child:
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('VALUE  '.toLowerCase(), style: const TextStyle(
                          fontSize: 14, color: Colors.grey,fontWeight: FontWeight.w600)),
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade700.withOpacity(0.30),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          child:  Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text('  ₹${AppWidgets.formatCurrency.format(widget.model!.psubscriptionamt)}  ', style: const TextStyle(color: Colors.grey,fontSize: 11, fontWeight: FontWeight.w600),),
                          )),
                      const Spacer(),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text((widget.model!.pchitstatus=="P"?"prized":"non prized"),style: TextStyle(fontSize: 14, color: AppStyles.primaryColor,fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppStyles.fadePinkColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${widget.model!.psubscribername}',
                                        style: AppStyles.labelTxtStyle.copyWith(fontWeight: FontWeight.w600,fontSize: 12)),
                                    const SizedBox(height: 2,),
                                    Text('${widget.model!.pvchbranch}', style: AppStyles.contentTxtStyle.copyWith(fontSize: 10,color: Colors.white70),),
                                    const SizedBox(height: 2,),
                                    Text('${widget.model!.pchitno}', style: AppStyles.contentTxtStyle.copyWith(color: Colors.white70,fontSize: 10,fontWeight: FontWeight.w600),),
                                    const SizedBox(height: 2,),
                                    Container(
                                        color: Colors.red.shade800,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(' due date ', style: AppStyles.contentTxtStyle,),
                                        )),
                                    const SizedBox(height: 2,),
                                    // Text('06-jan-2024', style:  AppStyles.contentTxtStyle.copyWith(color: Colors.white70,fontSize: 12),),
                                    Text(DateFormat('dd-MMM-yyyy').format(DateTime.parse(widget.model!.pduedate.toString())), style:  AppStyles.numTxtStyle1,),

                                  ],
                                ),
                                const SizedBox(height: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: 90,
                                        height:18,
                                        color:Colors.white,
                                        child: Center(child: Text('previous due', style: AppStyles.contentTxtStyle.copyWith(color: Colors.red)))),
                                    const SizedBox(height: 2,),
                                    Text('₹${widget.model!.previousdue??'N/A'}', style: AppStyles.numTxtStyle1,),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(top:25.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 75,
                                  color: Colors.black,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('advance', style: AppStyles.greyTxtStyle1,),
                                        Text('₹${AppWidgets.formatCurrency.format(widget.model!.padvance)}', style: AppStyles.numTxtStyle1,),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        height: 18,
                                        width: 110,
                                        decoration:BoxDecoration(
                                            border: Border.all(color:Colors.white38)
                                        ),
                                        child: Center(child: Text('summit at credit', style: AppStyles.contentTxtStyle.copyWith(color: Colors.white)))),
                                    const SizedBox(height: 2,),
                                    Text('₹${AppWidgets.formatCurrency.format(widget.model!.psumatcredit)}',style:AppStyles.numTxtStyle1),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: AppStyles.gapHeight,),
                Padding(
                  padding: const  EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Previous Auction'.toLowerCase(), style: const TextStyle(
                          fontSize: 14, color: Colors.grey,fontWeight: FontWeight.w600)),
                      const Spacer(),
                      const Text('subscription ', style: TextStyle(color: Colors.grey,fontSize: 13),),
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
                              padding: const EdgeInsets.all(4.0),
                              child: Text('₹${AppWidgets.formatCurrency.format(widget.model!.psubscriptionamt)}',style: const TextStyle(color: Colors.white, fontSize: 11)),
                            ),
                          )),
                    ],
                  ),
                ),
                //------------ PREVIOUS AUCTION ---------
                SizedBox(height: AppStyles.gapHeight,),
                Padding(
                  padding: const  EdgeInsets.symmetric(horizontal: 5.0),
                  child: Container(
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
                ),

                //------------ NEXT AUCTION ---------
                SizedBox(height: AppStyles.gapHeight,),
                Padding(
                  padding: const  EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('NEXT AUCTION'.toLowerCase(), style: const TextStyle(
                          fontSize: 14, color: Colors.grey,fontWeight: FontWeight.w600)),
                      Padding(
                        padding: const EdgeInsets.only(right: 0.0),
                        child: OpenContainer(
                          tappable: false,
                          transitionType: _transitionType,
                          openBuilder: (context, action) {
                            return Container(
                            );
                          },
                          closedColor: Colors.grey.shade900.withOpacity(0.2),
                          closedElevation: 6.0,
                          closedBuilder: (BuildContext context, void Function() action) {
                            return Container(
                                width: 90,
                                height: 35,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [Colors.cyan, Colors.cyanAccent],
                                  ),
                                ),
                                child: Center(child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(' place bid ', textAlign: TextAlign.center,
                                        style: AppStyles.buttonTxtStyle.copyWith(color: Colors.black,fontWeight: FontWeight.w600)),
                                    Image.asset('assets/images/arrow-right.png',color: Colors.black,height: 13, ),
                                  ],
                                )));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppStyles.gapHeight,),
                Padding(
                  padding: const  EdgeInsets.symmetric(horizontal: 5.0,),
                  child: Container(
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
                )
              ],
            )
        ),
      );
  }
}