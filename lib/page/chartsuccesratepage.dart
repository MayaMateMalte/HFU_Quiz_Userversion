/**
 * Created by Malte Denecke
 */



import 'package:classroomquiz_usersedition/db/IncorrectCorrectAnswered_database.dart';
import 'package:classroomquiz_usersedition/model/IncorrectCorrectAnswered.dart';
import 'package:classroomquiz_usersedition/model/chartdata.dart';
import 'package:classroomquiz_usersedition/model/chartdatasucessrate.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class ChartSuccessRateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chartpage Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),

      home: ChartSucccesRatePage(),

    );
  }
}

class ChartSucccesRatePage extends StatefulWidget {
  ChartSucccesRatePage({Key? key}) : super(key: key);





  @override
  _ChartSucccesRateState createState() => _ChartSucccesRateState();

}

class _ChartSucccesRateState extends State<ChartSucccesRatePage> {

  late TooltipBehavior _tooltipBehavior;
  List<IncorrectCorrectAnswered> iccalist = [];
  double max = 0;
  List<ChartDataSuccessRate> chartDataList = [];
  final legendItemText =  'legend';
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
          body: Container(  margin: EdgeInsets.all(0),
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
                        Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap, textStyle: TextStyle(fontSize: 18)),
                        tooltipBehavior: _tooltipBehavior,

                        series: <CircularSeries>[
                          RadialBarSeries<ChartDataSuccessRate, String>(
                             // animationDuration: 2000,
                              dataSource: chartDataList,

                              xValueMapper: (ChartDataSuccessRate data, _) => data.gamename,
                              yValueMapper: (ChartDataSuccessRate data, _) => data.successrate.round(),
                              dataLabelSettings: DataLabelSettings(isVisible: true),
                              enableTooltip: true,

                              maximumValue: 100)
                        ],

                      ),
                    );}}
            ),
          ),

      ),
    );
  }

  void resetPufferData(){

    setState(() {
      List<IncorrectCorrectAnswered> iccalist = [];

      List<ChartData> chartDataList = [];
    });

  }

  @override
  void dispose(){
    super.dispose();
  }

  double getMaximumValue(){

    for(int i = 0; i < chartDataList.length; i++){
      if(chartDataList[i].successrate > max){
        max = chartDataList[i].successrate.toDouble();
      }
    }
    print("Max Value");
    print(max);
    return max;
  }


  Future<List<ChartDataSuccessRate>> getIncorrectCorrecetAnsweredData() async {
    if(alreadychecked == false) {
      iccalist = await IncorrectCorrectAnsweredDatabase.instance
          .readAllIncorrectCorrectAnswered();
      print(iccalist.length);
      for (int i = 0; i < iccalist.length; i++) {
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
    int successCounter = 0;
    int failCounter = 0;
    int overviewCounter = 0;
    for (int i = 0; i < iccalist.length; i++)
    {
      if(iccalist[i].gamename == gamename)
      {
        if(iccalist[i].iscorrect == "true"){
          successCounter ++;
        }
        else{
          failCounter++;
        }

      }

    }
    overviewCounter = successCounter + failCounter;
    double successrate = (overviewCounter/successCounter)*10;
    successrate.round();
    print("Methode einmal aufgerufen!");
    print("Overview: $overviewCounter");
    print("Successrate: $successrate");
    print("FailCounter: $failCounter");
    //print("$gamename wurde $gameCounter mal gespielt");
    ChartDataSuccessRate chartDataObject = new ChartDataSuccessRate(gamename, successrate);
    chartDataList.add(chartDataObject);

  }



}


