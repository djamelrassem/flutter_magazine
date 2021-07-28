import 'package:flutter/material.dart';

class MagazineDetailPage extends StatefulWidget {
  const MagazineDetailPage({Key? key}) : super(key: key);

  @override
  _MagazineDetailPageState createState() => _MagazineDetailPageState();
}

class _MagazineDetailPageState extends State<MagazineDetailPage> {
  double expandedHeight = 600;
  double toolBarHeight = 50;
  late double factor = 6;
  late ScrollController controller = ScrollController()..addListener(listener);

  void listener() {
    if (controller.position.pixels < (expandedHeight - toolBarHeight)) {
      setState(() {
        factor = (1 -
                    (controller.position.pixels /
                        (expandedHeight - toolBarHeight))) *
                5 +
            1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: controller,
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.black,
            toolbarHeight: toolBarHeight,
            expandedHeight: expandedHeight,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              stretchModes: [StretchMode.zoomBackground],
              collapseMode: CollapseMode.parallax,
              title: Container(
                width: double.infinity,
                color: Colors.black,
                child: Text(
                  '03',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24 * factor),
                ),
              ),
              background: Container(
                color: Colors.red,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  color: index.isOdd ? Colors.white : Colors.black12,
                  height: 100.0,
                  child: Center(
                    child: Text('$index', textScaleFactor: 5),
                  ),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
