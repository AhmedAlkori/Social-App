

import 'dart:ui';

import 'package:flutter/material.dart';

Color getColor(MessageState state)
{
  Color color;
  switch(state)
  {
    case MessageState.SUCCESS:
      color=Colors.green;
      break;
    case MessageState.WARNING:
      color=Colors.amberAccent;
      break;
    case MessageState.ERROR:
      color=Colors.red;
      break;

  }
  return color;
}

enum MessageState
{
  SUCCESS,
  WARNING,
  ERROR,
}