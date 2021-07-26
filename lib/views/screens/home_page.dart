import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
              MagazinesList(),
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
