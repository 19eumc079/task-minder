import 'package:flutter/material.dart';

class AlertDialogMethod {
  BuildContext context;
  Widget ok;
  Widget cancel;
  AlertDialogMethod(
      {required this.context, required this.cancel, required this.ok});
  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Would you like to delete of this Item\'s?'),
              ],
            ),
          ),
          actions: <Widget>[cancel, ok],
        );
      },
    );
  }
}
