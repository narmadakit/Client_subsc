import 'dart:async';

import 'package:animations/animations.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../Utils/AppStyles.dart';
import '../Utils/AppWidgets.dart';
import '../Utils/ShimmerScreens.dart';
import '../bloc/Auction/AuctionBloc.dart';
import '../bloc/Auction/AuctionEvent.dart';
import '../bloc/Auction/AuctionState.dart';
import '../model/AuctionReponse.dart';
import 'BidOfferScreen.dart';

class AuctionScreen extends StatefulWidget {
  const AuctionScreen({super.key});

  @override
  State<AuctionScreen> createState() => _AuctionScreenState();
}

class _AuctionScreenState extends State<AuctionScreen> {
  int _start = 5;
  late Timer timer;
  bool isLoading=false;
  bool isShimmerLoading=true;
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;
  List<AuctionReponse> listData=[];
  late AuctionLoadedState loadedState = AuctionLoadedState(listData);

  var hour;
  var minute ;
  var second ;

  void callResourceTimer() {
    const oneSec = const Duration(seconds: 5);
    timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          callApi();
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
  void _stopTimer() {
    timer.cancel();
    // Do something when the timer is stopped, like navigate to another screen
  }
  callApi(){
      context.read<AuctionBloc>().add(GetAuctionDetailsEvent('8985812695'));
  }

  @override
  void initState() {
    BlocProvider.of<AuctionBloc>(context).add(
        GetAuctionDetailsEvent('8985812695'));
    print('isShimmerLoading------------$isShimmerLoading');
    callResourceTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyles.bgColor,
        title: Text('Auctions',style: AppStyles.headingTxtStyle,),
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
        actions: [
          IconButton(onPressed: () => _modalBottomSheetMenu(context), icon: const Icon(Icons.more_vert,color: Colors.white,))
        ],
      ),
      body: BlocConsumer<AuctionBloc,AuctionState>(
        builder: (context, state) {
          print('Initial state++++++++++ $state');
          if(state is AuctionInitialState){
            // return ShimmerScreens.shimmerLoader();
            return Container(
              height: 200,
              color: Colors.red,
            );
          }
          return buildBody();
        },
        listener: (context, state) {
          if (state is AuctionErrorState) {
            Center(
              child: Lottie.asset("assets/lotties/nointernet.json",
                  // height:  size.height / 4
              ),
            );
          }
          else if(state is AuctionLoadingState){
            isLoading = true;
          }else
            if (state is AuctionLoadedState) {
            loadedState= state;
            isLoading = false;
          }
        },
      ),
    );
  }
  Widget buildBody() {
    return
      Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Visibility(
            visible: isLoading,
            child: const Center(
              child: CircularProgressIndicator(color: Colors.blue,),
            ),
          ),
        ),
        Padding(
          padding: AppStyles.screenPaddingH,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: loadedState.model.length,
            itemBuilder: (context, index) {
            if((loadedState.model[index].auctionstatus.toString().trim() != "Auction Running")
                && (loadedState.model[index].auctionstatus.toString().trim() != "Auction Delayed")
                && (loadedState.model[index].auctionstatus.toString().trim() != "Auction Completed")){
              var s =loadedState.model[index].auctionstatus;
              var onee= s!.split(":")[0].trim();
              var twoo= s.split(":")[1].trim();
              var three= s.split(":")[2].trim();
               hour = onee[0];
               minute = twoo.split(" ")[0];
               second = three.split(" ")[0];
            }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(loadedState.model[index].vchsubscribername.toString(),style: AppStyles.blackTxtStyle.copyWith(fontSize: 15,fontWeight: FontWeight.bold),),
                                Text(loadedState.model[index].chitno.toString(),style: AppStyles.headingTxtStyle1.copyWith(color: Colors.black)),
                              ],
                            )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Branch'.toUpperCase(),style: AppStyles.blackTxtStyle.copyWith(fontWeight: FontWeight.w500,color: Colors.black54)),
                                Text(loadedState.model[index].vchbranchname.toString(),style: AppStyles.valueTextStyle.copyWith(color: Colors.black)),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    color: Colors.grey,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 7.0,vertical: 2),
                                      child: Text('Auction time'.toUpperCase(),style: AppStyles.contentTxtStyle),
                                    )),
                                Row(
                                  children: [
                                    Text(loadedState.model[index].serverdate.toString(),style: AppStyles.headingTxtStyle1.copyWith(color: Colors.black)),
                                    SizedBox(width: 15,),
                                    Text(loadedState.model[index].vchaucttime.toString(),style: AppStyles.headingTxtStyle1.copyWith(color: AppStyles.fadeGreenColor)),
                                  ],
                                ),
                              ],
                            ),
                            Expanded(child: Container()),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      color: Colors.green,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 7.0,vertical: 2),
                                        child: Text('Value'.toUpperCase(),style: AppStyles.contentTxtStyle),
                                      )),
                                  Text('₹${AppWidgets.formatCurrency.format(loadedState.model[index].chitvalue)}',style: AppStyles.headingTxtStyle1.copyWith(color: Colors.black)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: DottedLine(
                            dashLength: 4,
                            dashGapLength: 5,
                            lineThickness: 0.9,
                            dashGradient: [Colors.orangeAccent, Colors.blue],
                          ),
                        ),
                        // InkWell(
                        //   onTap: () {
                        //     Navigator.push(context, MaterialPageRoute(builder: (context) =>BidOfferScreen(
                        //       groupCode: loadedState.model[index].vchgrpcode,
                        //       branchName: loadedState.model[index].vchbranchname,
                        //       auctionMonth: loadedState.model[index].auctmonth,
                        //       subscriberName: loadedState.model[index].vchsubscribername,
                        //       ticketno: loadedState.model[index].numticketno.toString(),
                        //       chitNo: loadedState.model[index].chitno.toString(),
                        //     )));
                        //
                        //   },
                        //   child: Container(
                        //           width: 90,
                        //           height: 35,
                        //           decoration: const BoxDecoration(
                        //             gradient: LinearGradient(
                        //               begin: Alignment.topLeft,
                        //               end: Alignment.bottomRight,
                        //               colors: [Colors.cyan, Colors.cyanAccent],
                        //             ),
                        //           ),
                        //           child: Center(child: Row(
                        //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //             children: [
                        //               Text(' place bid ', textAlign: TextAlign.center,
                        //                   style: AppStyles.buttonTxtStyle.copyWith(color: Colors.black,fontWeight: FontWeight.w600)),
                        //               Image.asset('assets/images/arrow-right.png',color: Colors.black,height: 13, ),
                        //             ],
                        //           ))),
                        // ),

                        (loadedState.model[index].auctionstatus.toString().trim() == "Auction Delayed" || loadedState.model[index].auctionstatus == "Auction Completed")?
                        Text(loadedState.model[index].auctionstatus.toString(),
                            style: AppStyles.blackTxtStyle.copyWith(
                              color: AppStyles.fadePinkColor,
                                // color: (loadedState.model[index].auctionstatus == "Auction Delayed")?AppStyles.fadePinkColor:(loadedState.model[index].auctionstatus == "Auction Completed")?AppStyles.fadeGreenColor: Colors.black,
                                fontWeight: FontWeight.bold,fontSize: 14))
                        : (loadedState.model[index].auctionstatus == "Auction Running")?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(loadedState.model[index].auctionstatus.toString(),
                                style: AppStyles.blackTxtStyle.copyWith(
                                    color: Colors.cyan,
                                    fontWeight: FontWeight.bold,fontSize: 14)),
                            OpenContainer(
                              transitionType: _transitionType,
                              tappable: false,
                              openBuilder: (context, action) {
                                return Container();
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
                                        Text(' Participate '.toLowerCase(), textAlign: TextAlign.center,
                                            style: AppStyles.buttonTxtStyle.copyWith(color: Colors.black,fontWeight: FontWeight.w600)),
                                        Image.asset('assets/images/arrow-right.png',color: Colors.black,height: 13,),
                                      ],
                                    )));
                              },
                            )
                          ],
                        )
                        :Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('your auction will start in',style: AppStyles.blackTxtStyle.copyWith(color: AppStyles.fadePinkColor)),
                          SizedBox(height: 2,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TimerCountdown(
                                  format: CountDownTimerFormat.hoursMinutesSeconds,
                                  enableDescriptions: true,
                                  descriptionTextStyle: const TextStyle(color: Colors.black54,fontSize: 12, fontWeight: FontWeight.w500),
                                  spacerWidth: 3,
                                  timeTextStyle: AppStyles.blackTxtStyle.copyWith(fontWeight: FontWeight.bold,fontSize: 14),
                                  colonsTextStyle: AppStyles.blackTxtStyle.copyWith(fontWeight: FontWeight.bold,fontSize: 14),
                                  endTime: DateTime.now().add(
                                    Duration(
                                      hours: int.parse(hour),
                                      minutes: int.parse(minute),
                                      seconds: int.parse(second),
                                    ),
                                  ),
                                  onEnd: () {
                                    print("Timer finished");
                                  },
                                ),
                                OpenContainer(
                                  transitionType: _transitionType,
                                  openBuilder: (context, action) {
                                    return  BidOfferScreen(
                                      groupCode: loadedState.model[index].vchgrpcode,
                                      branchName: loadedState.model[index].vchbranchname,
                                      auctionMonth: loadedState.model[index].auctmonth,
                                      subscriberName: loadedState.model[index].vchsubscribername,
                                      ticketno: loadedState.model[index].numticketno.toString(),
                                      chitNo: loadedState.model[index].chitno.toString(),
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
                                )
                              ],
                            )
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

}


_modalBottomSheetMenu(BuildContext context){
  showModalBottomSheet(
      clipBehavior: Clip.antiAlias,
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
      ),
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text('Monthly'),
              onTap: () {
                print('Monthly');
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('User Defined'),
              onTap: () {
                print('User Defined');
              },
            ),
          ],
        );
      });
}
