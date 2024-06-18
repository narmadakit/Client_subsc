import 'package:flutter/material.dart';

import '../Utils/AppStyles.dart';
import '../Utils/AppWidgets.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWidgets.appbarWidget('Confirm to pay', () => Navigator.pop(context),context),
      body: Padding(
        padding: AppStyles.screenPaddingH.copyWith(bottom: 10),
        child: ListView(
          children: [
            Card(
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
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text('Hema Priya'),
                          const Spacer(),
                          SizedBox(
                            width: 110,
                            child: Row(
                              children: [
                                IconButton(onPressed: () {
                                },
                                icon: const Icon(Icons.delete_outline_rounded,color: Colors.red,size: 16,)),

                                IconButton(onPressed: () {
                                },
                                    icon: const Icon(Icons.edit_outlined,color: Colors.green,size: 16,))
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5,),
                      const Row(
                        children: [
                          Text('10LGC002'),
                          Spacer(),
                          SizedBox(
                            width: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                                                     children: [
                             Text('Total Due'),
                             Text('25878'),

                                                     ],
                            ),
                          )
                          ],
                      ),
                      const SizedBox(height: 5,),
                      const Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Value'),
                              Text('1000000'),
                            ],
                          ),
                          Spacer(),
                          SizedBox(
                            width: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Paying Amount'),
                                Text('25878'),

                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
