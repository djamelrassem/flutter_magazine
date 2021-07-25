import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

double abs(double num) {
  if (num < 0) {
    return -1 * num;
  } else {
    return num;
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController swipeController;
  late Animation swipeAnimation;
  Alignment position = Alignment(0, 0);

  @override
  initState() {
    super.initState();
    swipeController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this)
          ..addListener(() {
            setState(() {
              if (!swipeController.isDismissed) {
                position = swipeAnimation.value;
              }
            });
          });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black,
            Colors.black,
            Colors.white,
            Colors.white,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Magazines',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 26),
                        ),
                        Icon(
                          CupertinoIcons.camera,
                          size: 27,
                          color: Colors.white,
                        )
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 24, bottom: 64),
                      padding: EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white.withOpacity(0.2),
                      ),
                      child: Icon(
                        CupertinoIcons.search,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onHorizontalDragEnd: (onEndDrag) {
                  if (abs(position.x) < 0.3 && abs(position.y) < 0.3) {
                    setState(() {
                      position = Alignment.center;
                    });
                  } else {
                    swipeAnimation = Tween(
                            begin: position,
                            end: Alignment(position.x > 0 ? 10 : -10, 0))
                        .animate(swipeController);
                    swipeController
                        .forward()
                        .then((value) => {swipeController.reset()});
                  }
                },
                onHorizontalDragUpdate: (onDragDetatils) {
                  setState(() {
                    position = Alignment(
                        (onDragDetatils.localPosition.dx /
                                    MediaQuery.of(context).size.width) *
                                2 -
                            1,
                        (onDragDetatils.localPosition.dy / 360) * 2 - 1);
                  });
                },
                child: Container(
                  height: 360,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Align(
                        alignment: position,
                        child: Container(
                          height: 300,
                          width: MediaQuery.of(context).size.width - 200,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 64),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'All magazines',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                        Icon(
                          CupertinoIcons.arrow_right_circle_fill,
                          size: 28,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      height: 120,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.brown,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.brown,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.brown,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          enableFeedback: false,
          items: [
            BottomNavigationBarItem(
              label: '',
              icon: Icon(
                CupertinoIcons.house,
                color: Colors.black,
                size: 32,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(
                Icons.shopping_bag_outlined,
                color: Colors.black,
                size: 32,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(
                CupertinoIcons.add_circled,
                color: Colors.black,
                size: 32,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(
                CupertinoIcons.profile_circled,
                color: Colors.black,
                size: 32,
              ),
            )
          ],
        ),
      ),
    );
  }
}
