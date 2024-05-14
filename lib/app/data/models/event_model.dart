
import 'package:json_annotation/json_annotation.dart';

part 'event_model.g.dart';

@JsonSerializable(nullable: true)
class EventModelTeste {
  final int id;
  final int changed;
  final DateTime start; // Alterado para DateTime
  final DateTime end; // Alterado para DateTime
  final Map<String, dynamic> title;
  final Map<String, dynamic> description;

  //final Category category;
  final Map<String, dynamic> category;

  //final Location locations;
  final List<Map<String, dynamic>> locations;

  //final EventType type;
  final Map<String, dynamic> type;
  final List<dynamic> papers;

  // final List<Person> people;
  final List<Map<String, dynamic>> people;
  final int status;
  final int weight;
  final dynamic addons;
  final dynamic parent;
  final String event;

  EventModelTeste(
      this.id,
      this.changed,
      this.status,
      this.weight,
      this.addons,
      this.parent,
      this.event,
      this.papers,
      this.title,
      this.description,
      this.start,
      this.end,
      this.category,
      this.locations,
      this.type,
      this.people);

  factory EventModelTeste.fromJson(Map<String, dynamic> json) =>
      _$EventModelTesteFromJson(json);

  Map<String, dynamic> toJson() => _$EventModelTesteToJson(this);
}
