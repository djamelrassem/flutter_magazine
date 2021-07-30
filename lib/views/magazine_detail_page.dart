import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MagazineDetailPage extends StatefulWidget {
  final String image;
  const MagazineDetailPage({Key? key, required this.image}) : super(key: key);

  @override
  _MagazineDetailPageState createState() => _MagazineDetailPageState();
}

class _MagazineDetailPageState extends State<MagazineDetailPage> {
  double expandedHeight = 800;
  double toolBarHeight = 50;
  double height = 150;
  double x = -1;
  double y = 0.3;
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
        y = 0.3 +
            0.6 *
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
    return Stack(
      children: [
        Scaffold(
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
                      alignment: Alignment(x, 1.0),
                      child: Text(
                        '0' + widget.image,
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
                            image: AssetImage('assets/${widget.image}.jpg'),
                          ),
                          color: Colors.white,
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.0)),
                            child: Center(
                              child: Hero(
                                tag: widget.image,
                                child: Image(
                                  filterQuality: FilterQuality.low,
                                  height: (MediaQuery.of(context).size.height /
                                          2.5) *
                                      0.9,
                                  width: (MediaQuery.of(context).size.height /
                                          3.2) *
                                      0.9,
                                  fit: BoxFit.cover,
                                  image:
                                      AssetImage("assets/${widget.image}.jpg"),
                                ),
                              ),
                            ),
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
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  color: Colors.black,
                  height: MediaQuery.of(context).size.height,
                  child: Text(
                    '''KEY BACKGROUND

Musk first said that he’d made an unsuccessful overture to speak with Cook last December, after Reuters reported that Apple aimed to start making self-driving cars by 2024. Musk claimed he reached out to Cook to propose an acquisition during the “darkest days of [Tesla’s] Model 3 program,” which led to production difficulties and heavy losses for the automaker in 2017 and 2018. Cook refused to meet about a sale, Musk said. Since then, Tesla’s revenue and market capitalization have grown substantially.

CRUCIAL QUOTE

“There was a point where I requested to meet with Cook to talk about Apple buying Tesla,” Musk tweeted Friday afternoon. “There were no conditions of acquisition proposed whatsoever.”

TANGENT

By siding with Epic Games in its dispute against Apple, Musk is wading into a contentious debate about Apple’s power over app makers. Both Apple and Google charge commissions of 15% to 30% for all in-app purchases through their iPhone and Android app stores, respectively. App designers and some government officials have cast this system as anti-competitive, but the two tech companies argue these commissions are inline with industry standards and their restrictive policies ensure app stores are safe and user-friendly.''',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment(0.8, y),
          child: Container(
            padding: EdgeInsets.all(8.0),
            color: Colors.black,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.white,
                  size: 42,
                ),
                SizedBox(
                  height: 12,
                ),
                Icon(
                  Icons.bookmark_border_outlined,
                  color: Colors.white,
                  size: 42,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
