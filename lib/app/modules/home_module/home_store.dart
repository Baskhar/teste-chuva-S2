import 'package:chuva_dart/app/data/models/event_model.dart';
import 'package:chuva_dart/app/data/repositories/event_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../data/http/exeptions.dart';
import '../../data/storage/event_id_storage.dart';

class EventStore {
  final IEventRepository repository;

  EventStore({required this.repository});

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<List<EventModelTeste>> state = ValueNotifier<List<EventModelTeste>>([]);
  final ValueNotifier<String> error = ValueNotifier<String>('');

  Future<void> getEvents() async {
    await _fetchEvents();

  }

  Future<void> getSecondEvents() async {
    await _fetchEvents();
  }
  Future<void> _fetchEvents() async {
    isLoading.value = true;
    try {
      final result1 = await repository.getEvents(url: 'https://raw.githubusercontent.com/chuva-inc/exercicios-2023/master/dart/assets/activities.json');
      state.value = result1;
      final result2 = await repository.getEvents(url: 'https://raw.githubusercontent.com/chuva-inc/exercicios-2023/master/dart/assets/activities-1.json');
      state.value.addAll(result2);
    } on NotFoundExeption catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
  List<EventModelTeste> getEventsForDay(int day) {
    return state.value.where((event) {
      final eventDay = int.parse(DateFormat('dd').format(event.start));
      return eventDay == day;
    }).toList();
  }
}

//   Future<void> _fetchEvents(String url) async {
//     isLoading.value = true;
//     try {
//       final result = await repository.getEvents(url: url);
//       state.value = result;
//     } on NotFoundExeption catch (e) {
//       error.value = e.message;
//     } catch (e) {
//       error.value = e.toString();
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

Color getColorFromCss(String cssColor) {
  if (cssColor.startsWith('#')) {
    cssColor = cssColor.substring(1);
  }

  int hexColor = int.parse(cssColor, radix: 16);

  if (cssColor.length == 6) {
    hexColor = hexColor + 0xFF000000;
  }

  return Color(hexColor);
}

