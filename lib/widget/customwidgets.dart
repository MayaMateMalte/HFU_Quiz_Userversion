/**
 * Created by Malte Denecke
 */

              import 'package:classroomquiz_usersedition/model/questions.dart';
              import 'package:flutter/material.dart';
              import 'package:classroomquiz_usersedition/const/const.dart';
              extension ColorExtension on String {
                toColor() {
                  var hexColor = this.replaceAll("#", "");
                  if (hexColor.length == 6) {
                    hexColor = "FF" + hexColor;
                  }
                  if (hexColor.length == 8) {
                    return Color(int.parse("0x$hexColor"));
                  }
                }
              }

              Widget answerCard(String text, Color color, BuildContext context) {
                return Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      elevation: 5,
                      color: color,
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Text(
                                text,
                                style: TextStyle(color: Colors.black, fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )),
                    ));
              }

              checkTruefalse() {}

              Widget solutionCard(String text, BuildContext context) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.004,
                  width: MediaQuery.of(context).size.width,


                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    elevation: 5,
                    color: Colors.white54,
                    child: Stack(

                      children: [
                        Center(
                        child: Container(margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.05,MediaQuery.of(context).size.height * 0.005,MediaQuery.of(context).size.width*0.05,0),
                          child: Text(
                            text,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.normal,

                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),

                    ] ),
                  ),
                );
              }

              Widget listViewCard(String text, BuildContext context) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    elevation: 3,
                    color: Colors.white70,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          text,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                );
              }

              Widget submitButton(String text, BuildContext context) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    elevation: 3,
                    color: Colors.amber,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          text,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                );
              }

              TextStyle headerTextStyle() {
                return TextStyle(
                    color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold);
              }
