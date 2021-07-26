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
  double firstElementRotation = 0;
  double secondElementRotation = pi / 16;
  double thirElementRotation = -pi / 16;
  int swipe = 0;

  @override
  void initState() {
    super.initState();
    orderRotationController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this)
          ..addListener(() {
            if (!orderRotationController.isDismissed) {
              switch (swipe) {
                case 0:
                  setState(() {
                    firstElementRotation =
                        -pi / 16 + orderRotationAnimation.value;
                    secondElementRotation = orderRotationAnimation.value;
                    thirElementRotation =
                        pi / 16 - orderRotationAnimation.value * 2;
                  });
                  break;
                case 1:
                  setState(() {
                    thirElementRotation =
                        -pi / 16 + orderRotationAnimation.value;
                    secondElementRotation =
                        pi / 16 - orderRotationAnimation.value * 2;
                    firstElementRotation = orderRotationAnimation.value;
                  });
                  break;
                case 2:
                  setState(() {
                    secondElementRotation =
                        (-pi / 16) + orderRotationAnimation.value;
                    thirElementRotation = orderRotationAnimation.value;
                    firstElementRotation =
                        pi / 16 - orderRotationAnimation.value * 2;
                  });
                  break;
              }
            } else {
              switch (swipe) {
                case 0:
                  setState(() {
                    firstElementRotation = 0;
                  });
                  break;
                case 1:
                  setState(() {
                    thirElementRotation = 0;
                  });
                  break;
                case 2:
                  setState(() {
                    secondElementRotation = 0;
                  });
                  break;
              }
            }
          });
    orderRotationAnimation =
        Tween(begin: 0.0, end: pi / 12).animate(orderRotationController);
  }

  onEndDismiss() {
    swipe = (swipe + 1) % 3;
    orderRotationController
        .forward()
        .then((value) => {orderRotationController.reset()});
  }

  late Function magazines = (
      {required double thirElementRotation,
      required double secondElementRotation,
      required double firstElementRotation,
      required int index}) {
    late List<Widget> children = [
      Transform.rotate(
        alignment: Alignment.bottomCenter,
        angle: thirElementRotation,
        child: MagazineSwiper(
          onEndDrag: () {},
          onEndDismiss: () {
            onEndDismiss();
          },
          color: Colors.red,
        ),
      ),
      Transform.rotate(
        alignment: Alignment.bottomCenter,
        angle: secondElementRotation,
        child: MagazineSwiper(
          onEndDrag: () {},
          color: Colors.white,
          onEndDismiss: () {
            onEndDismiss();
          },
        ),
      ),
      Transform.rotate(
        alignment: Alignment.bottomCenter,
        angle: firstElementRotation,
        child: MagazineSwiper(
          onEndDismiss: () {
            onEndDismiss();
          },
          onEndDrag: () {},
          color: Colors.blue,
        ),
      ),
    ];
    return [
      children[(swipe + 1) % 3],
      children[(swipe + 3) % 3],
      children[(swipe + 2) % 3],
    ];
  };

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: magazines(
            firstElementRotation: firstElementRotation,
            secondElementRotation: secondElementRotation,
            thirElementRotation: thirElementRotation,
            index: swipe));
  }
}
