import 'package:flutter/cupertino.dart';

extension StringExtensions on dynamic {
  Widget text() => Text(this.toString());
}

extension WidgetExtensions on Widget {
  Widget pad({double padding = 8}) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: this,
    );
  }
}
