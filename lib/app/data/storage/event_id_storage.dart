import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventIdStorage extends ChangeNotifier {
  late SharedPreferences _prefs;
  late List<int> _idEvents;

  List<int> get idEvents => _idEvents;

  EventIdStorage() {
    _idEvents = [];
    _initStorage();
  }

  Future<void> _initStorage() async {
    _prefs = await SharedPreferences.getInstance();
    _idEvents = _prefs.getStringList('idEvents')?.map(int.parse).toList() ?? [];
    notifyListeners();
  }

  Future<void> addIdEvent(int id) async {
    _idEvents.add(id);
    await _prefs.setStringList('idEvents', _idEvents.map((id) => id.toString()).toList());
    notifyListeners();
  }

  Future<void> removeIdEvent(int id) async {
    _idEvents.remove(id);
    await _prefs.setStringList('idEvents', _idEvents.map((id) => id.toString()).toList());
    notifyListeners();
  }

  Future<void> clearIdEvents() async {
    _idEvents.clear();
    await _prefs.remove('idEvents');
    notifyListeners();
  }

  bool contains(int id) {
    return _idEvents.contains(id);
  }
}
