import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MagazineDetailPage extends StatefulWidget {
  const MagazineDetailPage({Key? key}) : super(key: key);

  @override
  _MagazineDetailPageState createState() => _MagazineDetailPageState();
}

class _MagazineDetailPageState extends State<MagazineDetailPage> {
  double expandedHeight = 700;
  double toolBarHeight = 50;
  double height = 150;
  double x = -1;
  late ScrollController controller = ScrollController()..addListener(listener);

  void listener() {
    if (controller.position.pixels < (expandedHeight - toolBarHeight)) {
      setState(() {
        height = toolBarHeight +
            100 *
                (1 -
                    (controller.position.pixels /
                        (expandedHeight - toolBarHeight)));
        x = -1 +
            (controller.position.pixels / (expandedHeight - toolBarHeight));
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.removeListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        physics: PageScrollPhysics(),
        controller: controller,
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: false,
            backgroundColor: Colors.black,
            toolbarHeight: toolBarHeight,
            expandedHeight: expandedHeight,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              stretchModes: [StretchMode.zoomBackground],
              collapseMode: CollapseMode.parallax,
              title: Container(
                height: height,
                width: double.infinity,
                color: Colors.black,
                child: FittedBox(
                  alignment: Alignment(x, 0.0),
                  child: Text(
                    '03',
                  ),
                ),
              ),
              background: Column(
                children: [
                  Container(
                    height: expandedHeight,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/2.jpg'),
                      ),
                      color: Colors.white,
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.white.withOpacity(0.0)),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    color: Colors.black,
                  ))
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.black,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Text('Scroll to see the SliverAppBar in effect. ' * 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
