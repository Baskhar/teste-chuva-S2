

import 'dart:convert';

import 'package:chuva_dart/app/data/http/exeptions.dart';
import 'package:chuva_dart/app/data/models/event_model.dart';

import '../http/http_client.dart';

abstract class IEventRepository{
  Future<List<EventModelTeste>>getEvents({required String url});
}

class EventRepository implements IEventRepository{
  final IHttpClient client;
  EventRepository({required this.client});
  @override
  Future<List<EventModelTeste>> getEvents( {required String url}) async {
    final response = await client.get(url: url);

    if (response.statusCode == 200) {
      final dynamic responseData = json.decode(response.data);

      if (responseData is Map && responseData.containsKey("data")) {
        final dynamic jsonData = responseData["data"];

        if (jsonData is List) {
          final List<EventModelTeste> events = jsonData.map<EventModelTeste>((item) {

            return EventModelTeste.fromJson(item);
          }).toList();


          return events;
        } else {
          print("O JSON retornado não é uma lista");
          throw Exception("O JSON retornado não é uma lista.");
        }
      } else {
        print("O JSON retornado não contém a chave 'data'.");
        throw Exception("O JSON retornado não contém a chave 'data'.");
      }
    } else {
      print('Erro ao realizar requisição');
      throw NotFoundExeption('Erro ao realizar requisição');
    }

  }

  }

