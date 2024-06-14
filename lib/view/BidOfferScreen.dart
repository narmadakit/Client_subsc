import 'dart:convert';
import 'package:client_subscriber/bloc/Auction/AuctionBloc.dart';
import 'package:client_subscriber/bloc/BidOffer/BidOfferBloc.dart';
import 'package:client_subscriber/bloc/BidOffer/BidOfferState.dart';
import 'package:client_subscriber/model/SaveBidOfferRequest.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Utils/AppStyles.dart';
import '../Utils/AppWidgets.dart';
import '../Utils/styles.dart';

import '../bloc/BidOffer/BidOfferEvent.dart';

class BidOfferScreen extends StatefulWidget {
  final String? groupCode;
  final String? branchName;
  final num? auctionMonth;
  final String? subscriberName;
  final String? ticketno;
  final String? chitNo;
  const BidOfferScreen({Key? key,
     this.groupCode,this.branchName, this.auctionMonth,this.subscriberName,this.ticketno,this.chitNo});

  @override
  State<BidOfferScreen> createState() => _BidOfferScreenState();
}

class _BidOfferScreenState extends State<BidOfferScreen> {
  var bidOfferController = TextEditingController();
  String? maxDiscount;
  String? minDiscount;
  SaveBidOfferRequest saveBidOfferRequest =SaveBidOfferRequest();

  @override
  void initState() {
    context.read<BidOfferBloc>().add(GetMaxBidEvent(widget.groupCode,widget.branchName,widget.auctionMonth));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppStyles.bgColor,
      appBar: AppWidgets.appbarWidget('Bid Offer', () => Navigator.pop(context),context),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Image.asset('assets/images/user_new.png', height: 35,),
                      Text('   ${widget.subscriberName}', style: AppStyles.headingTxtStyle,)
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text('Chit no'.toLowerCase(),style: AppStyles.greyTxtStyle,),
                            Text('${widget.chitNo}',style: AppStyles.valueTextStyle,)
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text('Branch'.toLowerCase(),style: AppStyles.greyTxtStyle,),
                            Text('${widget.branchName}',style: AppStyles.valueTextStyle)
                          ],
                        ),
                      ),

                    ],
                  ),
                  const SizedBox(height: 10,),
                  BlocConsumer<BidOfferBloc,BidofferState>(
                    builder: (context, state) {
                      if (state is BidLoadedState) {
                        maxDiscount = state.bidOfferResponse.maxDiscount;
                        minDiscount = state.bidOfferResponse.minDiscount;
                        return Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text('maximum bid offer',style: AppStyles.greyTxtStyle,),
                                  Text('₹${minDiscount}',style: AppStyles.valueTextStyle,)
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text('maximum discount allowed'.toLowerCase(),style: AppStyles.greyTxtStyle,),
                                  Text('₹${maxDiscount}',style: AppStyles.valueTextStyle.copyWith(color: AppStyles.fadePinkColor,fontWeight: FontWeight.w800))
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                      else {
                        return Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text('maximum bid offer',style: AppStyles.greyTxtStyle,),
                                  Text('₹${minDiscount??0}',style: AppStyles.valueTextStyle,)
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text('maximum discount allowed'.toLowerCase(),style: AppStyles.greyTxtStyle,),
                                  Text('₹${maxDiscount??0}',style: AppStyles.valueTextStyle.copyWith(color: AppStyles.fadePinkColor,fontWeight: FontWeight.w800))
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                    },
                    listener: (context, state) {
                      if(state is BidInitialState){
                        BlocProvider.of<BidOfferBloc>(context).add(
                            GetMaxBidEvent(widget.groupCode,widget.branchName,widget.auctionMonth));
                      }
                    },
                  ),
                  const SizedBox(height: 30,),
                  DottedBorder(
                    color: Colors.grey.shade800,
                    strokeWidth: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: bidOfferController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            style: const TextStyle(color: Colors.white,fontSize: 13),
                            decoration: InputDecoration(
                              counterText: "",
                              hintText: 'Add bid offer'.toLowerCase(),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                              hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13
                                // fontWeight: FontWeight.w400
                              ),
                            ),
                          ),
                          SizedBox(height: AppStyles.gapHeight,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 30.0, left: 10, right: 10, top: 5),
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
              child: BlocConsumer<BidOfferBloc,BidofferState>(
                builder: (context, state) {
                  if(state is SaveBidLoadingState){
                    return const Padding(
                        padding: EdgeInsets.all(2),
                        child: Center(child:
                        CircularProgressIndicator(color: Colors.black,)
                        ));
                  }
                  else {
                    return InkWell(
                      onTap: () async {
                        saveBidOfferRequest.branchName = widget.branchName;
                        saveBidOfferRequest.subscriberName = widget.subscriberName;
                        saveBidOfferRequest.groupcode = widget.groupCode;
                        saveBidOfferRequest.auctionMonth = widget.auctionMonth.toString();
                        saveBidOfferRequest.maxDiscount = maxDiscount;
                        saveBidOfferRequest.minDiscount = minDiscount;
                        saveBidOfferRequest.offerAmount = bidOfferController.text;
                        saveBidOfferRequest.ticketno = widget.ticketno.toString();
                        BlocProvider.of<BidOfferBloc>(context).add(SaveBidOfferEvent(saveBidOfferRequest));
                        await Future.delayed(const Duration(seconds: 2));
                        BlocProvider.of<BidOfferBloc>(context).add(GetMaxBidEvent(saveBidOfferRequest.groupcode,saveBidOfferRequest.branchName,widget.auctionMonth));
                      },
                      child: Center(
                        child: Text(
                          "Proceed".toUpperCase(),
                          style: getLoginTextStyle(fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Colors.black),
                        ),
                      ),
                    );
                  }
                },
                listener: (context, state) {
                if(state is SaveBidErrorState){
                  AppWidgets.showSnackBar(context, '${state.saveBidOfferResponse.statusmsg}',Colors.red);
                }
                if(state is SaveBidSuccessState){
                  AppWidgets.showSnackBar(context, '${state.saveBidOfferResponse.statusmsg}',Colors.green);
                }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
