import 'package:client_subscriber/bloc/ChitDetails/ChitDetailsBloc.dart';
import 'package:client_subscriber/bloc/ChitDetails/ChitDetailsEvent.dart';
import 'package:client_subscriber/bloc/ChitDetails/ChitDetailsState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Utils/AppStyles.dart';
import '../Utils/AppWidgets.dart';
import '../Utils/ShimmerScreens.dart';
import 'ChitDetailsPage.dart';
import 'DemoUi.dart';
import 'TransactionDetailsScreen.dart';

class ChitDetailsTab extends StatefulWidget {
  final String? chitNo;
  const ChitDetailsTab({Key? key, this.chitNo}) : super(key: key);

  @override
  _ChitDetailsTabState createState() => _ChitDetailsTabState();
}

class _ChitDetailsTabState extends State<ChitDetailsTab>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chit Details', style: AppStyles.headingTxtStyle),
          toolbarHeight: 50,
          elevation: 0.4,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal:  15.0),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                'assets/images/arrow-left.png',
                color: Theme.of(context).indicatorColor,
              ),
            ),
          ),
          bottom: TabBar(
            dividerHeight: 0.1,
            tabs: [
              Tab(child: Text('Chit Details'.toUpperCase(),style: AppStyles.valueTextStyle,)),
              Tab(child: Text('Transaction Details'.toUpperCase(),style: AppStyles.valueTextStyle))
            ],
            indicatorColor: AppStyles.fadePinkColor,
            labelColor: Colors.grey,
            // unselectedLabelStyle: TextStyle(color: Colors.black),
          ),
        ),
        body: BlocBuilder<ChitDetailsBloc,ChitDetailsState>(
          builder: (context, state) {
            if (state is DetailsInitialState) {
              BlocProvider.of<ChitDetailsBloc>(context).add(
                  GetChitDetailsByTicket(widget.chitNo.toString()));
              return
                ShimmerScreens.shimmerLoader();
            }
            if(state is DetailsLoadedState){
              return TabBarView(children: [
                DemoUI(model: state.model,chitNo: widget.chitNo),
                // ChitDetailsPage(model: state.model,chitNo: widget.chitNo,),
                TransactionDetailsScreen(state.model.lstSubscribertransDTO!)
              ]);
            }
            else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}