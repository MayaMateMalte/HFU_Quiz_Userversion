/**
 * Created by Malte Denecke
 */



import 'package:classroomquiz_usersedition/db/IncorrectCorrectAnswered_database.dart';
import 'package:classroomquiz_usersedition/model/IncorrectCorrectAnswered.dart';
import 'package:classroomquiz_usersedition/model/chartdata.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class ChartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GameDiagram',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),

      home: ChartPage(),

    );
  }
}

class ChartPage extends StatefulWidget {
  ChartPage({Key? key}) : super(key: key);





  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {

  late TooltipBehavior _tooltipBehavior;
  List<IncorrectCorrectAnswered> iccalist = [];
  double max = 0;
  List<ChartData> chartDataList = [];
  bool alreadychecked = false;

  @override
  void initState() {

    resetPufferData();
    _tooltipBehavior = TooltipBehavior(enable: true);
     // getIncorrectCorrecetAnsweredData();



    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
              body: Container(
        decoration: BoxDecoration(image: DecorationImage(
            image:AssetImage("assets/background.png"),
        fit: BoxFit.fill)),
              child: FutureBuilder(
                future: getIncorrectCorrecetAnsweredData(),

                  builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                  } else
                    {
                      return   Container(
                child: SfCircularChart(

                  legend:
                  Legend(isVisible: true,  overflowMode: LegendItemOverflowMode.wrap, textStyle: TextStyle(fontSize: 18,)),
                  tooltipBehavior: _tooltipBehavior,

                  series: <CircularSeries>[
                    RadialBarSeries<ChartData, String>(
                        dataSource: chartDataList,
                        xValueMapper: (ChartData data, _) => data.gamename,
                        yValueMapper: (ChartData data, _) => data.gamecount,
                        dataLabelSettings: DataLabelSettings(isVisible: true),
                        enableTooltip: true,

                        maximumValue: max)
                  ],
                ),
              );}}
    ),
            )
        ),);
  }

  void resetPufferData(){

    setState(() {
      List<IncorrectCorrectAnswered> iccalist = [];

      List<ChartData> chartDataList = [];
    });
  }


  double getMaximumValue(){

    for(int i = 0; i < chartDataList.length; i++){
      if(chartDataList[i].gamecount > max){
        max = chartDataList[i].gamecount.toDouble();
      }
    }
    print("Max Value");
    print(max);
    return max;
  }


  Future<List<ChartData>> getIncorrectCorrecetAnsweredData() async {
    if(alreadychecked == false) {
    iccalist = await IncorrectCorrectAnsweredDatabase.instance.readAllIncorrectCorrectAnswered();
    print(iccalist.length);
    for(int i = 0; i< iccalist.length; i++){
      print(iccalist[i]);
    }
    createChartData();
    print(chartDataList.length);
    getMaximumValue();
    alreadychecked = true;
    return chartDataList;
    }
    else return chartDataList;
  }

  void createChartData(){
    List<String> iccalistUniqueGamenames = [];


    for(int i =0; i< iccalist.length;i++){
      iccalistUniqueGamenames.add(iccalist[i].gamename);
    }
    print("UniqueGamenames");
    iccalistUniqueGamenames = iccalistUniqueGamenames.toSet().toList();
    print("Anzahl:");
    print(iccalistUniqueGamenames.length);
    print(iccalistUniqueGamenames);
    int counterProgrammieren = 0;
    for(int i =0; i< iccalistUniqueGamenames.length;i++){
      countGames(iccalistUniqueGamenames[i]);
    }
  }

  void countGames(String gamename) {
    int? gameCounterPuffer;
    int gameCounter = 0;
      for (int i = 0; i < iccalist.length; i++)
    {
      if(iccalist[i].gamename == gamename)
      {
       if(iccalist[i].gamecounter != gameCounterPuffer){
         gameCounter++;
         gameCounterPuffer = iccalist[i].gamecounter;
       }

      }

    }

        print("Methode einmal aufgerufen!");
        print("$gamename wurde $gameCounter mal gespielt");
        ChartData chartDataObject = new ChartData(gamename, gameCounter);
        chartDataList.add(chartDataObject);

  }



}


