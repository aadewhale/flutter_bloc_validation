import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 3)),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(home: Splash());
          } else {
            return MaterialApp(
                title: 'Flutter bloc form validation',
                theme: ThemeData(
                  buttonTheme: Theme.of(context).buttonTheme.copyWith(
                        highlightColor: Colors.deepPurple,
                      ),
                  primarySwatch: Colors.indigo,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                home: HomePage());
          }
        });
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Service'),
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: Icon(Icons.arrow_back),
        automaticallyImplyLeading: true,
      ),
      body: Container(
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(30),
              color: Colors.blue,
              child: Column(
                children: [
                  Text(
                    'Water delivery',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'We deliver water at any point on the earth in 30 minutes',
                    style: TextStyle(fontSize: 16),
                  ),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(bottom: 20, top: 20),
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/second');
                      },
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                            fontFamily: 'FiraSans',
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed))
                              return Colors.yellow;
                            return Colors.white;
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2.0)),
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/third');
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed))
                              return Colors.black;
                            return Colors.transparent;
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Icon(
        Icons.access_alarm_outlined,
      )),
    );
  }
}
