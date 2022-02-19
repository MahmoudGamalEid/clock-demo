import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'analog_clock.dart';

class LocalTimeClock extends StatefulWidget {
  const LocalTimeClock({Key? key}) : super(key: key);

  @override
  State<LocalTimeClock> createState() => _LocalTimeClockState();
}

class _LocalTimeClockState extends State<LocalTimeClock> {
  String? _timezone;
  var _isDigital = true;

  @override
  Widget build(BuildContext context) {
    _timezone = Provider.of<String?>(context);
    if(_timezone !=null){
      _timezone = _timezone!.split("/")[1];
    }
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 8.0),
                            child: FittedBox(
                              child: Text(
                                DateTime.now().timeZoneName,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ),
                          FittedBox(
                            child: _timezone == null
                                ? const CupertinoActivityIndicator()
                                : Text(
                                    _timezone!,
                                    style:
                                        Theme.of(context).textTheme.headline2,
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
