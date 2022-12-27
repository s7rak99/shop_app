import 'package:flutter/material.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/modules/shop_app/login/login.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/network/remote/cache_helper.dart';
import 'package:shop_app/shared/style/color.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../model/board_model.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> model = [
    BoardingModel(
        image: 'assets/images/cart2.png',
        title: 'Exploring our app',
        body: 'Many Items In One App!!'),
    BoardingModel(
        image: 'assets/images/cart1.png',
        title: 'Fill your cart',
        body: "Let's Spent some money"),
    BoardingModel(
        image: 'assets/images/bag2.png',
        title: 'Here we go',
        body: 'Check up to receive your order')
  ];
  bool isLast = false;

  void submit(){
    CacheHelper.saveDate(key: 'onBoarding', val: true).then((value) {
      navigatePush((context), ShopLoginScreen());

    });

  }

  var boardController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            text: 'SKIP',
        onPressed: (){
             submit();
        }
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Flexible(
              child: PageView.builder(
                controller: boardController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (i) {
                  if (i == model.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, i) {
                  return buildBoardingItems(model[i]);
                },
                itemCount: model.length,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: model.length,
                  effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 5,
                      expansionFactor: 4,
                      activeDotColor: defaultColor),
                ),
                // const Text('Indicator', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                //  ),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                    submit();
                    }
                    boardController.nextPage(
                        duration: Duration(seconds: 1), curve: Curves.linear);
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItems(BoardingModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Image(
            image: AssetImage('${model.image}'),
          ),
        ),
        Text(
          '${model.title}',
          style: const TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Text(
          '${model.body}',
          style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 50.0,
        ),
      ],
    );
  }

}
