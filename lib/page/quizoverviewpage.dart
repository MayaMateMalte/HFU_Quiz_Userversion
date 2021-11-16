/**
 * Created by Malte Denecke
 */

import 'package:classroomquiz_usersedition/db/gamename_database.dart';
import 'package:classroomquiz_usersedition/db/questions_database.dart';
import 'package:classroomquiz_usersedition/model/gamename.dart';
import 'package:classroomquiz_usersedition/model/questions.dart';
import 'package:classroomquiz_usersedition/page/quizpage.dart';
import 'package:classroomquiz_usersedition/widget/showalertdialog.dart';
import 'package:classroomquiz_usersedition/widget/customwidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:classroomquiz_usersedition/page/settingspage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';



            class QuizOverViewPage extends StatefulWidget {

              QuizOverViewPage({Key? key}) : super(key: key);

              @override
              _QuizOverViewPageState createState() => _QuizOverViewPageState();
            }
            class _QuizOverViewPageState extends State<QuizOverViewPage>{

              String qrCode2 = '';
              String scanstatus = "Starte Scan";
              String value2 = "";
              bool scanned = false;
            //  final List<String> gamenamelist = ["Mobile Systeme", "Internet Working", "Programmieren 2","App Programmierung","Mathematik und Statistik",
           //     "Business Intelligence","Datenbanken","Integrierte Standardsoftware","Rechnungswesen"];
              static bool quizscanned = false;
              late List<Gamename> gamenamesfuture;
                List<String> gamenamepufferlist= [];
               List<String> gamenamepufferlist2 =[];




              //static works better as the state of the art final -> flutter api: pass data through constructor
              static String value = "";

              late List<Questions> questionsfuture;
              late Future<int> sqlcounter;
              static List<String> pufferlist= [];
               List<String> pufferlist2 =[];
              static int sqlstaticcounter = 0;
              final List<String> gamenamelistpuffer = ["Mobile Systeme", "Internet Working", "Programmieren 2","App Programmierung","Mathematik und Statistik",
              "Business Intelligence","Datenbanken","Integrierte Standardsoftware","Rechnungswesen"];



              @override
                initState()   {

                getnames();

                print("GamePufferList");
                print(gamenamepufferlist2);
                print("pufferlist2");
                print(pufferlist2);
                super.initState();
              }

              Future getnames() async {
                // this.questionsfuture = await QuestionsDatabase.instance.getGamenames();
                this.questionsfuture = await QuestionsDatabase.instance.readAllQuestions();
                if(questionsfuture.isNotEmpty){
                  print(questionsfuture.length);
                  for(Questions item in questionsfuture)
                  {
                    // print(pufferlist.length);
                    // print(item.gamename);
                    pufferlist.add(item.gamename);
                  }
                  pufferlist2 = pufferlist.toSet().toList();
                  print(pufferlist2);
                  print(pufferlist2.length);

                }
                return pufferlist2;
              }

              Future getGameNames() async{
                this.gamenamesfuture = await GamenameDatabase.instance.readAllGamenames();
                print("getGamenames wurde aufgerufen");
                if(gamenamesfuture.isNotEmpty){

                  print("GetgamesName länge:");
                  print(gamenamesfuture.length);
                for(Gamename item in gamenamesfuture)
                {
                  // print(pufferlist.length);
                  // print(item.gamename);

                  gamenamepufferlist.add(item.gamename);
                }
                  gamenamepufferlist2 = gamenamepufferlist;
                gamenamepufferlist2 = gamenamepufferlist.toSet().toList();
                print(gamenamepufferlist2);
                return gamenamepufferlist2;}

                else {
                  gamenamepufferlist2 = ["Fügen Sie ein Spiel hinzu"];
                  return gamenamepufferlist2 = ["Fügen Sie ein Spiel hinzu"];
                }
              }

              @override
              Widget build(BuildContext context){
                return Scaffold(
                  appBar: AppBar(
                    title: Text("Übersicht"),
                    backgroundColor: Color(0xFF16804E),
                    centerTitle: true,

                  ),
                  body:Center(
                    child: Container(
                      decoration: BoxDecoration(image: DecorationImage(
                          image:AssetImage("assets/background.png"),
                      fit: BoxFit.fill)),
                      child: FutureBuilder(
                          future: getGameNames(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            } else { return
                              Container(
                                  child: ListView.builder(
                                      itemCount: gamenamepufferlist2.length,
                                      //scrollDirection: Axis.horizontal,
                                      itemBuilder: (BuildContext context, int index) {
                                        return GestureDetector(
                                          child: Container(
                                            height: 80, width: 100,
                                            child: listViewCard(gamenamepufferlist2[index],context)),
                                          onTap: (){
                                            print(gamenamepufferlist2[index]);
                                            value = gamenamepufferlist2[index];

                                            Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                    builder: (context) => QuizPage(value:value)));



                                          },

                                          onLongPress: ()  => showDialog<String>(

                                            context: context,
                                            builder: (BuildContext context) => AlertDialog(
                                              title: const Text('Quiz löschen?'),
                                              content: Text(gamenamepufferlist2[index]),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () => Navigator.pop(context, 'Cancel'),
                                                  child: const Text('Abbrechen'),
                                                ),
                                                TextButton(
                                                  onPressed: () => deleteCourse(gamenamepufferlist2[index]),
                                                  child: const Text('Löschen'),
                                                ),
                                              ],
                                            ),
                                          ),



                                        );
                                      }));
                            }
                          }),
                    ),

                  ),


                  floatingActionButton: SpeedDial(
                      icon: Icons.add,
                      backgroundColor: Color(0xFF16804E),
                      children: [
                        SpeedDialChild(
                          child: Icon(Icons.qr_code),
                          label: 'QR Code scannen',
                          backgroundColor: Color(0xFF16804E),
                          onTap: () {scanQRCode();},
                        ),
                        SpeedDialChild(
                          child: Icon(Icons.text_fields),
                          label: 'Quiz eintippen',
                          backgroundColor: Color(0xFF16804E),
                          onTap: () {
                            _displayTextInputDialog(context);
                            print("///////////////////////////////");

                            setState(() {

                            });
                            },
                        ),

                      ]),

                );
              }



              void deleteCourse(String paketname){
                 GamenameDatabase.instance.delete2(paketname);
                  print(paketname);
                  for(int i = 0; i < gamenamepufferlist2.length; i++){
                    if(gamenamepufferlist2[i] ==paketname){
                      gamenamepufferlist2.removeAt(i);
                    }else{
                      //do nothing
                    }
                  }

                 for(int i = 0; i < gamenamepufferlist.length; i++){
                   if(gamenamepufferlist[i] ==paketname){
                     gamenamepufferlist.removeAt(i);
                   }else{
                     //do nothing
                   }
                 }


                  setState(() {

                  });

                 Navigator.pop(context, 'OK');

              }



              TextEditingController _textFieldController = TextEditingController();
              Future<void> _displayTextInputDialog(BuildContext context) async {

                return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Quiz hinzufügen'),
                      content: TextField(
                        controller: _textFieldController,
                        decoration: InputDecoration(hintText: "Quiz eingeben"),
                      ),
                      actions: <Widget>[
                        //Kann durch TextButton ausgetauscht werden
                        FlatButton(
                          child: Text('Abbrechen'),
                          onPressed: () {

                            Navigator.pop(context);
                          },
                        ),
                       //Kann durch TextButton ausgetauscht werden
                        FlatButton(
                          child: Text('Hinzufügen'),
                          onPressed: () {
                            print(_textFieldController.text);
                            checkForCourse(_textFieldController.text);
                            Navigator.pop(context);

                          },
                        ),
                      ],
                    );
                  },
                );
              }





              Future checkForCourse(String puffer) async{
                for (int i = 0; i < gamenamelistpuffer.length; i++){
                  if(puffer == gamenamelistpuffer[i]){
                    value2 = gamenamelistpuffer[i];
                    print("//////////////////////////////////////////");
                    print("Kurs wurde gefunden");
                    print(value2);
                    quizscanned = true;



                  }
                }
                await getnames();
                print(pufferlist2);

                for (int i = 0; i < pufferlist2.length; i++){
                  if(puffer == pufferlist2[i]){
                    value2 = pufferlist2[i];
                    print("****************************");
                    print("Kurs wurde gefunden");
                    print(value2);
                    quizscanned = true;
                    Gamename g1 = new Gamename(gamename: value2);

                    await GamenameDatabase.instance.create(g1);
                    List<Gamename> gpuffer = await GamenameDatabase.instance.readAllGamenames();
                    print(gpuffer);
                    setState(() {

                    });
                  }
                }

              }

              Future<void> scanQRCode() async {
                try {
                  final qrCode = await FlutterBarcodeScanner.scanBarcode(
                    '#008452',
                    'abbrechen',
                    true,
                    ScanMode.QR,
                  );

                  if (!mounted) return;

                  setState(() {
                    this.qrCode2 = qrCode;
                    print(qrCode2);
                    checkForCourse(qrCode2);
                    this.scanstatus = "Du hast gescannt";

                  });
                }
                on PlatformException {
                  qrCode2 = 'Failed to get platform version.';
                }
              }
            }