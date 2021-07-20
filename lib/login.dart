import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klody/trainingSwipePage.dart';
import 'package:klody/userId.dart';
import 'package:klody/webApi.dart';

class LogInPage extends StatefulWidget {
  @override
  LogInPageState createState() => LogInPageState();
}

class LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Klody"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/background.jpg',
                  fit: BoxFit.fill,
                ),
              ),
              width: 300,
              height: 300,
            ),
            LogInFields().build(context),
          ],
        ),
      ),
    );
  }
}

class LogInFieldsState extends StatefulWidget {
  @override
  LogInFields createState() {
    return LogInFields();
  }
}

class LogInFields extends State<LogInFieldsState> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Future<String> _logInCreds;

  // method to call log in api
  Future callLogin(TextEditingController _usernameController,
      TextEditingController _passwordController) async {
    //** call logIn() api */
    _logInCreds = await LogIn()
        .logIn(_usernameController.text, _passwordController.text)
        .then((value) {
      UserId.userId = value;

      // when status 404.
      if (value == null || value == "") {
        log("valie:" +value);
        callLogin(_usernameController, _passwordController);
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 300,
              child: TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      hintText: "Username"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please type something';
                    }
                    return null;
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: SizedBox(
              width: 300,
              child: TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      hintText: "Password"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please type something';
                    }
                    return null;
                  }),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                //UserId.userId = "" ;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(_usernameController.text +
                      " " +
                      _passwordController.text),
                  duration: Duration(milliseconds: 1000),
                ));

                // method to call log in api.
                await callLogin(_usernameController, _passwordController);

                //** log in logic. */
                if (UserId.userId.toString() != "") {
                  if (UserId.userId.length > 6) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(UserId.userId),
                      duration: Duration(milliseconds: 5000),
                    ));
                    Navigator.pushNamed(context, '/training');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Failed log in"),
                      duration: Duration(milliseconds: 5000),
                    ));
                  }
                }
                //checkLogIn();
              },
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).buttonColor),
              child: Text("Log In")),
        ],
      ),
    );
  }
}
