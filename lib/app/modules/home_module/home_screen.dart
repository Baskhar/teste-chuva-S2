import 'package:chuva_dart/app/data/http/http_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chuva_dart/app/data/models/event_model.dart';
import 'package:chuva_dart/app/modules/home_module/home_store.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


import '../../data/storage/event_id_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 // final _store = EventStore(repository: EventRepository(client: HttpClient()));
  int _selectedIndex = 0;
  List<EventModelTeste> _allEvents = [];
  late EventStore _store;
  @override
  void initState() {
    super.initState();
    _store = Provider.of<EventStore>(context, listen: false);
    _store.getEvents();
  }

  @override
  Widget build(BuildContext context) {
   // final _store = Provider.of<EventStore>(context);
    final eventIdStorage = Provider.of<EventIdStorage>(context, listen: false);


  //  _store.getEvents();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        centerTitle: true,
        backgroundColor: Color(0xff456189),
        title: Column(
          children: [
            const Text(
              'Chuva 💜 Flutter',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const Text(
              'Programação',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          color: Color(0xff306DC3),
                          borderRadius: BorderRadius.circular(30)),
                      child: Icon(
                        Icons.calendar_month,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Exibindo todas atividades',
                    style: TextStyle(color: Colors.black,fontSize: 17),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 1,
          ),
          Container(
            width: double.infinity,
            height: 50,
            color: Color(0xff306DC3),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    child: Container(
                      height: 50,
                      width: 40,
                      color: Colors.white,
                      child: Center(
                        child: Text(
                          'Nov\n2023',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  for (var i = 26; i <= 30; i++)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _selectedIndex = i - 26; // Deselecionar botão
                        });
                      },
                      child: Text(
                        '$i',
                        style: TextStyle(
                          color: _selectedIndex == i - 26
                              ? Colors.white
                              : Colors.grey, // Alterar cor e estilo
                          fontWeight: _selectedIndex == i - 26
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: ValueListenableBuilder<List<EventModelTeste>>(
              valueListenable: _store.state,
              builder: (context, events, child) {
                //  print('eeeeeeeeeee:${_store.state.value}');
                if (events.isEmpty) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  List<EventModelTeste> filteredEvents = _store.getEventsForDay(26 + _selectedIndex);


                  return ListView.builder(
                    itemCount: filteredEvents.length,
                    itemBuilder: (context, index) {
                      String startTime = DateFormat('HH:mm')
                          .format(filteredEvents[index].start);
                      String endTime =
                          DateFormat('HH:mm').format(filteredEvents[index].end);
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
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
                          child: InkWell(
                            onTap: () {
                              context.pushNamed('/event',
                                  extra: EventModelTeste(
                                      filteredEvents[index].id ?? 0,
                                      filteredEvents[index].changed ?? 0,
                                      filteredEvents[index].status  ?? 0,
                                      filteredEvents[index].weight ?? 0,
                                      filteredEvents[index].addons ?? [],
                                      filteredEvents[index].parent ?? [],
                                      filteredEvents[index].event ?? '',
                                      filteredEvents[index].papers ?? [],
                                      filteredEvents[index].title ?? {},
                                      filteredEvents[index].description ?? {},
                                      filteredEvents[index].start ?? DateTime(0),
                                      filteredEvents[index].end ?? DateTime(0),
                                      filteredEvents[index].category ?? {},
                                      filteredEvents[index].locations ?? [],
                                      filteredEvents[index].type  ?? {} ,
                                      filteredEvents[index].people ?? []));
                            },
                            child: Stack(
                              children: [
                                Container(
                                  height: 120,
                                  width: 8,
                                  decoration: BoxDecoration(
                                    color: filteredEvents[index]
                                        .category['color'] !=
                                        null
                                        ? getColorFromCss(filteredEvents[index]
                                        .category['color'])
                                        : Colors.black,
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5)),
                                  ),

                                ),
                                Visibility(
                                  visible: eventIdStorage.contains(filteredEvents[index].id),
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
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${filteredEvents[index].type['title']['pt-br']} de ${startTime} até ${endTime} ',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          '${filteredEvents[index].title['pt-br']}',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          '${filteredEvents[index].people.isNotEmpty ? filteredEvents[index].people[0]['name'] : ''}',
                                          style: TextStyle(color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
