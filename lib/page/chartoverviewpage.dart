import 'package:classroomquiz_usersedition/page/chartsuccesratepage.dart';
import 'package:flutter/material.dart';
/**
 * Created by Malte Denecke
 */
import 'chartpage.dart';

class ChartOverviewPage extends StatefulWidget {
  //ChartOverviewPage({required Key key}) : super(key: key);

  @override
  _ChartOverviewPageState createState() => _ChartOverviewPageState();
}

class _ChartOverviewPageState extends State<ChartOverviewPage> {
  int _page = 0;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: _page);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar( title: Text("Übersicht"),
          backgroundColor: Color(0xFF16804E),
          centerTitle: true,

        ),

      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFF16804E),
          currentIndex: _page,
          onTap: (index) {
            this._pageController.animateToPage(index,
                duration: Duration(milliseconds: 500), curve: Curves.easeIn);
          },
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
                icon: Icon(Icons.data_usage), label: "Übersicht"),
            new BottomNavigationBarItem(
                icon: Icon(Icons.data_usage), label: "Score"),

          ]),
      body: PageView(
        controller: _pageController,
        onPageChanged: (newpage) {
          setState(() {
            this._page = newpage;

          });
        },
        children: [
          ChartPage(),
          ChartSucccesRatePage()

        ],
      ),
    );
  }


}