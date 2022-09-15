import 'package:flutter/material.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/on_boarding/on_boarding_model.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../login/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardingController = PageController();

  List<OnBoardingModel> onBoardingList = [
    OnBoardingModel('assets/images/onboard_1.jpg'),
    OnBoardingModel('assets/images/onboard_2.jpg'),
    OnBoardingModel('assets/images/onboard_3.jpg'),
  ];
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defultTextButton(
              function: submit,
              text: 'Skip'
          )
        ],
      ),
      body: PageView.builder(
        physics: BouncingScrollPhysics(),
          controller: boardingController,
          onPageChanged: (index){
          if(index == onBoardingList.length -1){
            setState(() {
              isLast = true;
            });
          }
          else{
            setState(() {
              isLast = false;
            });
          }
          },
          itemBuilder: (context ,index)=>buildOnBoardingItem(
              onBoardingList[index],)
      ),
    );
  }

  Widget buildOnBoardingItem(OnBoardingModel model,) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child:
              Image.asset(
                '${model.image}',
              )
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'On Boarding Title',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
          Text(
            'body title',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  count: onBoardingList.length,
                  effect: WormEffect(
                    dotColor: Colors.grey,
                    activeDotColor: primaryColor,
                    dotHeight: 15,
                    dotWidth: 15,
                    spacing: 20.0,
                  ),
                ),
                Spacer(),
                TextButton(
                    onPressed: () {
                      if (isLast) {
                      submit();
                      }
                      else{
                        boardingController.nextPage(
                            duration: Duration(
                                milliseconds: 700
                            ),
                            curve: Curves.fastLinearToSlowEaseIn
                        );
                      }

                    },
                    child: Text(
                      'Next',
                      style: TextStyle(
                          fontSize: 18.0
                      ),

                    )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true);
    navigatAndFinish(context, LoginScreen());
  }
}
