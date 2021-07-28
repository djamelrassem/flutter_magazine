import 'dart:math';

import 'package:flutter/material.dart';
import 'package:magazine/views/screens/widgets/magazine_swiper.dart';

double orderRotation = 0.0;

class MagazinesList extends StatefulWidget {
  const MagazinesList({
    Key? key,
  }) : super(key: key);
  @override
  _MagazinesListState createState() => _MagazinesListState();
}

class _MagazinesListState extends State<MagazinesList>
    with TickerProviderStateMixin {
  late AnimationController orderRotationController;
  late Animation<double> orderRotationAnimation;
  late Animation<double> sizeAnimation;
  double firstElementRotation = 0;
  double secondElementRotation = pi / 16;
  double thirElementRotation = -pi / 16;
  int swipe = 0;
  int index = 0;
  double resizer = 0.0;
  @override
  void initState() {
    super.initState();
    orderRotationController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this)
          ..addListener(() {
            setState(() {
              if (!orderRotationController.isDismissed) {
                resizer = sizeAnimation.value;
                switch (swipe) {
                  case 0:
                    firstElementRotation =
                        -pi / 16 + orderRotationAnimation.value;
                    secondElementRotation = orderRotationAnimation.value;
                    thirElementRotation =
                        pi / 16 - orderRotationAnimation.value * 2;

                    break;
                  case 1:
                    thirElementRotation =
                        -pi / 16 + orderRotationAnimation.value;
                    secondElementRotation =
                        pi / 16 - orderRotationAnimation.value * 2;
                    firstElementRotation = orderRotationAnimation.value;

                    break;
                  case 2:
                    secondElementRotation =
                        (-pi / 16) + orderRotationAnimation.value;
                    thirElementRotation = orderRotationAnimation.value;
                    firstElementRotation =
                        pi / 16 - orderRotationAnimation.value * 2;

                    break;
                }
              } else {
                switch (swipe) {
                  case 0:
                    firstElementRotation = 0;

                    break;
                  case 1:
                    thirElementRotation = 0;

                    break;
                  case 2:
                    secondElementRotation = 0;
                    break;
                }
              }
            });
          });
    orderRotationAnimation =
        Tween(begin: 0.0, end: pi / 12).animate(orderRotationController);
    sizeAnimation =
        Tween(begin: 0.0, end: 1.0).animate(orderRotationController);
  }

  onEndDismiss() {
    swipe = (swipe + 1) % 3;
    orderRotationController
        .forward()
        .then((value) => {orderRotationController.reset()});
  }

  @override
  Widget build(BuildContext context) {
    late List<Widget> children = [
      Transform.scale(
        scale: index == 3 ? resizer : 1,
        child: Transform.rotate(
          alignment: Alignment.bottomCenter,
          angle: thirElementRotation,
          child: MagazineSwiper(
            onEndDrag: () {},
            onEndDismiss: () {
              index = 3;
              onEndDismiss();
            },
            color: Colors.red,
          ),
        ),
      ),
      Transform.scale(
        scale: index == 2 ? resizer : 1,
        child: Transform.rotate(
          alignment: Alignment.bottomCenter,
          angle: secondElementRotation,
          child: MagazineSwiper(
            onEndDrag: () {},
            color: Colors.white,
            onEndDismiss: () {
              index = 2;
              onEndDismiss();
            },
          ),
        ),
      ),
      Transform.scale(
        scale: index == 1 ? resizer : 1,
        child: Transform.rotate(
          alignment: Alignment.bottomCenter,
          angle: firstElementRotation,
          child: MagazineSwiper(
            onEndDismiss: () {
              index = 1;
              onEndDismiss();
            },
            onEndDrag: () {},
            color: Colors.blue,
          ),
        ),
      ),
    ];
    return Stack(children: [
      children[(swipe + 1) % 3],
      children[(swipe + 3) % 3],
      children[(swipe + 2) % 3],
    ]);
  }
}
