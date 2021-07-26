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
  late Animation orderRotationAnimation;

  @override
  void initState() {
    super.initState();
    orderRotationController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this)
          ..addListener(() {
            if (!orderRotationController.isDismissed) {
              setState(() {
                orderRotation = orderRotationAnimation.value;
              });
            }
          });
  }

  onEndDismiss() {
    setState(() {
      Widget last = magazines.removeLast();
      magazines.insert(0, last);
    });
  }

  late List<Widget> magazines = [
    Transform.rotate(
      alignment: Alignment.bottomCenter,
      angle: 0,
      child: MagazineSwiper(
        onEndDrag: () {},
        onEndDismiss: onEndDismiss,
        color: Colors.red,
      ),
    ),
    Transform.rotate(
      alignment: Alignment.bottomCenter,
      angle: 0,
      child: MagazineSwiper(
        onEndDrag: () {},
        color: Colors.white,
        onEndDismiss: onEndDismiss,
      ),
    ),
    Transform.rotate(
      alignment: Alignment.bottomCenter,
      angle: 0,
      child: MagazineSwiper(
        onEndDismiss: onEndDismiss,
        onEndDrag: () {},
        color: Colors.blue,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(children: magazines);
  }
}
