import 'dart:math';

import 'package:flutter/material.dart';
import 'package:magazine/views/screens/widgets/magazine_swiper.dart';

double orderRotation = 0.0;

class MagazinesList extends StatefulWidget {
  final List<Widget> children;
  const MagazinesList({
    Key? key,
    required this.children,
  }) : super(key: key);
  @override
  _MagazinesListState createState() => _MagazinesListState();
}

class _MagazinesListState extends State<MagazinesList>
    with TickerProviderStateMixin {
  late AnimationController orderRotationController;
  late Animation<double> orderRotationAnimation;
  late Animation<double> sizeAnimation;

  List<double> rotations = [0, pi / 16, -pi / 16];
  int swipe = 0;
  int index = 0;
  double resizer = 0.0;
  @override
  void initState() {
    super.initState();
    orderRotationController =
        AnimationController(duration: Duration(milliseconds: 350), vsync: this)
          ..addListener(() {
            setState(() {
              if (!orderRotationController.isDismissed) {
                resizer = sizeAnimation.value;
                switch (swipe) {
                  case 0:
                    rotations[0] = -pi / 16 + orderRotationAnimation.value;
                    rotations[1] = orderRotationAnimation.value;
                    rotations[2] = pi / 16 - orderRotationAnimation.value * 2;

                    break;
                  case 1:
                    rotations[2] = -pi / 16 + orderRotationAnimation.value;
                    rotations[1] = pi / 16 - orderRotationAnimation.value * 2;
                    rotations[0] = orderRotationAnimation.value;

                    break;
                  case 2:
                    rotations[1] = (-pi / 16) + orderRotationAnimation.value;
                    rotations[2] = orderRotationAnimation.value;
                    rotations[0] = pi / 16 - orderRotationAnimation.value * 2;

                    break;
                }
              } else {
                switch (swipe) {
                  case 0:
                    rotations[0] = 0;

                    break;
                  case 1:
                    rotations[2] = 0;

                    break;
                  case 2:
                    rotations[1] = 0;
                    break;
                }
              }
            });
          });
    orderRotationAnimation =
        Tween(begin: 0.0, end: pi / 16).animate(orderRotationController);
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
    List<Widget> widgets = List.generate(
      widget.children.length,
      (indexer) => Transform.scale(
        scale: index == widget.children.length - indexer ? resizer : 1,
        child: Transform.rotate(
          alignment: Alignment.bottomCenter,
          angle: rotations[2 - indexer],
          child: MagazineSwiper(
              height: MediaQuery.of(context).size.height / 2.5 + 64,
              width: MediaQuery.of(context).size.width,
              onEndDrag: () {},
              onEndDismiss: () {
                index = widget.children.length - indexer;
                onEndDismiss();
              },
              color: Colors.red,
              child: widget.children[indexer]),
        ),
      ),
    );

    return Stack(children: [
      widgets[(swipe + 1) % 3],
      widgets[(swipe + 3) % 3],
      widgets[(swipe + 2) % 3],
    ]);
  }
}
