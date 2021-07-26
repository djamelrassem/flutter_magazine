import 'package:flutter/material.dart';
import 'dart:math';

double abs(double num) {
  if (num < 0) {
    return -1 * num;
  } else {
    return num;
  }
}

class MagazineSwiper extends StatefulWidget {
  final Color? color;
  final Function onEndDrag;
  final Function onEndDismiss;
  const MagazineSwiper(
      {Key? key,
      this.color,
      required this.onEndDrag,
      required this.onEndDismiss})
      : super(key: key);

  @override
  _MagazineSwiperState createState() => _MagazineSwiperState();
}

class _MagazineSwiperState extends State<MagazineSwiper>
    with TickerProviderStateMixin {
  late AnimationController swipeController;
  late Animation swipeAnimation;
  late AnimationController rotateController;
  late Animation<double> rotateAnimation;
  Alignment position = Alignment(0, 0);
  double rotation = 0.0;

  @override
  initState() {
    super.initState();
    swipeController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this)
          ..addListener(() {
            if (!swipeController.isDismissed) {
              setState(() {
                position = swipeAnimation.value;
              });
            } else {
              widget.onEndDismiss();
              setState(() {
                position = Alignment.center;
              });
            }
          });
    rotateController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this)
          ..addListener(() {
            if (!rotateController.isDismissed) {
              setState(() {
                rotation = rotateAnimation.value;
              });
            } else {
              setState(() {
                rotation = rotateAnimation.value;
              });
            }
          });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (onEndDrag) {
        if (abs(position.x) < 0.3 && abs(position.y) < 0.3) {
          setState(() {
            position = Alignment.center;
          });
        } else {
          swipeAnimation = Tween(
                  begin: position,
                  end: Alignment(position.x > 0 ? 10.0 : -10.0, 0))
              .animate(swipeController);
          rotateAnimation =
              Tween(begin: 0.0, end: position.x > 0 ? pi / 8 : -pi / 8)
                  .animate(rotateController);
          rotateController
              .forward()
              .then((value) => {rotateController.reset()});
          swipeController.forward().then((value) => {swipeController.reset()});
          widget.onEndDrag();
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
              child: Transform.rotate(
                angle: rotation,
                child: Container(
                  height: 320,
                  width: MediaQuery.of(context).size.width - 128,
                  color: widget.color,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
