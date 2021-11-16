/**
 * Created by Malte Denecke
 */

import 'package:classroomquiz_usersedition/page/quizoverviewpage.dart';
import 'package:flutter/material.dart';

showAlertDialog(BuildContext context) {  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed:  () {
      print("Quiz nicht löschen!");
      Navigator.of(context).pop();},
  );
  Widget continueButton = TextButton(
    child: Text("Continue"),
    onPressed:  () {
      print("Quiz löschen!");
      Navigator.of(context).pop();
    },
  );  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("AlertDialog"),
    content: Text("Would you like to continue learning how to use Flutter alerts?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  ); }