import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../data/models/event_model.dart';
import '../../data/storage/event_id_storage.dart';
import '../home_module/home_store.dart';

class PeopleScreen extends StatefulWidget {
   String? name;
   Map<String, dynamic>? bio;
   String? foto;
   String? institution;

   PeopleScreen(
      {super.key,
      required this.name,
      required this.bio,
      required this.foto,
      required this.institution});

  @override
  State<PeopleScreen> createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  @override
  Widget build(BuildContext context) {
    final eventIdStorage = Provider.of<EventIdStorage>(context, listen: false);
    EventStore eventStore = Provider.of<EventStore>(context);

    String? bioText = widget.bio?['pt-br'] ;
    List<EventModelTeste> eventos = eventStore.state.value
        .where((evento) =>
        evento.people.any((pessoa) => pessoa['name'] == widget.name))
        .toList();

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        toolbarHeight: 70,
        centerTitle: true,
        backgroundColor: Color(0xff456189),
        title: Column(children: [
          const Text(
            'Chuva 💜 Flutter',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ]),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: widget.foto != null
                        ? CachedNetworkImageProvider(
                      widget.foto!,
                    )
                        : null,
                    child: widget.foto == null
                        ? Icon(Icons.person, size: 30)
                        : null,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        widget.institution ?? '',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Visibility(
              visible: bioText!=null,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Bio",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(bioText ?? ''),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Atividades",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Text(
                        '${_getAbbreviatedDayOfWeek(DateTime.now())}, ${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: eventos.map((evento) {
                String startTime = DateFormat('HH:mm').format(evento.start);
                String endTime = DateFormat('HH:mm').format(evento.end);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: evento.category['color'] != null
                                ? getColorFromCss(evento.category['color'])
                                : Colors.black,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5)),
                          ),
                          height: 120,
                          width: 8,
                        ),
                        Visibility(
                          visible: eventIdStorage.contains(evento.id),
                          child: Positioned(
                            right: 5,
                            child: Icon(
                              Icons.bookmark,
                              color: Color(0xff7C90AC),
                            ),
                          ),
                        ),
                        Container(
                          height: 120,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${evento.type['title']['pt-br']} de ${startTime} até ${endTime} ',
                                  style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${evento.title['pt-br']}',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '${evento.people.isNotEmpty ? evento.people[0]['name'] : ''}',
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

  String _getAbbreviatedDayOfWeek(DateTime date) {
    final List<String> weekdaysAbbreviations = [
      'Dom',
      'Seg',
      'Ter',
      'Qua',
      'Qui',
      'Sex',
      'Sáb'
    ];
    return weekdaysAbbreviations[date.weekday - 1];
  }
}
