
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Utils/AppStyles.dart';
import '../Utils/AppWidgets.dart';
import '../model/ChitDetailsModel.dart';

class TransactionDetailsScreen extends StatefulWidget {
  final List<LstSubscribertransDTO> transDetails;
  TransactionDetailsScreen(this.transDetails, {super.key});
  @override
  State<TransactionDetailsScreen> createState() => _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<TransactionDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: (i % 2 == 0) ? Colors.grey.shade900: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppStyles.fadePinkColor.withOpacity(0.1))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('TRANSACTION NO : '.toLowerCase(), style: AppStyles.greyTxtStyle,),
                            Text('${widget.transDetails[i].ptransno}', style: AppStyles.valueTextStyle.copyWith(fontSize: 11,fontWeight: FontWeight.w600),),
                            const Spacer(),
                            Text('PAID AMOUNT'.toLowerCase(), style: AppStyles.greyTxtStyle,),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('DATE : '.toLowerCase(), style: AppStyles.greyTxtStyle,),
                            Text(DateFormat('dd-MMM-yyyy').format(DateTime.parse(widget.transDetails[i].ptransdate.toString())), style: AppStyles.valueTextStyle.copyWith(fontSize: 11,fontWeight: FontWeight.w600),),
                            const Spacer(),
                            Text('₹${AppWidgets.formatCurrency.format(widget.transDetails[i].ptotalamount)}', style: AppStyles.valueTextStyle.copyWith(fontSize: 11,color: AppStyles.fadePinkColor,fontWeight: FontWeight.w600),),
                          ],
                        ),

                      ],
                    ),
                  )),
            );
          },
          itemCount: 3,
        ),
      ),
    );
  }
}
