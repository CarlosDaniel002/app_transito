import 'package:flutter/material.dart';

class MenuModel {
  // State fields for stateful widgets in this page.
  final unfocusNode = FocusNode();

  // Initialization and disposal methods.
  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

}
