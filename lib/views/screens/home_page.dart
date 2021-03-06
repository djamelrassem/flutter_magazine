import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magazine/views/magazine_detail_page.dart';
import 'package:magazine/views/screens/widgets/magazinesList.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
              MagazinesList(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 700),
                              pageBuilder: (context, _, __) =>
                                  MagazineDetailPage(
                                    image: '1',
                                  )));
                    },
                    child: Hero(
                      tag: '1',
                      child: Image(
                        filterQuality: FilterQuality.low,
                        height: MediaQuery.of(context).size.height / 2.5,
                        width: MediaQuery.of(context).size.height / 3.2,
                        fit: BoxFit.cover,
                        image: AssetImage("assets/1.jpg"),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 700),
                              pageBuilder: (context, _, __) =>
                                  MagazineDetailPage(image: '2')));
                    },
                    child: Hero(
                      tag: '2',
                      child: Image(
                        filterQuality: FilterQuality.low,
                        height: MediaQuery.of(context).size.height / 2.5,
                        width: MediaQuery.of(context).size.height / 3.2,
                        fit: BoxFit.cover,
                        image: AssetImage("assets/2.jpg"),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 700),
                              pageBuilder: (context, _, __) =>
                                  MagazineDetailPage(image: '3')));
                    },
                    child: Hero(
                      tag: '3',
                      child: Image(
                        filterQuality: FilterQuality.low,
                        height: MediaQuery.of(context).size.height / 2.5,
                        width: MediaQuery.of(context).size.height / 3.2,
                        fit: BoxFit.cover,
                        image: AssetImage("assets/3.jpg"),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
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
                            child: Image(
                              image: AssetImage('assets/1.jpg'),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Image(
                              image: AssetImage('assets/2.jpg'),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Image(
                              image: AssetImage('assets/3.jpg'),
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
