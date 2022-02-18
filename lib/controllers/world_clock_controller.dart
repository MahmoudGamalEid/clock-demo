import 'package:clock_demo/models/world_clock_model.dart';
import 'package:flutter/cupertino.dart';

class WorldClockController extends ChangeNotifier{
  List<WorldClock> _clocks = [];

  List<WorldClock> get clocks => _clocks;

  addClock(WorldClock worldClock){
    _clocks.add(worldClock);
    notifyListeners();
  }
  removeClock(WorldClock worldClock){
    _clocks.remove(worldClock);
    notifyListeners();
  }
}