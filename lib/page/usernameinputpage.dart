/**
 * Created by Malte Denecke
 */
import 'package:classroomquiz_usersedition/db/usernamedatabase.dart';
import 'package:classroomquiz_usersedition/model/username.dart';
import 'package:classroomquiz_usersedition/page/quizoverviewpage.dart';
import 'package:classroomquiz_usersedition/page/settingspage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:classroomquiz_usersedition/page/quizpage.dart';
import 'package:classroomquiz_usersedition/const/const.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:classroomquiz_usersedition/widget/customwidgets.dart';

import '../main.dart';


class UserNameInputApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: UserNameInputPage());
  }
}

class UserNameInputPage extends StatelessWidget {
  final textController = TextEditingController();
  late String puffer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("", style: TextStyle(color: '0xff16804e'.toColor())),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.settings,
                color: '#16804E'.toColor(),
              ),
              onPressed: () async {
                await Navigator.push(context,
                  MaterialPageRoute(
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

              Container(

                padding: EdgeInsets.fromLTRB(10,2,10,2),
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),

                    border: Border.all(color: Colors.blue,
                    width: 2),
                ),
                child: TextField(

                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Username",
                  ),
                  controller: textController,
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                            )),
                        onPressed: () async {
                          puffer = textController.text;
                          Username u1 = new Username(username: puffer);
                          await UsernameDatabase.instance.create(u1);
                          print("Hinzugefügter Username ist:");
                          print(textController.text);
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Bestätigen',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ))),


            ],
          )),
    );
  }
}
