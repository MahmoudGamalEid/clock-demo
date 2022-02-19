import 'package:clock_demo/controllers/world_clock_controller.dart';
import 'package:clock_demo/models/world_clock_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'analog_clock.dart';
import 'package:timezone/standalone.dart' as tz;

class ClockItem extends StatefulWidget {
  const ClockItem({Key? key, required this.clock}) : super(key: key);
  final WorldClock clock;
  @override
  State<ClockItem> createState() => _ClockItemState();
}

class _ClockItemState extends State<ClockItem> {
  bool _isDigital = true;

  @override
  Widget build(BuildContext context) {
    WorldClockController _worldClockController = Provider.of<WorldClockController>(context);
    var timeZone = tz.getLocation(widget.clock.timeZoneName);
    var offset = timeZone.currentTimeZone.offset ~/ 3600000;
    var abbreviation = timeZone.currentTimeZone.abbreviation;
    var description = "";
    if (offset.isNegative) {
      description = "$abbreviation, UTC $offset HRS";
    } else {
      description = "$abbreviation, UTC +$offset HRS";
    }
    return Slidable(
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context){
              _worldClockController.removeClock(widget.clock);
            },
            foregroundColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).backgroundColor,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Padding(
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
                                  description,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                            ),
                            FittedBox(
                              child: Text(
                                widget.clock.cityName,
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
                                          DateFormat('h:mm a').format(
                                              tz.TZDateTime.now(timeZone)),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1,
                                        ),
                                      ),
                                    )
                                  : Expanded(
                                      flex: 5,
                                      child: AnalogClock(
                                        time: tz.TZDateTime.now(timeZone),
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
      ),
    );
  }
}
