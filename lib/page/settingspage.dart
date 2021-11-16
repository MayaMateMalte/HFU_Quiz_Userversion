/**
 * Created by Malte Denecke
 */


        import 'package:classroomquiz_usersedition/db/IncorrectCorrectAnswered_database.dart';
import 'package:classroomquiz_usersedition/db/gamename_database.dart';
import 'package:classroomquiz_usersedition/db/questions_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../main.dart';

        class SettingsPage extends StatefulWidget {
          SettingsPage({Key? key}) : super(key: key);

          @override
          _SettingsWidgetState createState() => _SettingsWidgetState();
        }

        class _SettingsWidgetState extends State<SettingsPage> {
          final scaffoldKey = GlobalKey<ScaffoldState>();

          @override
          void initState() {


            super.initState();
          }



          @override
          Widget build(BuildContext context) {

            return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                backgroundColor: Color(0xFF16804E),
                title: Text("Einstellungen"),
              ),
              body: Center(child: Container(
                  width: MediaQuery.of(context).size.width,
                height: 60,
                margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.amber,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0),
                          )),
                      onPressed: ()  async {


                        showDialog<String>(

                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Appdaten löschen?'),
                            content: Text("Dies erfordert einen Neustart"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'Cancel'),
                                child: const Text('Abbrechen'),
                              ),
                              TextButton(
                                onPressed: () => deleteAppDataAndShowMessage(),
                                child: const Text('Löschen'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text(
                        'Appdaten zurücksetzen',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ))),
              ),
            );
          }





         void deleteAppDataAndShowMessage()
          async {
            print("deleteAppData Method");
            await QuestionsDatabase.instance.dropTable();
            await IncorrectCorrectAnsweredDatabase.instance.deleteTable();
            await GamenameDatabase.instance.deleteTable();
            Navigator.pop(context);
            showToast("Appdaten wurden zurückgesetzt");
            showToast("Starten Sie App nun neu");

          }

          void showToast(String text){
            Fluttertoast.showToast(
                msg: text,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 300
            );
          }
        }
