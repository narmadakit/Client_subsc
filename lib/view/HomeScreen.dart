import 'package:animations/animations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:client_subscriber/view/AllChitsScreen.dart';
import 'package:client_subscriber/view/AuctionsScreen.dart';
import 'package:client_subscriber/view/LoginScreen.dart';
import 'package:client_subscriber/bloc/AllChit/AllChitsBloc.dart';
import 'package:client_subscriber/bloc/AllChit/AllChitsEvent.dart';
import 'package:client_subscriber/bloc/AllChit/AllChitsState.dart';
import 'package:client_subscriber/model/LoginResponse.dart';
import 'package:client_subscriber/view/ResetPinScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../utils/AppStyles.dart';
import '../utils/AppWidgets.dart';
import '../utils/SharedPref.dart';
import '../utils/ShimmerScreens.dart';
import 'MoreScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool isPlaying = false;
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;
  var sharedpref = SharedPref();

  final CarouselController _controller = CarouselController();
  int _current = 0;
  bool isloader = false;
  double _fabDimension = 56.0;
  bool isAlertVisible = true;
  var prefs = SharedPref();
  LoginResponse loginData = LoginResponse();

  final checked = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List imageSliders = [
    'https://www.freecodecamp.org/news/content/images/size/w2000/2021/06/w-qjCHPZbeXCQ-unsplash.jpg',
    'https://img.freepik.com/free-vector/hand-painted-watercolor-pastel-sky-background_23-2148902771.jpg',
    'https://www.mypaisaa.com/blog/wp-content/uploads/2021/09/6.-Yes-Chit-funds.png'
  ];

  @override
  initState() {
    super.initState();
    isloader = true;
    getLogindata();

    // _animationController =
    //     AnimationController(vsync: this, duration: const Duration(seconds: 1));
    //
    // _animationController.forward();
  }

  getLogindata() async {
    loginData = LoginResponse.fromJson(await prefs.read("loginData"));
    // AppWidgets.gMobileNo = loginData.pmobileno;
  }

  // @override
  // void dispose() {
  //   _animationController.dispose();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: false,
          leadingWidth: 0,
          automaticallyImplyLeading: false,
          title: Text('Hello Subscriber!'.toLowerCase(),
            style:AppStyles.headingTxtStyle.copyWith(fontSize: 19),
          ),
        ),
        body:
      BlocConsumer<AllChitsBloc,AllChitsState>(
        listener: (context, state) {
          if (state is ChitErrorState) {
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                content: Text("Error", style: TextStyle(),),
              ),
            );
          }
        },
        builder: (BuildContext context, AllChitsState state) {
          if (state is ChitsInitialState) {
            BlocProvider.of<AllChitsBloc>(context).add(
                GetChitDetailsEvent(loginData.pmobileno.toString()));
            return
              ShimmerScreens.shimmerLoader();
          }
          if (state is ChitLoadedState) {
            return buildBody(context,state);
          }
          else {
            return Container();
          }
        },
      ),
    );

    //   BlocConsumer<NetworkBloc,NetworkState>(
    //   listener: (context, state) {
    //     if(state is InternetLostState){
    //        Container(child: Text('Internet Not COnnected'));
    //     }
    //   },
    //   builder: (context, state) {
    //   if(state is InternetGainState){
    //     return SafeArea(
    //       child:
    //       Scaffold(
    //         backgroundColor: AppStyles.bgColor,
    //         key: _scaffoldKey,
    //         appBar: AppBar(
    //           toolbarHeight: 60,
    //           centerTitle: false,
    //           leadingWidth: 0,
    //           backgroundColor: AppStyles.bgColor,
    //           title: Text('Hello Subscriber!', style: getAppbarTextStyle(),),
    //         ),
    //         body:
    //         BlocConsumer<ChitListBloc,ChitListState>(
    //           listener: (context, state) {
    //             if (state is ChitErrorState) {
    //               showDialog(
    //                 context: context,
    //                 builder: (context) => const AlertDialog(
    //                   content: Text("Error", style: TextStyle(color: Colors.white70),),
    //                 ),
    //               );
    //             }
    //           },
    //           builder: (BuildContext context, ChitListState state) {
    //             if (state is ChitsInitialState) {
    //               BlocProvider.of<ChitListBloc>(context).add(
    //                   GetChitDetailsEvent(loginData.pmobileno.toString()));
    //               return
    //                 ShimmerScreens.shimmerLoader();
    //             }
    //             if (state is ChitLoadedState) {
    //               return buildBody(context,state);
    //             }
    //             else {
    //               return Container();
    //             }
    //
    //           },
    //
    //         ),
    //       ),
    //     );
    //   }
    //   return Container();
    //   },
    //
    // );
  }


  Widget buildBody(BuildContext context, ChitLoadedState state){
    return ListView(
      shrinkWrap: true,
      children: [
        Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: isAlertVisible,
                  child:
                  Padding(
                    padding: AppStyles.screenPaddingH,
                    child:  Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.amberAccent.shade200,
                        borderRadius: BorderRadius.circular(12),
                        // border: const Border(
                        //   top: BorderSide( //                    <--- top side
                        //     color: Colors.black,
                        //     width: 0.5,
                        //   ),
                        // ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Expanded(
                            child:  Shimmer.fromColors(
                              baseColor: Colors.black,
                              highlightColor: Colors.white30,
                              period: const Duration(milliseconds: 5000),
                              direction: ShimmerDirection.rtl,
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text('your subscription due expired your subscription due expired',
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    maxLines: 3,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isAlertVisible = false;
                                  });
                                },
                                child:  Image.asset('assets/images/close_circle.png',height: 15, ),
                                ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Column(children: [
                  const SizedBox(height: 15,),
                  Padding(
                    padding: AppStyles.screenPaddingH,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Text('pay and \nmanage your chits',
                          style:  AppStyles.headingTxtStyle,
                        ),
                        OpenContainer(
                          transitionType: _transitionType,
                          openBuilder: (context, action) {
                            return const AllChitsScreen(
                            );
                          },
                          closedColor: Colors.grey.shade900.withOpacity(0.2),
                          closedElevation: 6.0,
                          closedBuilder: (context, action) {
                            return Container(
                                width: 90,
                                height: 35,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [Colors.cyan, Colors.cyanAccent],
                                  ),
                                  // color: Colors.green.shade800,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(' Pay Now  '.toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: AppStyles.buttonTxtStyle.copyWith(color: Colors.black,fontWeight: FontWeight.w600)
                                      ),
                                      Image.asset('assets/images/arrow-right.png',color: Colors.black,height: 13, ),
                                    ],
                                  ),
                                ));
                          },
                        )
                      ],
                    ),
                  ),
                  // Divider(),
                  const SizedBox(height: 15,),
                  Container(
                    height: 90,
                    child: Padding(
                      padding: AppStyles.screenPaddingH,
                      // child: Scrollbar(
                      //   thickness: 0.7,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 1,
                          scrollDirection: Axis.horizontal,
                          itemBuilder:(context, index) {
                            int chitvalue=0;
                            int totDividend=0;
                            int totDue=0;
                            for(var a in state.model){
                              chitvalue += (a.pchitvalue != null)?a.pchitvalue!:0;
                              totDividend += (a.pnumdividend != null)?a.pnumdividend!:0;
                              totDue += (a.ptotaldue != null)?a.ptotaldue!:0;
                            }
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                OpenContainer(
                                  transitionType: _transitionType,
                                  openBuilder: (context, action) {
                                    return const AllChitsScreen(
                                    );
                                  },
                                  closedColor:Colors.grey.shade900.withOpacity(0.90),
                                  closedElevation: 6.0,
                                  closedShape: const RoundedRectangleBorder(
                                    // side: BorderSide(color:Colors.grey.shade800.withOpacity(0.2)),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12.0 ),
                                    ),
                                  ),
                                  closedBuilder: (context, action) {
                                    return Container(
                                      height: 90,
                                      decoration: BoxDecoration(
                                        color:Colors.cyanAccent.withOpacity(0.06),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Image.asset('assets/images/give-money.png',height: 22,color: Colors.white, ),
                                                const SizedBox(width: 10,),
                                                Row(
                                                    children: [
                                                      Text('Total Chits'.toLowerCase(),
                                                          style: AppStyles.greyTxtStyle
                                                      ),
                                                       Text(' ${state.model.length} ',
                                                          style: AppStyles.numTxtStyle
                                                      )
                                                    ]
                                                ) ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text('Value '.toLowerCase(),
                                                    style: AppStyles.greyTxtStyle
                                                ),
                                                const SizedBox(width: 10,),
                                                Text('₹${AppWidgets.formatCurrency.format(chitvalue)}',
                                                    style: AppStyles.numTxtStyle
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(width: 8,),
                                OpenContainer(
                                  transitionType: _transitionType,
                                  tappable:false,
                                  closedColor:Colors.grey.shade900.withOpacity(0.90),
                                  closedElevation: 6.0,
                                  closedShape: const RoundedRectangleBorder(
                                    // side: BorderSide(color:Colors.grey.shade800.withOpacity(0.2)),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12.0 ),
                                    ),
                                  ),
                                  closedBuilder: (BuildContext context, void Function() action) {
                                    return  AppWidgets.miniCardWidget(context,
                                        Icons.pending_actions, '₹',
                                        AppWidgets.formatCurrency.format(totDue), 'Total dues'.toLowerCase());
                                  },
                                  openBuilder: (context, action) {
                                    return Container();
                                  },
                                ),
                                const SizedBox(width: 8,),
                                OpenContainer(
                                  transitionType: _transitionType,
                                  tappable:false,
                                  closedColor:Colors.grey.shade900.withOpacity(0.90),
                                  closedElevation: 6.0,
                                  closedShape: const RoundedRectangleBorder(
                                    // side: BorderSide(color:Colors.grey.shade800.withOpacity(0.2)),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12.0 ),
                                    ),
                                  ),
                                  closedBuilder: (context, action) {
                                    return AppWidgets.miniCardWidget(context,
                                        Icons.savings, '₹',
                                        AppWidgets.formatCurrency.format(totDividend), 'Dividends\nGained'.toLowerCase());
                                  },
                                  openBuilder: (context, action) {
                                    return Container();
                                  },
                                )
                              ],
                            );
                          }, ),
                      // ),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  CarouselSlider.builder(
                    carouselController: _controller,
                    options: CarouselOptions(
                      height: 200.0,
                      aspectRatio: 0.18,
                      enlargeCenterPage: true,
                      viewportFraction: 1,
                      autoPlay: true,
                      autoPlayAnimationDuration: const Duration(milliseconds: 2000),
                      autoPlayInterval: const Duration(seconds: 4),
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      },
                    ),
                    itemCount: imageSliders.length,
                    itemBuilder: (context, index, realIndex) {
                      return
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Stack(
                              children:[
                                (index == 0)?
                                Container(
                                    width: double.infinity,
                                    color: AppStyles.fadeGreenColor):
                                (index.isOdd)?
                                Container(
                                    width: double.infinity,
                                    color: AppStyles.fadePinkColor)
                                    : Container(
                                    width: double.infinity,
                                    color: AppStyles.purpleColor),
                                Positioned(
                                    top: 10,
                                    left: 10,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 100,
                                        child: const Text('KAPIL BUSINESS PARK',
                                          style: TextStyle(color: Colors.white, fontSize: 20),),
                                      ),
                                    )),

                                Positioned(
                                    bottom: 25,
                                    left: 10,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 150,
                                        child: const Text('Earn monthly rent 18000/-',
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),),
                                      ),
                                    )),

                                Positioned(
                                    bottom: 10,
                                    right: 10,
                                    child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.white,width: 0.5),
                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => const LoginScreen()),
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                Text('Details  ',
                                                    textAlign: TextAlign.center,
                                                    style: AppStyles.underlineButtonTxtStyle),
                                                Image.asset('assets/images/arrow-right.png',color: Colors.white,height: 13, ),
                                              ],
                                            ),
                                          ),
                                        )))
                              ]
                          ),
                        );
                    },
                    // imageSlider
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imageSliders.map((url) {
                      int index = imageSliders.indexOf(url);
                      return Container(
                        width: 7.0,
                        height: 7.0,
                        margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 7.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: _current == index
                              ? Colors.pink
                              : Theme.of(context).iconTheme.color,
                        ),
                      );
                    }).toList(),
                  ),
                ],
                ),
                Padding(
                  padding: AppStyles.screenPaddingH,
                  child: Card(
                    color: Theme.of(context).splashColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                      color: Theme.of(context).splashColor,
                        border: Border.all(
                            color:Theme.of(context).dividerColor,
                            width:  0.2
                        ),
                         borderRadius: const BorderRadius.all(Radius.circular(15.0),
                          ),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      OpenContainer(
                                        transitionType: _transitionType,
                                        openBuilder: (BuildContext context, VoidCallback _) {
                                          return const AllChitsScreen(
                                          );
                                        },
                                        closedElevation: 6.0,
                                        closedColor:Colors.grey.shade900.withOpacity(0.90),
                                        closedShape:  const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30.0 ),
                                          ),
                                        ),
                                        // closedColor: Colors.red.shade900.withOpacity(0.90),
                                        closedBuilder: (BuildContext context, VoidCallback openContainer) {
                                          return Container(
                                            height: _fabDimension,
                                            width: _fabDimension,
                                            decoration: BoxDecoration(
                                              color:Colors.cyanAccent.withOpacity(0.06),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(AppStyles.iconPadding),
                                              child:Image.asset('assets/images/give-money.png',color: Colors.white, ),
                                            ),
                                          );
                                        },
                                      ),
                                      Text('my chits', style: AppStyles.labelTxtStyle),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      OpenContainer(
                                        transitionType: _transitionType,
                                        // tappable: false,
                                        openBuilder: (BuildContext context, VoidCallback _) {
                                          return const AuctionScreen(
                                            // includeMarkAsDoneButton: false,
                                          );
                                        },
                                        closedElevation: 6.0,
                                        closedColor:Colors.grey.shade900.withOpacity(0.90),
                                        closedShape:  const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30.0 ),
                                          ),
                                        ),
                                        closedBuilder: (BuildContext context, VoidCallback openContainer) {
                                          return Container(
                                            height: _fabDimension,
                                            width: _fabDimension,
                                            decoration: BoxDecoration(
                                              color:Colors.cyanAccent.withOpacity(0.06),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(AppStyles.iconPadding),
                                              child:Image.asset('assets/images/auction.png', color: Colors.white, ),
                                            ),
                                          );
                                        },
                                      ),
                                      Text('auctions', style: AppStyles.labelTxtStyle,),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      OpenContainer(
                                        transitionType: _transitionType,
                                        // tappable: false,
                                        openBuilder: (BuildContext context, VoidCallback _) {
                                          return const ResetPinScreen(
                                          );
                                        },
                                        closedElevation: 6.0,
                                        closedShape:  const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30.0 ),
                                          ),
                                        ),
                                        closedColor: Colors.grey.shade900.withOpacity(0.90),
                                        closedBuilder: (BuildContext context, VoidCallback openContainer) {
                                          return Container(
                                            height: _fabDimension,
                                            width: _fabDimension,
                                            decoration: BoxDecoration(
                                              color:Colors.cyanAccent.withOpacity(0.06),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(AppStyles.iconPadding),
                                              child:Image.asset('assets/images/reset-pin.png',color: Colors.white, ),
                                            ),
                                          );
                                        },
                                      ),
                                      Text('pin reset', style: AppStyles.labelTxtStyle,),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      OpenContainer(
                                        transitionType: _transitionType,
                                        tappable: false,
                                        openBuilder: (BuildContext context, VoidCallback _) {
                                          return const LoginScreen(
                                          );
                                        },
                                        closedElevation: 6.0,
                                        closedShape:  const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30.0 ),
                                          ),
                                        ),
                                        closedColor: Colors.grey.shade900.withOpacity(0.90),
                                        closedBuilder: (BuildContext context, VoidCallback openContainer) {
                                          return Container(
                                            height: _fabDimension,
                                            width: _fabDimension,
                                            decoration: BoxDecoration(
                                              color:Colors.cyanAccent.withOpacity(0.06),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(AppStyles.iconPadding),
                                              child:Image.asset('assets/images/reset-pin.png',color: Colors.white, ),
                                            ),
                                          );
                                        },
                                      ),
                                      Text('About us'.toLowerCase(), style: AppStyles.labelTxtStyle,),
                                    ],
                                  ),

                                  Column(
                                    children: [
                                      OpenContainer(
                                        transitionType: _transitionType,
                                        openBuilder: (BuildContext context, VoidCallback _) {
                                          return const MoreScreen(
                                            // includeMarkAsDoneButton: false,
                                          );
                                        },
                                        closedElevation: 6.0,
                                        closedShape:  const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30.0 ),
                                          ),
                                        ),
                                        closedColor: Colors.grey.shade900.withOpacity(0.90),
                                        closedBuilder: (BuildContext context, VoidCallback openContainer) {
                                          return Container(
                                            height: _fabDimension,
                                            width: _fabDimension,
                                            decoration: BoxDecoration(
                                              color:Colors.cyanAccent.withOpacity(0.06),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(AppStyles.iconPadding),
                                              child:Image.asset('assets/images/verified.png',color: Colors.white, ),
                                            ),
                                          );
                                        },
                                      ),
                                      Text('more', style: AppStyles.labelTxtStyle,),
                                    ],
                                  ),

                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (_) {
                                                return Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: AlertDialog(
                                                    alignment: Alignment.bottomCenter,
                                                    backgroundColor: Colors.black,
                                                    shape: const RoundedRectangleBorder(
                                                      side: BorderSide(color: Colors.white,width: 0.4),
                                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                                    ),
                                                    // elevation: 5,
                                                    insetPadding: const EdgeInsets.all(2.0),
                                                    title: Text('Are you sure want to logout?',style: AppStyles.headingTxtStyle1,),
                                                    actions: [
                                                      InkWell(
                                                          onTap: () {
                                                            sharedpref.clear();
                                                            Navigator.of(context).pushNamed('/loginScreen');
                                                          },
                                                          child: const Text('Yes', style: TextStyle(color: Colors.white),)),
                                                      const SizedBox(width: 10,),
                                                      InkWell(
                                                          onTap: () {
                                                            Navigator.pop(context);
                                                          },
                                                          child: Text(' No ',style: TextStyle(color: AppStyles.fadeGreenColor))),
                                                    ],
                                                  ),
                                                );
                                              }).then((exit) {
                                            if (exit == null) return;
                                            if (exit) {
                                              // user pressed Yes button
                                            } else {
                                              // user pressed No button
                                            }
                                          });
                                        },
                                        child: OpenContainer(
                                          transitionType: _transitionType,
                                          tappable: false,
                                          openBuilder: (BuildContext context, VoidCallback _) {
                                            return const MoreScreen(
                                              // includeMarkAsDoneButton: false,
                                            );
                                          },
                                          closedElevation: 6.0,
                                          closedShape:  const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(30.0 ),
                                            ),
                                          ),
                                          closedColor: Colors.grey.shade900.withOpacity(0.90),
                                          closedBuilder: (BuildContext context, VoidCallback openContainer) {
                                            return Container(
                                              height: _fabDimension,
                                              width: _fabDimension,
                                              decoration: BoxDecoration(
                                                color:Colors.cyanAccent.withOpacity(0.06),
                                              ),
                                              child: Padding(
                                                  padding: EdgeInsets.all(AppStyles.iconPadding),
                                                  child:Image.asset('assets/images/logout.png',color: Colors.white),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Text('logout', style: AppStyles.labelTxtStyle,),
                                    ],
                                  ),

                                ],
                              ),
                              const SizedBox(height: 5,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15,)
              ],)
          ],
        ),
      ],
    );
  }
}

