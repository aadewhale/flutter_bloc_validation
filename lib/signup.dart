import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

import 'constant.dart';

class EmailSignUp extends StatefulWidget {
  EmailSignUp({required this.title});

  final String title;

  @override
  _EmailSignUpState createState() => _EmailSignUpState();
}

class _EmailSignUpState extends State<EmailSignUp> {
  late RegistrationBloc _blocRegistration;

  var _controllerFname = TextEditingController();
  var _controllerLname = TextEditingController();
  var _controllerEmail = TextEditingController();
  var _controllerConfirmPassword = TextEditingController();
  var _controllerPassword = TextEditingController();

  @override
  void initState() {
    _blocRegistration = RegistrationBloc();
    _controllerConfirmPassword = TextEditingController(text: '');
    _controllerPassword = TextEditingController(text: '');

    super.initState();
  }

  bool _obscureText = true;
  bool _isChecked = true;
  bool _isLoading = false;
  bool isLoad = true;
  bool onTap = true;

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
            Visibility(
                visible: MediaQuery.of(context).viewInsets.bottom == 0,
                child: ClipPath(
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
                            'Create',
                            style: TextStyle(
                                fontFamily: 'FiraSans',
                                fontSize: 30,
                                color: Colors.white),
                          ),
                          Text(
                            'account',
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
                )),
            Visibility(
                visible: MediaQuery.of(context).viewInsets.bottom != 0,
                child: SizedBox(
                  height: 100,
                )),
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
      children: <Widget>[
        StreamBuilder<Object>(
            stream: _blocRegistration.fname$,
            builder: (context, snapshot) {
              return TextField(
                  controller: _controllerFname,
                  onChanged: (value) {
                    _blocRegistration.setFname(value);
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    errorText:
                        snapshot.hasError ? snapshot.error.toString() : null,
                    prefixIcon: Icon(Icons.person),
                    hintText: "First Name",
                  ));
            }),
        SizedBox(
          height: 20,
        ),
        StreamBuilder<Object>(
            stream: _blocRegistration.lname$,
            builder: (context, snapshot) {
              return Container(
                child: RawKeyboardListener(
                  focusNode: FocusNode(),
                  onKey: (input) => print('hhhhhhh'),
                  child: TextField(
                      controller: _controllerLname,
                      onChanged: (value) {
                        _blocRegistration.setLname(value);
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        errorText: snapshot.hasError
                            ? snapshot.error.toString()
                            : null,
                        prefixIcon: Icon(Icons.person),
                        hintText: "Last Name",
                      )),
                ),
              );
            }),
        StreamBuilder<Object>(
            stream: _blocRegistration.email$,
            builder: (context, snapshot) {
              return TextField(
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
        StreamBuilder<Object>(
            stream: _blocRegistration.confirmPassword$,
            builder: (context, snapshot) {
              return TextFormField(
                controller: _controllerConfirmPassword,
                onChanged: (value) {
                  _blocRegistration.setConfirmPassword(value);
                },
                textInputAction: TextInputAction.done,
                obscureText: true,
                decoration: InputDecoration(
                    errorText:
                        snapshot.hasError ? snapshot.error.toString() : null,
                    labelText: "Confirm the password",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                        icon: Icon(Icons.remove_red_eye), onPressed: _toggle)),
              );
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
                        child: Text('Sign up'),
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
                        child: Text('Log in'),
                      ),
                    )
                  : SizedBox();
            }),
      ],
    );
  }
}

class RegistrationBloc with Validation {
  final _fname = BehaviorSubject<String>();
  Stream<String> get fname$ => _fname.stream.transform(fNameValidate);
  void setFname(String value) => _fname.sink.add(value);
  void clearFname() => _fname.sink.add('');
  String get geFnameTxt => _fname.value;

  final _lname = BehaviorSubject<String>();
  Stream<String> get lname$ => _lname.stream.transform(lNameValidate);
  void setLname(String value) => _lname.sink.add(value);
  void clearLname() => _lname.sink.add('');
  String get geLnameTxt => _lname.value;

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

  final _confirmPassword = BehaviorSubject<String>();
  Stream<String> get confirmPassword$ =>
      _confirmPassword.stream.transform(passwordValidate).doOnData((String c) {
        if (0 != gePasswordStr.compareTo(c)) {
          _confirmPassword.addError("The passwords do not match");
        }
      });

  void setConfirmPassword(String value) => _confirmPassword.sink.add(value);
  void clearConfirmPassword() => _confirmPassword.sink.add('');
  String get geConfirmPasswordStr => _confirmPassword.value;

  Stream<bool> get submitValidate => Rx.combineLatest5(lname$, email$,
      password$, confirmPassword$, fname$, (l, e, p, c, f) => true);

  void dispose() {
    _fname.close();
    _lname.close();
    _confirmPassword.close();
    _email.close();
    _password.close();
    _confirmPassword.close();
  }
}
