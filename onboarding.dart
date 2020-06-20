import 'package:fitnessapp/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:page_view_indicator/page_view_indicator.dart";
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<String> images = [
    'assets/images/bg.jpg',
    'assets/images/bgg3.jpg',
    'assets/images/bg.jpg',
  ];
  List<String> titels = ['Welcome!', 'Select!', 'Finish!'];
  List<String> descriptions = [
    'Create Course to get a healthy body',
    'Select items that you need it to create your course',
    'Finish , you can show your course that you made '
  ];

  ValueNotifier<int> _pageViewNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(
            'Fitness App',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: Stack(children: <Widget>[
          PageView.builder(
            itemBuilder: (context, index) {
              return Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: ExactAssetImage(images[index]),
                            fit: BoxFit.cover)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(top: 470),
                          child: Text(
                            titels[index],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 48,
                          right: 48,
                        ),
                        child: Text(
                          descriptions[index],
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  )
                ],
              );
            },
            itemCount: images.length,
            onPageChanged: (index) {
              _pageViewNotifier.value = index;
            },
          ),
          Transform.translate(
            offset: Offset(0, 310),
            child: Align(
              alignment: Alignment.center,
              child: _displayPageIndicators(images.length),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: SizedBox(
                  width: 350,
                  child: RaisedButton(
                    child: Text(
                      'GET STARTED',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.red,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        _updateSeen();
                        return HomeScreen();
                      }));
                    },
                  ),
                )),
          ),
        ]));
  }

  Widget _displayPageIndicators(int length) {
    return PageViewIndicator(
        pageIndexNotifier: _pageViewNotifier,
        length: length,
        normalBuilder: (animationController, index) => Circle(
              size: 8.0,
              color: Colors.grey,
            ),
        highlightedBuilder: (animationController, index) => ScaleTransition(
              scale: CurvedAnimation(
                parent: animationController,
                curve: Curves.ease,
              ),
              child: Circle(size: 12.0, color: Colors.red),
            ));
  }

  void _updateSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('seen', true);
  }
}
