import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'analog_clock.dart';

class ClockItem extends StatefulWidget {
  const ClockItem({Key? key}) : super(key: key);

  @override
  State<ClockItem> createState() => _ClockItemState();
}

class _ClockItemState extends State<ClockItem> {
  bool _isDigital = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 1)),
        builder: (context, snapshot) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              children: [
                Divider(color: Theme.of(context).colorScheme.tertiary),
                Flexible(
                  fit: FlexFit.tight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("Digital"),
                      CupertinoSwitch(
                          value: _isDigital,
                          onChanged: (val) {
                            setState(() {
                              _isDigital = val;
                            });
                          }),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                            child: Text(
                              DateTime.now().timeZoneName,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              "Cairo",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: SizedBox(
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _isDigital
                                ? Flexible(
                                    child: FittedBox(
                                      child: Text(
                                        DateFormat('h:mm a')
                                            .format(DateTime.now()),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1,
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    flex: 5,
                                    child: AnalogClock(
                                      time: DateTime.now(),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
