import 'package:flutter/material.dart';

class AddAlarmModalBottomSheet extends StatelessWidget {
  const AddAlarmModalBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FractionallySizedBox(
        heightFactor: 0.9,
        child:  Center(child: Text("Here you add a new alarm bro")));
  }
}
