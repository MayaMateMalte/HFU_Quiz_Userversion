/**
 * Created by Malte Denecke
 */

import 'package:flutter/material.dart';

import 'package:classroomquiz_usersedition/page/chartoverviewpage.dart';
import 'package:classroomquiz_usersedition/page/chartpage.dart';
import 'package:classroomquiz_usersedition/page/chartsuccesratepage.dart';
import 'package:classroomquiz_usersedition/page/quizoverviewpage.dart';
import 'package:classroomquiz_usersedition/page/settingspage.dart';
import 'package:classroomquiz_usersedition/page/usernameinputpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:classroomquiz_usersedition/page/quizpage.dart';
import 'package:classroomquiz_usersedition/const/const.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:classroomquiz_usersedition/widget/customwidgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:io';
import 'package:classroomquiz_usersedition/db/questions_database.dart';
import 'package:classroomquiz_usersedition/model/questions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'model/questions.dart';
void main() {
  runApp(StartApp());
}
class StartApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return MaterialApp(home: StartPage());
  }
}

class StartPage extends StatefulWidget {

  @override
  StartPageState createState() => StartPageState();
}
List ? data = [];

List<Questions> questionslist = [];
List<Questions> questionslistNewEntrys = [];
List<Questions> questionslistAlreadyExits = [];
bool apiCheck = false;
bool databasecheck = false;
  class StartPageState extends State<StartPage>{






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text("", style: TextStyle(color: '0xff16804e'.toColor())),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.data_usage,
                color: '#16804E'.toColor(),
              ),
              onPressed: () async {
                await Navigator.push(context,
                  CupertinoPageRoute(
                    builder: (context) => ChartOverviewPage(),
                  ),
                );

              }),
          IconButton(
              icon: Icon(
                Icons.settings,
                color: '#16804E'.toColor(),
              ),
              onPressed: () async {
                await Navigator.push(context,
                  CupertinoPageRoute(
                    builder: (context) => SettingsPage(),
                  ),
                );
              })
        ],
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Image.asset("assets/hfu_logo.png"),
              ),
              SizedBox(height: 50),
              Container(
                height: 60,
                margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
                child: SizedBox(
                  width: 250.0,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Agne',
                      color: Colors.black,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText('Studieren auf höchstem Niveau!',speed: const Duration(milliseconds: 100)),
                      ],
                      onTap: () {
                        print("Tap Event");
                      },
                    ),
                  ),
                ),
              ),
              //SizedBox(height: 100),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.amber,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                            )),
                        onPressed: () async {
                        if(databasecheck == false){
                          await writeToDatabase();
                        changeDatabaseBool();
                        }
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => QuizOverViewPage()));
                          print("Quiz auswählen pressed");
                        },
                        child: Text(
                          'Quiz auswählen',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ))),
            ],
          )),
    );
  }

  //Api Download implementation

  Future<String> fetchData() async {
    String urlpuffer = "";
    final url =
        'https://drive.google.com/uc?export=download&id=1ZufPOhnwDPtSC4O-ap-V1vOkwNM8HVQ0';
    try{
      final checker = await http.get(Uri.parse(url));
    }catch(SocketExcetion){
      print("No Internet Conncetion");
      showToast("Download fehlgeschlagen");
    }
    try{
      final response = await http.get(Uri.parse(url));
      if(response.statusCode !=200){

        print("No Internet Conncetion");
        showToast("Download fehlgeschlagen");
      }
      if (response.statusCode == 200) {
        print(response.toString());
        print('succesfull parse');
        this.setState(() {
          Map<String, dynamic> map = json.decode(response.body);
          data = map["quizsets"];
          //data = json.decode(response.body);
          //print(data);
          data!.forEach((element) =>
              questionslist.add(new Questions.fromJsonApi(element)));
          print("Anzahl der Questionsobjekte");
          print(questionslist.length);
          print(questionslist);
        });
        checkForNewEntrys();
      }}catch(SocketExption){
      print("No Internet Conncetion");
      showToast("Download fehlgeschlagen");
    }
    return "null";
  }
  @override
  void initState() {
    resetQuestionslist();
    super.initState();
    if(apiCheck == false){
      fetchData();
      changeApiBool();
    }
    else
    {
      print("Already checked");
    }
  }
  void changeApiBool(){
    apiCheck = true;
  }
void changeDatabaseBool(){

    databasecheck = true;
}
  Questions ? q1;
  checkForNewEntrys()  async {
    for(int i = 0; i < questionslist.length; i++){
      final bool puffer = await QuestionsDatabase.instance.readbyQuestiontextAndCheckforExisting(questionslist[i].questiontext);
      print(puffer);
      if(puffer == true){
        print("################################");
        print("Bereits in Datennbank vorhanden");
        print(QuestionsDatabase.instance.readNotebyQuestiontext(questionslist[i].questiontext));
        print(questionslist[i].questiontext);
        questionslistAlreadyExits.add(questionslist[i]);
        showToast("Keine neuen Daten");
      }
      else{
        print("++++++++++++++++++++++++++++++++++++++");
        print("Eintrag in Datennbank nicht vorhanden");
        print(QuestionsDatabase.instance.readNotebyQuestiontext(questionslist[i].questiontext));
        print(questionslist[i].questiontext);
        questionslistNewEntrys.add(questionslist[i]);
      }
    }
    showToast("Datenbank aktuell");
    showNewEntrys();
  }

  Future<void> writeToDatabase() async {
    print("Write to Database ... ");
    for (int i = 0; i < questionslistNewEntrys.length; i++) {
      await QuestionsDatabase.instance.create(questionslistNewEntrys[i]);
      print("QuestionsObjekt");
      print(questionslistNewEntrys[i]);
    }
    print(" ......finished! ");
    showNewEntrys();
  }
  void showNewEntrys(){
    print("New Entrys are:");
    for (int i = 0; i < questionslistNewEntrys.length; i++){
      print(questionslistNewEntrys[i]);
    }
    print("Entrys already exits;");
    for (int i = 0; i < questionslistAlreadyExits.length; i++){
      print(questionslistAlreadyExits[i]);
    }
  }
  void showToast(String text){
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 100
    );
  }
  void resetQuestionslist() {
    setState(() {
      questionslist = [];
      questionslistNewEntrys = [];
      questionslistAlreadyExits = [];
      apiCheck = false;
    });

  }
}
