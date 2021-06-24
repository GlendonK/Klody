import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klody/trainingSwipePage.dart';
import 'package:klody/graphPage.dart';

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
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/training');
                },
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).buttonColor),
                child: Text("To Swipe Page")),
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
          )
        ],
      ),
    );
  }
}
