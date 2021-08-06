import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'constant.dart';

class EmailSignIn extends StatefulWidget {
  EmailSignIn({
    required this.title,
  });

  final String title;

  @override
  _EmailSignInState createState() => _EmailSignInState();
}

class _EmailSignInState extends State<EmailSignIn> {
  late RegistrationBloc _blocRegistration;

  var _controllerEmail = TextEditingController();

  var _controllerPassword = TextEditingController();

  @override
  void initState() {
    _blocRegistration = RegistrationBloc();
    _controllerPassword = TextEditingController(text: '');
    super.initState();
  }

  bool _obscureText = true;
  bool _isChecked = true;
  bool _isLoading = false;
  bool isLoad = true;
  bool notLogin = false;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: MyCustomClipper(),
              child: Container(
                padding: EdgeInsets.all(20),
                height: 370,
                width: double.infinity,
                color: Colors.indigo,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Welcome',
                        style: TextStyle(
                            fontFamily: 'FiraSans',
                            fontSize: 30,
                            color: Colors.white),
                      ),
                      Text(
                        'back',
                        style: TextStyle(
                            fontFamily: 'FiraSans',
                            fontSize: 30,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ]),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: _buildForm(context),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        notLogin
            ? Container(
                height: 50,
                child: Text(
                  'Invalid username or Password',
                  style: TextStyle(color: Colors.red),
                ))
            : SizedBox(
                height: 50,
              ),
        StreamBuilder<Object>(
            stream: _blocRegistration.email$,
            builder: (context, snapshot) {
              return TextField(
                  autofocus: true,
                  controller: _controllerEmail,
                  onChanged: (value) {
                    _blocRegistration.setEmail(value);
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    errorText:
                        snapshot.hasError ? snapshot.error.toString() : null,
                    prefixIcon: Icon(Icons.mail),
                    hintText: "E-mail",
                  ));
            }),
        StreamBuilder<Object>(
            stream: _blocRegistration.password$,
            builder: (context, snapshot) {
              return TextField(
                  onChanged: (t) {
                    _blocRegistration.setPassword(t);
                  },
                  controller: _controllerPassword,
                  obscureText: _obscureText,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    errorText:
                        snapshot.hasError ? snapshot.error.toString() : null,
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: _isChecked
                        ? IconButton(
                            icon: Icon(Icons.remove_red_eye),
                            onPressed: _toggle,
                          )
                        : Icon(Icons.check),
                  ));
            }),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          TextButton(
            child: Text('Forget password?'),
            onPressed: null,
          ),
        ]),
        _isLoading
            ? CircularProgressIndicator(
                strokeWidth: 5,
              )
            : SizedBox(),
        StreamBuilder<Object>(
            stream: _blocRegistration.submitValidate,
            builder: (context, snapshot) {
              return isLoad
                  ? Container(
                      decoration: BoxDecoration(
                          color: snapshot.data != true
                              ? Colors.white
                              : Colors.indigoAccent,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: snapshot.data != true
                                ? Colors.indigoAccent
                                : Colors.white,
                          )),
                      child: MaterialButton(
                        elevation: 0,
                        minWidth: double.infinity,
                        onPressed: () {},
                        child: Text('Log in'),
                      ),
                    )
                  : SizedBox();
            }),
        SizedBox(
          height: 10,
        ),
        StreamBuilder<Object>(
            stream: _blocRegistration.submitValidate,
            builder: (context, snapshot) {
              return isLoad
                  ? Container(
                      decoration: BoxDecoration(
                          color: snapshot.data != true
                              ? Colors.indigoAccent
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: snapshot.data != false
                                ? Colors.indigoAccent
                                : Colors.white,
                          )),
                      child: MaterialButton(
                        elevation: 0,
                        minWidth: double.infinity,
                        onPressed: () {},
                        child: Text('Sign up'),
                      ),
                    )
                  : SizedBox();
            }),
      ],
    );
  }
}

class RegistrationBloc with Validation {
  final _email = BehaviorSubject<String>();
  Stream<String> get email$ => _email.stream.transform(eMailValidate);
  void setEmail(String value) => _email.sink.add(value);
  void clearEmail() => _email.sink.add('');
  String get geEmailTxt => _email.value;

  final _password = BehaviorSubject<String>();
  Stream<String> get password$ => _password.stream.transform(passwordValidate);
  void setPassword(String value) => _password.sink.add(value);
  void clearPassword() => _password.sink.add('');
  String get gePasswordStr => _password.value;

  Stream<bool> get submitValidate => Rx.combineLatest2(
      email$,
      password$,
      (
        e,
        p,
      ) =>
          true);

  void dispose() {
    _email.close();
    _password.close();
  }
}
