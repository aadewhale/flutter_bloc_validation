import 'dart:async';

import 'package:flutter/material.dart';

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0.0, size.height);
    path.quadraticBezierTo(
        size.width / 4, size.height - 40, size.width / 2, size.height - 20);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, size.height - 30);

    path.lineTo(size.width, 0.0);
    return path;
  }

  @override
  bool shouldReclip(MyCustomClipper oldClipper) => true;
}

mixin Validation {
  final fNameValidate =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (value.length < 7) {
      sink.addError('This field');
    } else {
      sink.add(value);
    }
  });

  final lNameValidate =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (value.length < 7) {
      sink.addError('This field cannot be null');
    } else {
      sink.add(value);
    }
  });
  final eMailValidate =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      sink.addError('Enter the e-mail');
    } else if (!regExp.hasMatch(value)) {
      sink.addError('The e-mail is invalid!');
    } else {
      sink.add(value);
    }
  });

  final passwordValidate =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      sink.addError('Enter the password');
    } else if (!regExp.hasMatch(value)) {
      sink.addError('The password must contain numbers and special case');
    } else {
      sink.add(value);
    }
  });

  //another validations
  final onlyNumbers =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      sink.addError('This filed cannot be null');
    } else if (!regExp.hasMatch(value)) {
      sink.addError('Just numbers are accepted');
    } else {
      sink.add(value);
    }
  });

  final cannotBeNull =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (value.length == 0) {
      sink.addError('This field cannot be null');
    } else {
      sink.add(value);
    }
  });

  final zipCodeValidate =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    int tamanho = value.length;
    if (tamanho == 0) {
      sink.addError("Zipcode is required");
    } else if (tamanho > 0 && tamanho < 9) {
      sink.addError("Zipcode is invalid");
    } else {
      sink.add(value);
    }
  });
}
