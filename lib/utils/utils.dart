import 'package:flutter/material.dart';

TextStyle extend(TextStyle style1, TextStyle style2) {
  return style1.merge(style2);
}
