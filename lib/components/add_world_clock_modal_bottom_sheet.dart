import 'package:clock_demo/components/world_clock_selection_item.dart';
import 'package:clock_demo/models/world_clock_model.dart';
import 'package:flutter/material.dart';
import 'package:timezone/standalone.dart' as tz;

class AddWorldClockModalBottomSheet extends StatefulWidget {
  const AddWorldClockModalBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddWorldClockModalBottomSheet> createState() =>
      _AddWorldClockModalBottomSheetState();
}

class _AddWorldClockModalBottomSheetState
    extends State<AddWorldClockModalBottomSheet> {
  String _searchTerm = "";
  late List<String> _timeZones;
  List<String> rawTimeZones = tz.timeZoneDatabase.locations.keys.toList();

  List<String> _cleanTimeZoneName(String timeZoneName) {
    String cleanTz = timeZoneName.replaceAll("_", " ");
    String cityName;
    String regionName = cleanTz.split("/")[0];
    if (cleanTz.split("/").length >= 3) {
      cityName = cleanTz.split("/")[2];
    } else {
      cityName = cleanTz.split("/")[1];
    }
    return [cityName, regionName];
  }

  List<String> _search(List<String> timezones) {
    List<String> result = [];
    for (var element in timezones) {
      if (element.contains(_searchTerm)) {
        result.add(element);
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    _timeZones = _search(rawTimeZones);
    return SafeArea(
      child: FractionallySizedBox(
          heightFactor: 0.9,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Padding(
                  padding:  EdgeInsets.all(8.0),
                  child:  Text("Choose a city"),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Search',
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )),
                              onChanged: (val) {
                                setState(() {
                                  _searchTerm = val;
                                });
                              },
                            ),
                          ),
                        ),
                        MaterialButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 15),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomScrollView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      slivers: [
                        SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                          if (index < _timeZones.length) {
                            List<String> cityRegion =
                                _cleanTimeZoneName(_timeZones[index]);
                            WorldClock clock = WorldClock(
                                cityName: cityRegion[0],
                                regionName: cityRegion[1],
                                timeZoneName: _timeZones[index]);
                            return WorldClockSelectionItem(clock: clock);
                          }
                        }, childCount: _timeZones.length)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
