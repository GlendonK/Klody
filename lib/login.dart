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
      appBar: AppBar(
        title: Text("Klody"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: ClipOval(child: Image.asset(
                'assets/images/background.jpg',
                fit: BoxFit.fill,
              ),),
              width: 300,
              height: 300,
            ),
            LogInFields().build(context),
            // ElevatedButton(
            //     onPressed: () {
            //       Navigator.pushNamed(context, '/training');
            //     },
            //     style: ElevatedButton.styleFrom(
            //         primary: Theme.of(context).buttonColor),
            //     child: Text("To Swipe Page")),
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

                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(_usernameController.text +" " + _passwordController.text),
              duration: Duration(milliseconds: 1000),));
              _logInCreds = LogIn().logIn(_usernameController.text, _passwordController.text);

              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              // content: Container(child: checkLogIn(),),
              // duration: Duration(milliseconds: 5000),));

              //log("HERER IS WORK");
              //log(UserId.userId);
              //checkLogIn();

              if (UserId.userId != "") {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(UserId.userId),
              duration: Duration(milliseconds: 5000),));
                Navigator.pushNamed(context, '/training');
              }
                },
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).buttonColor),
                child: Text("Log In")),
        ],
      ),
    );
  }

  // This is the future builder for log in funciton, to do something if log in susscess or fail
  // ! check the url if correct.
  FutureBuilder<String> checkLogIn() {
    log('HERE IS FUTURE BUILDER');
    return FutureBuilder<String>(
      future: _logInCreds,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // save the user id into static class variable
          UserId.userId = snapshot.data;
          log(snapshot.data.toString());
          
          //Navigator.pushNamed(context, '/training');
        
          return Text(snapshot.data);
        } else if (snapshot.hasError) {
          log(snapshot.error.toString());
          return Text('${snapshot.error}');
        } else if (snapshot.data == "False" || snapshot.data == "false") {
          log(snapshot.data.toString());
          return Text(snapshot.data.toString());
        } else if (!snapshot.hasData) {
          log("NO DATA");
          return Text("log in no data");
        }

        return Text("");
      },
    );
  }
}
